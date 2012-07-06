package com.jfw.engine.core.motion
{
	import com.jfw.engine.core.geom.isolib.map.consts.DirectionConst;
	import com.jfw.engine.core.geom.isolib.map.consts.MathConst;
	import com.jfw.engine.core.geom.isolib.map.data.IMapData;
	import com.jfw.engine.core.geom.isolib.map.data.Tile;
	import com.jfw.engine.core.interfaces.IAnimatable;
	import com.jfw.engine.core.interfaces.IMotion;
	
	import flash.display.DisplayObject;
	import flash.geom.Point;

	/**
	 *此类为移动类型的一种,用于使动画播放对象产生位移,之所以独立出来实现 
	 * IAnimationable接口而不是直接写在AbstractMontionPlayer内部
	 * 是为了让动画播放对象可以选择不同类型的位移类,更有利于扩展
	 * @author PianFeng
	 */	
	public class BevelLineMotion implements IAnimatable
	{
		protected var _motion: IMotion;//要被播放的动画对象
		protected var _path: Array;	//行走路径
		protected var _montionEnd: Boolean;
		protected var _mapData: IMapData;	//地图信息
		protected var _startX: Number;//当前起始2d坐标
		protected var _startY: Number;
		protected var _endX: Number;
		protected var _endY: Number;
		protected var _movedLength:Number;	//已经移动的距离
		protected var _pathIndex: int;		//走到第几格
		protected var _motionAngle: int;//每一贞时人物的角度
		protected var _currDirection: String;//人物当前的朝向
		protected var _isLastWalk: Boolean; 		//是否移动到最后一格了
		protected var _abort:Boolean;//中断动画播放的参数
		
		public function BevelLineMotion(motion:IMotion,mapData:IMapData,path:Array)
		{
			_motion = motion;
			_path = path;
			_montionEnd = false;
			_mapData = mapData;
			_pathIndex =0;
			_abort=false;	
			
			if (path.length > 1)
				initMotion();
			else
				_montionEnd = true;
		}
		/**
		 *初始化移动 
		 */		
		private function initMotion(): void 
		{
			_pathIndex += 1;
			
			if (_pathIndex >= _path.length - 1) //检查是否最后一格移动
			{
				_isLastWalk = true;
			}
			
			_startX = _motion.PosX();//设置起始点2d像素坐标
			_startY = _motion.PosY();
			
			var pathPoint:Point = new Point((_path[_pathIndex] as Tile).getXIndex(),(_path[_pathIndex] as Tile).getZIndex());		
			var p2d: Point =_mapData.GridToScreen(pathPoint);
			_endX = p2d.x;//设置终点2d像素坐标
			_endY = p2d.y;	
			_movedLength = 0;
			
			_motionAngle=MathConst.getAngle(_startX,_startY,_endX,_endY);//相邻格子之间的移动方向始终是不变的,除了校正以外.	
			_currDirection = DirectionConst.getDirectionByAngle(_motionAngle);
					
			_motion.Direction=_currDirection;
		}
		/**
		 *得到动画对象实例 
		 * @return 
		 */		
		public function getAnimationInstance():DisplayObject
		{
			return _motion.Instance();
		}
		/**
		 *执行运动 
		 */		
		public function gotoNextFrame():void
		{
			var _dx:int = _endX - _motion.getPosX();
			var _dy:int = _endY - _motion.getPosY();
			var _speed:Number = _motion.getSpeed();
			_motion.gotoNextFrame();//只是播放而不是移动
			_motion.onMontionEnterFrame(_currDirection);//只是播放而不是移动
			//距离终点不够一次移动像素就直接移动到终点,前提条件是速度单位小于等于一个格子
			if((_dx*_dx+_dy*_dy) <= (_speed*_speed)) 
			{
				_motion.setPosX(_endX);
				_motion.setPosY(_endY);
				(_motion as Charactor).onUpdateCurrentTile(_path[_pathIndex]);
				
				if(_isLastWalk||_abort==true)	
					_montionEnd = true;
				else 
					initMotion();
			}
			else 
			{
				_movedLength += _speed;
				var lx:Number = _startX + _movedLength * MathConst.COS[_motionAngle+180];
				var ly:Number = _startY + _movedLength * MathConst.SIN[_motionAngle+180];

				_motion.setPosX(lx);
				_motion.setPosY(ly);		
				// 测试发现，走的距离越长偏差越大，所以在走100像素后就校正一次
				if (_movedLength >= 100) 
				{
					_movedLength = 0;
					_startX = lx;
					_startY = ly;
					_motionAngle=MathConst.getAngle(_startX,_startY,_endX,_endY);
				}
			}
		}
		/**
		 * 中断动画播放
		 * @return 
		 */	
		public function stopEnterFrame():void
		{
			_abort=true;
		}
		/**
		 * 动画播放完毕
		 * @return 
		 */		
		public function isPlayEnd():Boolean
		{
			 _motion.isPlayEnd();
			return _montionEnd;
		}
		/**
		 *垃圾回收 
		 */		
		public function dispose():void
		{
			_motion = null;
			_path = null;
			_mapData=null;
		}
	}
}
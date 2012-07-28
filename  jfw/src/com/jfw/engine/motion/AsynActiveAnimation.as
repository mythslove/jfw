package com.jfw.engine.motion
{
	import app.manager.IResourceManager;
	
	import com.jfw.engine.animation.BmdAtlas;
	import com.jfw.engine.animation.Texture;
	import com.jfw.engine.isolib.map.consts.DirectionConst;
	import com.jfw.engine.isolib.map.consts.MathConst;
	import com.jfw.engine.isolib.map.data.IMapData;
	import com.jfw.engine.isolib.map.data.Tile;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;

	/**
	 * 必须设置路径和地图才可以移动,每次更换地图或路径都需要初始化运动参数,并且需要重新开始移动
	 * 路径只有一个结点不移动
	 * @author Administrator
	 * 
	 */	
	public class AsynActiveAnimation extends Sprite implements IMotion
	{
		protected var _motion:IAnimation=null;
		protected var _path: Array=null;	//行走路径
		protected var _mapData: IMapData=null;	//地图信息
		protected var _currSpd:Number=0;
		protected var _originX:Number=0;
		protected var _originY:Number=0;
		private var _startX: Number=0;//当前起始2d坐标
		private var _startY: Number=0;
		private var _endX: Number=0;
		private var _endY: Number=0;
		private var _movedLength:Number=0;				//已经移动的距离
		protected var _pathIndex: int=0;					//走到第几格
		private var _motionAngle: int=0;				//每一贞时人物的角度
		private var _isLastWalk: Boolean=false; 		//是否移动到最后一格了,只读
		private var _isEnd:Boolean=false;				//是否到达最终坐标
		private var _abort:Boolean=true;				//中断动画播放的参数
		
		public function AsynActiveAnimation(srcId:String,manager:IResourceManager,dir:String=DirectionConst.LEFTDOWN,act:String=AnimationConst.STOP,spd:Number=0,fps:Number=12)
		{
			_motion=new BaseAnimation(srcId,manager,dir,act,fps);
			this._currSpd=spd;
			this.addChild(_motion.Instance);
			this.addEventListener(AnimationEvent.UPDATE_TEXTURES,updateOrigin);
		}
		
		public function play():void
		{
			_motion.play();
		}

		public function pause():void
		{
			_motion.pause();
		}

		public function stop():void
		{
			_motion.stop();
		}
		
		public function get isPlaying():Boolean
		{
			return _motion.isPlaying;
		}
		
		public function get Instance():DisplayObject
		{
			return _motion.Instance;
		}

		public function set ActionType(value:String):void
		{
			_motion.ActionType=value;
		}
		
		public function get ActionType():String
		{
			return _motion.ActionType;
		}

		public function set Direction(dir:String):void
		{
			_motion.Direction=dir;
		}
		
		public function get Direction():String
		{
			return _motion.Direction;
		}
		
		public function get XOffset():Number
		{
			return _motion.XOffset;
		}
		
		public function get YOffset():Number
		{
			return _motion.YOffset;
		}
		/**
		 * 设置动画对象相对原点偏移量 ,此设置不会影响动画本身偏移量,主要用来给用户调整用
		 * @return 
		 * 
		 */	
		public function set XAdjust(value:Number):void
		{
			this._motion.XAdjust=value;
		}
		/**
		 * 设置动画对象相对原点偏移量 ,此设置不会影响动画本身偏移量,主要用来给用户调整用
		 * @return 
		 * 
		 */	
		public function set YAdjust(value:Number):void
		{
			this._motion.YAdjust=value;
		}
		
		public function get OriginX():Number
		{
			return this._originX;
		}
		
		public function set OriginX(value:Number):void
		{
			this._originX=value;
			x=value+this.XOffset;
		}
		
		public function get OriginY():Number
		{
			return this._originY;
		}
		
		public function set OriginY(value:Number):void
		{
			this._originY=value;
			y=value+this.YOffset;
		}
		
		public function get currentFrame():int
		{
			return _motion.currentFrame;
		}
		
		public function getFrameTexture(frameID:int):Texture
		{
			return _motion.getFrameTexture(frameID);
		}
		
		public function set fps(value:Number):void
		{
			_motion.fps=value;
		}
	
		public function get fps():Number
		{
			return this._motion.fps;
		}
		
		public function advanceTime(time:Number):void
		{
			this._motion.advanceTime(time);
	
			if(!this._abort&&!this._isEnd)
				gotoNextStep();
		}
		
		public function get Spd():Number
		{
			return this._currSpd;
		}
		
		public function set WalkPath(value:Array):void
		{
			this._path=value;
		}
		
		public function get WalkPath():Array
		{
			return this._path;
		}
		
		public function set MapData(value:IMapData):void
		{
			this._mapData=value;
		}
		public function get MapData():IMapData
		{
			return this._mapData;
		}
			
		public function StartMove():void
		{
			if(this.MapData==null||this.WalkPath==null)
				return;
			
			if(this.WalkPath&&this.WalkPath.length==1)//只有一个结点不移动
				return;
			
			this._abort=false;
			this._isLastWalk =false;	
			this._isEnd=false;
			this._pathIndex=0;
			
			initMotion();
		}

		public function PauseMove():void
		{
			this._abort=true;
		}
		
		public function ResumeMove():void
		{
			if(this.MapData==null||this.WalkPath==null)
				return;
			
			this._abort=false;
		}
		
		public function StopMove():void
		{
			this._path=null;
			this._abort=true;
			this._isLastWalk =false;	
			this._isEnd=false;
			this._pathIndex=0;
			this._movedLength=0;
		}
		/**
		 * 是否正在移动 
		 * @return 
		 * 
		 */		
		public function get isMoving():Boolean
		{
			return !_abort&&!_isEnd;
		}
		/**
		 * 每一结点的回调函数 
		 * @param index
		 * 
		 */		
		protected function onUpdate(tile:Tile):void
		{
			
		}
		/**
		 * 更新原点位置 
		 * @param evt
		 * 
		 */		
		private function updateOrigin(evt:AnimationEvent):void
		{
			evt.stopImmediatePropagation();
			x=this._originX+this._motion.XOffset;
			y=this._originY+this._motion.YOffset;
		}
		
		public function destroy():void
		{
			if(isMoving)
				pause();

			if(this.contains(_motion.Instance))
				this.removeChild(_motion.Instance);
			
			this.removeEventListener(AnimationEvent.UPDATE_TEXTURES,updateOrigin);
			_motion.destroy();
			_motion=null;
			_path=null;	//行走路径
			_mapData=null;	//地图信息
		}
		
		private function initMotion(): void 
		{
			if (_pathIndex >= WalkPath.length - 1) //检查是否最后一格移动
				_isLastWalk = true;

			_startX = this.OriginX;//设置起始点2d像素坐标
			_startY = this.OriginY;
			
			var pathPoint:Point = new Point((WalkPath[_pathIndex] as Tile).getXIndex(),(WalkPath[_pathIndex] as Tile).getZIndex());		
			var p2d:Point =this._mapData.gridToScreen(pathPoint);

			_endX=p2d.x;
			_endY=p2d.y;
			
			_movedLength = 0;
			
			_motionAngle=MathConst.getAngle(_startX,_startY,_endX,_endY);//相邻格子之间的移动方向始终是不变的,除了校正以外.	
			Direction = DirectionConst.getDirectionByAngle(_motionAngle);
		}
		
		private function gotoNextStep():void
		{
			var _dx:int = _endX - this.OriginX;
			var _dy:int = _endY - this.OriginY;
			
			//距离终点不够一次移动像素就直接移动到终点,前提条件是速度单位小于等于一个格子
			if((_dx*_dx+_dy*_dy) <= (this.Spd*this.Spd)) 
			{
				this.OriginX=_endX;
				this.OriginY=_endY;
				
				this.onUpdate(WalkPath[_pathIndex]);
				
				if(_isLastWalk||_abort)	
				{
					_isEnd=true;
					this.dispatchEvent(new AnimationEvent(AnimationEvent.WALK_COMPLETE,true,true));
				}
				else 
				{
					_pathIndex ++;
					initMotion();
				}
			}
			else 
			{
				_movedLength += this.Spd;
				var lx:Number = _startX + _movedLength * MathConst.COS[_motionAngle+180];
				var ly:Number = _startY + _movedLength * MathConst.SIN[_motionAngle+180];
					
				this.OriginX=lx;
				this.OriginY=ly;		
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
	}
}
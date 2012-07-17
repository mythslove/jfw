package examples.animation.animation
{
	import com.isolib.as3isolib.display.IsoSprite;
	import com.isolib.as3isolib.geom.IsoMath;
	import com.isolib.as3isolib.geom.Pt;
	import com.jfw.engine.animation.BmdAtlas;
	
	import examples.animation.geom.isolib.map.consts.DirectionConst;
	import examples.animation.geom.isolib.map.consts.MathConst;
	import examples.animation.geom.isolib.map.data.IMapData;
	import examples.animation.geom.isolib.map.data.Tile;
	import examples.animation.interfaces.IAnimation;
	import examples.animation.interfaces.IMotion;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;

	/**
	 * 必须设置路径和地图才可以移动,每次更换地图或路径都需要初始化运动参数,并且需要重新开始移动
	 * 路径只有一个结点不移动
	 * @author Administrator
	 * 
	 */	
	public class IsoActiveAnimation extends IsoSprite implements IMotion
	{
		private var _motion:IAnimation=null;
		private var _path: Array=null;	//行走路径
		private var _mapData: IMapData=null;	//地图信息
		private var _startX: Number=0;//当前起始2d坐标
		private var _startY: Number=0;
		private var _endX: Number=0;
		private var _endY: Number=0;
		private var _movedLength:Number=0;				//已经移动的距离
		private var _pathIndex: int=0;					//走到第几格
		private var _motionAngle: int=0;				//每一贞时人物的角度
		private var _isLastWalk: Boolean=false; 		//是否移动到最后一格了,只读
		private var _isEnd:Boolean=false;				//是否到达最终坐标
		private var _abort:Boolean=true;				//中断动画播放的参数
		private var _currSpd:Number=0;
		
		public function IsoActiveAnimation(source:BmdAtlas,dir:String=DirectionConst.LEFTDOWN,act:String=AnimationConst.STOP,spd:Number=0,fps:Number=12,size:Number=0)
		{
			super(size);
			
			_motion=new StaticAnimation(source,dir,act,fps);
			this._currSpd=spd;
			this.sprites=[_motion.Instance];
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
			var p3d:Pt=IsoMath.screenToIso(new Pt(_motion.XOffset,_motion.YOffset));
			return p3d.x;
		}
		
		public function get YOffset():Number
		{
			var p3d:Pt=IsoMath.screenToIso(new Pt(_motion.XOffset,_motion.YOffset));
			return p3d.y;
		}
		
		public function get PosX():Number
		{
			return 0;
		}
		
		public function set PosX(value:Number):void
		{
			
		}
		
		public function get PosY():Number
		{
			return 0;
		}
		
		public function set PosY(value:Number):void
		{

		}
		
		override public function get x():Number
		{
			return super.x-XOffset;
		}
		
		override public function set x(value:Number):void
		{
			super.x=value+XOffset;
		}
		
		override public function get y():Number
		{
			return super.y-YOffset;
		}
		
		override public function set y(value:Number):void
		{
			super.y=value+YOffset;
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
		public function onUpdate(tile:Tile):void
		{
			
		}
		
		public function destroy():void
		{
			if(isMoving)
				pause();
			
			this.sprites=null;
			_motion.destroy();
			_motion=null;
			_path=null;	//行走路径
			_mapData=null;	//地图信息
		}
		
		private function initMotion(): void 
		{
			_pathIndex += 1;
			
			if (_pathIndex >= WalkPath.length - 1) //检查是否最后一格移动
				_isLastWalk = true;

			_startX = this.x;//设置起始点2d像素坐标
			_startY = this.y;
			
			var pathPoint:Point = new Point((WalkPath[_pathIndex] as Tile).getXIndex(),(WalkPath[_pathIndex] as Tile).getZIndex());		
			//var p2d: Point =IsoMath.GridToScreen(pathPoint);
			
//			_endX = p2d.x;//设置终点2d像素坐标
//			_endY = p2d.y;	
			_endX=pathPoint.x*30+15;
			_endY=pathPoint.y*30+15;
			
			_movedLength = 0;
			
			_motionAngle=MathConst.getAngle(_startX,_startY,_endX,_endY);//相邻格子之间的移动方向始终是不变的,除了校正以外.	
			Direction = DirectionConst.getDirectionByAngle(_motionAngle);
		}
		
		private function gotoNextStep():void
		{
//			var _dx:int = _endX - this.PosX;
//			var _dy:int = _endY - this.PosY;
			
			var _dx:int = _endX - this.x;
			var _dy:int = _endY - this.y;
			
			//距离终点不够一次移动像素就直接移动到终点,前提条件是速度单位小于等于一个格子
			if((_dx*_dx+_dy*_dy) <= (this.Spd*this.Spd)) 
			{
//				this.PosX=_endX;
//				this.PosY=_endY;
				this.x=_endX;
				this.y=_endY;
				
				this.onUpdate(WalkPath[_pathIndex]);
				
				if(_isLastWalk||_abort)	
					_isEnd=true;
				else 
					initMotion();
			}
			else 
			{
				_movedLength += this.Spd;
				var lx:Number = _startX + _movedLength * MathConst.COS[_motionAngle+180];
				var ly:Number = _startY + _movedLength * MathConst.SIN[_motionAngle+180];
				
//				this.PosX=lx;
//				this.PosY=ly;	
				this.x=lx;
				this.y=ly;		
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
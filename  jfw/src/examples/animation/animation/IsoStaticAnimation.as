package examples.animation.animation
{
	import com.isolib.as3isolib.display.IsoSprite;
	import com.jfw.engine.animation.BmdAtlas;
	
	import examples.animation.geom.isolib.map.consts.DirectionConst;
	import examples.animation.interfaces.IAnimation;
	
	import flash.display.DisplayObject;
	
	public class IsoStaticAnimation extends IsoSprite implements IAnimation
	{
		private var _motion:IAnimation=null;
		
		public function IsoStaticAnimation(source:BmdAtlas,dir:String=DirectionConst.LEFTDOWN,act:String=AnimationConst.STOP,spd:Number=0,fps:Number=12,size:Number=0)
		{
			super(size);
			
			_motion=new StaticAnimation(source,dir,act,fps);
			this.sprites=[_motion];
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
			return return _motion.XOffset;;
		}
		
		public function get YOffset():Number
		{
			return _motion.YOffset;
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
			return _motion.isPlaying;;
		}
		
		public function advanceTime(time:Number):void
		{
			_motion.advanceTime(time);
		}
		
		public function destroy():void
		{
			this.sprites=null;
			_motion.destroy();
			_motion=null;
		}
	}
}
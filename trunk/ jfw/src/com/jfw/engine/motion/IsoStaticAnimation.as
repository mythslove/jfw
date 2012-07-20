package com.jfw.engine.motion
{
	import com.jfw.engine.animation.BmdAtlas;
	
	import com.jfw.engine.isolib.map.consts.DirectionConst;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class IsoStaticAnimation extends Sprite implements IAnimation
	{
		private var _motion:IAnimation=null;
		
		public function IsoStaticAnimation(source:BmdAtlas,dir:String=DirectionConst.LEFTDOWN,act:String=AnimationConst.STOP,spd:Number=0,fps:Number=12)
		{
			_motion=new StaticAnimation(source,dir,act,fps);
			this.addChild(_motion.Instance);
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
		
		public function get FootX():Number
		{
			return x-this.XOffset;
		}
		
		public function set FootX(value:Number):void
		{
			x=value+this.XOffset;
		}
		
		public function get FootY():Number
		{
			return y-this.YOffset;
		}
		
		public function set FootY(value:Number):void
		{
			y=value+this.YOffset;
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
			if(this.contains(_motion.Instance))
				this.removeChild(_motion.Instance);
			
			_motion.destroy();
			_motion=null;
		}
	}
}
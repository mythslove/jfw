package com.jfw.engine.core.animation
{
	import com.jfw.engine.core.interfaces.IAnimation;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	
	public class StaticAnimation extends BmdMovieClip implements IAnimation
	{
		public function StaticAnimation(bmds:Vector.<BitmapData>, fps:Number=12)
		{
			super(bmds, fps);
		}
		
		public function get AnimationInstance():DisplayObject
		{
			return null;
		}
		
		public function gotoNextFrame():void
		{
		}
		
		public function get isEnd():Boolean
		{
			return false;
		}
	}
}
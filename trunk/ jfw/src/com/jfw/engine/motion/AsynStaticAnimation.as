package com.jfw.engine.motion
{
	import com.jfw.engine.animation.BmdAtlas;
	import com.jfw.engine.animation.Texture;
	import com.jfw.engine.isolib.map.consts.DirectionConst;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class AsynStaticAnimation extends Sprite implements IAnimation
	{
		private var _motion:IAnimation=null;
		protected var _originX:Number=0;
		protected var _originY:Number=0;
		
		public function AsynStaticAnimation(source:BmdAtlas,dir:String=DirectionConst.LEFTDOWN,act:String=AnimationConst.STOP,spd:Number=0,fps:Number=12)
		{
			_motion=new BaseAnimation(source,dir,act,fps);
			this.addChild(_motion.Instance);
			this.addEventListener(AnimationEvent.UPDATE_TEXTURES,updateOrigin);
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
			return return _motion.XOffset;
		}
		
		public function get YOffset():Number
		{
			return _motion.YOffset;
		}
		
		public function set XAdjust(value:Number):void
		{
			this._motion.XAdjust=value;
		}
		
		public function set YAdjust(value:Number):void
		{
			this._motion.YAdjust=value;
		}
		
		public function get OriginX():Number
		{
			return x-this.XOffset;
		}
		
		public function set OriginX(value:Number):void
		{
			x=value+_motion.XOffset;;
		}
		
		public function get OriginY():Number
		{
			return y-_motion.YOffset;
		}
		
		public function set OriginY(value:Number):void
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
		
		public function get currentFrame():int
		{
			return _motion.currentFrame;
		}
		
		public function getFrameTexture(frameID:int):Texture
		{
			return _motion.getFrameTexture(frameID);
		}
		
		public function destroy():void
		{
			if(this.contains(_motion.Instance))
				this.removeChild(_motion.Instance);
			
			this.removeEventListener(AnimationEvent.UPDATE_TEXTURES,updateOrigin);
			_motion.destroy();
			_motion=null;
		}
	}
}
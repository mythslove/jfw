package com.jfw.engine.motion.bottom
{
	import app.manager.IResourceManager;
	
	import com.jfw.engine.animation.BmdAtlas;
	import com.jfw.engine.animation.Texture;
	import com.jfw.engine.isolib.map.consts.DirectionConst;
	import com.jfw.engine.motion.AnimationEvent;
	import com.jfw.engine.motion.IAnimation;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * 本垒最的特点是原点位于人物脚下 
	 * @author Administrator
	 * 
	 */	
	public class AsynBottomAnimation extends Sprite implements IAnimation
	{
		private var _motion:IAnimation=null;
		protected var _originX:Number=0;
		protected var _originY:Number=0;
		
		public function AsynBottomAnimation(srcid:String,manager:IResourceManager,frameName:String,defaultTextures:BitmapData,fps:Number=12)
		{
			_motion=new BottomAnimation(srcid,manager,frameName,defaultTextures,fps);
			
			this.addChild(_motion.getAnimation());
			this.addEventListener(AnimationEvent.UPDATE_TEXTURES,updateOrigin);
			_motion.getAnimation().addEventListener(Event.COMPLETE,onAnimationEnd);
		}
		
		public function getAnimation():DisplayObject
		{
			return _motion.getAnimation();
		}
		
		public function get CurFrameName():String
		{
			return _motion.CurFrameName;
		}
		
		public function set CurFrameName(value:String):void
		{
			_motion.CurFrameName=value;
		}
		
		public function get CurrFrame():int
		{
			return _motion.CurrFrame;
		}
		
		public function get totalFrames():int
		{
			return _motion.totalFrames;
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
		 * 子类业务逻辑如果需要舰艇动作结束需要重写 
		 * @param evt
		 * 
		 */		
		protected function onAnimationEnd(evt:Event):void
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
		
		public function destroy():void
		{
			if(this.contains(_motion.getAnimation()))
				this.removeChild(_motion.getAnimation());
			
			this.removeEventListener(AnimationEvent.UPDATE_TEXTURES,updateOrigin);
			_motion.getAnimation().removeEventListener(Event.COMPLETE,onAnimationEnd);
			_motion.destroy();
			_motion=null;
		}
	}
}
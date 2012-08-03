package com.jfw.engine.motion
{
	import app.manager.IResourceManager;
	
	import com.jfw.engine.animation.BmdAtlas;
	import com.jfw.engine.animation.Texture;
	import com.jfw.engine.isolib.map.consts.DirectionConst;
	import com.jfw.engine.motion.AnimationConst;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	/**
	 * 实现动态资源加载,更新偏移量 
	 * @author Administrator
	 * 
	 */	
	public class BaseAnimation extends MutiStateMovieClip implements IAnimation
	{
		protected var id:String;
		protected var manager:IResourceManager=null;
		protected var bmdAtlas:BmdAtlas=null;//资源工具
		protected var currFps:int=12;
		protected var xOffset:Number=0;
		protected var yOffset:Number=0;
		protected var xAdjust:Number=0;
		protected var yAdjust:Number=0;
		protected var currFrameName:String;	
		
		public function BaseAnimation(srcId:String,manager:IResourceManager,frameName:String,defaultTextures:BitmapData,fps:Number=12)
		{
			this.id=srcId;
			this.manager=manager;
			this.currFrameName=frameName;
			this.currFps=fps;

			bmdAtlas=manager.getSource(srcId);
			var textures:Vector.<Texture>=null;
			
			if(bmdAtlas)
			{
				textures=bmdAtlas.getTextures(currFrameName);
				
				if(textures.length==0)
					textures=getTextures(defaultTextures);
			}
			else
			{
				textures=getTextures(defaultTextures);
				manager.loadRes(srcId,redraw);
			}

			super(textures,fps);
			updateOffset();
		}
		
		private function getTextures(bmd:BitmapData):Vector.<Texture>
		{
			var textures:Vector.<Texture>=new Vector.<Texture>();
			textures.push( new Texture(bmd,bmd.rect,bmd.rect));
			return textures;
		}
		/**
		 * 重绘动态资源 
		 * 
		 */		
		public function redraw(bmdAtlas:BmdAtlas):void
		{
			this.bmdAtlas=bmdAtlas;
			update();
			this.dispatchEvent(new AnimationEvent(AnimationEvent.UPDATE_TEXTURES,true,true));
		}
		/**
		 * 跳到某个关键帧 
		 * @param frameName	关键帧名称
		 */		
		protected function update():void
		{
			if(bmdAtlas==null)
				return;
			
			var textures:Vector.<Texture>=bmdAtlas.getTextures(currFrameName);
			
			if(textures.length>0)
			{
				this.changeTextures(textures);
				updateOffset();
			}
			else
			{
				textures=null;
				return;
			}
		}
		/**
		 * 更新偏移量 
		 * 
		 */		
		protected function updateOffset():void
		{
		}
		
		public function get CurFrameName():String
		{
			return currFrameName;
		}
		
		public function set CurFrameName(value:String):void
		{
			if(value!=currFrameName)
			{
				currFrameName=value;
				update();
			}
		}

		public function get CurrFrame():int
		{
			return this.currentFrame;
		}
		
		public function get totalFrames():int
		{
			return this.numFrames;
		}
		
		public function getAnimation():DisplayObject
		{
			return this;
		}
		
		public function get XOffset():Number
		{
			return this.xOffset+this.xAdjust;
		}
		
		public function get YOffset():Number
		{
			return this.yOffset+this.yAdjust;
		}
		
		public function set XAdjust(value:Number):void
		{
			this.xAdjust=value;
		}
		
		public function set YAdjust(value:Number):void
		{
			this.yAdjust=value;
		}
		
		public function get OriginX():Number
		{
			return x;
		}
		
		public function set OriginX(value:Number):void
		{
			x=value;
		}
		
		public function get OriginY():Number
		{
			return y;
		}
		
		public function set OriginY(value:Number):void
		{
			y=value;
		}
		
		override public function advanceTime(passedTime:Number):void
		{
			this.updateOffset();
			
			super.advanceTime(passedTime);
		}
		
		override public function destroy():void
		{	
			this.destroy();
			bmdAtlas.dispose();
			manager=null;
			bmdAtlas=null;//资源工具
		}
	}
}
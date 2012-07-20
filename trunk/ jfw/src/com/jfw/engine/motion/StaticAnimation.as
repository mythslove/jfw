package com.jfw.engine.motion
{
	import app.manager.IResourceManager;
	
	import com.jfw.engine.animation.BmdAtlas;
	import com.jfw.engine.animation.Texture;
	import com.jfw.engine.isolib.map.consts.DirectionConst;
	import com.jfw.engine.motion.AnimationConst;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	
	public class StaticAnimation extends MutiStateMovieClip implements IAnimation
	{
		protected var id:String;
		protected var manager:IResourceManager=null;
		protected var bmdAtlas:BmdAtlas=null;//资源工具
		protected var currDir:String;
		protected var actType:String;
		protected var currFps:int=12;
		protected var xOffset:Number=0;
		protected var yOffset:Number=0;
		protected var currFrameName:String;
		
		
		public function StaticAnimation(srcId:String,manager:IResourceManager,dir:String=DirectionConst.LEFTDOWN,act:String=AnimationConst.STOP,fps:Number=12)
		{
			this.id=srcId;
			this.currDir=dir;
			this.actType=act;
			this.currFps=fps;
			this.currFrameName=this.currDir+"_"+this.actType+"_";
			this.manager=manager;
			
			bmdAtlas=manager.getSource(srcId);
			var textures:Vector.<Texture>=null;
			
			if(bmdAtlas)
			{
				textures=bmdAtlas.getTextures(currFrameName);
				
				if(textures.length==0)
					textures=manager.getDefaultSource();
			}
			else
			{
				textures=manager.getDefaultSource();
				manager.loadRes(srcId,redraw);
			}

			super(textures,fps);
			
			var texture:Texture=this.getFrameTexture(0);
			this.xOffset=texture.frameX-texture.regionWidth/2;
			this.yOffset=texture.frameY-texture.regionHeight;
		}
		/**
		 * 重绘动态资源 
		 * 
		 */		
		public function redraw(bmdAtlas:BmdAtlas):void
		{
			this.bmdAtlas=bmdAtlas;
			update();
		}
		/**
		 * 跳到某个关键帧 
		 * @param frameName	关键帧名称
		 */		
		private function update():void
		{
			if(bmdAtlas==null)
				return;
			
			this.currFrameName=this.currDir+"_"+this.actType+"_";
			var textures:Vector.<Texture>=bmdAtlas.getTextures(currFrameName);
			
			if(textures.length>0)
			{
				changeTextures(textures);
			}
			else
			{
				textures=null;
				return;
			}
		}
		
		public function get CurFrameName():String
		{
			return currFrameName;
		}

		public function get Instance():DisplayObject
		{
			return this;
		}
		
		public function get Direction():String
		{
			return this.currDir;	
		}
		
		public function set Direction(dir:String):void
		{
			if(this.currDir!=dir)
			{
				this.currDir=dir;
				update();
			}
		}
		
		public function get ActionType():String
		{
			return this.actType;	
		}
		
		public function set ActionType(value:String):void
		{
			if(this.actType!=value)
			{
				this.actType=value;
				update();
			}
		}
		
		public function get XOffset():Number
		{
			return this.xOffset;
		}
		
		public function get YOffset():Number
		{
			return this.yOffset;
		}
		
		public function get FootX():Number
		{
			return x-this.xOffset;
		}
		
		public function set FootX(value:Number):void
		{
			x=value+this.xOffset;
		}
		
		public function get FootY():Number
		{
			return y-this.yOffset;
		}
		
		public function set FootY(value:Number):void
		{
			y=value+this.yOffset;
		}
		
		override public function advanceTime(passedTime:Number):void
		{
			super.advanceTime(passedTime);
			
			var texture:Texture=this.getFrameTexture(this.currentFrame);
			this.xOffset=texture.frameX-texture.regionWidth/2;
			this.yOffset=texture.frameY-texture.regionHeight;
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
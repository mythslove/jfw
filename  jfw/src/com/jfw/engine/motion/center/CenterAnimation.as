package com.jfw.engine.motion.center
{
	import app.manager.IResourceManager;
	
	import com.jfw.engine.animation.Texture;
	import com.jfw.engine.motion.BaseAnimation;
	
	import flash.display.BitmapData;

	/**
	 * 原点为中心点 
	 * @author Administrator
	 * 
	 */	
	public class CenterAnimation extends BaseAnimation
	{
		public function CenterAnimation(srcId:String, manager:IResourceManager, frameName:String,defaultTextures:BitmapData,fps:Number=12)
		{
			super(srcId, manager, frameName, defaultTextures,fps);
		}
		
		override protected function updateOffset():void
		{
			var texture:Texture=this.getFrameTexture(0);
			this.xOffset=texture.frameX-(texture.regionWidth>>1);
			this.yOffset=texture.frameY-(texture.regionHeight>>1);
		}
	}
}
package examples.animation.animation
{
	import com.jfw.engine.animation.BmdAtlas;
	import com.jfw.engine.animation.Texture;
	
	import examples.animation.animation.AnimationConst;
	import examples.animation.geom.isolib.map.consts.DirectionConst;
	import examples.animation.interfaces.IAnimation;
	import examples.animation.source.AssetsManager;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	
	public class StaticAnimation extends MutiStateMovieClip implements IAnimation
	{
		protected var bmdAtlas:BmdAtlas=null;//资源工具
		protected var currDir:String;
		protected var actType:String;
		protected var currFps:int=12;
		protected var xOffset:Number=0;
		protected var yOffset:Number=0;
		
		protected var currFrameName:String;
		
		public function StaticAnimation(source:BmdAtlas,dir:String=DirectionConst.LEFTDOWN,act:String=AnimationConst.STOP,fps:Number=12)
		{
			this.bmdAtlas=source;
			this.currDir=dir;
			this.actType=act;
			this.currFps=fps;
			this.currFrameName=this.currDir+"_"+this.actType+"_";
			
			var textures:Vector.<Texture>=bmdAtlas.getTextures(currFrameName);
			
			if(textures.length==0)
			{
				var bmd:BitmapData=AssetsManager.Instance.getTexture("UnknownIcon");
				textures.push( new Texture(bmd,bmd.rect,bmd.rect));
			}

			super(textures,fps);
			
			var texture:Texture=this.getFrameTexture(0);
			this.xOffset=texture.frameX-texture.regionWidth/2;
			this.yOffset=texture.frameY-texture.regionHeight;
		}
		/**
		 * 跳到某个关键帧 
		 * @param frameName	关键帧名称
		 */		
		private function update():void
		{
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
			bmdAtlas=null;//资源工具
		}
	}
}
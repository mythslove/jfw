package app.battle.effect
{
	import app.battle.DataProvider;
	import app.battle.consts.GlobalConst;
	import app.battle.interfaces.IDisplayObject;
	import app.manager.IResourceManager;
	import app.battle.consts.PrefixConst;
	import app.manager.ResourceManager;
	
	import com.jfw.engine.motion.center.AsynCenterAnimation;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	public class BaseEffect extends AsynCenterAnimation implements IDisplayObject
	{
		protected var sourceManager:IResourceManager=null;
		protected var repeat:Boolean=false;
		
		public function BaseEffect(id:String,repeat:Boolean=false)
		{
			sourceManager=ResourceManager.Instance;
			this.repeat=repeat;
			
			super(id, sourceManager, PrefixConst.MAGIC, sourceManager.getDefaultSource(), GlobalConst.FPS);
		}
		
		override protected function onAnimationEnd(evt:Event):void
		{
			if(!repeat)
			{
				this.stop();
				
				if(this.parent)
					this.parent.removeChild(this);
			}
		}
		
		public function get Instance():DisplayObject
		{
			return this;	
		}
		
		public function get Visible():Boolean
		{
			return this.visible;
		}
		
		public function set Visible(value:Boolean):void
		{
			this.visible=value;
		}
		
		public function get Alpha():Number
		{
			return this.alpha;
		}
		
		public function set Alpha(value:Number):void
		{
			this.alpha=value;
		}
		
		public function get ScrX():Number
		{
			return this.x;
		}
		
		public function get ScrY():Number
		{
			return this.y;
		}
		
		public function move(x:Number=0,y:Number=0):void
		{
			this.OriginX=x;
			this.OriginY=y;
		}
		
		override public function destroy():void
		{
			super.destroy();
			
			sourceManager=null;
		}
	}
}
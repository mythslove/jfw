package app.view.iso.isoSprites
{
	import com.isolib.as3isolib.display.IsoSprite;
	import com.isolib.as3isolib.geom.Pt;
	import com.isolib.as3isolib.utils.IsoDrawingUtil;
	import com.jfw.engine.animation.BmdAtlas;
	import com.jfw.engine.animation.Texture;
	import com.jfw.engine.core.base.Core;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.system.ApplicationDomain;

	public class MapItem extends IsoSprite
	{
		// 已加载的资源缓存
		protected var spriteContainer:Sprite = null;
		
		public function MapItem() 
		{
			super();
			init();
		}
		
		private function init():void
		{
			spriteContainer = new Sprite();
			
			//temp
//			var base:Sprite = new Sprite();
//			base.graphics.beginFill(0x336699);
//			IsoDrawingUtil.drawIsoRectangle(base.graphics, new Pt(), 4*30,4*30);
//			sprites = [base,spriteContainer];
			sprites = [spriteContainer];
			container.mouseChildren = true;
			container.mouseEnabled = false;
		}
		
		public function getSprite():Sprite
		{
			return spriteContainer;
		}
		
		public function setHighLight( show:Boolean, color:uint = 0xFFFFFF, alpha:Number = 1 ):void
		{
			if ( show )
				container.filters = [ new GlowFilter( color, alpha, 8, 8, 20 ) ];
			else
				container.filters = [];
		}

		public function hitTestPoint( x:Number, y:Number, shapeFlag:Boolean = false ):Boolean
		{
			if ( container.hitTestPoint( x, y, shapeFlag ) )
				return true;
			return false;
		}
		
		protected function getAssets( clsName:String ):BmdAtlas
		{
			return new BmdAtlas( Core.getInstance().assetsModel.getBitmapData( clsName ),Core.getInstance().assetsModel.getXML(clsName) );
		}
		
	}

}
package app.view.game.sprite 
{
	import com.isolib.as3isolib.display.IsoSprite;
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
		private static var assetsDomains:Object = { };
		protected var spriteContainer:Sprite = null;
		private var _path:String = '';
		
		public function MapItem() 
		{
			super();
			init();
		}
		
		private function init():void
		{
			spriteContainer = new Sprite();
			sprites = [spriteContainer];
			container.mouseChildren = false;
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
		protected function loadAssets( path:String ):void
		{
			_path = path;
			if ( !assetsDomains[_path] )
			{
				assetsDomains[_path] = { loaded:false, domain:null };
				bulkLoader.add( _path, { id: _path } );
				bulkLoader.addEventListener( BulkProgressEvent.SINGLE_COMPLETE, onLoaded );
				if ( !bulkLoader.isRunning )
					bulkLoader.start();
			}
			else if ( !assetsDomains[_path]['loaded'] )
				bulkLoader.addEventListener( BulkProgressEvent.SINGLE_COMPLETE, onLoaded );
			else
				onAssetsLoaded( assetsDomains[_path]['domain'] );
		}
		
		private function onLoaded( evt:BulkProgressEvent ):void
		{
			if ( _path != evt.item.id )
				return;
			assetsDomains[_path]['domain'] = bulkLoader.getMovieClip( _path ).loaderInfo.applicationDomain;
			assetsDomains[_path]['loaded'] = true;
			bulkLoader.removeEventListener( BulkProgressEvent.SINGLE_COMPLETE, onLoaded );
			onAssetsLoaded( assetsDomains[_path]['domain'] );
		}
		
		protected function onAssetsLoaded( assetsDomain:ApplicationDomain ):void
		{
			
		}
		public function hitTestPoint( x:Number, y:Number, shapeFlag:Boolean = false ):Boolean
		{
			if ( container.hitTestPoint( x, y, shapeFlag ) )
				return true;
			return false;
		}
		protected function getMovieClip( domain:ApplicationDomain, define:String ):MovieClip
		{
			if (! domain.hasDefinition(define)) {
				define = 'AItem';
			}
			var classDef:Class = domain.getDefinition( define ) as Class;
			var mc:MovieClip = new classDef as MovieClip;
			return mc;
		}
		
		protected function getAssets( clsName:String ):BmdAtlas
		{
			return new BmdAtlas( Core.getInstance().assetsModel.getBitmapData( clsName ),Core.getInstance().assetsModel.getXML(clsName) );
		}
		
	}

}
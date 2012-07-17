package
{
	import com.jfw.engine.utils.json.JSON;
	import com.stimuli.loading.BulkLoader;
	import com.stimuli.loading.BulkProgressEvent;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.Security;
	import flash.utils.ByteArray;

	public class GameLoader extends Sprite
	{
		private var configObj:Object = null;
		private var applicationDomain:ApplicationDomain = null;
		private var  loaderContext:LoaderContext = null;
		
		public function GameLoader()
		{
			Security.allowDomain( "*" );
			Security.allowInsecureDomain( "*" );
			
			if ( stage )
				init();
			else
				addEventListener( Event.ADDED_TO_STAGE, onAddToStage );
		}
		
		private function onAddToStage( evt:Event ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddToStage );
			init();
		}
		
		private function init( ):void
		{
			trace( 'Config.dat loading...' );
			
			loaderContext = new LoaderContext();
			loaderContext.applicationDomain = ApplicationDomain.currentDomain;
			
			var loader:BulkLoader = new BulkLoader( 'GameLoader' );
			loader.addEventListener( BulkProgressEvent.COMPLETE, onConfigAssetsLoaded );
			loader.add( 'config.dat?v=' + int( Math.random() * 1000000 ).toString() , { id : 'config' , type : 'binary' ,context: loaderContext } );
			loader.start( );
		}
		
		private function onConfigAssetsLoaded( evt:BulkProgressEvent ):void
		{
			var cloader:BulkLoader = evt.target as BulkLoader;
			var content:ByteArray = cloader.getBinary( 'config' );
			try
			{
				content.uncompress( );
			}
			catch( e:Error )
			{
				
			}
			configObj = JSON.decode( content as String );
			
			cloader.removeEventListener( BulkProgressEvent.COMPLETE, onConfigAssetsLoaded );
			cloader.clear();

			trace( 'loading.swf loading...' );
			var loadingAssetsPath:String = 'assets/loading.swf?v=' + configObj['loadingv'];
			var loader:BulkLoader = new BulkLoader( 'GameLoader' );
			loader.addEventListener( BulkProgressEvent.COMPLETE, onGameMainLoaded );
			loader.add( loadingAssetsPath , { id : 'loading' , type : 'movieclip' ,context : loaderContext } );
			loader.start( );
		}
		
		
		private function onGameMainLoaded( evt:BulkProgressEvent ):void
		{
			var cloader:BulkLoader = evt.target as BulkLoader;
			cloader.removeEventListener( BulkProgressEvent.COMPLETE, onGameMainLoaded );
			cloader.clear();
			
			var content:MovieClip = getMovieClip('Loading');
			content.x = ( stage.stageWidth - content.width ) * .5;
			content.y = ( stage.stageHeight - content.height ) * .5;
			addChild( content );
		}
		
		private function getMovieClip( className:String ):MovieClip
		{
			var cls:Class = ApplicationDomain.currentDomain.getDefinition( className ) as Class; 
			if( cls )
				return new cls() as MovieClip;
			else
				return null;
		}
	}
}
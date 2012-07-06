package com.jfw.engine.core.model
{
	import com.jfw.engine.core.data.LoadStruct;
	import com.jfw.engine.utils.IQueueItem;
	import com.stimuli.loading.BulkLoader;
	import com.stimuli.loading.BulkProgressEvent;
	import com.stimuli.loading.loadingtypes.LoadingItem;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;

	/** 加载静态资源基类 ,实现 IEventDispatcher接口,可发送事件 */
	public class LoadModel extends BModel implements IAssetModel,IQueueItem
	{
		static public const KEY:String = 'assets';
		
		/** 下载失败重试次数 */
		static private const RETRY_LIMIT:int = 10;
		
		protected var dispatcher:EventDispatcher = null;
		
		protected var applicationDomain:ApplicationDomain = null;		
		/** 加载器 */
		protected var loader:BulkLoader = null;
		
		protected var baseAssetsList:Array = null;
		
		public function LoadModel()
		{
			super();
		}
		
		override public function onRegister():void
		{
			applicationDomain = ApplicationDomain.currentDomain;//new ApplicationDomain( ApplicationDomain.currentDomain );
			dispatcher = new EventDispatcher( this );
		}
		
		override public function onRemove():void
		{
			applicationDomain = null;
			dispatcher = null;
		}
		
		public function execute():void
		{
			loader = new BulkLoader( KEY );
			
			//输出加载日志
			loader.logLevel = BulkLoader.LOG_ERRORS;
			
			loader.addEventListener( BulkProgressEvent.PROGRESS, onAssetsLoading );
			loader.addEventListener( BulkProgressEvent.COMPLETE, onAssetsLoaded );
			
			baseAssetsList = this.getBaseAssetsList();
			var loaderContext:LoaderContext = new LoaderContext();
			loaderContext.applicationDomain = this.applicationDomain;
			
			for each ( var assets:LoadStruct in baseAssetsList )
			{
				loader.add( assets.path, 
					{ 
						id:assets.id,
						maxTries:RETRY_LIMIT,
						type:assets.type,
						context:loaderContext 
					} 
				);
			}
			loader.start( );
		}
		
		public function process( obj:* = null ):void
		{
			
		}
		
		public function result():void
		{
			
		}
		
		/**
		 * 用于实时加载 
		 * @param resRes 需要加载的资源列表
		 */
		public function load( resRes:Array ):void
		{
			var dloader:BulkLoader = new BulkLoader( 'dloader' );
			dloader.logLevel = BulkLoader.LOG_ERRORS;
			dloader.addEventListener(BulkProgressEvent.PROGRESS,onDynamicAssetsLoading );
			dloader.addEventListener(BulkProgressEvent.COMPLETE,onDynamicAssetsLoaded);
			var dloaderContext:LoaderContext = new LoaderContext();
			dloaderContext.applicationDomain = this.applicationDomain;
			
			for each( var assets:LoadStruct in resRes )
			{
				dloader.add( assets.path,
					{ 
						id:assets.id,
						maxTries:RETRY_LIMIT,
						type:assets.type,
						context:dloaderContext
					} 
				);
			}
			
			dloader.start( );
		}
		
		protected function onDynamicAssetsLoading( evt:BulkProgressEvent ):void
		{
			
		}
		
		protected function onDynamicAssetsLoaded( evt:BulkProgressEvent ):void
		{
			var dloader:BulkLoader = evt.currentTarget  as BulkLoader;
			dloader.removeEventListener(BulkProgressEvent.PROGRESS,onDynamicAssetsLoading);
			dloader.removeEventListener(BulkProgressEvent.COMPLETE,onDynamicAssetsLoaded);
			dloader.clear();
		}
		
		/**
		 * 需要下载的资源列表 
		 * @return 
		 * 
		 */
		protected function getBaseAssetsList():Array
		{
			return [
			
			];
		}
		/**
		 * 需要完成后要做的事
		 * @return 
		 * 
		 */
		protected function initAssets():void
		{
			
		}
		
		private function onAssetsLoading( evt:BulkProgressEvent ):void
		{
			//trace( evt.loadingStatus() );
			process( evt );
		}
		
		private function onAssetsLoaded( evt:BulkProgressEvent ):void
		{
			initAssets();
			
			loader.removeEventListener(BulkProgressEvent.PROGRESS,onAssetsLoading);
			loader.removeEventListener(BulkProgressEvent.COMPLETE,onAssetsLoaded);
			loader.clear();
			loader = null;
			
			baseAssetsList = [];
			
			result();
		}
		
		/**
		 * 是否包含类 
		 * @param name
		 * @return 
		 * 
		 */
		public function hasClass( name:String ):Boolean
		{
			return applicationDomain.hasDefinition( name );
		}
		
		/**
		 * 获取类 
		 * @param name
		 * @return 
		 * 
		 */
		public function getClass( name:String ):Class
		{
			return applicationDomain.getDefinition( name ) as Class;
		}
		
		/**
		 * 获取实例 
		 * @param name
		 * @return 
		 * 
		 */
		public function getDisplayObj( name :String ):DisplayObject
		{
			var cls:Class = getClass( name );
			if( null == cls )
				return null;
			return (new cls()) as DisplayObject;
		}
		
		/**
		 * 获取bitmap实例 
		 * @param name
		 * @return 
		 * 
		 */
		public function getBitmap( name:String ):Bitmap
		{
			var cls:Class = getClass( name );
			if( null == cls )
				return null;
			var bmd:BitmapData = new cls(0,0);
			return new Bitmap(bmd);
		}
		
		/**
		 * 获取bitmapdata 
		 * @param name
		 * @return 
		 * 
		 */
		public function getBitmapData( name:String ):BitmapData
		{
			var cls:Class = getClass( name );
			if( null == cls )
				return null;
			return new cls(0,0) as BitmapData;
		}
		
		public function addEventListener( type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false ):void
		{
			dispatcher.addEventListener( type,listener,useCapture,priority,useWeakReference );
		}
		
		public function dispatchEvent( evt:Event ):Boolean
		{
			return dispatcher.dispatchEvent( evt );
		}
		
		public function hasEventListener(type:String):Boolean
		{
			return dispatcher.hasEventListener( type );
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
			dispatcher.removeEventListener( type,listener,useCapture );
		}
		
		public function willTrigger(type:String):Boolean
		{
			return dispatcher.willTrigger( type );
		}
	}
}
package app.model
{
	import app.model.data.ProgressDataStruct;
	import app.model.events.LoadingEvent;
	import app.model.events.ModelEvent;
	
	import com.jfw.engine.core.data.LoadStruct;
	import com.jfw.engine.core.model.LoadModel;
	import com.stimuli.loading.BulkProgressEvent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	/** 游戏数据模块 */
	public class AssetsModel extends LoadModel
	{
		private var monsterData:XML;
		private var npcData:XML;
		private var levelData:XML;
		private var userData:XML;
		
		public function AssetsModel()
		{
			super();
		}
		
		override public function result():void
		{
//			Debugger.trace( this,"AssetsModel load finish..." );
			this.dispatchEvent( new Event( Event.COMPLETE ) );
			//sendEvent( ModelEvent.LOADING_HIDE );
			sendEvent( ModelEvent.GAME_INIT );
		}
		
		override protected function getBaseAssetsList():Array
		{
			var assets:Array = [];
			
			var assetsAry:Array = this.core.configModel.configData['preload'];
			trace( assetsAry.length,"<<>o" );
			for( var i:int = 0,len:int = assetsAry.length; i<len; i++ )
			{
				var loadStruct:LoadStruct = new LoadStruct( assetsAry[i] );
				loadStruct.id = assetsAry[i].id;
				loadStruct.path = loadStruct.path.replace( '$lang$' , this.core.configModel.configData['lang'] );
				loadStruct.type = assetsAry[i].type;
				assets.push( loadStruct );
			}
			assetsAry = null;
			
			return assets;	
		}
		
		override protected function initAssets():void
		{
			for(var i:int = 0, len:int = this.baseAssetsList.length;i<len;i++)
			{
				var asset:LoadStruct = this.baseAssetsList[i] as LoadStruct;
				
				if( LoadStruct.TYPE_BINARY == asset.type )
				{
					
					var content:ByteArray = loader.getBinary( asset.id );
					try
					{
						content.uncompress( );
					}
					catch( e:Error )
					{
						
					}
					
					switch( asset.id )
					{
						case 'monster':
							this.monsterData = XML( content );
							break;
						case 'npc':
							this.npcData = XML( content );
							break;
						case 'levels':
							this.levelData = XML( content );
							break;
						case 'user':
							this.userData = XML( content );
							break;
					}
				}
			}
		}
		
		
		override public function process( obj:*=null ):void
		{
			var evt:BulkProgressEvent = BulkProgressEvent( obj );
			super.process( evt );
			
			var progressVO:ProgressDataStruct = new ProgressDataStruct();
			progressVO.percent = Math.ceil( evt.weightPercent * 100 );
			
			//trace(evt.loadingStatus()," <: loading status");
			
			progressVO.description = evt.itemsLoaded.toString() + '/' + evt.itemsTotal.toString();
			
			sendEvent( LoadingEvent.LOADING_PROCESS,progressVO );
		}
		
		/**
		 * 实时加载过程处理 
		 * @param evt
		 * 
		 */		
		override protected function onDynamicAssetsLoading(evt:BulkProgressEvent):void
		{
			
		}
		
		
		/**
		 * 实时加载完成处理 
		 * @param evt
		 * 
		 */		
		override protected function onDynamicAssetsLoaded(evt:BulkProgressEvent):void
		{
			
		}
	}
}
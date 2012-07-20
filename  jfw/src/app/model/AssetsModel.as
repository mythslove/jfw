package app.model
{
	import app.model.data.ProgressDataStruct;
	import app.model.events.LoadingEvent;
	import app.model.events.ModelEvent;
	
	import com.jfw.engine.core.data.LoadStruct;
	import com.jfw.engine.core.mvc.model.LoadModel;
	import com.stimuli.loading.BulkProgressEvent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	/** 游戏数据模块 */
	public class AssetsModel extends LoadModel
	{
		public function AssetsModel()
		{
			super();
		}
		
		override protected function getBaseAssetsList():Array
		{
			var assets:Array = [];
			
			var assetsAry:Array = this.core.configModel.configData['preload'];
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
		
		override public function result():void
		{
			super.result();
			//Debugger.trace( this,"AssetsModel load finish..." );
			
			//sendEvent( ModelEvent.LOADING_HIDE );
			sendEvent( ModelEvent.GAME_INIT );
		}
	}
}
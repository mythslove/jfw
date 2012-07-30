package app.mvc.model
{
	import app.mvc.model.data.ProgressDataStruct;
	import app.mvc.control.events.LoadingEvent;
	import app.mvc.control.events.ModelEvent;
	import app.mvc.model.net.NetRequest;
	
	import com.jfw.engine.core.data.LoadStruct;
	import com.jfw.engine.core.mvc.model.IAssetModel;
	import com.jfw.engine.core.mvc.model.LoadModel;
	import com.jfw.engine.utils.logger.Logger;
	import com.stimuli.loading.BulkProgressEvent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	/** 游戏数据模块 */
	public class AssetsModel extends LoadModel implements IAssetModel
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
			
			//Logger.info(evt.loadingStatus()," <: loading status");
			
			progressVO.description = evt.itemsLoaded.toString() + '/' + evt.itemsTotal.toString();
			
			sendEvent( LoadingEvent.LOADING_PROCESS,progressVO );
		}
		
		override public function result():void
		{
			super.result();
			Logger.info( "AssetsModel load finish..." );
			
			//sendEvent( ModelEvent.LOADING_HIDE );
			sendEvent( NetRequest.UserInit );
		}
	}
}
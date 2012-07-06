package app.model
{
	import app.model.events.LoadingEvent;
	import app.model.events.ModelEvent;
	
	import com.jfw.engine.core.data.LoadStruct;
	import com.jfw.engine.core.model.LoadModel;
	import com.stimuli.loading.BulkProgressEvent;
	
	import flash.events.Event;

	/** Loading */
	public class LoadingModel extends LoadModel
	{
		public function LoadingModel()
		{
			super();
		}
		
		override public function result():void
		{
//			Debugger.trace( this,"LoadingModel load finish..." );
			this.dispatchEvent( new Event( Event.COMPLETE ) );
			
			sendEvent( LoadingEvent.LOADING_SHOW );
		}
		
		override public function process( obj:* = null ):void
		{
			var evt:BulkProgressEvent = obj as BulkProgressEvent;
			
			
		}
		
		override protected function getBaseAssetsList():Array
		{
			
			var loading:LoadStruct = new LoadStruct();
			loading.id = 'loading';
			loading.path = 'assets/swf/loading.swf';
			loading.type = 'movieclip';
			
			return [ loading ];
		}
		
	}
}
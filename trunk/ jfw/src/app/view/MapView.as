package app.view
{
	import app.model.events.LoadingEvent;
	import app.model.events.ModelEvent;
	
	import com.jfw.engine.core.data.IStruct;
	import com.jfw.engine.core.mvc.view.BView;
	
	import flash.display.DisplayObjectContainer;
	
	/**
	 * 地图场景
	 * @author jianzi
	 * 
	 */	
	public class MapView extends BView
	{
		public function MapView(mapContainer:DisplayObjectContainer,data:IStruct=null)
		{
			super(data);
			sendEvent( LoadingEvent.LOADING_HIDE );
			
			if( mapContainer )
				mapContainer.addChild( this );
		}
	}
}
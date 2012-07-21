package app.view
{
	import app.control.events.LoadingEvent;
	import app.control.events.ModelEvent;
	
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
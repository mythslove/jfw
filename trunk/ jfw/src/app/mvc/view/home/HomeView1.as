package app.mvc.view.home
{
	import app.mvc.control.events.HomeEvent;
	import app.mvc.control.events.LoadingEvent;
	import app.mvc.model.data.BuildingStruct;
	
	import com.jfw.engine.core.data.IStruct;
	import com.jfw.engine.core.mvc.view.map.BIsoMap;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class HomeView1 extends BIsoMap
	{
		private var buildings:Vector.<BuildingStruct>;
		
		private var _homeMc:MovieClip;
		
		public function HomeView1( mapContainer:DisplayObjectContainer = null,data:IStruct=null )
		{
			super( data );
			
			if( mapContainer )
			{
				mapContainer.addChild( this );
//				this.showGrid( true );
			}
		}
		
		override protected function onInit():void
		{
//			super.onInit();
//			this.makeCenter();
			
			this.addChild( this.homeMc );
			
			sendEvent( LoadingEvent.LOADING_HIDE );
		}
		
		override protected function listEventInterests():Array
		{
			return [
				HomeEvent.INIT_BUILDING
			];
		}
		
		override protected function handleEvent(evt:String, param:Object):void
		{
			switch( evt )
			{
				case HomeEvent.INIT_BUILDING:
					this.initBuildings();
					break;
			}
		}
		
		private function initBuildings():void
		{
			for( var i:int = 0,len:int = this.buildings.length; i < len; i++ )
			{
				
			}
		}
		
		override protected function onClick(event:MouseEvent):void
		{
			
		}
		
		override protected function onMouseUp(event:MouseEvent):void
		{
			super.onMouseUp( event );
		}
		
		override protected function onMouseDown(event:MouseEvent):void
		{
			super.onMouseDown( event );
		}
		
		override protected function onMouseMove(event:MouseEvent):void
		{
		}
		
		private function get homeMc():MovieClip
		{
			return ( _homeMc ) ? _homeMc : core.assetsModel.getDisplayObj( 'HomeMc' ) as MovieClip;
		}
	}
}
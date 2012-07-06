package app.view
{
	import app.model.events.LoadingEvent;
	import app.model.events.ModelEvent;
	
	import com.jfw.engine.core.data.IStruct;
	import com.jfw.engine.core.view.BView;
	import com.jfw.engine.core.view.map.BIsoMap;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	
	/**
	 * 主城 
	 * @author jianzi
	 */	
	public class HomeView extends BIsoMap
	{
		private var mapBg:Bitmap = null;
			
		public function HomeView( mapContainer:DisplayObjectContainer = null,data:IStruct=null)
		{
			super(data);
			
			if( mapContainer )
			{
				mapContainer.addChild( this );
				this.showGrid( true );
			}
		}
		
		override public function initMapBg():void
		{
			super.initMapBg();
			
			var bmpBg:Bitmap = this.core.assetsModel.getBitmap('HomeBg');
			if( bmpBg )
				setMapBg( bmpBg );
		}
		
		override protected function onInit():void
		{
			super.onInit();
			
			
			this.makeCenter();
			sendEvent( LoadingEvent.LOADING_HIDE );
		}
		
		private function setMapBg( bitmap:Bitmap ):void
		{
			this.mapBg = new Bitmap();
			this.addChild( this.mapBg );
			
//			var bmpData:BitmapData = new BitmapData( sceneRect.width, sceneRect.height, false, 0xFFFFFF );
//			bmpData.draw( bitmap );
			mapBg.bitmapData = bitmap.bitmapData;// bmpData;
//			makeCenter();
		}
		
		override protected function onClick(event:MouseEvent):void
		{
			trace("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Click");
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
			trace("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Move");
		}
	}
}
package app.mvc.view
{
	import app.mvc.model.data.BuildingStruct;
	import app.mvc.control.events.HomeEvent;
	import app.mvc.control.events.LoadingEvent;
	import app.mvc.control.events.ModelEvent;
	import app.mvc.view.iso.isoSprites.building.MapBuilding;
	import app.mvc.view.ui.component.alert.Alert;
	import app.mvc.view.ui.component.alert.AlertSmallWindow;
	import app.mvc.view.ui.component.alert.AlertWindow;
	import app.mvc.view.ui.window.AddGemWindow;
	import app.mvc.view.ui.window.NoticeWindow;
	import app.mvc.view.ui.window.ShopWindow;
	
	import com.jfw.engine.core.data.IStruct;
	import com.jfw.engine.core.mvc.view.BView;
	import com.jfw.engine.core.mvc.view.map.BIsoMap;
	import com.jfw.engine.utils.Queue;
	import com.jfw.engine.utils.manager.PopUpManager;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import mx.binding.BindingManager;
	import mx.binding.utils.BindingUtils;
	
	
	/**
	 * 主城 
	 * @author jianzi
	 */	
	public class HomeView extends BIsoMap
	{
		private var mapBg:Bitmap = null;
		
		private var buildings:Vector.<BuildingStruct>;
		
		private var path:Array;
		
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
//			this.debug();
			
			this.makeCenter();
			
			//test
			var homeTown:MapBuilding = new MapBuilding( 'B10001',4,4 );
			homeTown.moveTo( 5*30,5*30,0 );
			this.isoScene.addChild( homeTown );
			
			homeTown = new MapBuilding( 'B10002',4,4 );
			homeTown.moveTo( 10*30,5*30,0 );
			this.isoScene.addChild( homeTown );
			
			homeTown = new MapBuilding( 'B10003',4,4 );
			homeTown.moveTo( 5*30,10*30,0 );
			this.isoScene.addChild( homeTown );
			
			homeTown = new MapBuilding( 'B10004',4,4 );
			homeTown.moveTo( 14*30,8*30,0 );
			this.isoScene.addChild( homeTown );
			
			homeTown = new MapBuilding( 'B10005',4,4 );
			homeTown.moveTo( 8*30,15*30,0 );
			this.isoScene.addChild( homeTown );
			
			this.isoScene.render();
			
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
		
		private function setMapBg( bitmap:Bitmap ):void
		{
			this.mapBg = new Bitmap();
			this.addChild( this.mapBg );
			
//			var bmpData:BitmapData = new BitmapData( sceneRect.width, sceneRect.height, false, 0xFFFFFF );
//			bmpData.draw( bitmap );
			mapBg.bitmapData = bitmap.bitmapData;// bmpData;
//			makeCenter();
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
		
		
		private function debug():void
		{
			//			var windowQueue:Queue = new Queue();
			//			windowQueue.add( new NoticeWindow() );
			//			windowQueue.add( new ShopWindow() );
			//			windowQueue.execute();
			
			//			Alert.show( "fuck", Alert.SHARE );
			//			Alert.show( 'fffffffffff',Alert.OK,null,'small' );
			//			WindowManager.openWindow( new NoticeWindow() );
			//			WindowManager.openWindow( new ShopWindow() );
		}
	}
}
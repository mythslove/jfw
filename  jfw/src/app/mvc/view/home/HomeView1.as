package app.mvc.view.home
{
	import app.mvc.control.events.HomeEvent;
	import app.mvc.control.events.LoadingEvent;
	import app.mvc.control.events.ModelEvent;
	import app.mvc.model.data.BuildingStruct;
	import app.mvc.view.ui.window.equip.EquipWindow;
	import app.mvc.view.ui.window.home.HomeWindow;
	import app.mvc.view.ui.window.monster.MonsterWindow;
	import app.mvc.view.ui.window.rank.RankWindow;
	import app.mvc.view.ui.window.shop.ShopWindow;
	import app.mvc.view.ui.window.spell.SpellWindow;
	
	import com.jfw.engine.core.data.IStruct;
	import com.jfw.engine.core.mvc.view.WindowManager;
	import com.jfw.engine.core.mvc.view.map.BIsoMap;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class HomeView1 extends BIsoMap
	{
		static public const INIT_HOME_FINISH:String = 'initHomeFinish';
		
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
			this.homeMc.addEventListener( INIT_HOME_FINISH,onHomeInitFinish );
		
			sendEvent( LoadingEvent.LOADING_HIDE );
		}
		
		override public function destroy():void
		{
			this.removeEventListener(MouseEvent.CLICK , onClick );
			this.removeEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
			stage.removeEventListener( MouseEvent.MOUSE_UP, onMouseUp );
			this.removeEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			
			this._homeMc = null;
			this.buildings = null;
			super.destroy();
		}
		
		protected function onHomeInitFinish(event:Event):void
		{
			this.homeMc.removeEventListener( INIT_HOME_FINISH,onHomeInitFinish );
			
			sendEvent( ModelEvent.UI_INIT );
			
			addEventListener( MouseEvent.CLICK, onClick );
			addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
			stage.addEventListener( MouseEvent.MOUSE_UP, onMouseUp );
			addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
		}		
		
		override protected function onClick(event:MouseEvent):void
		{
			switch( event.target.name )
			{
				case '$pbHome':
					WindowManager.getInstance().openWindow( new HomeWindow(),null,true);
					break;
				case '$pbRole':
					WindowManager.getInstance().openWindow( new MonsterWindow(),null,true);
					break;
				case '$pbShop':
					WindowManager.getInstance().openWindow(new ShopWindow(),null,true);
					break;
				case '$pbElement':
					break;
				case '$pbSpell':
					WindowManager.getInstance().openWindow( new SpellWindow(),null,true);
					break;
				case '$pbRank':
					WindowManager.getInstance().openWindow( new RankWindow(),null,true);
					break;
				case '$pbEquip':
					WindowManager.getInstance().openWindow( new EquipWindow(),null,true);
					break;
			}
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
					break;
			}
		}
		
		override protected function onMouseUp(event:MouseEvent):void
		{
		}
		
		override protected function onMouseDown(event:MouseEvent):void
		{
			
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
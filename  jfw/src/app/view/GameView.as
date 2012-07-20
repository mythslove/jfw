package app.view
{
	import app.model.BattleModel;
	import app.model.events.BattleEvent;
	import app.model.events.LoadingEvent;
	import app.model.events.ModelEvent;
	import app.view.init.LoadingView;
	import app.view.ui.MainUIView;
	import app.view.ui.component.Tip;
	
	import com.jfw.engine.core.base.Core;
	import com.jfw.engine.core.data.IStruct;
	import com.jfw.engine.core.mvc.view.BView;
	import com.jfw.engine.utils.Stats;
	import com.jfw.engine.utils.manager.PopUpManager;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	public class GameView extends BView
	{
		private var gameContainer:DisplayObjectContainer = null;
		
		private var loadingView:LoadingView = null;
		
		private var mapLayer:Sprite = null;
		private var uiLayer:Sprite = null;
		private var popLayer:Sprite = null;
		private var debugLayer:Sprite = null;
		
		public function GameView( container:DisplayObjectContainer, data:IStruct=null )
		{
			super( data );
			
			if( container != null )
			{
				this.gameContainer = container;
				this.gameContainer.addChild( this );
			}
		}
		
		override protected function onInit( ):void
		{
			mapLayer = new Sprite();
			uiLayer = new Sprite();
			popLayer = new Sprite();
			
			this.addChild( mapLayer );
			this.addChild( uiLayer );
			this.addChild( popLayer );
			
			
			//初始化Popup管理器
			PopUpManager.init( popLayer, true, 0x0, .5 );
			Tip.init(this.gameContainer);
			
			//Debug
			CONFIG::debug {
				this.addChild( new Stats() );
			}
		}
		
		override public function destroy( ):void
		{
			this.mapLayer = null;
			this.uiLayer = null;
			this.popLayer = null;
			this.gameContainer = null;
			this.loadingView = null;
			super.destroy( );
		}
		
		override protected function listEventInterests():Array
		{
			return [
				LoadingEvent.LOADING_SHOW,
				LoadingEvent.LOADING_HIDE,
				ModelEvent.GAME_INIT,
				BattleEvent.BATTLE_RES_LOAD_COMPLETE
			];
		}
		
		override protected function handleEvent(evt:String, param:Object):void
		{
			switch( evt )
			{
				case LoadingEvent.LOADING_SHOW :
					if( !loadingView )
						loadingView = new LoadingView();
					this.addChild( loadingView );
					break;
				case LoadingEvent.LOADING_HIDE :
					if( loadingView )
						this.removeChild( loadingView ); 
					loadingView = null;
					break;
				case ModelEvent.GAME_INIT :
					trace( 'Game init ...' );
					new HomeView( this.mapLayer );
					new MainUIView( this.uiLayer );
					break;
				case BattleEvent.BATTLE_RES_LOAD_COMPLETE:
					new BattleView(this.mapLayer);
					break;
			}
		}
	}
}
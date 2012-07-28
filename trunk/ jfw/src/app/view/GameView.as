package app.view
{
	import app.control.events.BattleEvent;
	import app.control.events.LoadingEvent;
	import app.control.events.ModelEvent;
	import app.model.BattleModel;
	import app.view.init.LoadingView;
	import app.view.ui.MainShortCut;
	import app.view.ui.MainUI;
	import app.view.ui.component.Tip;
	import app.view.ui.component.alert.Alert;
	
	import com.jfw.engine.core.base.Core;
	import com.jfw.engine.core.data.IStruct;
	import com.jfw.engine.core.mvc.view.BView;
	import com.jfw.engine.utils.Stats;
	import com.jfw.engine.utils.logger.Logger;
	import com.jfw.engine.utils.manager.PopUpManager;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.events.MouseEvent;
	
	public class GameView extends BView
	{
		private var gameContainer:DisplayObjectContainer = null;
		
		private var loadingView:LoadingView = null;
		
		private var mapLayer:Sprite = null;
		private var uiLayer:Sprite = null;
		private var popLayer:Sprite = null;
		private var shortCutLayer:Sprite = null;
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
			shortCutLayer = new Sprite();
			
			this.addChild( mapLayer );
			this.addChild( uiLayer );
			this.addChild( popLayer );
			this.addChild( shortCutLayer );
			
			
			//初始化Popup管理器
			PopUpManager.init( popLayer, true, 0x0, .5 );
			Tip.init(this.gameContainer);
			
			//Debug
			CONFIG::debug {
				//this.addChild( new Stats() );
			}
		}
		
		override public function destroy( ):void
		{
			this.mapLayer = null;
			this.uiLayer = null;
			this.popLayer = null;
			this.shortCutLayer = null;
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
					this.mapLayer.addChild( loadingView );
					break;
				case LoadingEvent.LOADING_HIDE :
					if( loadingView )
						this.mapLayer.removeChild( loadingView ); 
					loadingView = null;
					break;
				case ModelEvent.GAME_INIT :
					Logger.info( 'Game init ...' );
					
					new HomeView( this.mapLayer );
					new MainUI( this.uiLayer );
					new MainShortCut( this.shortCutLayer );
					
//					var battleModel:BattleModel=Core.getInstance().retModel("BattleModel") as BattleModel;
//					battleModel.startLoad(null);
					break;
				case BattleEvent.BATTLE_RES_LOAD_COMPLETE:
					new BattleView(this.mapLayer);
					break;
			}
		}
	}
}
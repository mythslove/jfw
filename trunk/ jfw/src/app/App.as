package app
{
	import app.manager.ResourceManager;
	import app.mvc.control.LoadPicCmd;
	import app.mvc.control.WarnCmd;
	import app.mvc.control.events.ModelEvent;
	import app.mvc.model.BattleModel;
	import app.mvc.model.DebugModel;
	import app.mvc.model.LoadingModel;
	import app.mvc.model.MaterialModel;
	import app.mvc.model.MonsterModel;
	import app.mvc.model.WarnModel;
	import app.mvc.model.net.NetModel;
	import app.mvc.model.net.NetRequest;
	import app.mvc.model.player.FriendModel;
	import app.mvc.model.player.PlayerModel;
	import app.mvc.model.res.AssetsModel;
	import app.mvc.model.res.ConfigModel;
	import app.mvc.model.res.LoadPicModel;
	import app.mvc.model.spell.SpellModel;
	import app.mvc.view.GameView;
	
	import com.jfw.engine.AbsGameWorld;
	import com.jfw.engine.utils.Queue;
	
	public class App extends AbsGameWorld
	{
		private var queue:Queue = null;
		
		private static var instance:App ;
		
		public function App()
		{
			if( instance )
				throw new Error();
			instance = this;
		}
		
		static public function getInstance():App
		{
			if( !instance )
				instance = new App();
			return instance;
		}
		
		override protected function initCmds():void
		{
			NetRequest.getInstance().init();

			//register commands
			this.regCmd( ModelEvent.ERROR_REFRESH_ALERT,WarnCmd );
			this.regCmd( ModelEvent.LOAD_PIC,LoadPicCmd );
			
			//Net Commands
			var netCommands:Array = NetRequest.getInstance().netCommands;
			for( var netId:String in netCommands )
			{
				var callCmd:String = netCommands[netId][1];
				var callBackCmd:String = netCommands[netId][2];
				var cmdCls:Class = netCommands[netId][0];
				this.regCmds( [ callCmd,callBackCmd ], cmdCls ); 
			}
		}
		
		override  protected function initModels():void
		{
			//顺序加载
			queue = new Queue();
			queue.add( new ConfigModel( ) );
			queue.add( new LoadingModel( ) );
			queue.add( new AssetsModel( ) );
			
			new DebugModel( );
			new LoadPicModel( );
			new WarnModel( );
			new MaterialModel( ) ;
			new PlayerModel( );
			new FriendModel( );
			new SpellModel( );
			new MonsterModel( );
			new BattleModel( );
		}
		
		override protected function initViews():void
		{
			new GameView( this.gameStage );
		}
		
		override protected function startGame():void
		{
			queue.execute( );
		}
	}
}
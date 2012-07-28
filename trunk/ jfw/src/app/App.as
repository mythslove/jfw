package app
{
	import app.control.WarnCmd;
	import app.control.events.ModelEvent;
	import app.manager.ResourceManager;
	import app.model.AssetsModel;
	import app.model.BattleModel;
	import app.model.ConfigModel;
	import app.model.DebugModel;
	import app.model.LoadingModel;
	import app.model.MaterialModel;
	import app.model.WarnModel;
	import app.model.net.NetModel;
	import app.model.net.NetRequest;
	import app.model.player.FriendModel;
	import app.model.player.PlayerModel;
	import app.view.GameView;
	
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

			this.regCmd( ModelEvent.ERROR_REFRESH_ALERT,WarnCmd );
			
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
			new WarnModel( );
			new MaterialModel( ) ;
			new PlayerModel( );
			new FriendModel( );
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
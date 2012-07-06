package app
{
	import app.model.AssetsModel;
	import app.model.BattleModel;
	import app.model.ConfigModel;
	import app.model.GuidModel;
	import app.model.LoadingModel;
	import app.model.LoginModel;
	import app.model.MissionModel;
	import app.model.NetModel;
	import app.model.UserModel;
	import app.view.GameView;
	
	import com.jfw.engine.core.app.AbsGameWorld;
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
		
		override  protected function initModels():void
		{
			//顺序加载
			queue = new Queue();
			queue.add( new ConfigModel( ) );
			queue.add( new LoadingModel( ) );
			queue.add( new AssetsModel( ) );

			new NetModel( );
			new LoginModel( );
			new UserModel( );
			new GuidModel( );
			new MissionModel( );
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
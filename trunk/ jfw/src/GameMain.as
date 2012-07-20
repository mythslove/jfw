package
{
	import app.App;
	
	import com.demonsters.debugger.MonsterDebugger;
	import com.jfw.engine.utils.Stats;
	import com.jfw.engine.utils.logger.Logger;
	
	import flash.display.Sprite;
	import flash.system.Security;

	[SWF(width="760",height="700",frameRate="24", backgroundColor="#ffffff")]
	
	public class GameMain extends Sprite
	{
		public function GameMain()
		{
			Security.allowDomain( "*" );
			Security.allowInsecureDomain( "*" );
			
			CONFIG::debug {
				MonsterDebugger.initialize(this);
			}
			
			this.run( );
		}
		
		public function run( ):void
		{
			Logger.info( 'GameMain.run Entry...' );
			App.getInstance( ).initWorld( this.stage );
		}
	}
}
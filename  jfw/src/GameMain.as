package
{
	import app.App;
	
	import com.jfw.engine.utils.Stats;
	
	import flash.display.Sprite;
	import flash.system.Security;

	[SWF(width="768",height="610",frameRate="24", backgroundColor="#ffffff")]
	
	public class GameMain extends Sprite
	{
		
		static public const DEBUG:Boolean = true;
		
		public function GameMain()
		{
			Security.allowDomain( "*" );
			Security.allowInsecureDomain( "*" );
			this.run( );
		}
		
		public function run( ):void
		{
			trace( this,'GameMain.run Entry...' );
			App.getInstance( ).initWorld( this.stage );
		}
	}
}
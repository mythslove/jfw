package app.model
{
	import com.jfw.engine.core.model.BModel;
	
	/** 游戏主模块 */
	public class GameModel extends BModel
	{
		static public const NAME:String = 'GameModel';
		
		public function GameModel()
		{
			super( NAME );
		}
	}
}
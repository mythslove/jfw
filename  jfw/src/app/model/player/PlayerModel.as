package app.model.player
{
	import app.model.data.player.PlayerStruct;
	
	import com.jfw.engine.core.mvc.model.BModel;
	
	[Bindable]
	public class PlayerModel extends BModel
	{
		static public const NAME:String = 'PlayerModel';

		private var _playerVO:PlayerStruct ;
		
		public function PlayerModel()
		{
			super( NAME );
		}
		
		/**
		 * 初始化玩家信息 
		 * @param info
		 */
		public function initPlayerVO( info:Object ):void
		{
			this.playerVO = new PlayerStruct( info );
		}
		
		public function get playerVO( ):PlayerStruct
		{
			return this._playerVO
		}
		
		public function set playerVO( val:PlayerStruct ):void
		{
			this._playerVO = val;
		}
	}
}
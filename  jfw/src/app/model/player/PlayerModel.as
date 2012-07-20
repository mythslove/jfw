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
			
			/** test */
			this._playerVO = new PlayerStruct();
			this._playerVO.aid = 'C10001';
			this._playerVO.exp = 100;
			this._playerVO.gb = 5000;
			this._playerVO.yb = 234;
			this._playerVO.power = 190;
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
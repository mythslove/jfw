package app.model
{
	import app.model.data.BuildingStruct;
	
	import com.jfw.engine.core.mvc.model.BModel;
	
	/** 游戏主模块 */
	
	[Bindable]
	public class HomeModel extends BModel
	{
		static public const NAME:String = 'GameModel';
		
		private var _buildings:Vector.<BuildingStruct> ;
		
		public function HomeModel()
		{
			super( NAME );
		}
		
		public function get buildings():Vector.<BuildingStruct>
		{
			return this._buildings;
		}
		
		public function set buildings( val:Vector.<BuildingStruct> ):void
		{
			this._buildings = val;
		}
	}
}
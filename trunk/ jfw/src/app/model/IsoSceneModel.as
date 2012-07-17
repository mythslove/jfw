package app.model
{
	import app.view.iso.BaseIsoView;
	
	import com.bossa.monsters.view.iso.isoScenes.GroundIsoScene;
	import com.jfw.engine.core.mvc.model.BModel;
	
	public class IsoSceneModel extends BModel
	{
		static public const NAME:String = 'IsoSceneModel';
		
		/** 地表 */
		private var _groundIsoScene:GroundIsoScene;
		
		private var _isoView:BaseIsoView;
		
		public function IsoSceneModel()
		{
			super( NAME );
		}
		
		public function get groundIsoScene():GroundIsoScene
		{
			return this._groundIsoScene;
		}
		
		public function set groundIsoScene(val:GroundIsoScene):void
		{
			this._groundIsoScene = val;
		}
		
		public function get isoView( ) :BaseIsoView
		{
			return this._isoView;
		}
		
		public function set isoView( val:BaseIsoView ):void
		{
			this._isoView = val;
		}
	}
}
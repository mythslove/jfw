package app.battle
{
	import com.jfw.engine.core.base.Core;
	import com.jfw.engine.core.mvc.model.IAssetModel;
	import com.jfw.engine.core.mvc.model.IConfigModel;

	public class DataProvider
	{
		private static var instance:DataProvider=null;

		public function DataProvider()
		{
		}
		
		public static function get Instance():DataProvider
		{
			return instance||=new DataProvider();
		}
		
		public function getRoleAttrById(id:String,attr:String):String
		{
			var data:XML=assetsModel.getXML("roledata");
			var attr:String=data.(@id==id).attribute( attr );
			return attr;
		}
		
		public function getMagicAttrById(id:String,attr:String):String
		{
			var data:XML=assetsModel.getXML("magicdata");
			var attr:String=data.(@id==id).attribute( attr );
			return attr;
		}
		
		public function getMapIdById(id:String):String
		{
			return "MAP_"+id;
		}
		
		public function getMapBgById(id:String):String
		{
			return "D"+id;
		}
		
		/**
		 * 获取配置model 
		 * @return 
		 * 
		 */
		private function get configModel():IConfigModel
		{
			return Core.getInstance().configModel;
		}
		
		/**
		 * 获取资源model 
		 * @return 
		 * 
		 */
		private function get assetsModel():IAssetModel
		{
			return Core.getInstance().assetsModel;
		}
	}
}
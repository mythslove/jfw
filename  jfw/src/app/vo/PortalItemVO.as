package app.mvc.models.vo.item
{
	import com.pianfeng.engine.isolib.map.data.Tile;

	public class PortalItemVO 
	{
		/** 对应门的id */
		public var portalID:int=0;
		/** 使用次数 */
		public var passTimes:int=0;
		/** 保存传送之前的地图块*/
		public var oldDirectTile:Tile=null;
	}
}
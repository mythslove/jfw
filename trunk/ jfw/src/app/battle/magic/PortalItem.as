package app.mvc.views.game.mapItem.item
{
	import app.mvc.models.vo.item.PortalItemVO;
	import app.mvc.views.game.mapItem.base.BaseBattleItem;
	
	import com.pianfeng.engine.animation.data.IAnimationObj;
	import com.pianfeng.engine.isolib.map.data.Tile;
	
	public class PortalItem extends BaseBattleItem
	{
		private var itemVO:PortalItemVO;
		
		public function PortalItem(id:int,itemID:int, type:int,level:int=0, animation:IAnimationObj=null, gridX:int=0, gridY:int=0)
		{
			super(id,itemID, type, level,animation, gridX, gridY);
			itemVO=new PortalItemVO();
		}
		
		override public function get DType():int
		{
			return 0;
		}
		
		override public function get VO():*
		{
			return itemVO;
		}
		/**
		 * 对应的传送门id
		 * 
		 */		
		public function get PortalID():int
		{
			return itemVO.portalID;
		}
		/**
		 * 对应的传送门id
		 * @param value
		 * 
		 */		
		public function set PortalID(value:int):void
		{
			itemVO.portalID=value;
		}
		/**
		 * 被触发的次数
		 * 
		 */		
		public function get PassTimes():int
		{
			return itemVO.passTimes;
		}
		/**
		 * 被触发的次数
		 * @param value
		 * 
		 */		
		public function set PassTimes(value:int):void
		{
			itemVO.passTimes=value;
		}
		/**
		 * 记录触发人触发时的地图块,记录方向信息
		 * 
		 */		
		public function get OldDirectTile():Tile
		{
			return itemVO.oldDirectTile;
		}
		/**
		 * 记录触发人触发时的地图块,记录方向信息
		 * @param value
		 * 
		 */		
		public function set OldDirectTile(value:Tile):void
		{
			itemVO.oldDirectTile=value;
		}
	}
}
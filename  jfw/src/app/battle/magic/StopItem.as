package app.mvc.views.game.mapItem.item
{
	import app.globals.consts.CharactorConst;
	import app.mvc.models.vo.item.StopItemVO;
	import app.mvc.views.game.mapItem.base.BaseBattleItem;
	
	import com.pianfeng.engine.animation.data.IAnimationObj;
	import com.pianfeng.engine.animation.player.AnimationPlayer;
	/**
	 * 停止道具 
	 * @author PianFeng
	 * 
	 */	
	public class StopItem extends BaseBattleItem
	{
		private var itemVO:StopItemVO;
		
		public function StopItem(id:int,singleID:int,type:int,level:int=0,animation:IAnimationObj=null,gridX:int=0,gridY:int=0)
		{
			super(id,singleID,type,level,animation,gridX,gridY);
			itemVO=new StopItemVO();
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
		 * 持续秒数
		 * @return 
		 * 
		 */		
		public function get DT():int
		{
			return itemVO.dt;
		}
		/**
		 * 持续秒数
		 * @param value
		 * 
		 */		
		public function set DT(value:int):void
		{
			itemVO.dt=value;
		}
	}
}
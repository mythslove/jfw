package app.mvc.views.game.mapItem.magic
{
	import app.mvc.models.vo.item.MagicItemVO;
	import app.mvc.views.game.mapItem.base.BaseBattleItem;
	
	import com.pianfeng.engine.animation.data.IAnimationObj;
	
	public class MagicItem extends BaseBattleItem
	{
		private var itemVO:MagicItemVO;
			
		public function MagicItem(id:int, itemID:int, type:int, level:int=1,animation:IAnimationObj=null,gridX:int=0, gridY:int=0)
		{
			super(id, itemID, type, level,animation, gridX, gridY);
			itemVO=new MagicItemVO();
		}
		
		override public function get DType():int
		{
			return 1;
		}
		/**
		 * 作用类型1
		 * @return 
		 * 
		 */		
		public function get AType1():int
		{
			return itemVO.atype1;
		}
		/**
		 * 作用类型1
		 * @param value
		 * 
		 */		
		public function set AType1(value:int):void
		{
			itemVO.atype1=value;
		}
		
		/**
		 * 作用值1
		 * @return 
		 * 
		 */		
		public function get AValue1():int
		{
			return itemVO.avalue1;
		}
		/**
		 * 作用值1
		 * @param value
		 * 
		 */		
		public function set AValue1(value:int):void
		{
			itemVO.avalue1=value;
		}
		
		/**
		 * 产生的buff类型1
		 * @return 
		 * 
		 */		
		public function get BUFF1():int
		{
			return itemVO.buff1;
		}
		/**
		 * 产生的buff类型1
		 * @param value
		 * 
		 */		
		public function set BUFF1(value:int):void
		{
			itemVO.buff1=value;
		}
		
		/**
		 * 持续时间1
		 * @return 
		 * 
		 */		
		public function get DT1():int
		{
			return itemVO.dt1;
		}
		/**
		 * 持续时间1
		 * @param value
		 * 
		 */		
		public function set DT1(value:int):void
		{
			itemVO.dt1=value;
		}
		
		/**
		 * 作用类型2
		 * @return 
		 * 
		 */		
		public function get AType2():int
		{
			return itemVO.atype2;
		}
		/**
		 * 作用类型2
		 * @param value
		 * 
		 */		
		public function set AType2(value:int):void
		{
			itemVO.atype2=value;
		}
		
		/**
		 * 作用值2
		 * @return 
		 * 
		 */		
		public function get AValue2():int
		{
			return itemVO.avalue2;
		}
		/**
		 * 作用值2
		 * @param value
		 * 
		 */		
		public function set AValue2(value:int):void
		{
			itemVO.avalue2=value;
		}
		
		/**
		 * 产生的buff类型2
		 * @return 
		 * 
		 */		
		public function get BUFF2():int
		{
			return itemVO.buff2;
		}
		/**
		 * 产生的buff类型2
		 * @param value
		 * 
		 */		
		public function set BUFF2(value:int):void
		{
			itemVO.buff2=value;
		}
		
		/**
		 * 持续时间2
		 * @return 
		 * 
		 */		
		public function get DT2():int
		{
			return itemVO.dt2;
		}
		/**
		 * 持续时间2
		 * @param value
		 * 
		 */		
		public function set DT2(value:int):void
		{
			itemVO.dt2=value;
		}
	}
}
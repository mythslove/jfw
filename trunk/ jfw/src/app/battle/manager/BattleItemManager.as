package app.mvc.models.manager
{
	import app.mvc.views.game.mapItem.base.BaseBattleItem;
	import app.mvc.views.game.mapItem.base.BaseItem;
	import app.globals.interfaces.IBattleItem;
	
	import com.pianfeng.engine.global.interfaces.IDispose;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	public class BattleItemManager extends EventDispatcher
	{
		static private var instance:BattleItemManager=null;
		public var itemArr:Array=[]; 
		
		public function BattleItemManager(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		static public function getInstance():BattleItemManager
		{
			if(instance==null)
				instance = new BattleItemManager();
			
			return instance;
		}
		/**
		 *得到道具数 
		 * @return 
		 * 
		 */		
		public function getItemLength():uint
		{
			return itemArr.length;
		}
		/**
		 *删除指定道具 
		 * @param char
		 * 
		 */		
		public function removeItem(item:IBattleItem):Boolean
		{
			var i:int=itemArr.indexOf(item);
			
			if(i!=-1)
			{
				itemArr.splice(i,1);
				return true;
			}
			else
			{
				return false;
			}	
		}
		/**
		 *删除指定索引道具 
		 * @param char
		 * 
		 */		
		public function removeItemAt(xIndex:int,yIndex:int):Boolean
		{
			for each(var item:IBattleItem in itemArr)
			{
				if(item.GridX==xIndex&&item.GridY==yIndex)
				{
					var i:int=itemArr.indexOf(item);
					itemArr.splice(i,1);
					return true;
				}
			}
			
			return false;
		}
		/**
		 *加入道具
		 * @param args 可以一次加多个
		 * 
		 */		
		public function addItem(...args):void
		{
			for each(var c:IBattleItem in args)
			{
				itemArr.push(c);
			}
		}		
		/**
		*得到指定索引道具 
		* @param char
		* 
		*/		
		public function getItemAt(xIndex:int,yIndex:int):IBattleItem
		{
			for each(var item:IBattleItem in itemArr)
			{
				if(item.GridX==xIndex&&item.GridY==yIndex)
				{
					return item;
				}
			}
			
			return null;
		}
		/**
		 *根据id得到道具 
		 * @param id
		 * @return 
		 * 
		 */		
		public function getItemByID(id:int):IBattleItem
		{
			for each(var item:BaseBattleItem in itemArr)
			{
				if(item.SingleID==id)
				{
					return item;
				}
			}
			
			return null;
		}
		/**
		 * 是否有指定道具
		 * @param item
		 * @return 
		 * 
		 */	
		public function hasItem(item:IBattleItem):Boolean
		{
			return itemArr.indexOf(item)!=-1;
		}
		/**
		 *清空所有道具
		 * 
		 */		
		public function removeAll():void
		{
			for each(var i:IDispose in itemArr)
			{
				i.dispose();
			}
			
			this.itemArr=[];
		}			
		/**
		 *是否有道具
		 * @return 
		 * 
		 */		
		public function isNull():Boolean
		{
			return itemArr.length==0;
		}
	}
}
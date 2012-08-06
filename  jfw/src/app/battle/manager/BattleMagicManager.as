package app.mvc.models.manager
{
	import app.mvc.views.game.mapItem.base.BaseBattleItem;
	import app.globals.interfaces.IBattleItem;
	import app.mvc.views.game.mapItem.magic.MagicItem;
	
	import com.pianfeng.engine.global.interfaces.IDispose;
	import flash.utils.Dictionary;
	
	public class BattleMagicManager
	{
		static private var instance:BattleMagicManager=null;
		public var magicArr:Array=[]; 
		
		public function BattleMagicManager()
		{
		}
		
		static public function getInstance():BattleMagicManager
		{
			if(instance==null)
				instance = new BattleMagicManager();
			
			return instance;
		}
		/**
		 *得到道具数 
		 * @return 
		 * 
		 */		
		public function getItemLength():uint
		{
			return magicArr.length;
		}
		/**
		 *删除指定道具 
		 * @param char
		 * 
		 */		
		public function removeItem(item:IBattleItem):Boolean
		{
			var i:int=magicArr.indexOf(item);
			
			if(i!=-1)
			{
				magicArr.splice(i,1);
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
			for each(var item:IBattleItem in magicArr)
			{
				if(item.GridX==xIndex&&item.GridY==yIndex)
				{
					var i:int=magicArr.indexOf(item);
					magicArr.splice(i,1);
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
				magicArr.push(c);
			}
		}		
		/**
		 *得到指定索引道具 
		 * @param char
		 * 
		 */		
		public function getItemAt(xIndex:int,yIndex:int):IBattleItem
		{
			for each(var item:IBattleItem in magicArr)
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
			for each(var item:MagicItem in magicArr)
			{
				if(item.SingleID==id)
				{
					return item;
				}
			}
			
			return null;
		}
		/**
		 *根据所属(belong)得到道具集合
		 * @param id
		 * @bool true选择false排除
		 * @return 
		 * 
		 */		
		public function getItemsByBelong(belong:int,bool:Boolean=true):Array
		{
			var arr:Array=[];
			
			for each(var item:MagicItem in magicArr)
			{
				if(item.Belong==belong&&bool)
					arr.push(item);
			}
			
			return arr;
		}
		/**
		 * 是否有指定道具
		 * @param item
		 * @return 
		 * 
		 */	
		public function hasItem(item:IBattleItem):Boolean
		{
			return magicArr.indexOf(item)!=-1;
		}
		/**
		 *清空所有道具
		 * 
		 */		
		public function removeAll():void
		{
			for each(var i:IDispose in magicArr)
			{
				i.dispose();
			}
			
			this.magicArr=[];
		}			
		/**
		 *是否有道具
		 * @return 
		 * 
		 */		
		public function isNull():Boolean
		{
			return magicArr.length==0;
		}
	}
}
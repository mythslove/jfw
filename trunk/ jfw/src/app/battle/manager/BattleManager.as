package app.mvc.models.manager
{
	import app.globals.interfaces.ICharactor;
	import app.statemachine.StateConst;
	
	import com.pianfeng.engine.global.interfaces.IDispose;

	/**
	 *角色管理器基类 
	 * @author PianFeng
	 * 
	 */	
	public class BattleManager
	{
		static private var instance:BattleManager=null;
		public var charArr:Array=[]; 
		
		public function BattleManager()
		{
		}
		
		static public function getInstance():BattleManager
		{
			if(instance==null)
				instance = new BattleManager();
			
			return instance;
		}
		/**
		 * 获取长度 
		 * @return 
		 * 
		 */
		public function getLength():uint
		{
			return charArr.length;
		}
		/**
		 *加入队员 
		 * @param args 可以一次加多个
		 * 
		 */		
		public function addMember(...args):void
		{
			for each(var c:ICharactor in args)
			{
				charArr[c.SingleID]=c;
			}
		}
		/**
		 *删除指定npc 
		 * @param char
		 * 
		 */		
		public function removeMember(char:ICharactor):void
		{
			delete charArr[char.SingleID];
		}
		
		/**
		 *得到指定位置角色,死掉的排除
		 * @param char
		 * 
		 */		
		public function getMemberAtGrid(xIndex:int,yIndex:int):ICharactor
		{
			for each(var char:ICharactor in charArr)
			{
				if(char.GridX==xIndex&&char.GridY==yIndex)
				{
					if(char.NpcState.getName()!=StateConst.IS_DIED_STATE)
						return char;
				}
			}
			
			return null;
		}
		/**
		 *得到所有活着的角色
		 * 
		 */		
		public function getCharsAlive():Array
		{
			var arr:Array=[];
			
			for each(var char:ICharactor in charArr)
			{
				if(char.NpcState.getName()!=StateConst.IS_DIED_STATE)
					arr.push(char);
			}
			
			return arr;
		}
		/**
		 *根据阵营得到角色集合 
		 * @param camps
		 * @bool true选择false排除
		 * @return 
		 * 
		 */		
		public function getCharsByCamps(camps:int,bool:Boolean=true):Array
		{
			var arr:Array=[];
			
			for each(var c:ICharactor in this.charArr)
			{
				if(bool)
				{
					if(c.Camps==camps)
						arr.push(c);
				}
				else 
				{
					if(c.Camps!=camps)
						arr.push(c);
				}
			}
			
			return arr;
		}
		/**
		 *根据id得到角色
		 * @param index
		 * @return 无值则返回null
		 * 
		 */		
		public function getMemberByID(sid:int):ICharactor
		{
			return charArr[sid];
		}	
		/**
		 *是否有某个角色
		 * @param char
		 * @return 
		 * 
		 */		
		public function hasMember(char:ICharactor):Boolean
		{
			return charArr[char.SingleID]!=null;
		}
		/**
		 *判断是否全部死亡
		 * 
		 */		
		public function isAllDied(camps:int):Boolean
		{
			for each(var c:ICharactor in charArr)
			{
				if(c.Camps==camps&&c.NpcState.getName()!=StateConst.IS_DIED_STATE)
					return false;
			}
			
			return true;
		}	
		/**
		 *清空所有角色 
		 * 
		 */		
		public function removeAll():void
		{
			for each(var c:IDispose in charArr)
			{
				c.dispose();
				delete charArr[(c as ICharactor).SingleID];
			}
			
			this.charArr=[];
		}		
	}
}
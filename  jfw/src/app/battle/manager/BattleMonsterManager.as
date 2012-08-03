package app.mvc.models.manager
{
	import app.charactor.Charactor;
	import app.globals.interfaces.ICharactor;
	
	import com.pianfeng.engine.global.interfaces.IDispose;

	public class BattleMonsterManager extends BattleManager
	{
		static private var instance:BattleMonsterManager=null;
		
		public function BattleMonsterManager()
		{
		}
		
		static public function getInstance():BattleMonsterManager
		{
			if(instance==null)
				instance = new BattleMonsterManager();
			
			return instance;
		}
		/**
		 *是否有某个角色
		 * @param char
		 * @return 
		 * 
		 */		
		override public function hasMember(char:ICharactor):Boolean
		{
			for each(var c:ICharactor in this.charArr)
			{
				if(c.ID==char.ID)
					return true;
			}
			
			return false;
		}
		/**
		 *清空所有妖将
		 * 
		 */		
		override public function removeAll():void
		{
			this.charArr=[];
		}			
	}
}
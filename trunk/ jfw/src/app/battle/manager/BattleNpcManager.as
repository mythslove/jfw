package app.mvc.models.manager
{
	import app.globals.consts.CharactorConst;
	import app.globals.interfaces.ICharactor;
	import app.globals.utils.ArrayUtils;

	public class BattleNpcManager extends BattleManager
	{
		static private var instance:BattleNpcManager=null;
		
		public function BattleNpcManager()
		{
		}
		
		static public function getInstance():BattleNpcManager
		{
			if(instance==null)
				instance = new BattleNpcManager();
			
			return instance;
		}
		/**
		 *清空所有妖将
		 * 
		 */		
		override public function removeAll():void
		{
			this.charArr=[];
		}	
		/**
		 *得到队长
		 * @return 
		 * 
		 */	
		public function getMaster():ICharactor
		{
			for each(var c:ICharactor in charArr)
			{
				if(c.Type==CharactorConst.MASTER)
					return c;
			}
			
			return null;
		}
		/**
		 * 按照队伍顺序取队员
		 * @return 
		 * 
		 */		
		public function getMembersByIndex():Array
		{
			if(charArr.length==0)
			{
				return null;
			}
			else
			{
				return ArrayUtils.SortOn(charArr,"TeamIndex");
			}
		}
	}
}
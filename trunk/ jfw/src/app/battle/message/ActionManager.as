package app.battle.message
{
	import app.AppFacade;
	import app.globals.consts.AppConst;
	import app.globals.interfaces.ICharactor;
	import app.mvc.models.manager.BattleManager;
	import app.statemachine.StateConst;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	/**
	 * 消息处理器
	 * @author PianFeng
	 * 
	 */	
	public class ActionManager extends EventDispatcher
	{
		private static var instance:ActionManager;
		private var battleManager:BattleManager;
		private var facade:AppFacade;
		
		public function ActionManager(target:IEventDispatcher=null)
		{
			super(target);
			
			battleManager=BattleManager.getInstance();
			facade=AppFacade.getInstance();
		}
		
		public static function getInstance():ActionManager
		{
			if(instance==null)
				instance=new ActionManager();
			
			return instance;
		}
		/**
		 * 处理消息
		 * 
		 */		
		public function execute():void
		{
			for each(var char:ICharactor in battleManager.charArr)
			{
				if(char.CurrHP==0)
					continue;

				for(var i:int=0,j:int=char.queueLength;i<j;i++)
				{
					var msg:IActionMessage=char.shift();
					
					facade.sendNotification(AppConst.MESSAGE_EXECUTE,msg);
				}		
			}
		}
	}
}
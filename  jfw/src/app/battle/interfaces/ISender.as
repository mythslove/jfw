package app.battle.interfaces
{
	import app.battle.message.IActionMessage;

	/**
	 * 动作发出者 
	 * @author PianFeng
	 * 
	 */	
	public interface ISender
	{
		/**
		 * 获取发出者 
		 * @return 
		 * 
		 */		
		function get Sender():IRole;
		/**
		 * 望队列管理器里压消息 
		 * 
		 */		
		function sendMessage(msg:IActionMessage):void;
	}
}
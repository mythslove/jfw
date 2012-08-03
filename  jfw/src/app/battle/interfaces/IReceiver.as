package app.battle.interfaces
{
	import app.battle.message.IActionMessage;
	/**
	 * 消息接收者 
	 * @author PianFeng
	 * 
	 */
	public interface IReceiver
	{
		/**
		 * 获取接收者 
		 * @return 
		 * 
		 */		
		function get Receiver():IRole;
		/**
		 * 压入自己队列方法 
		 * 
		 */		
		function push(msg:IActionMessage):void;
		/**
		 * 从自己队列里顺序取出第一个元素
		 * 
		 */		
		function shift():IActionMessage;
		/**
		 * 队列长度 
		 * @return 
		 * 
		 */		
		function get queueLength():int;
		/**
		 * 消息队列是否为空 
		 * @return 
		 * 
		 */		
		function get empty():Boolean;
		/**
		 * 清空消息队列 
		 * 
		 */		
		function clear():void;
	}
}
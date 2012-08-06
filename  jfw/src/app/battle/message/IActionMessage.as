package app.battle.message
{
	import app.battle.action.IAction;
	import app.battle.interfaces.IReceiver;
	import app.battle.interfaces.ISender;

	/**
	 * 动作消息接口 
	 * @author PianFeng
	 * 
	 */
	public interface IActionMessage
	{
		/**
		 * 获取动作名字
		 * @return 
		 * 
		 */		
		function get Name():String;
		/**
		 * 设置动作名字
		 *  
		 * 
		 */		
		function set Name(name:String):void;
		/**
		 * 获取发出者
		 * @return 
		 * 
		 */		
		function get From():ISender;
		/**
		 * 设置发出者 
		 * @param value
		 * 
		 */		
		function set From(value:ISender):void;
		/**
		 * 获取接收者 
		 * @return 
		 * 
		 */		
		function get To():IReceiver;
		/**
		 * 设置接收者
		 * @param value
		 * 
		 */		
		function set To(value:IReceiver):void;
		/**
		 * 获取技能,包含特效 
		 * @return 
		 * 
		 */		
		function get Actions():Array;
		/**
		 * 设置技能,包含特效 
		 * @param value
		 * 
		 */		
		function set Actions(value:Array):void;
		/**
		 * 加入action
		 * @param action
		 * 
		 */		
		function AddItem(action:IAction):void;
	}
}
package app.battle.action
{
	/**
	 * 动作接口 
	 * @author PianFeng
	 * 
	 */	
	public interface IAction
	{
		/**
		 * 动作名
		 * @return 
		 * 
		 */		
		function get Name():String;
		/**
		 * 动作名
		 * @param value
		 * 
		 */		
		function set Name(value:String):void;
	}
}
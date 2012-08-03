package app.battle.action
{
	/**
	 * 此类根据技能特效播放目标类型来判断播放给自己或对方 
	 * @author PianFeng
	 * 
	 */	
	public class BaseAction implements IAction
	{
		protected var name:String;
		
		public function BaseAction()
		{
		}
		
		public function get Name():String
		{
			return this.name;
		}
		
		public function set Name(value:String):void
		{
			this.name=value;
		}
	}
}
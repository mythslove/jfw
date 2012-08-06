package app.battle.interfaces
{
	/**
	 * 消耗 
	 * @author PianFeng
	 * 
	 */	
	public interface ICost
	{
		/** 角色花费的法力 */
		function get CostMP():int;
		
		/** 角色花费的法力 */
		function set CostMP(value:int):void;
		
		/** 角色花费的金币 */
		function get CostMoney():int;
		
		/** 角色花费的金币 */
		function set CostMoney(value:int):void;
		
		/** 是否付费 */
		function get IsVip():Boolean;
		
		/** 是否付费 */
		function set IsVip(value:Boolean):void;
	}
}
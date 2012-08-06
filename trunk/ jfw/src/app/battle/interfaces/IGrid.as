package app.battle.interfaces
{
	/**
	 * 支持菱形格子 
	 * @author PianFeng
	 * 
	 */	
	public interface IGrid
	{
		/** 角色格子坐标X */
		function get GridX():int;
		
		/** 角色格子坐标X */
		function set GridX(gridX:int):void;
		
		/** 角色格子坐标Y */
		function get GridY():int;
		
		/** 角色格子坐标Y */
		function set GridY(gridY:int):void;
		
		/** 设置屏幕格子坐标 */
		function setPosition(gdx:int=0,gdy:int=0):void;
	}
}
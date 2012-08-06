package app.battle.interfaces
{
	import flash.events.IEventDispatcher;

	/**
	 * 
	 * @author PianFeng
	 * 图层抽象类
	 * 
	 */	
	public interface ILayer extends IEventDispatcher
	{
		/**
		 *得到层名字 
		 * @return 
		 * 
		 */		
		function layerName():String
	}
}
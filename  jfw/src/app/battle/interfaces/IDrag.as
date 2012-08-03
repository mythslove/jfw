package  app.battle.interfaces
{
	/**
	 * 可拖拽接口 
	 * @author PianFeng
	 * 
	 */	
	public interface IDrag extends IDisplayObject,IGrid
	{
		/** 是否已经放到地图上*/
		function get IsDropped():Boolean;
		
		/** 是否已经放到地图上*/
		function set IsDropped(value:Boolean):void;
		
		/** 可拖拽的类型*/
		function get DType():int;
	}
}
package app.view.ui.component.interfaces
{
	import com.jfw.engine.core.data.IStruct;

	public interface IListItem 
	{
		function set itemId(value:int):void;
		function get itemId():int;
		function set data(value:IStruct):void;
		function get data():IStruct;
		function get body():Object;
		
		function get x():Number;
		function get y():Number;
		function get width():Number;
		function get height():Number;
		function get visible():Boolean;
		
		function set x(value:Number):void;
		function set y(value:Number):void;
		function set width(value:Number):void;
		function set height(value:Number):void;
		function set visible(value:Boolean):void;
		
		function set selected(value:Boolean):void;
		function get selected():Boolean;
	}
	
}
package app.mvc.view.ui.component.interfaces
{
	import flash.events.IEventDispatcher;
	
	public interface IList extends IEventDispatcher
	{
		function set data( value:Array ):void;
		function get data( ):Array;
		function set drag( value:Boolean ):void;
		function get drag( ):Boolean;
		function set dragEffect( value:Boolean ):void;
		function get dragEffect( ):Boolean;
		function setCurrentItem( value:int,refresh:Boolean = true ):void;
		function setSelectItem( value:int ):void;
		function getItemById( id:int ):IListItem;
	}
}
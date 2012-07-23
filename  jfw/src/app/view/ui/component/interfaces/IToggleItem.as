package app.view.ui.component.interfaces
{
	import flash.events.IEventDispatcher;

	public interface IToggleItem extends IEventDispatcher
	{
		function set selected(value:Boolean):void
		
		function get selected():Boolean
	}
}
package app.view.ui.component.alert
{
	import flash.events.IEventDispatcher;
	
	public interface IAlertWindow extends IEventDispatcher
	{
		function get id():int
		
		function set id(value:int):void
			
		function get closeHandler():Function
		
		function set closeHandler(value:Function):void
			
		function get isDisable():Boolean
		
		function set isDisable(value:Boolean):void
			
		function setButton(butFlags:uint):void
			
		function setText(str:String):void
			
		function close():void
	}
}
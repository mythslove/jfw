package app.view.ui.component.alert
{
	import flash.events.Event;
	
	public class AlertCloseEvent extends Event
	{
		
		public static const CLOSE:String = "closeAlert";
		public var detail:int;

		public function AlertCloseEvent(type:String, bubbles:Boolean = false,
								   cancelable:Boolean = false, detail:int = -1)
		{
			super(type, bubbles, cancelable);
			
			this.detail = detail;
		}

		override public function clone():Event
		{
			return new AlertCloseEvent(type, bubbles, cancelable, detail);
		}
	}
}
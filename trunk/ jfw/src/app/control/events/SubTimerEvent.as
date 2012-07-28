package app.control.events
{
	import flash.events.Event;
	
	public class SubTimerEvent extends Event
	{
		public static const TIME_STEP:String='time_step';
		public static const TIME_COMPLETE:String='time_complete';
		
		public function SubTimerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
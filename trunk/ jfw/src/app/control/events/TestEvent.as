package app.control.events
{
	import flash.events.Event;
	
	public class TestEvent extends Event
	{
		static public const TEST_COMMAND_EVENT:String = 'test_command_event';
		
		public function TestEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
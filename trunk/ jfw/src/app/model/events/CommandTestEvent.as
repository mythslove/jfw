package app.model.events
{
	import flash.events.Event;
	
	public class CommandTestEvent extends Event
	{
		static public const COMMAND_TEST_EVENT:String = 'command_test_event';
		
		public function CommandTestEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
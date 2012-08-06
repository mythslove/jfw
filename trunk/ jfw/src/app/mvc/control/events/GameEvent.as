package app.mvc.control.events
{
	import flash.events.Event;
	
	public class GameEvent extends Event
	{
		public static const BUFF_ADD:String='buff_add';
		public static const BUFF_DELETE:String='buff_delete';
		public var data:Object=null;
		
		public function GameEvent(type:String,data:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data=data;
		}
	}
}
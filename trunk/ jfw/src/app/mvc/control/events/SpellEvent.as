package app.mvc.control.events
{
	import flash.events.Event;
	
	public class SpellEvent extends Event
	{
		static public const MONSTERLIST_CLICK_ITEM:String  = 'SpellEvent_MONSTERLIST_CLICK_ITEM';
		static public const LOAD_PIC:String                = 'app_load_pic';
		static public const GAME_INIT:String               = 'game_init';
		
		public var data:Object;
		
		public function SpellEvent(type:String,data:Object,  bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data = data;
		}
	}
}
package app.mvc.control.events
{
	import flash.events.Event;
	
	/** 游戏事件 */
	public class ModelEvent extends Event
	{
		static public const STAGE_RESIZE:String 			= 'stageResize';
		static public const LOAD_PIC:String 				= 'app_load_pic';
		static public const GAME_INIT:String				= 'game_init';
		static public const UI_INIT:String				= 'ui_init';
		
		/** 消息提示 */
		public static const ERROR_REFRESH_ALERT:String		= 'message_alert' ; 
		
		public function ModelEvent( type:String, bubbles:Boolean=false, cancelable:Boolean=false )
		{
			super( type, bubbles, cancelable );
		}
	}
}
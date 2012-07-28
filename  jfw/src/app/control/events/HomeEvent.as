package app.control.events
{
	import flash.events.Event;

	/**
	 * 主城相关事件
	 * @author jianzi
	 */	
	public class HomeEvent extends Event
	{
		/** 初始化所有建筑 */
		static public const INIT_BUILDING:String 		= 'init_building';
		
		/** 拜访好友初始化 */
		public static const VISITFRIEND_INIT:String	= 'visitfriend_init';
		
		public function HomeEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
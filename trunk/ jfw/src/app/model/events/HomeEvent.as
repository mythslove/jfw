package app.model.events
{
	import flash.events.Event;

	/**
	 * 主城相关事件
	 * @author jianzi
	 */	
	public class HomeEvent extends Event
	{
		/** 初始化所有建筑 */
		static public const INIT_BUILDING:String = 'init_building';
		
		public function HomeEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
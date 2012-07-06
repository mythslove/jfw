package app.model.events
{
	import flash.events.Event;

	/**
	 * Loading事件 
	 * @author jianzi
	 */	
	public class LoadingEvent extends Event
	{
		/** 显示loading界面 */
		public static const LOADING_SHOW:String		= 'loading_show';
		/** 隐藏loading界面 */
		public static const LOADING_HIDE:String		= 'loading_hide';
		/** loading过程事件 */
		public static const LOADING_PROCESS:String	= 'loading_process';
		
		public function LoadingEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
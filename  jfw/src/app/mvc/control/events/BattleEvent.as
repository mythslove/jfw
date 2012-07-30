package app.mvc.control.events
{
	import flash.events.Event;
	
	public class BattleEvent extends Event
	{
		public static const BATTLE_RES_LOAD_COMPLETE:String='battle_res_load_complete';// 加载战场资源完成
		
		public function BattleEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
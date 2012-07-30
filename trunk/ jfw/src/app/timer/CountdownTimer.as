package app.timer
{
	import app.mvc.control.events.SubTimerEvent;

	/**
	 * 倒计时秒表 
	 * @author Administrator
	 * 
	 */	
	public class CountdownTimer
	{
		private var timer:SubTimer=null;
		private var seconds:int=1;
		private var stepCallBack:Function=null;
		private var endCallBack:Function=null;
		private var currSecond:int=0;
		
		public function CountdownTimer(seconds:int,stepCallBack:Function,endCallBack:Function)
		{
			this.seconds=seconds;
			this.currSecond=seconds;
			this.stepCallBack=stepCallBack;
			this.endCallBack=endCallBack;
			
			timer=new SubTimer(seconds);
			timer.addEventListener(SubTimerEvent.TIME_STEP,onTimer);
			timer.addEventListener(SubTimerEvent.TIME_COMPLETE,onComplete);
		}
		
		public function start():void
		{
			timer.start();
		}
		
		public function stop():void
		{
			timer.stop();
		}
		
		public function get CurrSecond():int
		{
			return this.currSecond;
		}
		
		private function onTimer(e:SubTimerEvent):void
		{
			stepCallBack();
			this.currSecond--;
		}
		
		private function onComplete(e:SubTimerEvent):void
		{
			endCallBack();
		}
	}
}
package app.timer
{
	import app.control.events.SubTimerEvent;
	
	public class DalayCall 
	{
		public var timer:SubTimer=null;
		public var callBack:Function=null;
		
		public function DalayCall(dalay:Number,callBack:Function)
		{
			this.callBack=callBack;
			timer=new SubTimer(dalay);
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
		
		private function onComplete(e:app.control.events.SubTimerEvent):void
		{
			if(callBack!=null)
				callBack();
		}
	}
}
package app.battle.timer
{	
	import app.mvc.control.events.SubTimerEvent;
	
	import flash.events.EventDispatcher;

	/**
	 * 首次执行一次的timer
	 * 至少会执行一次step事件,设定次数,等于间隔数
	 * stamp必须为delay的整数倍,参数不能小于1秒
	 * @author Administrator
	 * 
	 */
	public class SubTimer extends EventDispatcher
	{
		public var times:int=0;//播放总次数
		public var currentTimes:int=0;//当前播放次数
		public var currentCount:int=0;//当前运行的次数
		public var running:Boolean=false;//是否正在运行
		public var isComplete:Boolean=false;//时间是否停止
		public var delay:int=100;
		public var stamp:int=1000;
		public var isRepeat:Boolean=false;
		
		public function SubTimer(times:int=0,stamp:Number=1000)
		{
			if(times>=1)
			{
				this.times=times;
				isRepeat=false;
			}
			else if(times==0)
			{
				this.times=Number.MAX_VALUE;
				isRepeat=true;
			}
			else
			{
				return;
			}
				
			this.stamp=stamp;
			TimerManager.Instance.AddTimer(this);
		}	
		
		public function start():void
		{
			this.running=true;
			
			if(this.currentCount==0)
			{
				if(!isRepeat)
					currentTimes++;
				
				this.dispatchEvent(new SubTimerEvent(SubTimerEvent.TIME_STEP));
			}
		}
		
		public function stop():void
		{
			this.running=false;
		}
		/**
		 * @param count 单位毫秒
		 * 
		 */		
		public function reset(times:int=0):void
		{
			this.running=true;
			
			if(times!=0)
				this.times=times;
				
			if(this.currentCount==0)
			{
				if(!isRepeat)
					currentTimes++;
				
				this.dispatchEvent(new SubTimerEvent(SubTimerEvent.TIME_STEP));
			}
		}
		
		public function onTimer():void
		{
			this.currentCount++;
			
			if(this.currentCount*delay%stamp==0)
			{
				if(!isRepeat)
					currentTimes++;
				
				if(currentTimes>this.times)
				{
					this.dispatchEvent(new SubTimerEvent(SubTimerEvent.TIME_COMPLETE));
					this.isComplete=true;
					this.running=false;
					TimerManager.Instance.RemoveTimer(this);
				}
				else
				{
					this.dispatchEvent(new SubTimerEvent(SubTimerEvent.TIME_STEP));
				}
			}
		}
		
		public function get Runing():Boolean
		{
			return this.running;
		}

		/**
		 * @param count 单位毫秒
		 * 
		 */
		public function get LastSeconds():int
		{
			if(isRepeat)
				return Number.MAX_VALUE;
			else
				return times*stamp-this.currentCount*delay;
		}
	}
}
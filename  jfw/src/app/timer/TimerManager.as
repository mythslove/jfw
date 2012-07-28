package app.timer
{
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 *管理器 
	 * @author PianFeng
	 * 
	 */
	public class TimerManager extends EventDispatcher
	{
		private static var instance:TimerManager=null;
		private var dic:Vector.<SubTimer>;	
		private var timer:Timer;
		private var speed:Number=91.836735;//0-100,表示速度倍率
		private const MaxHz:Number=1000;
		private const MinHz:Number=20;
		
		public function TimerManager()
		{
			dic=new Vector.<SubTimer>();
			timer=new Timer(delay);
		}
		
		public static function Instance():TimerManager
		{
			return instance||=new TimerManager();
		}
		
		public function get delay():Number
		{
			return (100-speed)*(MaxHz-MinHz)/100+MinHz;
		}
		/**
		 * 开始播放计时器 
		 * 
		 */		
		public function start():void
		{
			this.timer.addEventListener(TimerEvent.TIMER,onTimer);
			this.timer.start();
		}
		/**
		 * 重置计时器 
		 * 
		 */		
		public function reset():void
		{
			this.timer.addEventListener(TimerEvent.TIMER,onTimer);
			this.timer.reset();
		}
		/**
		 * 范围为 0-100,实际频率范围20-1000,默认频率为100,实际速度为1秒的1/10到5倍;
		 * @param value
		 * 
		 */		
		public function changeSpeed(value:Number=91.836735):void
		{	
			if(value<0||value>100)
				return;
			
			this.speed=value;
			timer.delay=this.delay;
		}
		
		/**
		 *停止计时器 
		 * 
		 */		
		public function stop():void
		{
			if(!timer.running)
				return;
			
			this.timer.removeEventListener(TimerEvent.TIMER,onTimer);
			this.timer.stop();
		}
		
		private function onTimer(evt:TimerEvent):void
		{				
			for each(var t:SubTimer in this.dic)
			{
				if(t.Runing)
					t.onTimer();	
				
				if(t.isComplete)
					this.removeTimer(t);
			}
		}
		/**
		 *得到集合长度 
		 * @return 
		 * 
		 */		
		private function get length():int
		{
			return dic.length;
		}
		/**
		 * 是否为空
		 * @return true则为空
		 * 
		 */		
		private function get isEmpty():Boolean
		{	
			return dic.length==0;
		}

		public function addTimer(t:SubTimer):void
		{
			if(isEmpty)
				this.start();
				
			dic.push(t);
		}
	
		public function removeTimer(t:SubTimer):void
		{
			if(t.Runing)
				t.stop();
			
			dic.splice(dic.indexOf(t),0);
			
			if(isEmpty)
				this.stop();
		}
		/**
		 *清除所有buff 
		 * 
		 */		
		public function clearAll():void
		{
			if(this.dic==null)
				return;
			
			for each(var t:SubTimer in this.dic)
			{
				t.stop();
				dic.splice(dic.indexOf(t),0);
			}
		}
	}
}
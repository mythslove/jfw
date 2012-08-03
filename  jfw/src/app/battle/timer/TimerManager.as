package app.battle.timer
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
		private var speed:Number=1.0;//表示速度倍率
		private var delay:Number=100;
		
		public function TimerManager()
		{
			dic=new Vector.<SubTimer>();
			timer=new Timer(delay);
		}
		
		public static function get Instance():TimerManager
		{
			return instance||=new TimerManager();
		}
		/**
		 * 开始播放计时器 
		 * 
		 */		
		public function Start():void
		{
			this.timer.addEventListener(TimerEvent.TIMER,onTimer);
			this.timer.start();
		}
		/**
		 * 重置计时器 
		 * 
		 */		
		public function Reset():void
		{
			this.timer.addEventListener(TimerEvent.TIMER,onTimer);
			this.timer.reset();
		}
		/**
		 * 范围0.5-5倍
		 * @param value
		 * 
		 */		
		public function set Speed(value:Number):void
		{	
			this.speed=Math.max(0.5,Math.min(5,value));

			timer.delay=this.delay*(1/value);
		}
		
		/**
		 *停止计时器 
		 * 
		 */		
		public function Stop():void
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
					this.RemoveTimer(t);
			}
		}
		/**
		 *得到集合长度 
		 * @return 
		 * 
		 */		
		private function get Length():int
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

		public function AddTimer(t:SubTimer):void
		{
			if(isEmpty)
				this.Start();
				
			dic.push(t);
		}
	
		public function RemoveTimer(t:SubTimer):void
		{
			if(t.Runing)
				t.stop();
			
			dic.splice(dic.indexOf(t),0);
			
			if(isEmpty)
				this.Stop();
		}
		/**
		 *清除所有buff 
		 * 
		 */		
		public function ClearAll():void
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
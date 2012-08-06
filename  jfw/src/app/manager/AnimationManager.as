package app.manager
{
	import com.jfw.engine.animation.Juggler;
	import com.jfw.engine.animation.helper.DelayedCall;
	import com.jfw.engine.motion.IAnimation;
	
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.getTimer;
	/**
	 * 动画播放管理器,用于总控制播放 
	 * @author Administrator
	 * 
	 */	
	public class AnimationManager extends Shape
	{
		private static var instance:AnimationManager=null;
		private var juggler:Juggler=null;
		private var mLastFrameTimestamp:Number=0;
		private var _pause:Boolean=false;
		private var _speed:Number=1.0;
		private var mObjects:Vector.<IAnimation>;
		
		public function AnimationManager()
		{
			juggler=new Juggler();
			mObjects=new Vector.<IAnimation>();
		}
		/**
		 * 范围为0.5-5倍 
		 * @param spd
		 * @return 
		 * 
		 */		
		public static function get Instance():AnimationManager
		{
			return instance||=new AnimationManager();
		} 
		
		public function Pause():void
		{
			_pause=true;
		}
		
		public function Resume():void
		{
			_pause=false;
		}
		
		public function get isPause():Boolean
		{
			return this._pause;
		}
		/**
		 * 0.5到5倍之间 
		 * @param value
		 * 
		 */		
		public function set Speed(value:Number):void
		{
			if(this._speed==value)
				return;
			
			this._speed=Math.max(0.5,Math.min(value,5));
		}
		/**
		 * 比例系数 0.5到5倍
		 * @return 
		 * 
		 */		
		public function get Speed():Number
		{
			return _speed;
		}
		
		public function Count():int
		{
			return mObjects.length;
		}
		
		public function Contain(obj:IAnimation):Boolean
		{
			return mObjects.indexOf(obj)!=-1;
		}
		
		/** Adds an object to the juggler. */
		public function Add(object:IAnimation):void
		{
			juggler.add(object);
			
			if(mObjects.indexOf(object)==-1)
			{
				mObjects.push(object);
			}
			
			if(mObjects.length>0&&!this.hasEventListener(Event.ENTER_FRAME))
			{
				mLastFrameTimestamp=getTimer() / 1000.0;
				this.addEventListener(Event.ENTER_FRAME,onEnterFrame);
			}
		}
		
		/** Removes an object from the juggler. */
		public function Remove(object:IAnimation):void
		{
			juggler.remove(object);
			var index:int=mObjects.indexOf(object);
			
			if(index!=-1)
			{
				mObjects.splice(index,1);
			}
			
			if(mObjects.length<=0)
				this.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
		
		/** Removes all tweens with a certain target. */
		public function RemoveTweens(target:Object):void
		{
			juggler.removeTweens(target);
		}
		
		/** Removes all objects at once. */
		public function ClearAll():void
		{
			juggler.purge();
			mObjects.length=0;
			
			if(this.hasEventListener(Event.ENTER_FRAME))
				this.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
		
		/** Delays the execution of a function until a certain time has passed. Creates an
		 *  object of type 'DelayedCall' internally and returns it. Remove that object
		 *  from the juggler to cancel the function call. */
		public function DelayCall(call:Function, delay:Number, ...args):DelayedCall
		{
			return juggler.delayCall(call,delay,args);
		}
		
		/** Advances all objects by a certain time (in seconds). */
		public function AdvanceTime(time:Number):void
		{   
			juggler.advanceTime(time);
		}
		
		/** The total life time of the juggler. */
		public function get ElapsedTime():Number 
		{ 
			return juggler.elapsedTime; 
		}
		
		private function onEnterFrame(e:Event):void
		{
			if(!_pause)
			{
				var now:Number = getTimer() / 1000.0;
				var passedTime:Number = now - mLastFrameTimestamp;
				mLastFrameTimestamp = now;
				
				juggler.advanceTime(passedTime*_speed);
			}
		}
		
		public function dispose():void
		{
			if(this.hasEventListener(Event.ENTER_FRAME))
				this.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
			
			juggler.purge();
			juggler=null;
			mObjects=null;
		}
	}
}
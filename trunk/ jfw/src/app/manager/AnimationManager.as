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
		private var _fps:Number=1;
		private var mObjects:Vector.<IAnimation>;
		
		public function AnimationManager(fps:Number=1)
		{
			juggler=new Juggler();
			mObjects=new Vector.<IAnimation>();
			this._fps=fps;
		}
		
		public static function Instance(fps:Number=1):AnimationManager
		{
			if(instance==null)
				instance=new AnimationManager(fps)
					
			return instance;
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
		
		public function set speed(value:Number):void
		{
			this._fps=value;
			
			for(var i:int=0,j:int=mObjects.length;i<j;i++)
			{
				mObjects[i].fps=value;
			}
		}
		
		public function get speed():Number
		{
			return _fps;
		}
		
		public function Count():int
		{
			return mObjects.length;
		}
		
		public function contain(obj:IAnimation):Boolean
		{
			return mObjects.indexOf(obj)!=-1;
		}
		
		/** Adds an object to the juggler. */
		public function add(object:IAnimation):void
		{
			juggler.add(object);
			
			if(mObjects.indexOf(object)==-1)
			{
				object.fps=this._fps;
				mObjects.push(object);
			}
			
			if(mObjects.length>0&&!this.hasEventListener(Event.ENTER_FRAME))
			{
				mLastFrameTimestamp=getTimer() / 1000.0;
				this.addEventListener(Event.ENTER_FRAME,onEnterFrame);
			}
		}
		
		/** Removes an object from the juggler. */
		public function remove(object:IAnimation):void
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
		public function removeTweens(target:Object):void
		{
			juggler.removeTweens(target);
		}
		
		/** Removes all objects at once. */
		public function clearAll():void
		{
			juggler.purge();
			mObjects.length=0;
			
			if(this.hasEventListener(Event.ENTER_FRAME))
				this.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
		
		/** Delays the execution of a function until a certain time has passed. Creates an
		 *  object of type 'DelayedCall' internally and returns it. Remove that object
		 *  from the juggler to cancel the function call. */
		public function delayCall(call:Function, delay:Number, ...args):DelayedCall
		{
			return juggler.delayCall(call,delay,args);
		}
		
		/** Advances all objects by a certain time (in seconds). */
		public function advanceTime(time:Number):void
		{   
			juggler.advanceTime(time);
		}
		
		/** The total life time of the juggler. */
		public function get elapsedTime():Number 
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
				
				juggler.advanceTime(passedTime);
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
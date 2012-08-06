package app.battle.buff
{
	import app.battle.effect.BaseEffect;
	import app.battle.interfaces.IRole;
	import app.manager.AnimationManager;
	
	import flash.display.Sprite;
	
	public class Buff
	{
		public var id:int;
		public var type:int=0;
		public var value:Number=0;
		public var char:IRole=null;//所属角色 
		public var ownerId:int=0;//发出者的id,有可能是技能或法
		public var seconds:int=0;//单位毫秒
		public var currentCount:int=0;//当前运行的次数
		public var effect:BaseEffect=null;//持续性特效
		public var onTimerCallBack:Function=null;
		public var endCallback:Function=null;//结束回调函数
		public var running:Boolean=false;//是否正在运行
		public var isComplete:Boolean=false;//时间是否停止
		public var delay:int=50;
		
		public function Buff(type:int,seconds:int,value:Number=0,char:IRole=null,ownerId:int=0,effect:BaseEffect=null)
		{
			this.type=type;
			this.value=value;
			this.seconds=seconds*1000;
			this.char=char;
			this.ownerId=ownerId;
			this.effect=effect;
		}
		/**
		 *判断该buff是buff还是debuff 
		 * 
		 */		
		public function get isUseful():Boolean
		{
			return type>0&&type<13?true:false;
		}
		
		public function play():void
		{
			this.running=true;
			
			if(effect)
				effect.play();
		}
		
		public function stop():void
		{
			if(effect)
			{
				AnimationManager.Instance.Remove(effect);
				effect.parent.removeChild(effect);
			}
			
			this.running=false;
			
			if(endCallback!=null)
				endCallback(this,char);
		}
		/**
		 * 暂停 
		 * 
		 */		
		public function pause():void
		{
			if(effect)
				effect.pause();
			
			if(endCallback!=null)
				endCallback(this,char);
			
			this.running=false;
		}
		/**
		 * @param count 单位毫秒
		 * 
		 */		
		public function reset(count:int):void
		{
			this.seconds=count;
			this.running=true;
			
			if(effect)
				effect.play();
		}
		
		public function set OnTimerCallBack(value:Function):void
		{
			this.onTimerCallBack=value;
			this.onTimerCallBack(this.char,this,this.value);
		}
		
		public function onTimer():void
		{
			this.currentCount++;
			
			if(this.currentCount*delay%1000==0)
				if(this.onTimerCallBack!=null)
					this.onTimerCallBack(this.char,this,this.value);
			
			if(this.currentCount*delay>=this.seconds)
				complete();
		}
		
		public function get Runing():Boolean
		{
			return this.running;
		}
		
		private function complete():void
		{	
			if(effect)
			{
				AnimationManager.Instance.Remove(effect);
				effect.parent.removeChild(effect);
			}
			
			if(this.endCallback!=null)
				this.endCallback(this,char);

			this.isComplete=true;
			this.running=false
		}
		/**
		 * @param count 单位毫秒
		 * 
		 */
		public function get LastSeconds():int
		{
			return this.seconds-this.currentCount*delay;
		}
		/**
		 * 持续性特效 
		 * @param value
		 * 
		 */		
		public function set Effect(effect:BaseEffect):void
		{
			this.effect=effect;
		}
	}
}
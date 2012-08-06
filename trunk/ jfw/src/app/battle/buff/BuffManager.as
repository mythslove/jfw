package app.battle.buff
{
	import app.battle.interfaces.IRole;
	import app.battle.timer.SubTimer;
	import app.battle.utils.IDUtils;
	import app.mvc.control.events.GameEvent;
	import app.mvc.control.events.SubTimerEvent;
	
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

	/**
	 *管理器 
	 * @author PianFeng
	 * 
	 */
	public class BuffManager extends EventDispatcher
	{
		public var dic:Array;	
		public var char:IRole;//所属角色
		private var timer:SubTimer;
		private const delay:int=100;
		
		public function BuffManager(char:IRole)
		{
			dic=[];
			this.char=char;
			timer=new SubTimer(0,delay);
		}
		/**
		 * 开始播放计时器 
		 * 
		 */		
		public function play():void
		{
			this.timer.addEventListener(SubTimerEvent.TIME_STEP,onTimer);
			this.timer.start();
		}
		/**
		 * 重置计时器 
		 * 
		 */		
		public function reset():void
		{
			this.timer.addEventListener(SubTimerEvent.TIME_STEP,onTimer);
			this.timer.reset();
		}
		/**
		 *停止计时器 
		 * 
		 */		
		public function stop():void
		{
			if(!timer.running)
				return;
			
			this.timer.removeEventListener(SubTimerEvent.TIME_STEP,onTimer);
			this.timer.stop();
		}
		
		private function onTimer(evt:SubTimerEvent):void
		{				
			for each(var buff:Buff in this.dic)
			{
				if(buff.Runing)
					buff.onTimer();	
				
				if(buff.isComplete)
					this.removeBuff(buff);
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
		/**
		 * 添加buff
		 * @param buff
		 * @param isCover 是否覆盖存在的buff
		 */		
		public function addBuff(buff:Buff,isCover:Boolean=true):void
		{
			if(isEmpty)
				this.play();
				
			if(isCover)
			{
				var arr:Array=this.getBuffsOfType(buff.type);
				
				if(arr.length>0)
					this.removeBuff(arr[0]);
			}
			
			buff.id=IDUtils.createNewID();	
			dic[buff.id]=buff;
			this.dispatchEvent(new GameEvent(GameEvent.BUFF_ADD,buff));
			buff.char=this.char;
			buff.delay=this.delay;
			buff.play();	
		}
		/**
		 *删除buff
		 * @param buff
		 * 如果buff未停止则停止它
		 */		
		public function removeBuff(buff:Buff):void
		{
			if(buff.Runing)
				buff.stop();
			
			this.dispatchEvent(new GameEvent(GameEvent.BUFF_DELETE,buff));
			dic[buff.id]=null;
			delete dic[buff.id];
			
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
			
			for each(var b:Buff in this.dic)
			{
				b.stop();
				dic[b.id]=null;
				delete dic[b.id];
			}
		}
		/**
		 *批量添加buff 
		 * @param arr
		 * 
		 */		
		public function addBuffs(arr:Array):void
		{
			for(var i:int=0;i<arr.length;i++)
			{
				this.addBuff(arr[i] as Buff);
			}
		}
		/**
		 *批量删除增益buff 
		 * @param arr
		 * 
		 */		
		public function removeBuffs(arr:Array):void
		{
			for(var i:int=0;i<arr.length;i++)
			{
				this.removeBuff(arr[i] as Buff);
			}
		}
		/**
		 *获取增益buff 
		 * @return 
		 * 
		 */		
		public function getAllUsefulBuff():Array
		{
			var arr:Array=[];
			for each(var buff:Buff in dic)
			{
				if(buff.isUseful)
					arr.push(buff);
			}
			
			return arr;
		}
		/**
		 *获取所有减益debuff
		 * @return 
		 * 
		 */		
		public function getAllDeBuff():Array
		{
			var arr:Array=[];
			for each(var buff:Buff in dic)
			{
				if(!buff.isUseful)
					arr.push(buff);
			}
			
			return arr;
		}
		/**
		 * 计算指定某一系列buff的值的和 
		 * @param type
		 * @return 
		 * 
		 */		
		public function getBuffValueOfType(type:int):Number
		{
			var count:Number=0;
			
			for each(var buff:Buff in dic)
			{
				if(buff.type==type)
					count+=buff.value;
			}
			
			return count;
		}
		/**
		 * 取得指定某一系列buff
		 * @param type
		 * @return 
		 * 
		 */		
		public function getBuffsOfType(type:int):Array
		{
			var arr:Array=[];
			
			for each(var buff:Buff in dic)
			{
				if(buff.type==type)
					arr.push(buff);
			}
			
			return arr;
		}
		/**
		 * 是否有某类型的buff 
		 * @param type
		 * @return 
		 * 
		 */		
		public function hasBuffOfType(type:int):Boolean
		{
			for each(var buff:Buff in dic)
			{
				if(buff.type==type)
					return true;
			}
			
			return false;
		}
		/**
		 *buff转成debuff 
		 * @param buff
		 * 
		 */		
		public function changeBuffToDebuff(buff:Buff):void
		{
			var b:Buff=new Buff(buff.type+4,buff.LastSeconds,buff.value,buff.char,buff.ownerId);
			b.OnTimerCallBack=buff.onTimerCallBack;
			b.endCallback=buff.endCallback;
			b.running=buff.Runing;
			b.isComplete=buff.isComplete;
			this.removeBuff(buff);
			this.addBuff(b);
		}
		/**
		 *debuff转成buff 
		 * @param buff
		 * 
		 */	
		public function changeDebuffToBuff(buff:Buff):void
		{
			var b:Buff=new Buff(buff.type-4,buff.LastSeconds,buff.value,buff.char,buff.ownerId);
			b.OnTimerCallBack=buff.onTimerCallBack;
			b.endCallback=buff.endCallback;
			b.running=buff.Runing;
			b.isComplete=buff.isComplete;
			this.removeBuff(buff);
			this.addBuff(b);
		}
	}
}
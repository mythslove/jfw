package com.jfw.engine.utils.operation.quest
{
	import com.jfw.engine.utils.operation.Oper;
	import com.jfw.engine.utils.operation.OperationEvent;
	import com.jfw.engine.utils.operation.Queue;
	
	import flash.events.EventDispatcher;
	

	[Event(name="quest_complete",type="com.jfw.engine.utils.operation.quest.QuestEvent")]
	
	/**
	 * 任务
	 * 
	 */
	public class Quest extends EventDispatcher
	{
		/**
		 * 任务标示
		 */
		public var id:int = 0;
		private var queue:Queue;
		private var opers:Array;
		
		public var activeHandler:Function;
		
		private var _step:int = 0;
		
		/**
		 * 执行阶段 
		 * @return 
		 * 
		 */
		public function get step():int
		{
			return _step;
		}

		public function set step(v:int):void
		{
			if (started)
				trace("已经开始的任务不能再设置阶段");
			else
				_step = v;
		}
		
		/**
		 * 
		 * @param v	Oper列表
		 * @param activeHandler	判断任务是否可接受
		 * @param step	当前执行到的步骤
		 * 
		 */
		public function Quest(v:Array=null,activeHandler:Function=null,step:int = 0)
		{
			this.opers = v;
			this.activeHandler = activeHandler;
			this.step = step;
		}
		
		/**
		 * 是否可用 
		 * @return 
		 * 
		 */
		public function get enabled():Boolean
		{
			return activeHandler==null || activeHandler.call();
		}
		
		/**
		 * 是否开始
		 * @return 
		 * 
		 */
		public function get started():Boolean
		{
			return queue != null;
		}
		
		/**
		 * 是否完成
		 * @return 
		 * 
		 */
		public function get finish():Boolean
		{
			return queue && queue.children.length == 0;
		}
		
		/**
		 * 开始 
		 * 
		 */
		public function start():void
		{
			queue = new Queue();
			queue.addEventListener(OperationEvent.OPERATION_COMPLETE,queueEmptyHandler);
			queue.addEventListener(OperationEvent.CHILD_OPERATION_COMPLETE,queueCompleteHandler);
			for (var i:int = step; i< opers.length;i++)
				queue.commitChild(opers[i] as Oper);
		}
		
		private function queueCompleteHandler(event:OperationEvent):void
		{
			_step++;
		}
		
		private function queueEmptyHandler(event:OperationEvent):void
		{
			var e:QuestEvent = new QuestEvent(QuestEvent.QUEST_COMPLETE);
			e.id = this.id;
			dispatchEvent(e);
		}
		
		/**
		 * 销毁 
		 * 
		 */
		public function destory():void
		{
			if (queue)
			{
				queue.removeEventListener(OperationEvent.OPERATION_COMPLETE,queueEmptyHandler);
				queue.removeEventListener(OperationEvent.CHILD_OPERATION_COMPLETE,queueCompleteHandler);
			}	
		}
	}
}
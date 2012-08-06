package app.battle.message
{
	import app.battle.interfaces.IReceiver;

	/**
	 * 战斗房间控制器 
	 * @author PianFeng
	 * 
	 */	
	public class QueueManager  
	{
		protected static var instance:QueueManager;
		protected var queue:Vector.<IActionMessage>;
		
		public function QueueManager()
		{
			queue=new Vector.<IActionMessage>();
		}
		
		public static function getInstance():QueueManager
		{
			if(instance==null)
				instance=new QueueManager();
			
			return instance;
		}
		/**
		 * 添加消息到队列管理器 
		 * @param act
		 * 
		 */		
		public function push(msg:IActionMessage):void
		{
			queue.push(msg);
		}
		/**
		 * 消息队列是否为空 
		 * @return 
		 * 
		 */		
		public function get empty():Boolean
		{
			return queue.length==0;
		}
		/**
		 * 把消息顺序压到目标人队列中
		 * 
		 */		
		public function execute():void
		{
			while(queue.length>0)
			{
				var msg:IActionMessage=queue.shift();
				msg.To.push(msg);
			}
		}
		/**
		 * 删除与目标相关的消息 
		 * @param receiver
		 * 
		 */		
		public function removeByReceiver(receiver:IReceiver):void
		{
			for(var i:int=0,j:int=queue.length;i<j;i++)
			{
				var msg:IActionMessage=queue[i] as IActionMessage
					
				if(msg.To==receiver)
					queue.splice(i,1);
					
			}
		}
		/**
		 * 
		 * 
		 */		
		public function clearAll():void
		{
			queue.splice(0,queue.length);
		}
	}
}
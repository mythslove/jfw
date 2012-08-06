package app.battle.message
{
	import app.battle.action.IAction;
	import app.globals.interfaces.IReceiver;
	import app.globals.interfaces.ISender;
	/**
	 * 战斗消息 
	 * @author PianFeng
	 * 
	 */	
	public class ActionMessage implements IActionMessage
	{
		protected var name:String;
		protected var from:ISender;
		protected var to:IReceiver;
		protected var actions:Array;
		
		public function ActionMessage(name:String,from:ISender,to:IReceiver,actions:Array=null)
		{
			this.name=name;
			this.from=from;
			this.to=to;
			this.actions=actions;
		}
	
		public function get Name():String
		{
			return this.name;
		}

		public function set Name(name:String):void
		{
			this.name=name;
		}
	
		public function get From():ISender
		{
			return this.from;
		}

		public function set From(value:ISender):void
		{
			this.from=value;
		}
	
		public function get To():IReceiver
		{
			return this.to;
		}

		public function set To(value:IReceiver):void
		{
			this.to=value;
		}
	
		public function get Actions():Array
		{
			return this.actions;
		}
	
		public function set Actions(value:Array):void
		{
			this.actions=value;
		}
		
		public function AddItem(action:IAction):void
		{
			if(this.actions==null)
				actions=[];
			
			actions.push(action);
		}
	}
}
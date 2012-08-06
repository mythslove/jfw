package app.statemachine
{
	import app.charactor.Charactor;
	import app.globals.interfaces.ICharactor;
	import app.mvc.models.res.BattleDataProxy;
	import app.statemachine.states.BaseState;
	import app.statemachine.states.IState;
	
	import flash.utils.Dictionary;

	/**
	 *状态机 
	 * 
	 */		
	public class StateMachine implements IStateMachine
	{
		public var stateArr:Dictionary;
		protected var char:ICharactor;
		protected var battleDataProxy:BattleDataProxy;
		/**
		 * 
		 * @param char 所有者
		 * @param battleDataProxy 所有者所在的世界
		 * 
		 */		
		public function StateMachine(char:ICharactor,battleDataProxy:BattleDataProxy)
		{
			this.stateArr=new Dictionary();
			this.char=char;
			this.battleDataProxy=battleDataProxy;
		}
		/**
		 * 添加状态到状态机 
		 * @param state
		 * 
		 */		
		public function addState(...args):void
		{
			for each(var s:IState in args)
			{
				(s as BaseState).npc=char;
				(s as BaseState).battleDataProxy=battleDataProxy;
				stateArr[s.getName()]=s;
			}
		}
		/**
		 * 删除所有状态
		 * @param state
		 * 
		 */		
		public function removeAll():void
		{
			for each(var s:IState in this.stateArr)
			{
				stateArr[s.getName()]=null;
				delete stateArr[s.getName()];
			}
			
			this.char=null;
			this.battleDataProxy=null;
		}
		/**
		 *得到某一状态
		 * @param stateName
		 * @return 
		 * 
		 */		
		public function getState(stateName:String):IState
		{
			return stateArr[stateName];
		}	
		/**
		 *初始化状态 
		 * @param char
		 * @param state
		 * 
		 */
		public function initState(stateName:String):void
		{
			char.NpcState=stateArr[stateName];
		}
		/**
		 *执行状态里的分支判断 
		 * @param char
		 * 
		 */		
		public function changeState(stateName:String=null):void
		{
			if(stateName!=null)
				char.NpcState=stateArr[stateName];
			
			char.NpcState.execute();
		}
		/**
		 *恢复原来状态 
		 * 
		 */
		public function resetState():void
		{
			char.NpcState.reset();
		}
		/**
		 *保持状态不变 
		 * 
		 */		
		public function keepState():void
		{
			return;
		}
		/**
		 *完成某个状态 
		 * 
		 */		
		public function exitState():void
		{
			char.NpcState.exit();
		}
	}
}
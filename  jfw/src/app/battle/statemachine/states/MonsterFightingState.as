package app.statemachine.states
{
	import app.charactor.Charactor;
	import app.globals.interfaces.ICharactor;
	import app.mvc.models.res.BattleDataProxy;
	import app.statemachine.StateConst;
	import app.statemachine.StateMachine;
	/**
	 *妖将战斗状态 
	 * @author PianFeng
	 * 
	 */	
	public class MonsterFightingState extends BaseState
	{
		public function MonsterFightingState(stateMachine:StateMachine, npc:ICharactor=null, battleDataProxy:BattleDataProxy=null)
		{
			super(stateMachine, npc, battleDataProxy);
			
			this.stateName=StateConst.MONSTER_FIGHTING_STATE;
		}
		
		override public function execute():void
		{
			
		}
		/**
		 *恢复上一个状态 
		 * 
		 */		
		override public function reset():void
		{
			npc.NpcState=npc.OldState;
		}
		
		override public function exit():void
		{
			this.reset();
		}
	}
}
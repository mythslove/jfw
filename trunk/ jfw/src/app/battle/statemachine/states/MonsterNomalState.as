package app.statemachine.states
{
	import app.globals.interfaces.ICharactor;
	import app.mvc.models.res.BattleDataProxy;
	import app.statemachine.StateConst;
	import app.statemachine.StateMachine;
	
	public class MonsterNomalState extends BaseState
	{
		public function MonsterNomalState(stateMachine:StateMachine, npc:ICharactor=null, battleDataProxy:BattleDataProxy=null)
		{
			super(stateMachine, npc, battleDataProxy);
			
			this.stateName=StateConst.MONSTER_NOMAL_STATE
		}
		
		override public function execute():void
		{
			
		}
	}
}
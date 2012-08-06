package app.statemachine.states.fight
{
	import app.globals.interfaces.ICharactor;
	import app.mvc.models.res.BattleDataProxy;
	import app.statemachine.StateMachine;
	import app.statemachine.states.BaseState;
	
	public class FreezingState extends BaseState
	{
		public function FreezingState(stateMachine:StateMachine, npc:ICharactor=null, battleDataProxy:BattleDataProxy=null)
		{
			super(stateMachine, npc, battleDataProxy);
		}
	}
}
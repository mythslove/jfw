package app.statemachine.states
{
	import app.globals.interfaces.ICharactor;
	import app.mvc.models.res.BattleDataProxy;
	import app.statemachine.StateConst;
	import app.statemachine.StateMachine;
	
	public class IsDiedState extends BaseState
	{
		public function IsDiedState(stateMachine:StateMachine, npc:ICharactor=null, battleDataProxy:BattleDataProxy=null)
		{
			super(stateMachine, npc, battleDataProxy);
			
			this.stateName=StateConst.IS_DIED_STATE;
		}
		
		override public function execute():void
		{
			
		}
	}
}
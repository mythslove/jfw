package app.statemachine.states
{
	import app.globals.interfaces.ICharactor;
	import app.mvc.models.res.BattleDataProxy;
	import app.statemachine.StateConst;
	import app.statemachine.StateMachine;
	
	public class StopWalkingState extends BaseState
	{
		public function StopWalkingState(stateMachine:StateMachine, npc:ICharactor=null, battleDataProxy:BattleDataProxy=null)
		{
			super(stateMachine, npc, battleDataProxy);
			
			this.stateName=StateConst.STOP_WALKING_STATE;
		}
		
		override public function execute():void
		{		
			if(this.checkSelfDied())
				executeSelfDied();
			
			if(this.checkStopComplete())
				executeStopComplete();
		}
	}
}
package app.statemachine.states
{
	import app.charactor.Charactor;
	import app.globals.interfaces.ICharactor;
	import app.mvc.models.res.BattleDataProxy;
	import app.statemachine.StateConst;
	import app.statemachine.StateMachine;

	/**
	 *等待出发状态 
	 * @author PianFeng
	 * 
	 */	
	public class ReadyToGoState extends BaseState
	{
		public function ReadyToGoState(stateMachine:StateMachine,npc:ICharactor=null, battleDataProxy:BattleDataProxy=null)
		{
			super(stateMachine,npc, battleDataProxy);
			
			this.stateName=StateConst.READY_TO_GO_STATE;
		}
		
		override public function execute():void
		{
			this.stateMachine.initState(StateConst.WALKING_TOGETHER_STATE);
			this.executeReadyToGo();
		}
	}
}
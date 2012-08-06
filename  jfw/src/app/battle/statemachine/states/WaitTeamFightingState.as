package app.statemachine.states
{
	import app.charactor.Charactor;
	import app.globals.consts.CharactorConst;
	import app.globals.interfaces.ICharactor;
	import app.mvc.models.res.BattleDataProxy;
	import app.statemachine.StateConst;
	import app.statemachine.StateMachine;

	/**
	 *主要是在队伍战斗时未参与战斗的队员的状态 
	 * @author PianFeng
	 * 
	 */	
	public class WaitTeamFightingState extends BaseState
	{
		public function WaitTeamFightingState(stateMachine:StateMachine,npc:ICharactor=null, battleDataProxy:BattleDataProxy=null)
		{
			super(stateMachine,npc, battleDataProxy);
			
			this.stateName=StateConst.WAIT_TEAM_FIGHTING_STATE;
		}
		
		override public function execute():void
		{
			if(this.checkMasterDied())
			{
				this.stateMachine.initState(StateConst.WALKING_ALONE_STATE);//设置状态为朝向主路	
				this.executeMasterDied();
				
				return;
			}
		}
		
		override public function exit():void
		{
			this.reset();
		}
	}
}
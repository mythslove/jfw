package app.statemachine.states
{
	import app.charactor.Charactor;
	import app.globals.consts.CharactorConst;
	import app.globals.interfaces.ICharactor;
	import app.mvc.models.res.BattleDataProxy;
	import app.statemachine.StateConst;
	import app.statemachine.StateMachine;
	
	public class MasterWaitTeamFightingState extends BaseState
	{
		public function MasterWaitTeamFightingState(stateMachine:StateMachine, npc:ICharactor=null, battleDataProxy:BattleDataProxy=null)
		{
			super(stateMachine, npc, battleDataProxy);
			
			this.stateName=StateConst.WAIT_TEAM_FIGHTING_STATE;
		}
		
		override public function execute():void
		{
			if(this.checkSelfDied())
			{
				executeSelfDied();
				return;
			}
		}
		
		override public function exit():void
		{
			this.reset();
		}
		/**
		 *处理自己死亡 
		 * 子类里要重写
		 */		
		override protected function executeSelfDied():void
		{
		//	char.isJoinedTeam=false;
			npc.Status=CharactorConst.DIED;
			this.stateMachine.initState(StateConst.IS_DIED_STATE);
			this.teamManager.removeAll();
		}
	}
}
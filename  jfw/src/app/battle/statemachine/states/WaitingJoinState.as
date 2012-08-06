package app.statemachine.states
{
	import app.charactor.Charactor;
	import app.globals.interfaces.ICharactor;
	import app.mvc.models.res.BattleDataProxy;
	import app.statemachine.StateConst;
	import app.statemachine.StateMachine;

	/**
	 *等待加入队伍状态 
	 * @author PianFeng
	 * 
	 */	
	public class WaitingJoinState extends BaseState
	{
		public function WaitingJoinState(stateMachine:StateMachine,npc:ICharactor=null, battleDataProxy:BattleDataProxy=null)
		{
			super(stateMachine,npc, battleDataProxy);
			
			this.stateName=StateConst.WAITING_JOIN_STATE;
		}
		
		override public function execute():void
		{
			if(this.checkSelfDied())
			{
				executeSelfDied();
				return;
			}
			
			if(this.checkMasterDied())
			{
				if(this.checkIdleMonster())
				{
					this.stateMachine.initState(StateConst.FIGHTING_STATE);
					this.executeNpcFight();
				}
				else
				{
					this.stateMachine.initState(StateConst.WALKING_ALONE_STATE);//设置状态为朝向主路	
					this.executeMasterDied();
				}
				
				return;
			}
			
			if(!this.checkTeamFighting()&&!this.checkTeamAdjusting())//不在战斗和调整是才可以加入
			{
				this.executeJoinTeam();
			}
		}
	}
}
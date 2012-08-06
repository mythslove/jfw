package app.statemachine.states
{
	import app.charactor.Charactor;
	import app.globals.events.GameEvent;
	import app.globals.interfaces.ICharactor;
	import app.mvc.models.res.BattleDataProxy;
	import app.statemachine.StateConst;
	import app.statemachine.StateMachine;
	
	import flash.display.Sprite;

	/**
	 *追寻队长状态,方向一定是朝向队长的 
	 * @author PianFeng
	 * 
	 */	
	public class WalkingToMasterState extends BaseState
	{
		public function WalkingToMasterState(stateMachine:StateMachine,npc:ICharactor=null, battleDataProxy:BattleDataProxy=null)
		{
			super(stateMachine,npc, battleDataProxy);
			
			this.stateName=StateConst.WALKING_TO_MASTER_STATE;
		}
		
		override public function execute():void
		{
			if(this.checkSelfDied())
			{
				executeSelfDied();
				return;
			}
			//分支判断
			if(this.checkGridPoint())
			{	
				if(this.checkGameOver())
				{
					//队员直接离场,战斗结束	
					npc.dispatchEvent(new GameEvent(GameEvent.GAME_FAIL,null,true,true));
					return;
				}
				
				if(this.checkMagicItem())
					this.executeMagicItem();
				
				if(this.checkItem())
				{
					if(this.checkCorner())
					{
						this.stateMachine.initState(StateConst.TURNING_CORNER_STATE);
						this.executeTurningCornerAlone();
					}
					else if(this.checkPortal())
					{
						if(this.checkMainPortal())
						{
							this.stateMachine.initState(StateConst.ON_ISLAND_STATE);
							this.executeIsLand();
						}		
					}
					else if(this.checkStopWalking())
					{
						this.executeStopWalking();		
					}
					
					return;
				}
			}
			
			if(this.checkIdleMonster())
			{
				this.stateMachine.initState(StateConst.FIGHTING_STATE);
				this.executeNpcFight();
				
				return;
			}
			
			if(this.checkMasterDied())
			{
				this.stateMachine.initState(StateConst.WALKING_ALONE_STATE);//设置状态为朝向主路	
				this.executeMasterDied();
				
				return;
			}
			
			if(this.checkJoinTeamReady())
			{
				if(this.checkTeamFighting()||this.checkTeamAdjusting())
				{
					this.stateMachine.initState(StateConst.WAITING_JOIN_STATE);
					this.executeWaitToJoin();
				}
				else
				{
					this.stateMachine.initState(StateConst.WALKING_TOGETHER_STATE);
					this.executeJoinTeam();
				}
				
				return;
			}
			
			if(this.checkGridPoint())
				this.executeAcknowledgeWalk();
		}
	}
}
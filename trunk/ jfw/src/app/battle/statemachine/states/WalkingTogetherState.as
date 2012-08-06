package app.statemachine.states
{
	import app.charactor.Charactor;
	import app.globals.consts.CharactorConst;
	import app.globals.events.GameEvent;
	import app.globals.interfaces.ICharactor;
	import app.mvc.models.res.BattleDataProxy;
	import app.mvc.views.game.mapItem.base.BaseBattleItem;
	import app.statemachine.StateConst;
	import app.statemachine.StateMachine;
	
	import flash.display.Sprite;

	/**
	 *组队行走状态 
	 * @author PianFeng
	 * 
	 */	
	public class WalkingTogetherState extends BaseState
	{
		public function WalkingTogetherState(stateMachine:StateMachine,npc:ICharactor=null, battleDataProxy:BattleDataProxy=null)
		{
			super(stateMachine,npc, battleDataProxy);
			
			this.stateName=StateConst.WALKING_TOGETHER_STATE;
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
				this.stateMachine.initState(StateConst.WALKING_ALONE_STATE);//设置状态为朝向主路	
				this.executeMasterDied();
				
				return;
			}
			else
			{
				npc.CurrSpeed=this.getMaster().CurrSpeed;
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
					if(this.checkActionIndex((this.currentItem as BaseBattleItem).FIndex))
					{
						executeDefItem();

						if(this.checkCorner())
						{
							this.stateMachine.initState(StateConst.TURNING_CORNER_STATE);
							this.executeTurningCorner();
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
			}
			
			if(this.checkIdleMonster())
			{
				this.executeWaitTeamFighting();//此处先由队管停止所有人移动,改变所有人状态为等待队伍战斗,最后战管处理战斗
				
				return;
			}
			
			if(this.checkGridPoint())
				this.executeAcknowledgeWalk();
		}
		
		override protected function executeSelfDied():void
		{
			if(npc.Status==CharactorConst.WALK)
				this.stopWalking();
			
			npc.IsJoinedTeam=false;
			npc.Status=CharactorConst.DIED;
			this.stateMachine.initState(StateConst.IS_DIED_STATE);
			
			if(npc.Type==CharactorConst.MASTER)
				return;
			
			npc.dispatchEvent(new GameEvent(GameEvent.LEAVE_TEAM,npc,true,true));
		}
	}
}
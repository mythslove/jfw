package app.statemachine.states
{
	import app.charactor.Charactor;
	import app.globals.consts.CharactorConst;
	import app.globals.events.GameEvent;
	import app.globals.interfaces.ICharactor;
	import app.mvc.models.res.BattleDataProxy;
	import app.statemachine.StateConst;
	import app.statemachine.StateMachine;
	
	import flash.display.Sprite;
	
	public class MasterWalkingState extends BaseState
	{
		public function MasterWalkingState(stateMachine:StateMachine, npc:ICharactor=null, battleDataProxy:BattleDataProxy=null)
		{
			super(stateMachine, npc, battleDataProxy);
			
			this.stateName=StateConst.WALKING_TOGETHER_STATE;
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
					executeDefItem();
					executeIgnoreItem();
					return;
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
			var char:Charactor=npc as Charactor;
			this.stopWalking();
			//char.isJoinedTeam=false;
			npc.Status=CharactorConst.DIED;
			this.stateMachine.initState(StateConst.IS_DIED_STATE);
			teamManager.removeAll();
		}
	}
}
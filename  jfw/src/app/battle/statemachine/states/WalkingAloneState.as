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
	 *队长死后,队员在主路上单独行走时的状态 
	 * @author PianFeng
	 * 
	 */	
	public class WalkingAloneState extends BaseState
	{
		public function WalkingAloneState(stateMachine:StateMachine, npc:ICharactor=null, battleDataProxy:BattleDataProxy=null)
		{
			super(stateMachine, npc, battleDataProxy);
			
			this.stateName=StateConst.WALKING_ALONE_STATE;
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
			
			if(this.checkIdleMonster())
			{
				this.stateMachine.initState(StateConst.FIGHTING_STATE);
				this.executeNpcFight();
				
				return;
			}
			//分支判断
			if(this.checkGridPoint())
				this.executeAcknowledgeWalk();
		}
	}
}
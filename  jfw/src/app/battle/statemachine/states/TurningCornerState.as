package app.statemachine.states
{
	import app.charactor.Charactor;
	import app.globals.interfaces.ICharactor;
	import app.mvc.models.res.BattleDataProxy;
	import app.mvc.views.game.mapItem.base.BaseBattleItem;
	import app.statemachine.StateConst;
	import app.statemachine.StateMachine;

	/**
	 * 转向中的状态
	 * @author PianFeng
	 * 当需要转向一个过渡状态(回到主路)时,只需要停止人物移动
	 */	
	public class TurningCornerState extends BaseState
	{
		public function TurningCornerState(stateMachine:StateMachine,npc:ICharactor=null, battleDataProxy:BattleDataProxy=null)
		{
			super(stateMachine,npc, battleDataProxy);
			
			this.stateName=StateConst.TURNING_CORNER_STATE;
		}
		
		override public function execute():void
		{
			if(this.checkSelfDied())
			{
				executeSelfDied();
				return;
			}
			trace(npc.GridX,npc.GridY);
			//分支判断
			if(this.checkGridPoint())
			{			
				if(this.checkMainOrMinRoad())//由回到主路状态处理战斗问题
				{
					this.stateMachine.initState(StateConst.BACK_TO_MAIN_ROAD_STATE);
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
			
			if(this.checkGridPoint())
				this.executeAcknowledgeWalk();
		}
	}
}
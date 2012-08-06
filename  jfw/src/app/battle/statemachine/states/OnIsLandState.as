package app.statemachine.states
{
	import app.charactor.Charactor;
	import app.globals.interfaces.ICharactor;
	import app.mvc.models.res.BattleDataProxy;
	import app.mvc.views.game.mapItem.base.BaseBattleItem;
	import app.statemachine.StateConst;
	import app.statemachine.StateMachine;

	/**
	 *在岛上 
	 * @author PianFeng
	 * 
	 */	
	public class OnIsLandState extends BaseState
	{
		public function OnIsLandState(stateMachine:StateMachine,npc:ICharactor=null, battleDataProxy:BattleDataProxy=null)
		{
			super(stateMachine,npc, battleDataProxy);
			
			this.stateName=StateConst.ON_ISLAND_STATE;
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
				if(this.checkMagicItem())
					this.executeMagicItem();
				
				if(this.checkItem())
				{
					executeDefItem();
					
					if(this.checkPortal())
					{	
						if(this.checkMinPortal())
						{
							this.executeReturnBack();
							
							if(this.checkMainOrMinRoad())
							{
								this.stateMachine.initState(StateConst.BACK_TO_MAIN_ROAD_STATE);
								this.executeBackToMainRoad();
							}
							else
							{
								this.stateMachine.initState(StateConst.TURNING_CORNER_STATE);
								this.executeBackToMinRoad();	
							}
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
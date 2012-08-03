package app.statemachine.states
{
	import app.charactor.Charactor;
	import app.globals.interfaces.ICharactor;
	import app.mvc.models.res.BattleDataProxy;
	import app.mvc.views.game.mapItem.base.BaseBattleItem;
	import app.statemachine.StateConst;
	import app.statemachine.StateMachine;
	
	import com.pianfeng.engine.isolib.map.data.Tile;

	/**
	 *回到主路状态 
	 * @author PianFeng
	 * 
	 */	
	public class BackToMainRoadState extends BaseState
	{
		public function BackToMainRoadState(stateMachine:StateMachine,npc:ICharactor=null, battleDataProxy:BattleDataProxy=null)
		{
			super(stateMachine,npc, battleDataProxy);
			
			this.stateName=StateConst.BACK_TO_MAIN_ROAD_STATE;
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
				
				if(this.checkIdleMonster())
				{
					this.stateMachine.initState(StateConst.FIGHTING_STATE);
					this.executeNpcFight();
					
					return;
				}
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
					this.executeWaitToJoin()
				}
				else
				{
					this.stateMachine.initState(StateConst.WALKING_TOGETHER_STATE);
					this.executeJoinTeam();
				}
				
				return;
			}

			if(this.checkGridPoint())
				this.executeDirection();
		}	
	}
}
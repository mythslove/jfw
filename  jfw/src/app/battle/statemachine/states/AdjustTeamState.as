package app.statemachine.states
{
	import app.charactor.Charactor;
	import app.globals.interfaces.ICharactor;
	import app.mvc.models.res.BattleDataProxy;
	import app.statemachine.StateConst;
	import app.statemachine.StateMachine;

	/**
	 *调整队形状态,此状态不做任何自身更改
	 * @author PianFeng
	 * 
	 */	
	public class AdjustTeamState extends BaseState
	{
		public function AdjustTeamState(stateMachine:StateMachine,npc:ICharactor=null,battleDataProxy:BattleDataProxy=null)
		{
			super(stateMachine,npc, battleDataProxy);
			
			this.stateName=StateConst.ADJUST_TEAM_STATE;
		}	
		
		override public function execute():void
		{

		}
		
		override public function exit():void
		{
			this.stateMachine.initState(StateConst.WALKING_TOGETHER_STATE);//初始化状态	
			this.executeAdjustTeam();
		}
	}
}
package app.statemachine.states
{
	import app.charactor.Charactor;
	import app.globals.interfaces.ICharactor;
	import app.mvc.models.res.BattleDataProxy;
	import app.statemachine.StateConst;
	import app.statemachine.StateMachine;

	/**
	 *战斗状态 
	 * @author PianFeng
	 * 
	 */	
	public class FightingState extends BaseState
	{
		public function FightingState(stateMachine:StateMachine,npc:ICharactor=null,battleDataProxy:BattleDataProxy=null)
		{
			super(stateMachine,npc, battleDataProxy);
			
			this.stateName=StateConst.FIGHTING_STATE;
		}
		
		override public function execute():void
		{

		}
		
		override public function exit():void
		{
			if(this.checkMainOrMinRoad())
				this.executeDirection();
			else
				this.reset();
		}
	}
}
package app.battle.action
{
	/**
	 * 普通伤害动作 
	 * @author PianFeng
	 * 
	 */	
	public class NormalAction extends BaseAction
	{
		/**
		 * 技能造成的伤害 
		 * @return 
		 * 
		 */	
		public var value:int=0;
		/**
		 * 播放动作类型
		 * 0:常态,1:受击
		 */		
		public var active:int=0;

		public function NormalAction(value:int=0,active:int=0)
		{
			super();	
			this.name=ActionConst.NORMAL_ACTION;
			this.value=value;
			this.active=active;
		}
	}
}
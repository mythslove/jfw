package app.battle.action
{
	/**
	 * 特效动作 
	 * @author PianFeng
	 * 
	 */	
	public class EffectAction extends BaseAction
	{
		public var effectID:int=0;
		/**技能效果位置0:上,1:中,2:下*/
		public var point:int=0;
		
		public function EffectAction(effid:int=0,point:int=0)
		{
			super();
			
			this.name=ActionConst.EFFECT_ACTION;
			this.effectID=effid;
			this.point=point;
		}
	}
}
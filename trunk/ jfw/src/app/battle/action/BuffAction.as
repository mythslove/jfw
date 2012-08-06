package app.battle.action
{
	/**
	 * buff是播放在身上位置的特效 
	 * @author PianFeng
	 * 
	 */	
	public class BuffAction extends BaseAction
	{
		public var buffType:int=0;
		public var buffValue:int=0;
		/**持续性buff特效 */
		public var effect:int=0;
		/**特效播放位置*/
		public var pt:int=0;
		/**持续时间 */		
		public var dt:int=0;
		public var act:int=0;
			
		public function BuffAction(buffType:int=0,buffValue:int=0,dt:int=0,act:int=0,effect:int=0,pt:int=0)
		{
			super();
			
			this.name=ActionConst.BUFF_ACTION;
			this.buffType=buffType;
			this.buffValue=buffValue;
			this.dt=dt;
			this.act=act;
			this.effect=effect;
			this.pt=pt;
		}
	}
}
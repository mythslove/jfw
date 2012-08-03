package app.battle.action
{
	/**
	 * 包括:buff交换,buff好变坏,坏变好,buff取消,抗魔 
	 * @author PianFeng
	 * 
	 */	
	public class SpecialAction extends BaseAction
	{
		public function SpecialAction()
		{
			super();
			
			this.name=ActionConst.SPECIAL_ACTION;
		}
	}
}
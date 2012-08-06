package app.battle.utils
{
	import app.vo.ValueResultVO;

	/**
	 * 战斗计算公式类 
	 * @author PianFeng
	 * 
	 */
	public class BattleCalculate
	{
		/**
		 * 检查字符串是数值或百分比
		 * 如果是百分比则返回int表示形式
		 * @param ValueResultVO
		 * @return 
		 * 
		 */		
		static public function CheckValOrPer(input:String):ValueResultVO
		{
			if(input.substr(0,1)=='%')
				return new ValueResultVO(false,parseInt(input.substr(1,input.length-1))/100);
			else
				return new ValueResultVO(true,parseFloat(input));	
		}
	}
}
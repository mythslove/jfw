package app.vo
{
	/**
	 * 保存分析字符串的结果 
	 * @author PianFeng
	 * 
	 */	
	public class ValueResultVO
	{
		/** 是否百分比 值为true*/
		public var isValue:Boolean;
		/** 值或百分比的number表示形式*/
		public var value:Number;
		
		public function ValueResultVO(isVal:Boolean,val:Number)
		{
			this.isValue=isVal;
			this.value=val;
		}
	}
}
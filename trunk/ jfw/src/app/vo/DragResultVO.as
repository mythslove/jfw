package app.vo
{
	/**
	 * 规则分通用规则和道具本身规则 
	 * @author PianFeng
	 * 
	 */	
	public class DragResultVO
	{
		public var isSuccessful:Boolean=true;
		public var result:int=0;
		
		/** 拖方道具超过地图边界 */
		static public const IS_OVER_TAKE:int = 0;
		/** 不是可行路径 */
		static public const IS_NOT_ROAD:int = 1;
		/** 该位置被占用 */
		static public const IS_OCCUPIED :int = 2;
		/** 该道具超过场上的数量限制 */
		static public const IS_OVER_COUNT :int = 3;
		/** 该道具的所费法力超过用户当前法力*/
		static public const IS_OVER_POWER :int = 4;
		/** 
		 * 是可行路径但规则不允许摆放 
		 * 妖将不允许摆放到站位路块,开始路块,结束路块,岛的入口点
		 * 转向只能摆放在岔路口
		 * 传送门母门不能摆放在开始路块,站位路块,结束路块,死路,岛上,
		 * 子门只能放在岛上的两端,并且必须有母门存在
		 */
		static public const CAN_NOT_DROP :int = 5;
		/** 不是岛图,主要针对传送门 */
		static public const IS_NOT_ISLAND_MAP :int = 6;
		/** 同一个妖将不允许重复出现 */
		static public const CAN_NOT_REPEAT :int = 7;
		/** 该vip道具数量是否足够 */
		static public const COUNT_IS_ZERO :int = 8;
		
		public function DragResultVO(isSuccessful:Boolean,result:int=0)
		{
			this.isSuccessful=isSuccessful;
			this.result=result;
		}
	}
}
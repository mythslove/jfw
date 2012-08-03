package app.vo
{
	public class ItemVO 
	{
		/** 所属用户ID */
		public var id:int=0;
		
		/**资源id*/	
		public var srcid:int;
		
		/** 物品ID */
		public var singleID:int=0;
		
		/** 物品名称(en) */
		public var name:String;
		
		/** 物品描述 */
		public var desc:String;
		
		/** 物品类型 */
		public var type:int=0;
		
		/** 物品级别 */
		public var level:int=0;
		
		/** 拖拽类型 */
		public var dragType:int=-1;
		
		/** x坐标 */
		public var gridX:int=0;
		
		/** y坐标 */
		public var gridY:int=0;
		
		/** 是否已摆放确认*/
		public var isLay:Boolean=false;
		
		/** 0:玩家,1:中立 */
		public var belong:int=0;
		
		/** 消耗法力 */
		public var costMp:int=0;
		
		/** 消耗金币 */
		public var costMoney:int=0;
		
		/** 是否是负费法宝*/
		public var isVip:Boolean=false;
		
		/** 开始标签*/
		public var startLabel:String;
		
		/** 结束标签*/
		public var endLabel:String;
		
		/** 播放速度*/
		public var playSpeed:int=5;
		
		/** 是否重复播放*/
		public var isPlayRpeat:Boolean=true;
		
		/** 播放次数*/
		public var playTimes:int=0;
		
		/** 暂停标志 */
		public var pause:Boolean=false;
	}
}
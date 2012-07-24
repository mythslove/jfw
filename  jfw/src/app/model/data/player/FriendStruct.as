package app.model.data.player
{
	public class FriendStruct extends PlayerStruct
	{
		
		/** 是否NPC */
		public var isNpc:Boolean = false;
		
		/** 是否自己 */
		public var isSelf:Boolean = false;
		
		/** 好友五行山的晶石类型 */
		public var type:int = 0;
		
		/** 排名 */
		public var rank:int = 1;
		
		/** 是否已经拜访过 */
		public var isVisit:Boolean = false;
		
		
		public function FriendStruct(obj:Object=null)
		{
			super(obj);
		}
		
		override protected function parse( obj:Object ):void
		{
			super.parse(obj);
			
			this.isNpc 		= obj.isNpc;
			this.isSelf 	= obj.isSelf;
			this.rank 		= obj.rank;
			this.isVisit 	= obj.isVisit;
			this.type 		= obj.type;
		}
	}
}
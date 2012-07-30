package app.mvc.model.data.player
{
	public class FriendStruct extends PlayerStruct
	{
		
		/** 是否NPC */
		public var isNpc:Boolean = false;
		
		/** 是否自己 */
		public var isSelf:Boolean = false;
		
		/** 是否仇人 */
		public var isPoe:Boolean = false;
		
		/** 好友五行山的晶石类型 */
		public var type:int = 0;
		
		/** 排名 */
		public var rank:int = 1;
		
		/** 是否已经拜访过 */
		public var isVisit:Boolean = false;
		
		/** 是否已赠送或索要过礼物 */
		public var isSendGift:Boolean = false;
		
		/** 是否已获得访问礼包 */
		public var isGetBox:Boolean = false;
		
		
		public function FriendStruct(obj:Object=null)
		{
			super(obj);
		}
		
		override protected function parse( obj:Object ):void
		{
			super.parse(obj);
			
			this.isNpc 			= ( obj.isNpc == 1 );
			this.isSelf 		= ( obj.isSelf == 1 );
			this.isPoe			= ( obj.isPoe == 1 );
			this.rank 			= obj.rank;
			this.isVisit 		= ( obj.isVisit == 1 );
			this.type 			= obj.type;
			this.isSendGift 	= ( obj.isSendGift == 1 );
			this.isGetBox		= ( obj.isGetBox == 1 );
		}
	}
}
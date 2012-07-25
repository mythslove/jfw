package app.model.player
{
	import app.model.data.player.FriendStruct;
	
	import com.jfw.engine.core.mvc.model.BModel;

	public class FriendModel extends BModel
	{
		static public const NAME:String = 'FriendModel';
		
		/** 好友列表 */
		public var friendList:Array = [];
		
		/** 仇人列表 */
		public var foeList:Array = [];
		
		public function FriendModel( )
		{
			super( NAME );
		}
		
		/**
		 * 初始化好友 
		 * @param friends
		 */
		public function initFriendList( friends:Array = null ):void
		{
			friendList = [];
			
			var url:String = 'http://img3.paipaiimg.com/f1558419/expr-4FDECB50-0000000032F653D34FDECB5000045C39.1.jpg';
			friends = [
				//好友列表测试
				{uid:1,uname:'好友1',thumb:url,exp:1200,vip:1,viplv:2,lv:20,sex:1,type:1,friendly:100},
				{uid:2,uname:'好友2',thumb:url,exp:3000,vip:0,viplv:0,lv:30,sex:1,type:0,friendly:222},
				{uid:3,uname:'好友3',thumb:url,exp:4000,vip:1,viplv:6,lv:11,sex:0,type:0,friendly:100},
				{uid:4,uname:'好友4',thumb:url,exp:1220,vip:0,viplv:0,lv:20,sex:0,type:2,friendly:34},
				{uid:5,uname:'好友5',thumb:url,exp:4020,vip:0,viplv:0,lv:9,sex:1,type:2,friendly:5},
				{uid:6,uname:'好友6',thumb:url,exp:1000,vip:0,viplv:0,lv:21,sex:0,type:5,friendly:12},
				{uid:7,uname:'好友7',thumb:url,exp:500,vip:0,viplv:0,lv:6,sex:1,type:2,friendly:67},
				{uid:8,uname:'好友8',thumb:url,exp:1000,vip:1,viplv:2,lv:20,sex:1,type:4,friendly:100},
				{uid:9,uname:'好友9',thumb:url,exp:1000,vip:1,viplv:2,lv:20,sex:1,type:2,friendly:78},
				{uid:10,uname:'好友10',thumb:url,exp:1000,vip:1,viplv:2,lv:20,sex:1,type:2,friendly:99},
				{uid:11,uname:'好友11',thumb:url,exp:1000,vip:1,viplv:2,lv:20,sex:1,type:3,friendly:100},
				{uid:12,uname:'好友12',thumb:url,exp:1000,vip:1,viplv:2,lv:20,sex:1,type:2,friendly:100},
				{uid:13,uname:'好友13',thumb:url,exp:1000,vip:1,viplv:2,lv:11,sex:0,type:3,friendly:100},
				{uid:14,uname:'好友14',thumb:url,exp:1000,vip:1,viplv:2,lv:20,sex:1,type:2,friendly:34},
				{uid:15,uname:'好友15',thumb:url,exp:1000,vip:1,viplv:2,lv:20,sex:1,type:2,friendly:89},
				{uid:16,uname:'好友16',thumb:url,exp:1000,vip:1,viplv:2,lv:20,sex:1,type:1,friendly:78},
				{uid:17,uname:'好友17',thumb:url,exp:1000,vip:1,viplv:2,lv:21,sex:1,type:2,friendly:56},
				{uid:18,uname:'好友18',thumb:url,exp:1000,vip:1,viplv:2,lv:20,sex:1,type:2,friendly:54},
				{uid:19,uname:'好友19',thumb:url,exp:1000,vip:1,viplv:2,lv:33,sex:1,type:2,friendly:23},
				{uid:20,uname:'好友20',thumb:url,exp:1000,vip:1,viplv:2,lv:20,sex:1,type:2,friendly:12},
			];
			
			// 初始化好友列表
			var frdStruct:FriendStruct = null;
			for each( var info:Object in friends )
			{
				frdStruct = new FriendStruct( info );
				friendList.push( frdStruct );
			}
			
//			friendList.sort( sortVip );
//			friendList.sort( sortLv );
			var rank:int = 1;
			for each ( var friend:FriendStruct in friendList )
			{
				if ( friend.isNpc )
					continue;
				friend.rank = rank++;
			}
			
			// 通知好友列表初始化完成
//			sendNotification( ModelEvents.INITFRIENDLIST );
		}
		
		/**
		 * 根据是否VIP排序 
		 * 	若返回值为负，则表示 A 在排序后的序列中出现在 B 之前。
			若返回值为 0，则表示 A 和 B 具有相同的排序顺序。
			若返回值为正，则表示 A 在排序后的序列中出现在 B 之后。
		 */
		private function sortVip( frdStruct1:FriendStruct,frdStruct2:FriendStruct ):Number
		{
			if ( frdStruct1.viplv > frdStruct2.viplv )
				return -1;
			else if ( frdStruct1.viplv == frdStruct2.viplv )
				return 0;
			else 
				return 1;
		}
		
		/**
		 * 根据等级排序 
		 * 
		 */
		private function sortLv( frdStruct1:FriendStruct,frdStruct2:FriendStruct ):Number
		{
			if( frdStruct1.lv >frdStruct2.lv )
				return -1;
			else if( frdStruct1.lv == frdStruct2.lv )
				return 0;
			else
				return 1;
		}
	}
}
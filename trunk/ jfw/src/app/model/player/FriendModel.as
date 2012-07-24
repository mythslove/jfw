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
				{uid:1,uname:'test1',thumb:url,exp:1200,vip:1,viplv:2,lv:20,sex:1,type:1},
				{uid:2,uname:'test2',thumb:url,exp:3000,vip:0,viplv:0,lv:30,sex:1,type:1},
				{uid:3,uname:'test3',thumb:url,exp:4000,vip:1,viplv:6,lv:11,sex:0,type:3},
				{uid:4,uname:'test4',thumb:url,exp:1220,vip:1,viplv:4,lv:20,sex:0,type:2},
				{uid:5,uname:'test5',thumb:url,exp:4020,vip:1,viplv:1,lv:9,sex:1,type:2},
				{uid:6,uname:'test6',thumb:url,exp:1000,vip:1,viplv:2,lv:21,sex:0,type:5},
				{uid:7,uname:'test7',thumb:url,exp:500,vip:1,viplv:4,lv:6,sex:1,type:2},
				{uid:8,uname:'test8',thumb:url,exp:1000,vip:1,viplv:2,lv:20,sex:1,type:4},
				{uid:9,uname:'test9',thumb:url,exp:1000,vip:1,viplv:2,lv:20,sex:1,type:2},
				{uid:10,uname:'test10',thumb:url,exp:1000,vip:1,viplv:2,lv:20,sex:1,type:2},
				{uid:11,uname:'test11',thumb:url,exp:1000,vip:1,viplv:2,lv:20,sex:1,type:3},
				{uid:12,uname:'test12',thumb:url,exp:1000,vip:1,viplv:2,lv:20,sex:1,type:2},
				{uid:13,uname:'test13',thumb:url,exp:1000,vip:1,viplv:2,lv:11,sex:0,type:3},
				{uid:14,uname:'test14',thumb:url,exp:1000,vip:1,viplv:2,lv:20,sex:1,type:2},
				{uid:15,uname:'test15',thumb:url,exp:1000,vip:1,viplv:2,lv:20,sex:1,type:2},
				{uid:16,uname:'test16',thumb:url,exp:1000,vip:1,viplv:2,lv:20,sex:1,type:1},
				{uid:17,uname:'test17',thumb:url,exp:1000,vip:1,viplv:2,lv:21,sex:1,type:2},
				{uid:18,uname:'test18',thumb:url,exp:1000,vip:1,viplv:2,lv:20,sex:1,type:2},
				{uid:19,uname:'test19',thumb:url,exp:1000,vip:1,viplv:2,lv:33,sex:1,type:2},
				{uid:20,uname:'test20',thumb:url,exp:1000,vip:1,viplv:2,lv:20,sex:1,type:2}
			];
			
			// 初始化好友列表
			var frdStruct:FriendStruct = null;
			for each( var info:Object in friends )
			{
				//id,isvisit,nickname,sex,headurl,regstamp,optstamp,exp,isvisit
				frdStruct = new FriendStruct( info );
//				frdStruct.uid = info.uid;
//				frdStruct.uname = info.uname;
//				frdStruct.thumb = info.thumb;
//				frdStruct.exp = info.exp;
//				frdStruct.vip = info.vip;
//				frdStruct.viplv = info.viplv;
//				frdStruct.lv = info.lv;
//				frdStruct.sex = info.sex;
//				frdStruct.type = info.type;
				friendList.push( frdStruct );
			}
			
			// 通知好友列表初始化完成
//			sendNotification( ModelEvents.INITFRIENDLIST );
		}
	}
}
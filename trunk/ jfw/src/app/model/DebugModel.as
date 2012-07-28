package app.model
{
	import app.model.data.player.PlayerStruct;
	import app.model.net.NetRequest;
	
	import com.jfw.engine.core.mvc.model.BModel;
	import com.jfw.engine.utils.ServiceDate;
	
	import flash.utils.getTimer;
	
	public class DebugModel extends BModel
	{
		static public const NAME:String = 'DebugModel';
		
		public function DebugModel( )
		{
			super( NAME );
		}
		
		/**
		 * 网络接口本地调试数据 
		 * @param netCmd 网络命令
		 */
		public function netDebugData( netCmd:String ):Object
		{
			var returnParams:Object = new Object();
			
			switch( netCmd )
			{
				case NetRequest.UserInit :
					returnParams = UserInit;
					break;
			}
			returnParams['code'] = 0;
			returnParams['useTime'] = 0;
			returnParams['ts'] = getTimer() / 1000;
			
			return returnParams;
		}
		
		/**
		 * 初始化 
		 * @return 
		 */
		private function get UserInit():Object
		{
			var url:String = 'http://py.qlogo.cn/friend/48a5beee9d1bd4e756676721db670921e5c46efd0b30a07f/audited/60?1323976857';
			return {
				'playerInfo':{
					uid:1,
					aid:'C10001',
					uname:'姜健',
					callName:'六小龄童',
					sex:1,
					thumb: url,
					vip:1,
					viplv:99,
					exp:999999,
					hp:999999,
					yb:999999,
					gb:999999,
					power:999999,
					lv:99,
					att:999999,
					def:999999,
					sp:99,
					jifen:999999,
					lucky:999999,
					friendly:999999,
					clvid:9
				},
				'friendList':[
					{uid:1,uname:'好友1',thumb:url,exp:1200,vip:1,viplv:2,lv:20,sex:1,type:1,friendly:100,isVisit:1,isSendGift:1,isGetBox:1},
					{uid:2,uname:'好友2',thumb:url,exp:3000,vip:0,viplv:0,lv:30,sex:1,type:0,friendly:222,isVisit:1,isSendGift:0,isGetBox:0},
					{uid:3,uname:'好友3',thumb:url,exp:4000,vip:1,viplv:6,lv:11,sex:0,type:0,friendly:100,isVisit:0,isSendGift:0,isGetBox:0},
					{uid:4,uname:'好友4',thumb:url,exp:1220,vip:0,viplv:0,lv:20,sex:0,type:2,friendly:34,isVisit:0,isSendGift:1,isGetBox:0},
					{uid:5,uname:'好友5',thumb:url,exp:4020,vip:0,viplv:0,lv:9,sex:1,type:2,friendly:5,isVisit:1,isSendGift:0,isGetBox:1},
					{uid:6,uname:'好友6',thumb:url,exp:1000,vip:0,viplv:0,lv:21,sex:0,type:5,friendly:12,isVisit:0,isSendGift:1,isGetBox:0},
					{uid:7,uname:'好友7',thumb:url,exp:500,vip:0,viplv:0,lv:6,sex:1,type:2,friendly:67,isVisit:1,isSendGift:0,isGetBox:1},
					{uid:8,uname:'好友8',thumb:url,exp:1000,vip:1,viplv:2,lv:20,sex:1,type:4,friendly:100,isVisit:1,isSendGift:1,isGetBox:1},
					{uid:9,uname:'好友9',thumb:url,exp:1000,vip:1,viplv:2,lv:20,sex:1,type:2,friendly:78,isVisit:1,isSendGift:1,isGetBox:1},
					{uid:10,uname:'好友10',thumb:url,exp:1000,vip:1,viplv:2,lv:20,sex:1,type:2,friendly:99,isVisit:0,isSendGift:1,isGetBox:0},
					{uid:11,uname:'好友11',thumb:url,exp:1000,vip:1,viplv:2,lv:20,sex:1,type:3,friendly:100,isVisit:1,isSendGift:1,isGetBox:1},
					{uid:12,uname:'好友12',thumb:url,exp:1000,vip:1,viplv:2,lv:20,sex:1,type:2,friendly:100,isVisit:1,isSendGift:1,isGetBox:1},
					{uid:13,uname:'好友13',thumb:url,exp:1000,vip:1,viplv:2,lv:11,sex:0,type:3,friendly:100,isVisit:1,isSendGift:1,isGetBox:1},
					{uid:14,uname:'好友14',thumb:url,exp:1000,vip:1,viplv:2,lv:20,sex:1,type:2,friendly:34,isVisit:0,isSendGift:1,isGetBox:0},
					{uid:15,uname:'好友15',thumb:url,exp:1000,vip:1,viplv:2,lv:20,sex:1,type:2,friendly:89,isVisit:1,isSendGift:1,isGetBox:1},
					{uid:16,uname:'好友16',thumb:url,exp:1000,vip:1,viplv:2,lv:20,sex:1,type:1,friendly:78,isVisit:1,isSendGift:1,isGetBox:1},
					{uid:17,uname:'好友17',thumb:url,exp:1000,vip:1,viplv:2,lv:21,sex:1,type:2,friendly:56,isVisit:1,isSendGift:1,isGetBox:1},
					{uid:18,uname:'好友18',thumb:url,exp:1000,vip:1,viplv:2,lv:20,sex:1,type:2,friendly:54,isVisit:1,isSendGift:1,isGetBox:1},
					{uid:19,uname:'好友19',thumb:url,exp:1000,vip:1,viplv:2,lv:33,sex:1,type:2,friendly:23,isVisit:1,isSendGift:1,isGetBox:1},
					{uid:20,uname:'好友20',thumb:url,exp:1000,vip:1,viplv:2,lv:20,sex:1,type:2,friendly:12,isVisit:1,isSendGift:1,isGetBox:1}
				],
				'foeList': [
					{uid:1,uname:'仇人1',thumb:url,exp:1200,vip:1,viplv:2,lv:20,sex:1,type:1,friendly:0,isVisit:1,isSendGift:1,isGetBox:1},
					{uid:2,uname:'仇人2',thumb:url,exp:1200,vip:1,viplv:2,lv:20,sex:1,type:1,friendly:0,isVisit:1,isSendGift:1,isGetBox:1}
				]
			};
		}
	}
}
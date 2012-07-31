package app.mvc.model
{
	import app.mvc.model.data.player.PlayerStruct;
	import app.mvc.model.net.NetRequest;
	
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
					id:1,
					srcid:'C10001',
					name:'姜健',
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
					{uid:1,uname:'好友1',thumb:url,exp:1200,vip:1,viplv:2,lv:20,sex:1,spartype:1,friendly:100,isVisit:1,isSendGift:1,isGetBox:1},
					{uid:2,uname:'好友2',thumb:url,exp:3000,vip:0,viplv:0,lv:30,sex:1,spartype:0,friendly:222,isVisit:1,isSendGift:0,isGetBox:0},
					{uid:3,uname:'好友3',thumb:url,exp:4000,vip:1,viplv:6,lv:11,sex:0,spartype:0,friendly:100,isVisit:0,isSendGift:0,isGetBox:0},
					{uid:4,uname:'好友4',thumb:url,exp:1220,vip:0,viplv:0,lv:20,sex:0,spartype:2,friendly:34,isVisit:0,isSendGift:1,isGetBox:0},
					{uid:5,uname:'好友5',thumb:url,exp:4020,vip:0,viplv:0,lv:9,sex:1,spartype:2,friendly:5,isVisit:1,isSendGift:0,isGetBox:1},
					{uid:6,uname:'好友6',thumb:url,exp:1000,vip:0,viplv:0,lv:21,sex:0,spartype:5,friendly:12,isVisit:0,isSendGift:1,isGetBox:0},
					{uid:7,uname:'好友7',thumb:url,exp:500,vip:0,viplv:0,lv:6,sex:1,spartype:2,friendly:67,isVisit:1,isSendGift:0,isGetBox:1},
					{uid:8,uname:'好友8',thumb:url,exp:1000,vip:1,viplv:2,lv:20,sex:1,spartype:4,friendly:100,isVisit:1,isSendGift:1,isGetBox:1},
					{uid:9,uname:'好友9',thumb:url,exp:1000,vip:1,viplv:2,lv:20,sex:1,spartype:2,friendly:78,isVisit:1,isSendGift:1,isGetBox:1},
					{uid:10,uname:'好友10',thumb:url,exp:1000,vip:1,viplv:2,lv:20,sex:1,spartype:2,friendly:99,isVisit:0,isSendGift:1,isGetBox:0},
					{uid:11,uname:'好友11',thumb:url,exp:1000,vip:1,viplv:2,lv:20,sex:1,spartype:3,friendly:100,isVisit:1,isSendGift:1,isGetBox:1},
					{uid:12,uname:'好友12',thumb:url,exp:1000,vip:1,viplv:2,lv:20,sex:1,spartype:2,friendly:100,isVisit:1,isSendGift:1,isGetBox:1},
					{uid:13,uname:'好友13',thumb:url,exp:1000,vip:1,viplv:2,lv:11,sex:0,spartype:3,friendly:100,isVisit:1,isSendGift:1,isGetBox:1},
					{uid:14,uname:'好友14',thumb:url,exp:1000,vip:1,viplv:2,lv:20,sex:1,spartype:2,friendly:34,isVisit:0,isSendGift:1,isGetBox:0},
					{uid:15,uname:'好友15',thumb:url,exp:1000,vip:1,viplv:2,lv:20,sex:1,spartype:2,friendly:89,isVisit:1,isSendGift:1,isGetBox:1},
					{uid:16,uname:'好友16',thumb:url,exp:1000,vip:1,viplv:2,lv:20,sex:1,spartype:1,friendly:78,isVisit:1,isSendGift:1,isGetBox:1},
					{uid:17,uname:'好友17',thumb:url,exp:1000,vip:1,viplv:2,lv:21,sex:1,spartype:2,friendly:56,isVisit:1,isSendGift:1,isGetBox:1},
					{uid:18,uname:'好友18',thumb:url,exp:1000,vip:1,viplv:2,lv:20,sex:1,spartype:2,friendly:54,isVisit:1,isSendGift:1,isGetBox:1},
					{uid:19,uname:'好友19',thumb:url,exp:1000,vip:1,viplv:2,lv:33,sex:1,spartype:2,friendly:23,isVisit:1,isSendGift:1,isGetBox:1},
					{uid:20,uname:'好友20',thumb:url,exp:1000,vip:1,viplv:2,lv:20,sex:1,spartype:2,friendly:12,isVisit:1,isSendGift:1,isGetBox:1}
				],
				'foeList': [
					{uid:1,uname:'仇人1',thumb:url,exp:1200,vip:1,viplv:2,lv:20,sex:1,spartype:1,friendly:0,isVisit:1,isSendGift:1,isGetBox:1},
					{uid:2,uname:'仇人2',thumb:url,exp:1200,vip:1,viplv:2,lv:20,sex:1,spartype:1,friendly:0,isVisit:1,isSendGift:1,isGetBox:1}
				],
				'spellList': [ 
					{owerid:1,srcid:'S10001',id:100001,name:'NAME1',lv:11,type:1,desc:"法术描述1",cd:300,uptip:'升级后的效果1',yb:1000,bookid:'BK10001'}, 
					{owerid:1,srcid:'S10002',id:100002,name:'NAME2',lv:21,type:1,desc:"法术描述2",cd:300,uptip:'升级后的效果2',yb:1000,bookid:'BK10001'}, 
					{owerid:1,srcid:'S10003',id:100003,name:'NAME3',lv:31,type:1,desc:"法术描述3",cd:300,uptip:'升级后的效果3',yb:1000,bookid:'BK10001'}, 
					{owerid:1,srcid:'S10004',id:100004,name:'NAME4',lv:41,type:1,desc:"法术描述4",cd:300,uptip:'升级后的效果4',yb:1000,bookid:'BK10001'}, 
					{owerid:1,srcid:'S10005',id:100005,name:'NAME5',lv:11,type:1,desc:"法术描述5",cd:300,uptip:'升级后的效果5',yb:1000,bookid:'BK10001'}, 
					{owerid:1,srcid:'S10006',id:100006,name:'NAME6',lv:21,type:1,desc:"法术描述6",cd:300,uptip:'升级后的效果6',yb:1000,bookid:'BK10001'}, 
					{owerid:1,srcid:'S10001',id:100001,name:'NAME7',lv:31,type:1,desc:"法术描述7",cd:300,uptip:'升级后的效果7',yb:1000,bookid:'BK10001'}, 
					{owerid:1,srcid:'S10002',id:100002,name:'NAME8',lv:41,type:1,desc:"法术描述8",cd:300,uptip:'升级后的效果8',yb:1000,bookid:'BK10001'}, 
					{owerid:1,srcid:'S10003',id:100003,name:'NAME9',lv:11,type:1,desc:"法术描述9",cd:300,uptip:'升级后的效果9',yb:1000,bookid:'BK10001'}, 
					{owerid:1,srcid:'S10004',id:100004,name:'NAME10',lv:21,type:1,desc:"法术描述10",cd:300,uptip:'升级后的效果10',yb:1000,bookid:'BK10001'}, 
					{owerid:1,srcid:'S10005',id:100005,name:'NAME11',lv:31,type:1,desc:"法术描述11",cd:300,uptip:'升级后的效果11',yb:1000,bookid:'BK10001'}, 
					{owerid:1,srcid:'S10006',id:100006,name:'NAME12',lv:41,type:1,desc:"法术描述12",cd:300,uptip:'升级后的效果12',yb:1000,bookid:'BK10001'} 
				],
				'monsterList': [
					{owerid:1,srcid:'M10001',id:100001,quality:0,lv:11,name:"老鼠精",soul:5,desc:'',att:100,def:1000,hp:1000,thp:1000,nhp:200,sp:50,ele:1,eleval:2,openlv:1,camps:0,item:[],eq1:{},eq2:{},eq3:{},eq4:{},eq5:{}},
					{owerid:1,srcid:'M10002',id:100002,quality:1,lv:22,name:"至尊宝",soul:4,desc:'',att:100,def:1000,hp:1000,thp:1000,nhp:200,sp:50,ele:1,eleval:2,openlv:1,camps:0,item:[],eq1:{},eq2:{},eq3:{},eq4:{},eq5:{}},
					{owerid:1,srcid:'M10003',id:100003,quality:2,lv:33,name:"凌虚子",soul:6,desc:'',att:100,def:1000,hp:1000,thp:1000,nhp:200,sp:50,ele:1,eleval:2,openlv:1,camps:0,item:[],eq1:{},eq2:{},eq3:{},eq4:{},eq5:{}},
					{owerid:1,srcid:'M10004',id:100004,quality:3,lv:12,name:"黑熊大王",soul:8,desc:'',att:100,def:1000,hp:1000,thp:1000,nhp:200,sp:50,ele:1,eleval:2,openlv:1,camps:0,item:[],eq1:{},eq2:{},eq3:{},eq4:{},eq5:{}},
					{owerid:1,srcid:'M10005',id:100005,quality:4,lv:45,name:"小白龙",soul:2,desc:'',att:100,def:1000,hp:1000,thp:1000,nhp:200,sp:50,ele:1,eleval:2,openlv:1,camps:0,item:[],eq1:{},eq2:{},eq3:{},eq4:{},eq5:{}},
					{owerid:1,srcid:'M10006',id:100006,quality:5,lv:8,name:"猪八戒",soul:8,desc:'',att:100,def:1000,hp:1000,thp:1000,nhp:200,sp:50,ele:1,eleval:2,openlv:1,camps:0,item:[],eq1:{},eq2:{},eq3:{},eq4:{},eq5:{}}
				]
			};
		}
	}
}
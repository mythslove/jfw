package app.mvc.models.manager
{
	import app.charactor.Charactor;
	import app.globals.interfaces.ICharactor;
	import app.mvc.models.vo.battle.BattleResultVO;
	/**
	 *战斗详细信息统计 
	 * @author PianFeng
	 * 
	 */	
	public class StatisticManager
	{
		static private var instance:StatisticManager=null;
		
		public var npcArr:Array=[];//抓捕的npc
		public var stars:int=0;//星级
		public var lvNo:int//关卡id
		public var isWin:Boolean;
		public var gb:int=0;//金币
		public var exp:int=0;//奖励经验
		public var mp:int=0;//补给玩家的法力
		public var flc:int=0;//法力池剩余法力
		public var reiki:int=0;//奖励的灵气
		public var item:Array=[];//奖励物品
		public var dropEquip:Boolean = false; //是否掉落装备
		private var startTime:int=0;
		private var endTime:int=0;

		public function StatisticManager()
		{
		}
		
		static public function getInstance():StatisticManager
		{
			if(instance==null)
				instance = new StatisticManager();
			
			return instance;
		}	
		public function getBattleResult():BattleResultVO
		{
			var result:BattleResultVO=new BattleResultVO();
			result.isWin=this.isWin;
			result.stars=this.stars;
			result.DurationTime=this.getDurationTime();
			result.npcArr=this.npcArr;
			result.gb=this.gb;//金币
			result.exp=this.exp;//奖励经验
			result.mp=this.mp;//补给玩家的法力
			result.flc=this.flc;//法力池剩余法力
			result.reiki=this.reiki;//奖励的灵气
			result.item=this.item;//奖励物品{"pid": 12001001,"count": 10,"lcateg": 2,"scateg": 1}
			result.dropEquip = this.dropEquip;
			return result;
		}
		/**
		 *加入npc
		 * @param
		 * 
		 */		
		public function addMember(id:int,name:String,isMaster:Boolean,isDied:Boolean):void
		{
			npcArr.push({id:id,name:name,isMaster:isMaster,isDied:isDied});
		}
		/**
		 *设置战斗开始时间戳 
		 * @param ts
		 * 
		 */		
		public function setStartTime(ts:int):void
		{
			startTime=ts;
		}
		/**
		 * 设置战斗结束时间戳 
		 * @param ts
		 * 
		 */		
		public function setEndTime(ts:int):void
		{
			endTime=ts;
		}
		/**
		 * 获取战斗时长 
		 * @return 
		 * 
		 */		
		public function getDurationTime():int
		{
			return this.endTime-this.startTime;
		}
		
		public function clearAllData():void
		{
			this.npcArr=[];
			this.stars=0;
			this.lvNo=0;
			this.startTime=0;
			this.endTime=0;
			this.gb=0;
			this.exp=0;
			this.mp=0;
			this.flc=0;
			this.reiki=0;
			this.item=[];
		}
	}
}
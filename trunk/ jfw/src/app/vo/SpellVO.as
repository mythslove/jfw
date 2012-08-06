package app.mvc.models.vo.item
{
	import app.mvc.models.vo.base.AbstractStruct;
	
	/** 法术VO */
	public class SpellVO extends AbstractStruct
	{
		/** 法术ID */
		public var id:int;
		
		/** 法术名称 */
		public var name:String;
		
		/** 法术描述 */
		public var desc:String;
		
		/** 区分法术道具类型（转向、停止、传送） */
		public var type3:int;
		
		/** 法术作用针对对象序号 */
		public var action:int;
		
		/** 解封需要法术堂级别 */
		public var buildlv:int;
		
		/** 解封需要金币 */
		public var needgb:int;
		
		/** 使用消耗法力值 */
		public var useneed:int;
		
		/** CD时间（秒） */
		public var cd:int;
		
		/** 持续时间 */
		public var dt:int;
		
		/** 所属0:玩家,1:中立 */
		public var belong:int=0;
		
		/** 状态：
		 * 1 开启条件未达成
		 * 2 可解封（未解封）
		 * 3 解封条件未达成
		 * 4 已解封
		 */
		public var status:int ;
		
		public function SpellVO(obj:Object=null)
		{
			super(obj);
		}
		
		override public function toObject():Object
		{
			var to:Object = super.toObject();
			
			to.id 		= this.id;
			to.name 	= this.name;
			to.desc 	= this.desc;
			to.type3 	= this.type3;
			to.action 	= this.action;
			to.buildlv 	= this.buildlv;
			to.needgb 	= this.needgb;
			to.useneed 	= this.useneed;
			to.cd		= this.cd;
			to.dt		= this.dt;
			to.status	= this.status;
			
			return to;
		}
		
		override protected function parseObject(obj:Object):void
		{
			super.parseObject(obj);
			
			this.id 		= obj.id;
			this.name 		= obj.name;
			this.desc 		= obj.desc;
			this.type3 		= obj.type3;
			this.action 	= obj.action;
			this.buildlv 	= obj.buildlv;
			this.needgb 	= obj.needgb;
			this.useneed 	= obj.useneed;
			this.cd			= obj.cd;
			this.dt			= obj.dt;
			this.status		= obj.status;
		}
	}
}
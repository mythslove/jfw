package app.mvc.models.vo.item
{
	import app.mvc.models.vo.base.AbstractStruct;
	
	/** 法宝VO */
	public class MagicVO extends AbstractStruct
	{
		/** 法宝ID */
		public var id:int;
		
		/** 级别 */
		public var lv:int;
		
		/** 名称 */
		public var name:String;
		
		/** 法宝类型*/
		public var type:int;
		
		/** 是否可升级 1可 0不可*/
		public var up:int;
		
		/** 拥有的法宝数量 */
		public var count:int ;
		
		/** 法宝描述 */
		public var desc:String;
		
		/** 需要法宝堂级别 */
		public var buildlv:int ;
		
		/** 解封需要金币*/
		public var needgb:int;
		
		/** 使用消耗类型（3法力，6妖币） */
		public var usetype:int;
		
		/** 使用需要资源 */
		public var useneed:int;
		
		/** 瞬间作用类型 */
		public var atype1:int;
		
		/** 瞬间作用数值 */
		public var avalue1:Number;
		
		/** buff类型 */
		public var buff1:int;
		
		/** 持续时间1 */
		public var dt1:int;
		
		/** 作用2类型 */
		public var atype2:int;
		
		/** 作用2数值 */
		public var avalue2:Number;
		
		/** buff类型 */
		public var buff2:int;
		
		/** 持续时间2 */
		public var dt2:int;
		
		/** CD时间（秒） */
		public var cd:int;
		
		/** 所属0:玩家,1:中立 */
		public var belong:int=0;
		
		/** 状态：
		 * 1 未开启，
		 * 2 可解封（未解封）
		 * 3 不可解封（未解封）
		 * 4 可升级（已解封） 
		 * 5 不可升级（已解封）
		 */
		public var status:int ;
		
		public function MagicVO(obj:Object=null)
		{
			super(obj);
		}
		
		override public function toObject():Object
		{
			var to:Object = super.toObject();
			
			to.id = this.id;
			to.lv = this.lv;
			to.name = this.name;
			to.type = this.type;
			to.up = this.up;
			to.count = this.count;
			to.desc = this.desc;
			to.buildlv = this.buildlv;
			to.needgb = this.needgb;
			to.usetype = this.usetype;
			to.useneed = this.useneed;
			to.atype1 = this.atype1;
			to.avalue1 = this.avalue1;
			to.buff1 = this.buff1;
			to.dt1 = this.dt1;
			to.atype2 = this.atype2;
			to.avalue2 = this.avalue2;
			to.buff2 = this.buff2;
			to.dt2 = this.dt2;
			to.cd = this.cd;
			
			return to;
		}
		
		override protected function parseObject(obj:Object):void
		{
			super.parseObject(obj);
			
			this.id = obj.id;
			this.lv = obj.lv;
			this.name = obj.name;
			this.type = obj.type;
			this.up = obj.up;
			this.count = obj.count;
			this.desc = obj.desc;
			this.buildlv = obj.buildlv;
			this.needgb = obj.needgb;
			this.usetype = obj.usetype;
			this.useneed = obj.useneed;
			this.atype1 = obj.atype1;
			this.avalue1 = obj.avalue1;
			this.buff1 = obj.buff1;
			this.dt1 = obj.dt1;
			this.atype2 = obj.atype2;
			this.avalue2 = obj.avalue2;
			this.buff2 = obj.buff2;
			this.dt2 = obj.dt2;
			this.cd = obj.cd;
		}
	}
}
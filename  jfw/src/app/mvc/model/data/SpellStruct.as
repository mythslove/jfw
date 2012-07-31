package app.mvc.model.data
{
	import com.jfw.engine.core.data.BaseStruct;
	
	/**
	 * 法术
	 */
	public class SpellStruct extends AbsStruct
	{
		/** 伤害 */
		public var hurt:int;
		/** 持续时间 */
		public var duration:int;
		/** 法术CD */
		public var cd:int;
		/** 升级后的效果描述 */
		public var uptip:String;
		/** 升级消耗妖币 */
		public var yb:int;
		/** 技能书ID */
		public var bookid:String;
		
		public function SpellStruct(obj:Object=null)
		{
			super(obj);
		}
		
		override protected function parse(obj:Object):void
		{
			super.parse( obj );
			
			this.cd = obj.cd;
			this.uptip = obj.uptip;
			this.yb = obj.yb;
			this.type = obj.type;
			this.bookid = obj.bookid;
			this.hurt = obj.hurt;
			this.duration = obj.duration;
		}
	}
}
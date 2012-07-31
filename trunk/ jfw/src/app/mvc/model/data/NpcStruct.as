package app.mvc.model.data
{
	import com.jfw.engine.core.data.BaseStruct;
	
	/** NPC数据 */
	public class NpcStruct extends AbsStruct
	{
		/** 攻击力*/
		public var att:int;
		
		/** 防御 */
		public var def:int;
		
		/** 血量 */
		public var hp:int ;
		
		/** 妖将总血量 */
		public var thp:int ;
		
		/** 妖将当前血量 */
		public var nhp:int ;
		
		/** 品质 */
		public var quality:int;
		
		/** 速度 */
		public var sp:Number;
		
		/** 解封关卡号 */
		public var openlv:int = 0;
		
		/** 阵营 0:攻击方,1:防守方,2:中立势力 */
		public var camps:int=0;
		
		/** 将魂数 */
		public var soul:int = 0;
		
		/** 妖将的装备 */
		public var item:Array = [];
		public var eq1:Object = null;
		public var eq2:Object = null;
		public var eq3:Object = null;
		public var eq4:Object = null;
		public var eq5:Object = null;
		
		public function NpcStruct(obj:Object=null)
		{
			super(obj);
		}
		
		override protected function parse(obj:Object):void
		{
			super.parse( obj );
			
			this.thp	= obj.thp;
			this.nhp  = obj.nhp;
			this.att = obj.att;
			this.def = obj.def;
			this.hp = obj.hp;
			this.sp = obj.sp;
			this.quality = obj.quality;
			this.openlv = obj.openlv;
			this.item = obj.item;
			this.soul = obj.soul;
			this.eq1 = obj.eq1;
			this.eq2 = obj.eq2;
			this.eq3 = obj.eq3;
			this.eq4 = obj.eq4;
			this.eq5 = obj.eq5;
		}
	}
}
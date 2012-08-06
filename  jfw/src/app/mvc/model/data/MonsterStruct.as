package app.mvc.model.data
{
	import com.jfw.engine.core.data.BaseStruct;
	
	/** 妖将数据 */
	public class MonsterStruct extends NpcStruct
	{
		/** 升级需要角色等级 */
		public var uvalue:int;
		
		/** 升级消耗晶石ID */
		public var needspar:int;
		
		/** 升级消耗晶石数量 */
		public var neednum:int;
		
		/** 升级消耗灵气值 */
		public var needreiki:int;
		
		/** 状态 */
		public var status:int = 0;
		
		public function MonsterStruct(obj:Object=null)
		{
			super(obj);
		}
		
		override protected function parse(obj:Object):void
		{
			super.parse( obj );
			
			this.uvalue = obj.uvalue;
			this.needspar = obj.needspar;
			this.neednum = obj.neednum;
			this.needreiki = obj.needreiki;
		}
	}
}
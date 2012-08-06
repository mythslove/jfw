package app.mvc.model.data
{
	import com.jfw.engine.core.data.BaseStruct;
	
	public class AbsStruct extends BaseStruct
	{
		/** 拥有玩家的ID */
		public var ownerid:int;
		
		/** 唯一ID */
		public var id:int;
		
		/** 资源ID */
		public var srcid:String;
		
		/** 类型 */
		public var type:int;
		
		/** 名称 */
		public var name:String;
		
		/** 描述 */
		public var desc:String;
		
		/** 级别 */
		public var lv:int;
		
		public function AbsStruct(obj:Object=null)
		{
			super(obj);
		}
		
		override protected function parse(obj:Object):void
		{
			super.parse( obj );
			
			this.ownerid = obj.ownerid;
			this.id = obj.id;
			this.srcid = obj.srcid;
			this.type = obj.type;
			this.name = obj.name;
			this.desc = obj.desc;
			this.lv = obj.lv;
		}
	}
}
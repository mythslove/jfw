package app.model.data
{
	import com.jfw.engine.core.data.BaseStruct;
	
	/** 主城建筑 */
	public class BuildingStruct extends BaseStruct
	{
		/** 所有者ID */
		public var owner:int ;
		
		/** 建筑ID */
		public var buildingId:int;
		
		/** 建筑名称 */
		public var buildingName:String;
		
		/** 建筑描述 */
		public var buildingDesc:String;
		
		/** 建筑等级 */
		public var buildingLv:int;
		
		/** 扩展属性 */
		public var extAttr:Object;

		public function BuildingStruct(obj:Object=null)
		{
			super(obj);
		}
		
		override protected function parse(obj:Object):void
		{
			super.parse( obj );
			
			this.owner 			= obj.owner;
			this.buildingId 	= obj.buildingId;
			this.buildingName 	= obj.buildingName;
			this.buildingDesc 	= obj.buildingDesc;
			this.buildingLv 	= obj.buildingLv;
			this.extAttr 		= obj.extAttr;
		}
	}
}
package app.mvc.view.ui.component.item
{
	import com.jfw.engine.core.data.BaseStruct;
	import com.jfw.engine.core.data.IStruct;
	
	/** 背包格子数据 */
	public class ItemStruct extends BaseStruct
	{
		/** ID */
		public var id:uint;
		
		/** 名称 */
		public var name:String ;
		
		/** 行数 */ 
		public var row:uint = 0;
		
		/** 名称颜色,品质 */
		public var color:uint = 0;
		
		/** 列数 */
		public var col:uint = 0;
		
		/** 最大叠加数 */
		public var maxNum:uint;
		
		/** 数量 */
		public var count:uint;
		
		/** 数据 */
		public var data:IStruct;
				public function ItemStruct(obj:Object=null)
		{
			super(obj);
		}
		
		override protected function parse(obj:Object):void
		{
			super.parse( obj );
			
			this.id = obj.data.id;
			this.name = obj.data.name;
			this.color = obj.color;
			this.row = obj.row;
			this.col = obj.col;
			this.maxNum = obj.maxNum;
			this.count = obj.count;
			this.data = obj.data;
		}
	}
	
}
package app.mvc.view.ui.component
{
	import com.jfw.engine.core.data.BaseStruct;
	
	public class TabStruct extends BaseStruct
	{
		/** tab标题 */
		public var label:String ;
		/** tab类型 */
		public var type:int;
		/** tab内容面板类 */
		public var cls:Class;
		
		public function TabStruct(obj:Object=null)
		{
			super(obj);
		}
		
		override protected function parse(obj:Object):void
		{
			this.label = obj.label;
			this.type = obj.type;
			this.cls = obj.cls;
		}
	}
}
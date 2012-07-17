package app.model.data
{
	import com.jfw.engine.core.data.BaseStruct;
	
	//加载进度对象
	public class ProgressDataStruct extends BaseStruct
	{
		/** 百分比 */
		public var percent:Number;
		
		/** 资源描述 */
		public var description:String;
		
		public function ProgressDataStruct(obj:Object=null)
		{
			super(obj);
		}
		
		override public function clone():Object
		{
			var to:Object = super.clone();
			
			to.percent = this.percent;
			to.description = this.description;
			
			return to;
		}
		
		override protected function parse(obj:Object):void
		{
			super.parse( obj );
			
			this.percent = obj.percent;
			this.description = obj.description;
		}
	}
}
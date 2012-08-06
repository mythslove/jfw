package app.mvc.model.data
{
	import com.jfw.engine.core.data.BaseStruct;
	
	public class EmptyStruct extends BaseStruct
	{
		public var label:String ;
		
		public function EmptyStruct(obj:Object=null)
		{
			super(obj);
		}
		
		override protected function parse(obj:Object):void
		{
			super.parse( obj );
			
			this.label = obj.label;
		}
	}
}
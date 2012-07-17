package app.model.data
{
	import com.jfw.engine.core.data.BaseStruct;
	
	/** 用户数据 */
	public class UserStruct extends BaseStruct
	{
		public function UserStruct(obj:Object=null)
		{
			super(obj);
		}
		
		override public function clone():Object
		{
			var to:Object = super.clone();
			
			return to;
		}
		
		override protected function parse(obj:Object):void
		{
			super.parse( obj );
			
			
		}
	}
}
package app.model.data
{
	import com.jfw.engine.core.data.BaseStruct;
	
	/** NPC数据 */
	public class NpcStruct extends BaseStruct
	{
		public function NpcStruct(obj:Object=null)
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
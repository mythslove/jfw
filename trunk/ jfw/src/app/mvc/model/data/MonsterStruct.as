package app.mvc.model.data
{
	import com.jfw.engine.core.data.BaseStruct;
	
	/** 妖将数据 */
	public class MonsterStruct extends BaseStruct
	{
		public function MonsterStruct(obj:Object=null)
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
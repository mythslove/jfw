package app.model.data
{
	import com.jfw.engine.core.data.BaseStruct;
	
	/** 关卡数据 */
	public class LevelStruct extends BaseStruct
	{
		public function LevelStruct(obj:Object=null)
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
package app.vo
{
	import com.jfw.engine.core.data.BaseStruct;
	
	import examples.animation.RoleView;
	
	public class TeamVO extends BaseStruct
	{
		public var dalay:Number=1;
		public var members:Vector.<String>;
		
		public function TeamVO(obj:Object=null)
		{
			super(obj);
			
			members=new Vector.<String>();
		}
	}
}
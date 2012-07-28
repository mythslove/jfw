package app.vo
{
	import com.jfw.engine.core.data.BaseStruct;
	
	public class RoundVO extends BaseStruct
	{
		public var dalay:Number=5;
		public var team:TeamVO=null;
		
		public function RoundVO(obj:Object=null)
		{
			super(obj);
			
			team=new TeamVO();
		}
	}
}
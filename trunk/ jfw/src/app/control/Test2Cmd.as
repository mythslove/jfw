package app.control
{
	import app.consts.NetConst;
	
	import com.jfw.engine.core.mvc.control.BCmd;
	
	public class Test2Cmd extends BCmd
	{
		override public function execute(evt:String, param:Object):void
		{
			switch( evt )
			{
				case NetConst.ExtraCollectYb:
					break;
				case NetConst.ExtraCollectYb + NetConst.CALLBACK:
					break;
			}
		}
	}
}
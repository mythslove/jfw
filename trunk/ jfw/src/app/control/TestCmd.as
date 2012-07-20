package app.control
{
	import app.consts.NetConst;
	
	import com.jfw.engine.core.mvc.control.BCmd;
	
	public class TestCmd extends BCmd
	{
		override public function execute(evt:String, param:Object):void
		{
			switch( evt )
			{
				case NetConst.CollectYb:
					break;
				case NetConst.CollectYb + NetConst.CALLBACK:
					break;
			}
		}
	}
}
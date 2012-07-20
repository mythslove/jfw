package app.control
{
	import com.jfw.engine.core.mvc.control.BCmd;
	
	public class TestCmd extends BCmd
	{
		override public function execute(evt:String, param:Object):void
		{
			//Command测试
			trace(evt,param.toString());
		}
	}
}
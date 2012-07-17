package app.view.ui.window
{
	import app.view.ui.WindowManager;
	
	import com.jfw.engine.core.data.IStruct;
	import com.jfw.engine.core.mvc.view.BWindow;
	
	public class AddGemWindow extends BWindow
	{
		public function AddGemWindow()
		{
			super()
		}
		
		override public function execute( obj:* = null ):void
		{
			WindowManager.getInstance().openWindow( this,null,null,false );
		}
	}
}
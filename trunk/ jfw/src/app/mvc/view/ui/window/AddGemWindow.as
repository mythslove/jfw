package app.mvc.view.ui.window
{
	import com.jfw.engine.core.data.IStruct;
	import com.jfw.engine.core.mvc.view.BWindow;
	import com.jfw.engine.core.mvc.view.WindowManager;
	
	public class AddGemWindow extends BWindow
	{
		public function AddGemWindow( )
		{
			super();
		}
		
		override public function execute( obj:* = null ):void
		{
			this.openWindow( this,null,false,false );
		}
	}
}
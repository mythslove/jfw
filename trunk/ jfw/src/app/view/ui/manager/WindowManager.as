package app.view.ui.manager
{
	import com.jfw.engine.core.mvc.view.BWindow;
	import com.jfw.engine.core.mvc.view.IWindow;
	import com.jfw.engine.utils.manager.PopUpManager;
	
	import flash.display.MovieClip;
	import flash.events.Event;

	public class WindowManager
	{
		static private var instance:WindowManager;
		
		public function WindowManager()
		{
			if( instance )
				throw new Error("");
			instance = this;
		}
		
		static public function getInstance():WindowManager
		{
			if( !instance )
				instance = new WindowManager();
			return instance;
		}
		
		/** 创建一个窗口 */
		public function createWindow( windowClassRef:Class, param:Object = null, spriteMC:MovieClip=null ,hasAction:Boolean = true ):void
		{
			var window:BWindow = null;
			if ( spriteMC )
				window = new windowClassRef( spriteMC , param ) as BWindow;
			else
				window = new windowClassRef() as BWindow;
			
			window.addEventListener( Event.CLOSE, function onCloseWindow( evt:Event ):void
			{
				PopUpManager.removePopUp( window,hasAction );
			});
			PopUpManager.addPopUp( window );
		}
		
		/** 打开一个窗口 */
		public function openWindow( window:BWindow, param:Object = null, spriteMC:MovieClip=null,hasAction:Boolean = true ):void
		{
			window.addEventListener( Event.CLOSE, function onCloseWindow( evt:Event ):void
			{
				PopUpManager.removePopUp( window,hasAction );
			});
			PopUpManager.addPopUp( window );
		}
	}
}
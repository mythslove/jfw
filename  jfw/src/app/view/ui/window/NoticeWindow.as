package app.view.ui.window
{
	import app.view.ui.TipManager;
	import app.view.ui.WindowManager;
	
	import com.jfw.engine.core.base.CoreConst;
	import com.jfw.engine.core.data.IStruct;
	import com.jfw.engine.core.mvc.view.BWindow;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class NoticeWindow extends BWindow
	{
		public var $pbBuy:MovieClip ;
		
		public function NoticeWindow()
		{
			super();
		}
		
		override protected function onInit():void
		{
			
		}
		
		override protected function onMouseOver(evt:MouseEvent):void
		{
			super.onMouseOver( evt );
			
			switch( getMcName( evt.target as DisplayObject ) )
			{
				case CoreConst.TAG_PB + 'Buy':
					TipManager.createToolTip( evt.target as DisplayObject,"续费并领取");
					break;
				case CoreConst.TAG_PB + 'Close':
					TipManager.createToolTip( evt.target as DisplayObject,"点击关闭");
					break;
			}
		}
		
		override protected function onMouseClick(evt:MouseEvent):void
		{
			super.onMouseClick( evt );
			
			switch( getMcName( evt.target as DisplayObject ) )
			{
				case CoreConst.TAG_PB + 'Buy':
					WindowManager.getInstance().openWindow( new AddGemWindow() );
					break;
			}
		}
		
		override public function execute( obj:* = null ):void
		{
			WindowManager.getInstance().openWindow( this, null,null,false );
		}
		
		override public function destroy():void
		{
			this.$pbBuy = null;
			
			super.destroy();
		}
	}
}
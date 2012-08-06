package app.mvc.view.ui.window
{
	import com.jfw.engine.core.mvc.view.WindowManager;
	import app.mvc.view.ui.component.Tip;
	
	import com.jfw.engine.core.base.CoreConst;
	import com.jfw.engine.core.data.IStruct;
	import com.jfw.engine.core.mvc.view.BWindow;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class NoticeWindow extends BWindow
	{
		public var $pbBuy:MovieClip ;
		public var $pbClose:MovieClip;
		
		public function NoticeWindow()
		{
			super();
		}
		
		override protected function onInit():void
		{
			Tip.register($pbBuy,'续费并领取');
			Tip.register($pbClose,'续费并领取');
		}
		
		override protected function onMouseClick(evt:MouseEvent):void
		{
			super.onMouseClick( evt );
			
			switch( getMcName( evt.target as DisplayObject ) )
			{
				case CoreConst.TAG_PB + 'Buy':
					this.openWindow( new AddGemWindow(),null,false,true );
					break;
			}
		}
		
		override public function execute( obj:* = null ):void
		{
			this.openWindow( this, null,false );
		}
		
		override public function destroy():void
		{
			this.$pbBuy = null;
			
			super.destroy();
		}
	}
}
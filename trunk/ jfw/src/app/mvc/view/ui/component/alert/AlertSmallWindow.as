package app.mvc.view.ui.component.alert
{
	import com.jfw.engine.core.mvc.view.BWindow;
	import com.jfw.engine.utils.FontUtil;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	public class AlertSmallWindow extends BWindow implements IAlertWindow
	{
		public var $txTxt:TextField;
		public var $txBg:MovieClip;
		
		private var _closeHandler:Function;
		
		private var isOpen:Boolean;
		private var _id:int;
		
		private var timeoutInt:uint;
		
		public function AlertSmallWindow()
		{
			super();
		}
		
		override protected function onInit():void
		{
			super.onInit();
			
			$txTxt.autoSize = TextFieldAutoSize.LEFT;
		}
		
		public function get id():int
		{
			return _id;
		}
		
		public function set id(value:int):void
		{
			_id = value;
		}
		
		public function get closeHandler():Function
		{
			return _closeHandler;
		}
		
		public function set closeHandler(value:Function):void
		{
		}
		
		public function get isDisable():Boolean
		{
			return false;
		}
		
		public function set isDisable(value:Boolean):void
		{
		}
		
		public function setButton(butFlags:uint):void
		{
		}
		
		public function setText(str:String):void
		{
			FontUtil.setText( $txTxt, str );
			
			this.$txBg.width = $txTxt.textWidth + 26;
			this.$txBg.height = $txTxt.textHeight + 26;
			this.$txBg.x = (this.$txBg.width - this.$txBg.width)/2;
			$txTxt.x = this.$txBg.x + 8;
			setCLoseTimeout();
			
			isOpen = true;
			
			addEventListener(MouseEvent.MOUSE_DOWN,sendClose);
		}
		
		override public function close():void
		{
			super.close();
			isOpen = false;
		}
		
		private function setCLoseTimeout():void
		{
			timeoutInt = setTimeout(sendClose,2000);
		}
		
		private function sendClose(e:MouseEvent=null):void
		{
			
			if(isOpen)
			{
				clearTimeout(timeoutInt);
				dispatchEvent(new AlertCloseEvent(AlertCloseEvent.CLOSE));
				removeEventListener(MouseEvent.MOUSE_DOWN,sendClose);
			}
			
		}
	}
}
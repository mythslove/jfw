package app.mvc.view.ui.component.alert
{
	import com.jfw.engine.core.mvc.view.BWindow;
	import com.jfw.engine.utils.FontUtil;
	
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	
	public class AlertWindow extends BWindow implements IAlertWindow
	{
		private static const BUTTON_GAP:int = 20;
		
		//属性
		public var $txTxt:TextField;
		public var $pbOkButton:SimpleButton;
		public var $pbCancelButton:SimpleButton;
		public var $pbShareButton:SimpleButton;
		public var $pbRefreshButton:SimpleButton;
		public var $pbCancelDisableButton:SimpleButton;
		public var $pbOkDisableButton:SimpleButton;
		
		private var _id:int;
		private var _closeHandler:Function;
		private var buttons:Vector.<SimpleButton>;
		private var _isDisable:Boolean;
		
		public var buttonFlags:uint;
		
		public function AlertWindow()
		{
			super();
			
			clearAllButton();
			buttons = new Vector.<SimpleButton>();
		}
		
		override protected function onInit():void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
		}
		
		override protected function onMouseClick(evt:MouseEvent):void
		{
			super.onMouseClick( evt );
			var buttonType:uint ;
			switch( evt.currentTarget )
			{
				case $pbOkButton:
					buttonType = Alert.OK;
					break;
				case $pbCancelButton:
					buttonType = Alert.CANCEL;
					break;
				case $pbShareButton:
					buttonType = Alert.SHARE;
					break;
				case  $pbRefreshButton:
					buttonType = Alert.REFRESH;
					break;
				case $pbCancelDisableButton:
					buttonType = Alert.CANCEL;
					break;
				default:
					buttonType = Alert.OK;
					break;
			}
			removeAlert(buttonType);
		}
		
		override protected function onMouseOver(evt:MouseEvent):void
		{
			
		}
		
		override protected function onMouseOut(evt:MouseEvent):void
		{
			
		}
		
		// helper
		
		private function clearAllButton():void
		{
			$pbOkButton.visible = false;
			$pbCancelButton.visible = false;
			$pbShareButton.visible = false;
			$pbRefreshButton.visible = false;
			
			$pbOkDisableButton.visible = false;
			$pbCancelDisableButton.visible = false;
		}
		
		private function showButton(butN:uint):void
		{
			var button:SimpleButton;
			switch(butN)
			{
				case Alert.OK:
					if(!isDisable)
					{
						button = $pbOkButton;
					}else
					{
						button = $pbOkDisableButton;
					}
					break;
				
				case Alert.CANCEL:
					if(!isDisable)
					{
						button = $pbCancelButton;
					}else
					{
						button = $pbCancelDisableButton;
					}
					
					break;
				
				case Alert.SHARE:
					button = $pbShareButton;
					break;
				
				case Alert.REFRESH:
					button = $pbRefreshButton;
					break;
				
				default:
					button = $pbOkButton;
			}
			button.visible = true;
			buttons.push(button);
		}
		
		private function keyDownHandler(event:KeyboardEvent):void
		{
			//ESC键
			if (event.keyCode == Keyboard.ESCAPE)
			{
				if (buttonFlags & Alert.CANCEL)
					close();
			}
			//Enter键
			else if(event.keyCode == Keyboard.ENTER)
			{
				if (buttonFlags & Alert.OK)
				{
					if(stage)
						stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
					removeAlert(Alert.OK);
				}
			}
		}
		
		public function setText(str:String):void
		{
			FontUtil.setText( $txTxt, str );
		}
		
		public function setButton(butFlags:uint):void
		{
			buttonFlags = butFlags;
			if (buttonFlags & Alert.OK)
				showButton(Alert.OK);
			
			if (buttonFlags & Alert.REFRESH)
				showButton(Alert.REFRESH);
			
			if (buttonFlags & Alert.SHARE)
				showButton(Alert.SHARE);
			
			if (buttonFlags & Alert.CANCEL)
				showButton(Alert.CANCEL);
			setButtonPosition();
		}
		
		private function setButtonPosition():void
		{
			if(buttons.length > 0)
			{
				var len:int = buttons.length;
				var buttonW:Number = buttons[0].width;
				var butsW:Number = buttonW * len + BUTTON_GAP * (len - 1);
				var startX:Number = (width - butsW) / 2;
				var i:int = 0;
				for each(var but:SimpleButton in buttons)
				{
					but.x = startX + (buttonW + BUTTON_GAP) * i;
					i++;
				}
			}
		}
		
		private function removeAlert(buttonPressed:uint):void
		{
			var closeEvent:AlertCloseEvent = new AlertCloseEvent(AlertCloseEvent.CLOSE);
			closeEvent.detail = buttonPressed;
			dispatchEvent(closeEvent);
		}
		
		override public function close():void
		{
			if(stage != null)
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			
			if (buttonFlags & Alert.CANCEL)
				removeAlert(Alert.CANCEL);
		}
		
		// getter / setter
		
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
			_closeHandler = value;
		}
		
		public function get isDisable():Boolean
		{
			return _isDisable;
		}
		
		public function set isDisable(value:Boolean):void
		{
			_isDisable = value;
		}
		
	}
}
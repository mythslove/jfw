package app.view.ui.component.alert
{
	import com.jfw.engine.utils.HashMap;
	import com.jfw.engine.utils.manager.PopUpManager;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	/**
	 *提示窗 管理器
	 * @author derek
	 * 
	 */
	public class Alert
	{
		public static const OK:uint = 0x0001;
		public static const CANCEL:uint = 0x0002;
		
		public static const SHARE:uint = 0x0004;
		public static const REFRESH:uint= 0x0008;
		
		
		private static var alertCount:int = 0;
		private static var alertMap:HashMap = new HashMap();
		
		public static function confrim (text:String, onOK:Function):void
		{
			Alert.show(text, Alert.OK | Alert.CANCEL, function (e:AlertCloseEvent):void
			{
				if (e.detail == Alert.OK)
				{
					onOK();
				}
			});
		}
		
		public static function show(text:String = "", flags:uint = 0x0001 /* Alert.OK */,closeHandler:Function = null,windowType:String="",modal:Boolean=true,isDisable:Boolean=false):IAlertWindow
		{
			var windowClass:Class;
			if(windowType == "")
			{
				windowClass = AlertWindow;
			}else if(windowType == "small")
			{
				windowClass = AlertSmallWindow;
			}
			
			var alert:IAlertWindow = new windowClass;
			//trace("alertCount",alertCount);
			alert.id = alertCount;
			alert.closeHandler =  closeHandler;
			alertCount ++;
			alert.isDisable = isDisable;
			
			alert.setButton(flags);
			
			alert.setText(text);
			
			alert.addEventListener(AlertCloseEvent.CLOSE, closeAlertHandler);
			
			alertMap.put(alert.id,alert);
			
			PopUpManager.addPopUp(DisplayObject(alert), modal);
			
			return alert;
		}
		
		
		private static function get myClassPackagePath():String
		{
			return "com.kingnet.dinoage.view.ui.window.components.alert.";
		}
		
		private static function closeAlertHandler(e:AlertCloseEvent):void
		{
			var alert:IAlertWindow =  IAlertWindow(e.target);
			var id:int = alert.id;
			//trace("id",id);
			if (alertMap.containsKey(id))
			{
				
				
				alert.removeEventListener(AlertCloseEvent.CLOSE, closeAlertHandler);
				
				if(alert.closeHandler != null)
				{
					var closeHandler:Function = alert.closeHandler;
					closeHandler(e);
				}
				
				PopUpManager.removePopUp(DisplayObject(alert));
				
				alertMap.remove(id);
				
			}
		}
		
		public static function closeAll():void
		{
			var alertWList:Array = alertMap.keys();
			for each(var id:int in alertWList)
			{
				var alert:IAlertWindow =  alertMap.getValue(id) as IAlertWindow;
				alert.close();
			}
		}
	}
}
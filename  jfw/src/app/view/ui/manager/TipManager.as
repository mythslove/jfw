package app.view.ui.manager
{
	import app.view.ui.component.ToolTip;
	
	import flash.accessibility.AccessibilityProperties;
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;

	/**
	 * ToolTip管理器 
	 * @author 
	 * 
	 */	
	public class TipManager
	{
		private static var tip:ToolTip;
		
		private static function getTip():ToolTip
		{
			return tip ||= new ToolTip();
		}
		
		/**
		 *  
		 * @param p
		 * @param title
		 * @param content
		 * @param titleTf
		 * @param contentTf
		 * @param hook
		 * @param hookSize
		 * @param cornerRadius
		 * @param align
		 * 
		 */
		static public function register(p:DisplayObject,
								   title:String,
								   content:String=null,
								   titleTf:TextFormat = null,
								   contentTf:TextFormat = null,
								   hook:Boolean = true,
								   hookSize:int = 10,
								   cornerRadius:int = 10,
								   align:String = 'left'):void
		{
			
			if( p && '' != title )
			{
				//
				// 将按钮提示信息，附在按钮元件的accessibilityProperties属性之中
				// 并且给按钮元件添加ROLL_OVER事件，交由ToolTipManagerImpl进行显示
				//
				var prop:AccessibilityProperties = new AccessibilityProperties();
				prop.description = title;
				p.accessibilityProperties = prop;
				p.addEventListener( MouseEvent.ROLL_OVER, function(evt:MouseEvent):void{
				
				
								getTip().hook = hook;
								getTip().hookSize = hookSize;
								getTip().cornerRadius = cornerRadius;
								getTip().align = align;
								if( titleTf )
									getTip().titleFormat = titleTf;
								if( contentTf )
									getTip().contentFormat = contentTf;
								getTip().show( p, title, content );
				
				} );
			}
//			else if( p.hasEventListener( MouseEvent.ROLL_OVER ) && null != p.accessibilityProperties )
//				p.removeEventListener( MouseEvent.ROLL_OVER,  );
			
//			
//			getTip().hook = hook;
//			getTip().hookSize = hookSize;
//			getTip().cornerRadius = cornerRadius;
//			getTip().align = align;
//			if( titleTf )
//				getTip().titleFormat = titleTf;
//			if( contentTf )
//				getTip().contentFormat = contentTf;
//			getTip().show( p, title, content );
		}
		
		
		/**
		 * 
		 * @param p
		 * @param title
		 * @param content
		 * @param titleTf
		 * @param contentTf
		 * @param hook
		 * @param hookSize
		 * @param cornerRadius
		 * @param align
		 * 
		 */
		static public function createToolTip( p:DisplayObject,
											  title:String,
											  content:String=null,
											  titleTf:TextFormat = null,
											  contentTf:TextFormat = null,
											  hook:Boolean = true,
											  hookSize:int = 5,
											  cornerRadius:int = 5,
											  align:String = 'left'):void
		{
			var tf:TextFormat = new TextFormat();
			//	tf.font = "georgia";  //font in library
			//	tf.bold = true;
			tf.size = 12;
			tf.color = 0xFEE46D;
			
			var tooltip:ToolTip = new ToolTip();
			tooltip.hook = false;
			tooltip.hookSize = hookSize;
			tooltip.buffer = 5;
			tooltip.cornerRadius = cornerRadius;
			tooltip.colors = [0x0,0x0];
			tooltip.bgAlpha = .8;
//			tooltip.delay = 10;
			tooltip.autoSize = true;
			tooltip.titleFormat = tf;
			tooltip.align = align;
			if( titleTf )
				tooltip.titleFormat = titleTf;
			if( contentTf )
				tooltip.contentFormat = contentTf;
			tooltip.show( p, title, content );
		}
	}
}
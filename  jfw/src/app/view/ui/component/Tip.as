package app.view.ui.component
{
	import flash.accessibility.AccessibilityProperties;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class Tip extends Sprite	
	{
		private static var instance:Tip = null;
		private var label:TextField;		
		private var area:DisplayObject;
		public function Tip() 
		{
			label = new TextField();
			label.autoSize = TextFieldAutoSize.LEFT;
			label.selectable = false;
			label.multiline = false;
			label.wordWrap = false;
			label.defaultTextFormat = new TextFormat("宋体", 13, 0xffcc33);
			label.text = "提示信息";
			label.x = 5;
			label.y = 2;
			addChild(label);
			redraw();
			visible = false;
			mouseEnabled = mouseChildren = false;
		}
		
		private function redraw():void
		{
			var w:Number = 10 + label.width;
			var h:Number = 4 + label.height;			
			this.graphics.clear();
//			this.graphics.beginFill(0x000000, 0.4);
//			this.graphics.drawRoundRect(3, 3, w, h, 5, 5);				
//			this.graphics.moveTo(6, 3 + h);
//			this.graphics.lineTo(12, 3 + h);
//			this.graphics.lineTo(9, 8 + h);
//			this.graphics.lineTo(6, 3 + h);
//			this.graphics.endFill();
			this.graphics.beginFill(0x0,.8);
			this.graphics.drawRoundRect(0, 0, w, h, 8, 8);
//			this.graphics.moveTo(3, h);
//			this.graphics.lineTo(9, h);
//			this.graphics.lineTo(6, 5 + h);
//			this.graphics.lineTo(3, h);
			this.graphics.endFill();
		}
		
		public static function init(base:DisplayObjectContainer):void
		{
			if (instance == null) {
				instance = new Tip();
				base.addChild(instance);				
			}
		}
		
		public static function register(area:DisplayObject, message:String):void {
			if(instance != null){
				var prop:AccessibilityProperties = new AccessibilityProperties();
				prop.description = message;
				area.accessibilityProperties = prop;
				area.addEventListener(MouseEvent.MOUSE_OVER, instance.handler);
			}
		}
		
		public static function unregister(area:DisplayObject):void {
			if (instance != null) {
				area.removeEventListener(MouseEvent.MOUSE_OVER, instance.handler);
			}
		}
		
		public function show(area:DisplayObject):void {
			this.area = area;
			this.area.addEventListener(MouseEvent.MOUSE_OUT, this.handler);
			this.area.addEventListener(MouseEvent.MOUSE_MOVE, this.handler);
			label.text = area.accessibilityProperties.description;
			redraw();			
		}
		
		
		public function hide():void	{
			this.area.removeEventListener(MouseEvent.MOUSE_OUT, this.handler);
			this.area.removeEventListener(MouseEvent.MOUSE_MOVE, this.handler);
			this.area = null;
			visible = false;
		}
		
		public function move(point:Point):void {			 
			var lp:Point = this.parent.globalToLocal(point);
			this.x = lp.x - 6;			
			this.y = lp.y - label.height - 12;
			
			if( this.y < 0 )
				this.y = lp.y + 24;
			if( ( this.y + label.height ) > stage.stageHeight )
				this.y = lp.y - label.height - 12;
			if( this.x < 0 )
				this.x = lp.x + 6;
			if( ( this.x + label.width ) > stage.stageWidth )
				this.x = lp.x - label.width - 6;
			
			
			if(!visible){
				visible = true;
			}
		}
		
		private function handler(event:MouseEvent):void	{
			switch(event.type) {
				case MouseEvent.MOUSE_OUT:
					this.hide();
					break;
				case MouseEvent.MOUSE_MOVE:
					this.move(new Point(event.stageX, event.stageY));					
					break;
				case MouseEvent.MOUSE_OVER:
					this.show(event.currentTarget as DisplayObject);
					this.move(new Point(event.stageX, event.stageY))
					break;
			}
		}
		
	}
}
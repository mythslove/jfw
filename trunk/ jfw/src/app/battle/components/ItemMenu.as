package app.mvc.views.components
{
	import app.globals.GameUtils;
	import app.globals.events.GameEvent;
	
	import com.pianfeng.engine.global.interfaces.IDispose;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	/**
	 *战场道具菜单 
	 * @author PianFeng
	 * 
	 */	
	public class ItemMenu extends Sprite implements IDispose
	{
		private var menu:*=null;
		
		public function ItemMenu(dis:*)
		{
			super();
			menu=dis;
			setTextField(menu.txtMove);
			setTextField(menu.txtDel);
			menu.gotoAndStop(1);
			this.addChild(menu);
			this.setVisible();
		}
		
		private function setTextField(txt:TextField):void 
		{			
			var _format:TextFormat = new TextFormat("宋体", 12,0x0000ff);
			var _glowfilter:GlowFilter = new GlowFilter(0x00ff00, 1, 2, 2,10, 1, false, false);
			txt.defaultTextFormat = _format;
			txt.filters = [_glowfilter];
			txt.autoSize = TextFieldAutoSize.LEFT;
			txt.selectable=false;
			txt.addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
			txt.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
			txt.addEventListener(MouseEvent.CLICK,onMouseDown);
		}
		
		private function onMouseOver(evt:MouseEvent):void
		{
			if(evt.target==menu.txtMove)
				menu.pbMove.gotoAndStop(1);
			else
				menu.pbDel.gotoAndStop(1);
		}
		
		private function onMouseOut(evt:MouseEvent):void
		{
			if(evt.target==menu.txtMove)
				menu.pbMove.gotoAndStop(2);
			else
				menu.pbDel.gotoAndStop(2);
		}
		
		private function onMouseDown(evt:MouseEvent):void
		{
			if(evt.target==menu.txtMove)
				this.dispatchEvent(new GameEvent(GameEvent.ITEM_MOVE,null,true,true));
			else
				this.dispatchEvent(new GameEvent(GameEvent.ITEM_DELLETE,null,true,true));
		}
		
		public function setVisible(value:Boolean=false):void
		{
			this.visible=value;
			
			if(!value)
			{
				menu.pbDel.gotoAndStop(2);
				menu.pbMove.gotoAndStop(2);
			}
		}
		/**
		 * 
		 * @param x stage坐标
		 * @param y stage坐标
		 * 
		 */		
		public function move(p:Point):void
		{
			var pLocal:Point=this.parent.globalToLocal(p);
			this.x=pLocal.x;
			this.y=pLocal.y;
		}
		
		public function dispose():void
		{
			menu.txtMove.removeEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
			menu.txtMove.removeEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
			menu.txtMove.removeEventListener(MouseEvent.CLICK,onMouseDown);
			menu.txtDel.removeEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
			menu.txtDel.removeEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
			menu.txtDel.removeEventListener(MouseEvent.CLICK,onMouseDown);
		}
	}
}
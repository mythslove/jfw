package app.mvc.view.ui.component
{
	import app.mvc.view.ui.component.interfaces.IToggleItem;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Navigation extends Sprite
	{
		// 纵向 	
		public static const VERTICAL:String		= "vertical";
		// 横向
		public static const HORIZONTAL:String		= "horizontal";	
		
		private var indexChange:Boolean = false;
		private var _index:int = -1;
		private var buttonList:Array;
		
		private var _spaceBetween:int;
		private var _distance:int;
		
		private var _layout:String = HORIZONTAL;
		
		public function Navigation( spaceB:int=0,dis:int=0 ,ly:String = HORIZONTAL)
		{
			buttonList = [];
			layout = ly;
			distance = dis;
			spaceBetween = spaceB;
		}
		
		public function getItemByIndex(index:int):IToggleItem
		{
			if (index >= 0 && buttonList.length > 0 && index < buttonList.length)
			{
				return buttonList[index];
			}
			return null;
		}
		
		public function set selectedIndex(index:int):void
		{
			if (index >= 0 && buttonList.length > 0 && index < buttonList.length && index != _index)
			{
				_index = index;
				indexChange = true;
				updateDisplayList();
				dispatchEvent(new Event(Event.CHANGE));
			}
		}
		
		public function get selectedIndex():int
		{
			return _index;
		}
		
		public function addItem(item:IToggleItem):void
		{
			buttonList.push(item);
			item.selected = false;
			addChild(item as DisplayObject);
			autoLayer();
			
			item.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownDispatcher);
		}
		
		private function autoLayer() : void
		{
			var item:DisplayObject;
			var index:int;
			var totalChild:int = this.numChildren;
			
			var pos:Number = distance;
			//纵向
			if( this.layout == VERTICAL )
			{
				while (index < totalChild)
				{
					item = this.getChildAt( index );
					item.y = pos;
					pos += item.height + spaceBetween;
					index++;
				}
			}
				//横向
			else
			{
				while (index < totalChild)
				{
					item = this.getChildAt(index);
					
					item.x = pos;
					pos += item.width + spaceBetween;
					index++;
				}
			}
		}
		
		private function getIndexByItem(item:IToggleItem) : int
		{
			var index:int;
			while (index < buttonList.length)
			{
				if (buttonList[index] == item)
				{
					return index;
				}
				index++;
			}
			return selectedIndex;
		}
		
		private function mouseDownDispatcher(e:MouseEvent) : void
		{
			var item:* = IToggleItem(e.currentTarget);
			selectedIndex = getIndexByItem(item);
		}
		
		private function refurbishDisplay():void
		{
			var index:int;
			while (index < buttonList.length)
			{
				IToggleItem(buttonList[index]).selected = false;
				index++;
			}
			IToggleItem(buttonList[selectedIndex]).selected = true;
		}
		
		
		
		protected function updateDisplayList():void
		{
			if (indexChange)
			{
				refurbishDisplay();
				indexChange = false;
			}
		}

		public function get layout():String
		{
			return this._layout;
		}
		
		public function set layout( ly:String ):void
		{
			this._layout = ly;
		}

		
		public function get distance():int
		{
			return _distance;
		}

		public function set distance(value:int):void
		{
			_distance = value;
		}

		public function get spaceBetween():int
		{
			return _spaceBetween;
		}

		public function set spaceBetween(value:int):void
		{
			_spaceBetween = value;
		}

		public function get itemCount():int
		{
			return buttonList.length;
		}
	}
}
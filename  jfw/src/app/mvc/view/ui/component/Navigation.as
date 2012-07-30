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
		private var indexChange:Boolean = false;
		private var _index:int = -1;
		private var buttonList:Array;
		
		private var _spaceBetween:int;
		private var _leftDistance:int;
		
		public function Navigation(spaceB:int=0,leftD:int=0)
		{
			buttonList = [];
			leftDistance = leftD;
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
			
			var pos:Number = leftDistance;
			while (index < totalChild)
			{
				item = this.getChildAt(index);
				
				item.x = pos;
				pos += item.width + spaceBetween;
				index++;
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

		public function get leftDistance():int
		{
			return _leftDistance;
		}

		public function set leftDistance(value:int):void
		{
			_leftDistance = value;
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
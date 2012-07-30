package app.mvc.view.ui.component
{
	import app.mvc.view.ui.component.interfaces.IList;
	import app.mvc.view.ui.component.interfaces.IListItem;
	
	import flash.display.Sprite;
	
	/**
	 * 多功能列表子项
	 */
	public class ListItem extends Sprite implements IListItem
	{
		private var _list:IList;
		
		private var _itemId:int;
		private var _data:Object;
		
		private var _selected:Boolean;
		
		public function ListItem(list:IList) 
		{
			_list	= list;
		}
		
		public function set itemId(value:int):void
		{
			_itemId = value;
		}
		
		public function get itemId():int
		{
			return _itemId;
		}
		
		public function set data(value:Object):void
		{
			_data	= value;
		}
		
		public function get data():Object
		{
			return _data;
		}
		
		public function get body():Object
		{
			return this;
		}
		
		public function get list():IList
		{
			return _list;
		}

		public function get selected():Boolean
		{
			return _selected;
		}

		public function set selected(value:Boolean):void
		{
			_selected = value;
		}

		
	}

}
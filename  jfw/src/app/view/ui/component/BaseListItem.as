package app.view.ui.component
{
	import app.view.ui.component.interfaces.IList;
	import app.view.ui.component.interfaces.IListItem;
	
	import com.jfw.engine.core.data.IStruct;
	import com.jfw.engine.core.mvc.view.BSprite;

	public class BaseListItem extends BSprite implements IListItem
	{
		protected var _list:IList;
		protected var _itemId:int;
		protected var _data:IStruct;
		protected var _selected:Boolean;
		
		public function BaseListItem(list:IList)
		{
			super();
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
		
		override public function set data(value:IStruct ):void
		{
			if(value == null)
			{
				clear();
				return;
			}
			visible = true;
			_data	= value;
			
			initData();
		}
		
		protected function initData():void
		{
			
		}
		
		protected function clear():void
		{
			_data = null;
			visible = false;
		}
		
		override public function get data():IStruct
		{
			return _data;
		}
		
		public function get body():Object
		{
			return this;
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
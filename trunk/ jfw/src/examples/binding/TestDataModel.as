package examples.binding
{
	[Bindable]
	public class TestDataModel
	{
		
		/** 金币 */
		private var _gb:int ;
		
		/** 妖币 */
		private var _yb:int ;
		
		/** 灵气 */
		private var _lq:int ;
		
		/** 物品 */
		private var _items:Vector.<TestItem>;
		
		public function TestDataModel()
		{
			if( instance )
				throw new Error("");
			instance = this;
		}
		
		//getter & setter
		public function get gb():int
		{
			return this._gb;
		}

		public function set gb( v:int ):void
		{
			this._gb = v;
		}
		
		public function get yb():int
		{
			return this._yb;
		}
		
		public function set yb( v:int ):void
		{
			this._yb = v;
		}
		
		public function get lq():int
		{
			return this._lq;
		}
		
		public function set lq( v:int ):void
		{
			this._lq = v;
		}
		
		public function get  items():Vector.<TestItem>
		{
			return this._items;
		}
		
		public function set items( v:Vector.<TestItem> ):void
		{
			this._items = v;
		}
		
		static private var instance:TestDataModel;
		
		static public function getInstance():TestDataModel
		{
			if( !instance )
				instance = new TestDataModel();
			return instance;
		}
		
		
	}
}
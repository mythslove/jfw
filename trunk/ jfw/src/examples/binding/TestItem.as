package examples.binding
{
	public class TestItem
	{
		private var _name:String;
		
		public function TestItem( n:String )
		{
			this.name = n;
		}
		
		public function get name():String
		{
			return this._name;
		}
		
		public function set name( v:String ):void
		{
			this._name = v;
		}
	}
}
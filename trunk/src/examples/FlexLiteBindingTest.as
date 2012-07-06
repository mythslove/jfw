package examples
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import mx.binding.utils.BindingUtils;
	
	public class FlexLiteBindingTest extends Sprite
	{
		[Bindable]
		private var _yb:int = 0;
		
		
		public function FlexLiteBindingTest()
		{
			super();
			
			//UI 显示妖币
			var ybTf:TextField = new TextField();
			ybTf.text = yb.toString();
			this.addChild( ybTf );
			
			BindingUtils.bindProperty( this,"yb", ybTf,"text" );
			
			stage.addEventListener(MouseEvent.CLICK,onClick);
		}
		
		protected function onClick(event:MouseEvent):void
		{
			this.yb++; 
			BindingUtils.dispatchChangeEvent( this,"yb" );
			trace("fuck");
		}
		
		public function get yb():int
		{
			return this._yb;
		}
		
		public function set yb( val:int ):void
		{
			this._yb = val;
		}
	}
}
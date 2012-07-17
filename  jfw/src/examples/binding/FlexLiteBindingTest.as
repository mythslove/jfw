package examples.binding
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import mx.binding.utils.BindingUtils;
	
	/**
	 * Binding测试
	 * 使用从flex框架剥离的FlexLite库 
	 * 
	 */
	public class FlexLiteBindingTest extends Sprite
	{
		private var ybTextField:TextField;
		private var gbTextField:TextField;
		private var lqTextField:TextField;
		
		public var myitems:Vector.<TestItem>;
		
		public function FlexLiteBindingTest()
		{
			super();
			
			//UI
			ybTextField = new TextField();
			gbTextField = new TextField();
			lqTextField = new TextField();
			ybTextField.autoSize = TextFieldAutoSize.LEFT;
			gbTextField.autoSize = TextFieldAutoSize.LEFT;
			lqTextField.autoSize = TextFieldAutoSize.LEFT;
			
			this.addChild( ybTextField );
			ybTextField.x = 0;
			this.addChild( gbTextField );
			gbTextField.x = 100;
			this.addChild( lqTextField );
			lqTextField.x = 200;
			
			TestDataModel.getInstance().items = new Vector.<TestItem>();
			
			BindingUtils.bindProperty(ybTextField,"text", TestDataModel.getInstance(),"yb" );
			BindingUtils.bindProperty(gbTextField,"text",TestDataModel.getInstance(),"gb");
			BindingUtils.bindSetter( lqFunc,TestDataModel.getInstance(),"lq" );
			
			BindingUtils.bindProperty( this,'myitems',TestDataModel.getInstance(),"items" );
//			BindingUtils.bindSetter( itemFunc,TestDataModel.getInstance(),"items",true );
			
			stage.addEventListener(MouseEvent.CLICK,onClick);
		}
		
		protected function onClick(event:MouseEvent):void
		{
			//更新数据，看UI同步情况
			TestDataModel.getInstance().yb = Math.random() * 100;
			TestDataModel.getInstance().gb = TestDataModel.getInstance().yb * 2;
			TestDataModel.getInstance().lq = TestDataModel.getInstance().yb + TestDataModel.getInstance().gb;
			
			TestDataModel.getInstance().items.push( new TestItem( "Item" + TestDataModel.getInstance().gb.toString()));
//			BindingUtils.dispatchChangeEvent( this,'myitems' );
			
			showItems();
		}
		
		private function lqFunc( lq:int ):void
		{
			lqTextField.text = "灵气：" + lq.toString();
		}
		
		private function showItems(  ):void
		{
			for( var i:int = 0,len:int = this.myitems.length;i<len;i++)
			{
				trace( "物品：",myitems[i].name ,'长度：',len);
			}
		}
	}
}
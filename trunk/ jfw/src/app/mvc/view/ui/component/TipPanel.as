package app.mvc.view.ui.component
{
	import com.jfw.engine.core.data.IStruct;
	import com.jfw.engine.core.mvc.view.BPanel;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	/** 使用位图做背景的Tooltip */
	public class TipPanel extends BPanel
	{
		public function TipPanel(cls_ref:Object=null, data:IStruct=null)
		{
			super(cls_ref, data);
		}
		
		/** 背景 */
		public var $mcTxtBg:Sprite;
		
		/** 文本框 */
		public var $txTxt:TextField;
		
		/** 九宫底图 */
		private var bitmapBg:BitmapScale9Grid;
		
		override protected function onInit():void
		{
			this.$txTxt.autoSize = TextFieldAutoSize.LEFT;
			this.$txTxt.selectable = false;
			this.$txTxt.multiline = true;
			this.$txTxt.mouseEnabled = false;
			this.$txTxt.x = 10;
			this.$txTxt.y = 8;
			
			var tbd:BitmapData = new BitmapData(this.$mcTxtBg.width + 5, this.$mcTxtBg.height, true, 0);
			tbd.draw(this.$mcTxtBg);
			this.bitmapBg = new BitmapScale9Grid(tbd);
			this.bitmapBg.scale9Grid = new Rectangle(10, 10, this.$mcTxtBg.width-10, this.$mcTxtBg.height-10);
			this.addChildAt(this.bitmapBg, 0);
			this.removeChild(this.$mcTxtBg);
		}
		
		public function show(data:Object, parentIO:DisplayObjectContainer=null) : void
		{
			if(this.parent != null)
			{
				if(data == null || data == "" || !(data is String)){
					this.hide();
				}
				else {
					this.$txTxt.htmlText = String(data);
					this.bitmapBg.width = this.$txTxt.width + 30;
					this.bitmapBg.height = this.$txTxt.height + 15;
				}
			}
		}
		
		public function hide(event:Boolean = true) : void
		{
			this.$txTxt.htmlText = "";
		}
	}
}
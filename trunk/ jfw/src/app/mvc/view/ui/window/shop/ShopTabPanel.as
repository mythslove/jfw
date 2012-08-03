package app.mvc.view.ui.window.shop
{
	import app.mvc.view.ui.component.Navigation;
	import app.mvc.view.ui.component.TabPanel;
	import app.mvc.view.ui.component.TabStruct;
	
	import com.jfw.engine.core.data.IStruct;
	
	import flash.events.Event;
	
	public class ShopTabPanel extends TabPanel
	{
		public function ShopTabPanel(cls_ref:Object=null, data:IStruct=null, tabfactory:Vector.<TabStruct>=null, tabButtonSkin:Class=null)
		{
			super(cls_ref, data, tabfactory, tabButtonSkin);
		}
		
		override protected function onInit():void
		{
			this.contentW = 756;
			this.contentH = 700;
			this.contentSpace = 0;
			this.contentX = 0;
			this.contentY = 0;
			this.navX = 0;
			this.navY = -20;
			this.navDis = 40;
			this.navSpaceBetween = 10;
			this.navLayout = Navigation.HORIZONTAL;
			
			super.onInit();
		}
		
		override protected function onChangeTab(evt:Event):void
		{
			super.onChangeTab( evt );
			
			
		}
	}
}
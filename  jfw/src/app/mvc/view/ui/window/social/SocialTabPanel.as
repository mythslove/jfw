package app.mvc.view.ui.window.social
{
	import app.mvc.view.ui.component.Navigation;
	import app.mvc.view.ui.component.TabPanel;
	import app.mvc.view.ui.component.TabStruct;
	
	import com.jfw.engine.core.data.IStruct;
	
	import flash.events.Event;
	
	public class SocialTabPanel extends TabPanel
	{
		public function SocialTabPanel(cls_ref:Object=null, data:IStruct=null, tabfactory:Vector.<TabStruct>=null, tabButtonSkin:Class=null)
		{
			super(cls_ref, data, tabfactory, tabButtonSkin);
		}
		
		override protected function onInit():void
		{
			this.contentW = 680;
			this.contentH = 530;
			this.contentSpace = 0;
			this.contentX = 35;
			this.contentY = 35;
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
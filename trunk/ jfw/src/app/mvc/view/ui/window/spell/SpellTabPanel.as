package app.mvc.view.ui.window.spell
{
	import app.mvc.view.ui.component.TabPanel;
	import app.mvc.view.ui.component.TabStruct;
	
	import com.jfw.engine.core.data.IStruct;
	
	public class SpellTabPanel extends TabPanel
	{
		public function SpellTabPanel(cls_ref:Object=null, data:IStruct=null, tabfactory:Vector.<TabStruct>=null, tabButtonSkin:Class=null)
		{
			super(cls_ref, data, tabfactory, tabButtonSkin);
			
			
		}
		
		override protected function onInit():void
		{
			this.contentW = 680;
			this.contentH = 427;
			this.contentSpace = 0;
			this.contentX = 40;
			this.contentY = 40;
			this.navX = 0;
			this.navY = 0;
			this.navLeftDis = 40;
			this.navSpaceBetween = 10;
			
			super.onInit();
		}
		
	}
}
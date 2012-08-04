package app.mvc.view.ui.window.monster
{
	import app.mvc.model.data.MonsterStruct;
	import app.mvc.view.ui.component.Navigation;
	import app.mvc.view.ui.component.TabPanel;
	import app.mvc.view.ui.component.TabStruct;
	
	import com.jfw.engine.core.data.IStruct;
	
	import flash.events.Event;
	
	public class MonsterTabPanel extends TabPanel
	{
		private var monsterData:IStruct;
		
		public function MonsterTabPanel(cls_ref:Object=null, data:IStruct=null, tabfactory:Vector.<TabStruct>=null, tabButtonSkin:Class=null)
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
			this.navY = -20;
			this.navDis = 40;
			this.navSpaceBetween = 1;
			this.navLayout = Navigation.HORIZONTAL;
			
			super.onInit();
		}
		
		override protected function onChangeTab(evt:Event):void
		{
			super.onChangeTab( evt );
			
			
		}
		
	}
}
package app.mvc.view.ui.window.packages
{
	import app.mvc.view.ui.component.List;
	import app.mvc.view.ui.component.Navigation;
	import app.mvc.view.ui.component.pagebar.PageBar;
	import app.mvc.view.ui.window.shop.ShopTab;
	
	import com.jfw.engine.core.data.IStruct;
	import com.jfw.engine.core.mvc.view.BPanel;
	
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class PackageContainerCollect extends BPanel
	{
		//tab
		private var tabNav:Navigation;
		private var tabFactory:Array;
		private var currSelectedTab:int = 0;
		
		private var listContainer:Sprite = null;
		private var listMask:Shape = null;
		private var listTween:Object = { };
		private var list:List = null;
		
		private var pageBar:PageBar = null;
		
		private static const listW:int = 214;
		private static const listH:int = 330;
		private static const FRIEND_COUNT_DISPLAY:int = 9;
		
		private static const listHSpace:int	= 0;
		private static const listSpace:int = 3;
		
		private var listEffect:Bitmap = null;
		
		public function PackageContainerCollect()
		{
			super();
			x=30;
		}
		
		override protected function onInit():void
		{
			super.onInit();
			
			createTab();
			
		}
		
		/**
		 * 创建Tab条 
		 * 
		 */
		private function createTab( ):void
		{
			tabFactory = 
				[
					{ tabName: '全部',type: 0 }, 
					{ tabName: '攻击类',type: 1 },
					{ tabName: '防守类',type: 2 },
					{ tabName: '几率类',type: 3 },
					{ tabName: '恢复类',type: 4 }
				];
			
			tabNav = new Navigation( tabFactory.length,0,Navigation.VERTICAL );
			for each ( var itemObj:Object in tabFactory )
			{
				tabNav.addItem( new ShopTab( itemObj.tabName ) );
			}
			
			this.addChild( tabNav );
			tabNav.x = 0;
			tabNav.y = 35;
			tabNav.selectedIndex = 0;
			tabNav.addEventListener(Event.CHANGE, onChangeTab);
		}
		
		/**
		 *  切换选项卡 
		 * @param evt
		 * 
		 */
		private function onChangeTab( evt:Event ):void
		{
			currSelectedTab = tabNav.selectedIndex;
			
		}
	}
}
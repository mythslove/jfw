package app.mvc.view.ui.window.shop
{
	import app.mvc.view.ui.component.List;
	import app.mvc.view.ui.component.Navigation;
	import app.mvc.view.ui.component.pagebar.PageBar;
	import app.mvc.view.ui.panel.friends.MainFriendItem;
	import app.mvc.view.ui.panel.friends.MainFriendTab;
	
	import com.jfw.engine.core.data.IStruct;
	import com.jfw.engine.core.mvc.view.BPanel;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	
	/**
	 *  商城面板
	 * @author
	 * 
	 */	
	public class ShopContainerShop extends BPanel
	{
		public var $mcShopContainer:Sprite = null;
		
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
		
		
		
		public function ShopContainerShop()
		{
			super();
		}
		
		override protected function onInit():void
		{
			super.onInit();
			
			createTab();
			
			
//			setData( friendModel.friendList );
			
//			pageBar = addChild( new PageBar( $mcPageBar ) ) as PageBar;
//			pageBar.setUpdateFun( pageUpdate );
//			pageUpdate(1);
//			pageBar.goto(1);
//			updatePageBar();
			//list.setCurrentItem( 0 );
		}
		
		/**
		 * 创建Tab条 
		 * 
		 */
		private function createTab( ):void
		{
			tabFactory = 
				[
					{ tabName: '畅销',type: 0 }, 
					{ tabName: '法宝',type: 1 },
					{ tabName: '材料',type: 2 },
					{ tabName: '书籍',type: 3 },
					{ tabName: '其他',type: 4 }
				];
			
			tabNav = new Navigation( tabFactory.length,0,Navigation.VERTICAL );
			for each ( var itemObj:Object in tabFactory )
			{
				tabNav.addItem( new ShopTab( itemObj.tabName ) );
			}
			
			this.addChild( tabNav );
			tabNav.x = 15;
			tabNav.y = 260;
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
//		
//		private function setData( value:Array ):void
//		{
//			dataList = value;
//			list.data = value;
//		}
		
	}
}
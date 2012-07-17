package app.view.ui.window
{
	import app.view.ui.WindowManager;
	import app.view.ui.component.BPageWindow;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	public class ShopWindow extends BPageWindow
	{
		
		private var _contentArea:Rectangle = new Rectangle( 30, 130, 660, 340 );
		
		public var emptyNoticeField:TextField;
		public var gotoInventoryButton:MovieClip;
		public var gotoChargeButton:MovieClip;
		public var userCashField:TextField;
		public var $txpanel_shop_title:TextField;
		
		public var $pbtab1Up:MovieClip;
		public var tab1Selected:MovieClip;
		public var $pbtab0Up:MovieClip;
		public var tab0Selected:MovieClip;
		
		public var $pbtab2Up:MovieClip;
		public var tab2Selected:MovieClip;
		public var $pbtab3Up:MovieClip;
		public var tab3Selected:MovieClip;
		public var $pbtab4Up:MovieClip;
		public var tab4Selected:MovieClip;
		public var $pbtab5Up:MovieClip;
		public var tab5Selected:MovieClip;
		
		public var ad:Sprite;
		
		public var currentTabIndex:int = 0;
		private static const ITEM_COUNT:int = 9;
		
		private var items:Vector.<ShopItem>;
		
		public function ShopWindow(){
			super();
			
			items = new Vector.<ShopItem>();
			var item:ShopItem;
			for(var i:int = 0; i < ITEM_COUNT; i++)
			{
				item		= new ShopItem(skin["i_"+i]);
				item.x		= item.x - contentArea.x;
				item.y		= item.y - contentArea.y;
				items.push( contentContainer.addChild(item) );
			}
			
			initTabs();
			removeChild( ad );
			
			
//			setFontText( emptyNoticeField, Language.shop_empty_notice );
//			setFontText(panel_shop_title,Language.shop_panel_title);
//			setFontText(gotoInventoryButton.panel_bag_desc,Language.shop_panel_bag_desc);
//			setFontText(gotoChargeButton.panel_pay_text, Language.shop_panel_pay_text);
//			setFontText(tab0Up.panel_noselect1, Language.shop_panel_noselect1);
//			setFontText(tab1Up.panel_noselect2, Language.shop_panel_noselect2);
//			setFontText(tab2Up.panel_noselect3, Language.shop_panel_noselect3);
//			setFontText(tab3Up.panel_noselect4, Language.shop_panel_noselect4);
//			setFontText(tab4Up.panel_noselect5, Language.shop_panel_noselect5);
//			setFontText(tab5Up.panel_noselect6, Language.shop_panel_noselect6);
//			
//			setFontText(tab0Selected.panel_select1, Language.shop_panel_select1);
//			setFontText(tab1Selected.panel_select2, Language.shop_panel_select2);
//			setFontText(tab2Selected.panel_select3, Language.shop_panel_select3);
//			setFontText(tab3Selected.panel_select4, Language.shop_panel_select4);
//			setFontText(tab4Selected.panel_select5, Language.shop_panel_select5);
//			setFontText(tab5Selected.panel_select6, Language.shop_panel_select6);
		}
		
		override public function execute( obj:* = null ):void
		{
			WindowManager.getInstance().openWindow(this,null,null,false);
		}
		
		private function initTabs ():void
		{
			/*
			var vipEnabled:Boolean = Global.isModelOpen( Global.MODEL_VIP );
			if (vipEnabled == false)
			{
			removeChild(getTabButtonUp(1));
			removeChild(getTabButtonSelected(1));
			}
			*/
			removeChild( getTabButtonUp(1) );
			removeChild( getTabButtonSelected(1) );
			
			var n:int = 5;
			for (var i:int = 0; i <= n; i++)
			{
				var tabUp:Sprite = getTabButtonUp(i);
				var tabSelected:Sprite = getTabButtonSelected(i);
				
				tabUp.buttonMode = true;
				tabUp.addEventListener(MouseEvent.CLICK, tabButton_clickHandler);
				tabUp.mouseChildren = false;
				
				tabSelected.buttonMode = true;
				tabSelected.addEventListener(MouseEvent.CLICK, tabButton_clickHandler);
				tabSelected.visible = false;
				tabSelected.mouseChildren = false;
			}
			
			for (var j:int = n; j > 0; j--)
			{
				getTabButtonUp(j).x = getTabButtonUp(j - 1).x;
				getTabButtonSelected(j).x = getTabButtonSelected(j - 1).x;
			}
			
		}
		
		
		
		private function tabButton_clickHandler(e:MouseEvent):void
		{
			var id:int = e.target.name.match(/\d/)[0];
			setCurrentTabIndex(id);
		}
		
		public function setCurrentTabIndex (value:int):void
		{
			getTabButtonUp(currentTabIndex).visible = true;
			getTabButtonSelected(currentTabIndex).visible = false;
			getTabButtonUp(value).visible = false;
			getTabButtonSelected(value).visible = true;
			
			currentTabIndex = value;
			pageUpdate(1);
			this.pageBar.goto(1);
			updatePageBar();
			//updateContent(1);
		}
		private function updatePageBar ():void
		{
			pageBar.max = Math.ceil(dataList.length/ITEM_COUNT);
			
			if(currentPage > pageBar.max)
			{
				currentPage = pageBar.max;
			}
			pageUpdate(currentPage);
		}
		
		private var dataListTabbed:Array;
		private function get dataList():Array
		{
			if (dataListTabbed == null)
			{
				initDataList();
			}
			return dataListTabbed[currentTabIndex];
		}
		
		
		private function initDataList ():void
		{
			dataListTabbed = [];
			shopList.sortOn(["isNew", "sort"], [Array.DESCENDING, Array.NUMERIC]);
			dataListTabbed[0] = shopList.filter( function (item:Object, index:int, array:Array):Boolean
			{
				return Boolean( int( item['new'] ) );
			});
			
			
			for (var i:int = 1; i <= 5; i++)
			{
				dataListTabbed[i] = shopList.filter( function (item:Object, index:int, array:Array):Boolean
				{
					return item.category == i;
				});
			}
		}
		
		public function getTabButtonUp (id:int):Sprite
		{
			return this["$pbtab" + id + "Up"];
		}
		
		public function getTabButtonSelected (id:int):Sprite
		{
			return this["tab" + id + "Selected"];
		}
		
//		override protected function initWindowData():void
//		{
//			data = model.assetsModel.getSaleItemsByType( ItemType.ITEM );
//			initDataList();
//			setCurrentTabIndex(currentTabIndex);
//			
//			setFontText( userCashField, model.gameModel.cash );
//		}
//		
		override protected function updateContent(page:int):void
		{
			emptyNoticeField.visible = dataList.length == 0;
			for(var i:int=0; i<items.length; i++)
			{
				var index:int = (page-1)*ITEM_COUNT+i;
				items[i].setData(dataList[index]);
			}
		}
		
		private function get shopList():Array
		{
			return data as Array;
		}
		
		protected override function get contentArea():Rectangle
		{
			return _contentArea;
		}
		
	}
}
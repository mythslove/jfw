package app.mvc.view.ui.panel.friends
{
	import app.mvc.model.player.FriendModel;
	import app.mvc.view.ui.component.pagebar.PageBar;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Bounce;
	import com.jfw.engine.core.mvc.view.BPanel;
	import com.jfw.engine.utils.FilterUtil;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import app.mvc.view.ui.component.List;
	import app.mvc.view.ui.component.Navigation;
	
	/**
	 * 好友面板 
	 */	
	public class MainFriendPanel extends BPanel
	{
		//属性
		public var $pbFriend:SimpleButton;
		public var $mcPageBar:MovieClip;
		public var $txInput:TextField;
		
		//tab
		private var tabNav:Navigation;
		private var tabFactory:Array;
		private var currSelectedTab:int = 0;
		
		private var list:List = null;
		private var dataList:Array = null;
		private var currentItemIndex:int = 0;
		private var listEffect:Bitmap = null;
		private var listContainer:Sprite = null;
		private var listMask:Shape = null;
		private var listTween:Object = { };
		
		private var pageBar:PageBar = null;
		
		private static const listW:int = 214;
		private static const listH:int = 330;
		private static const FRIEND_COUNT_DISPLAY:int = 9;
		
		private static const listHSpace:int	= 0;
		private static const listSpace:int = 3;
		
		
		//面板展开隐藏
		private var showStatus:Boolean = false;
		
		private var currentPage:int	= 1;
		
		public function MainFriendPanel()
		{
			super();
		}
		
		override protected function onMouseClick(evt:MouseEvent):void
		{
			super.onMouseClick( evt );
			switch( evt.target )
			{
				case this.$pbFriend:
					this.show( !showStatus );
					break;
			}
		}
		
		public function show( status:Boolean ):void
		{
			showStatus = status;
			y = stage.stageHeight - height >> 1;
			if( showStatus )
				TweenLite.to( this,.2,{x : stage.stageWidth - width});
			else
				TweenLite.to( this,.8,{x : stage.stageWidth,ease:Bounce.easeOut});
		}
		
		override protected function onInit():void
		{
			super.onInit();
			x = stage.stageWidth;
			
			createTab();
			createListContainer();
			
			setData( friendModel.friendList );
			
			pageBar = addChild( new PageBar( $mcPageBar ) ) as PageBar;
			pageBar.setUpdateFun( pageUpdate );
			pageUpdate(1);
			pageBar.goto(1);
			updatePageBar();
			//list.setCurrentItem( 0 );
		}
		
		override protected function onMouseOver(evt:MouseEvent):void
		{
			switch( evt.target )
			{
				case this.$mcPageBar['$pbPrevButton']:
				case this.$mcPageBar['$pbNextButton']:
					FilterUtil.applyContrast( evt.target as MovieClip );
					break;
			}
		}
		
		override protected function onMouseOut(evt:MouseEvent):void
		{
			switch( evt.target )
			{
				case this.$mcPageBar['$pbPrevButton']:
				case this.$mcPageBar['$pbNextButton']:
					FilterUtil.clearGlowFilter( evt.target as MovieClip );
					break;
			}
		}
		
		/**
		 * 创建Tab条 
		 * 
		 */
		private function createTab( ):void
		{
			tabFactory = 
				[
					{ tabName: '好友',type: 0 }, 
					{ tabName: '仇人',type: 1 }
				];
			
			tabNav = new Navigation( tabFactory.length );
			for each ( var itemObj:Object in tabFactory )
			{
				tabNav.addItem( new MainFriendTab( itemObj.tabName ) );
			}
			
			this.addChild( tabNav );
			tabNav.x = 57;
			tabNav.y = 32;
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
			listEffect.bitmapData = new BitmapData( listW, listH, true, 0 );
			listEffect.bitmapData.draw( list );
			listEffect.alpha = 1;
			
			var endA:int = 0;
			var endB:int = 0;
			
			if ( this.currSelectedTab < tabNav.selectedIndex )
			{
				listEffect.x = 0;
				list.x = listW + listHSpace;
				endA = -( listW + listHSpace );
				endB = 0;
			}
			else if ( this.currSelectedTab > tabNav.selectedIndex )
			{
				listEffect.x = 0;
				list.x =  -( listW + listHSpace );
				endA = listW + listHSpace ;
				endB = 0;
			}
			
			listTween.value	= list.x;
			TweenLite.to( listEffect, 0.4, { x:endA, alpha:0 } );
			TweenLite.to( listTween, 0.4, { value:endB, onUpdate:onListTweenUpdate } );
			
			list.setCurrentItem( 0, false );
			
			currSelectedTab = tabNav.selectedIndex;
			
			var type:int = tabFactory[ tabNav.selectedIndex ].type;
			var data:Array = friendModel.getData( type );
			
			pageBar.max = Math.ceil( data.length / FRIEND_COUNT_DISPLAY ) ;
			pageBar.goto(1);
			pageUpdate(1);
			
			var tab:MainFriendTab = MainFriendTab( tabNav.getItemByIndex( tabNav.selectedIndex ) );
			if( tab.getCount() != 0 )
			{
				tab.setCount(0);
			}
			
			setData( data );
		}
		
		private function onListTweenUpdate():void
		{
			list.x = listTween.value;
		}
		
		private function createListContainer():void
		{
			listContainer = new Sprite();
			listContainer.x = 25;
			listContainer.y = 80;
			
			// 好友列表
			list = new List( MainFriendItem, listW, listH, listSpace, List.VERTICAL );
			list.drag = false;
			listContainer.addChild( list );
			
			listEffect = new Bitmap();
			listContainer.addChild( listEffect );
			
			listMask = new Shape();
			listMask.x = listContainer.x;
			listMask.y = listContainer.y;
			listMask.graphics.beginFill( 0xFF00FF, 0.5 );
			listMask.graphics.drawRect( 0, 0, listW, listH );
			listMask.graphics.endFill();
			
			listContainer.mask = listMask;
			addChild( listContainer );
			addChild( listMask );
		}
		
		private function updatePageBar ():void
		{
			pageBar.max = Math.ceil( dataList.length / FRIEND_COUNT_DISPLAY );
			if( currentPage > pageBar.max )
			{
				currentPage = pageBar.max;
			}
			pageUpdate(currentPage);
		}
		
		private function setData( value:Array ):void
		{
			dataList = value;
			list.data = value;
		}
		
		private function pageUpdate( page:int ):void
		{
			currentItemIndex = ( page - 1 ) * FRIEND_COUNT_DISPLAY;
			list.setCurrentItemMoveTo( currentItemIndex );
		}
		
		override public function destroy():void
		{
			tabNav.removeEventListener(Event.CHANGE, onChangeTab);
			super.destroy();
		}
		
		private function get friendModel():FriendModel
		{
			return core.retModel( FriendModel.NAME ) as FriendModel;
		}
	}
}
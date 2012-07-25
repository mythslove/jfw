package app.view.ui.component
{
	import app.model.player.FriendModel;
	import app.view.ui.component.pagebar.PageBar;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.EaseLookup;
	import com.jfw.engine.core.data.IStruct;
	import com.jfw.engine.core.mvc.view.BPanel;
	import com.jfw.engine.core.mvc.view.BSprite;
	import com.jfw.engine.utils.FilterUtil;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	/**
	 * 好友面板 
	 */	
	public class MainFriendPanel extends BPanel
	{
		public var $pbFriend:SimpleButton;
		public var $mcTab:MovieClip;
		public var $pbFind:SimpleButton;
		public var $pbInvite:SimpleButton;
		public var $pbRefresh:SimpleButton;
		public var $mcPageBar:MovieClip;
		public var $txInput:TextField;
		
		private var list:List = null;
		private var dataList:Array = null;
		private var currentItemIndex:int = 0;
		
		private var keyword:String = '';
		private var pageBar:PageBar = null;
		
		private static const listW:int = 214;
		private static const listH:int = 330;
		private static const listSpace:int = 3;
		private static const FRIEND_COUNT_DISPLAY:int = 9;
		
		public var refreshMask:Shape = null;
		
		private var showStatus:Boolean = false;
		
		private var currentPage:int	= 1;
		private var contentContainer:Sprite = null;
		private var contentEffect:Bitmap = null;
		private var _contentArea:Rectangle = new Rectangle( 25, 80, 214, 330 );
		
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
			
			// 好友列表
			list = new List( MainFriendItem, listW, listH, listSpace, List.VERTICAL );
			list.drag = false;
			addChild( list );
			list.x = 25;
			list.y = 80;
			
			contentContainer = new Sprite();
			contentEffect = new Bitmap();
			this.addChild( contentEffect );
			
			refreshMask	= new Shape()
			addChild( refreshMask );
			
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
			trace( evt.target.name );
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
		
		/**
		 * 更新内容 
		 * @param page
		 * 
		 */
		private function updateContent( page:int ):void
		{
		}
		
		private function get minIndex():int
		{
			return 0;
		}
		
		private function get maxIndex():int
		{
			return this.dataList.length - FRIEND_COUNT_DISPLAY;
		}
		
		private function get contentArea():Rectangle
		{
			return _contentArea;
		}
		
		private function get friendModel():FriendModel
		{
			return core.retModel( FriendModel.NAME ) as FriendModel;
		}
	}
}
package app.view.ui.component
{
	import app.view.ui.component.pagebar.PageBar;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.EaseLookup;
	import com.jfw.engine.core.data.IStruct;
	import com.jfw.engine.core.mvc.view.BPanel;
	import com.jfw.engine.core.mvc.view.BSprite;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
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
		private var pageBar:PageBar = null;
		
		private static const listW:int = 214;
		private static const listH:int = 326;
		private static const listSpace:int = 1;
		private static const FRIEND_COUNT_DISPLAY:int = 9;
		
		public var refreshMask:Shape = null;
		
		private var showStatus:Boolean = false;
		
		private var currentPage:int	= 1;
		private var contentContainer:Sprite = null;
		private var contentEffect:Bitmap = null;
		private var _contentArea:Rectangle = new Rectangle( 25, 80, 214, 326 );
		
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
			setData( new Array() );
			
			pageBar = addChild( new PageBar( $mcPageBar ) ) as PageBar;
			pageBar.setUpdateFun( pageUpdate );
		}
		
		private function setData( value:Array ):void
		{
			list.data = [];
		}
		
		private function pageUpdate(page:int):void
		{
			if(currentPage != page)
			{
				this.contentEffect.bitmapData	= new BitmapData(contentArea.width, contentArea.height, true, 0);
				this.contentEffect.bitmapData.draw( this.contentContainer );
				this.contentEffect.alpha = 1;
				
				var effectX:int	= 0;
				
				if(currentPage > page)
				{
					this.contentContainer.x	= 0 - contentArea.width;
					this.contentEffect.x = 0;
					
					effectX	= 0 + contentArea.width + 20;
				}else if(currentPage < page)
				{
					this.contentContainer.x	= 0 + contentArea.width;
					this.contentEffect.x = 0;
					
					effectX	= 0 - contentArea.width - 20;
				}
				currentPage	= page;
				
				TweenLite.to(this.contentEffect, 0.5, {x:effectX, alpha:0});
				TweenLite.to(this.contentContainer, 0.5, {x:0});
			}
			updateContent(page);
		}
		
		/**
		 * 更新内容 
		 * @param page
		 * 
		 */
		private function updateContent(page:int):void
		{
			
		}
		
		private function get contentArea():Rectangle
		{
			return _contentArea;
		}
		
	}
}
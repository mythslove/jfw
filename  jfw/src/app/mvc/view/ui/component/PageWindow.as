package app.mvc.view.ui.component
{
	import com.greensock.TweenLite;
	import com.jfw.engine.core.data.IStruct;
	import com.jfw.engine.core.mvc.view.BWindow;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import app.mvc.view.ui.component.pagebar.PageBar;
	
	/**
	 * 支持分页的window 
	 * 
	 */	
	public class PageWindow extends BWindow
	{
		
		protected var pageBar:PageBar = null;
		
		protected var contentContainer:Sprite = null;
		protected var contentEffect:Bitmap = null;
		protected var allContainer:Sprite = null;
		protected var allMask:Shape = null;
		
		protected var currentPage:int	= 1;
		private var _contentArea:Rectangle = new Rectangle( 40, 36, 456, 258 );
		
		public function PageWindow()
		{
			super();
			
			contentContainer = new Sprite();
			contentEffect = new Bitmap();
			allContainer = new Sprite();
			allMask = new Shape();
			
			allContainer.addChild( contentContainer );
			allContainer.addChild( contentEffect );
			allContainer.x = contentArea.x;
			allContainer.y = contentArea.y;
			allMask.x = this.allContainer.x
			allMask.y = this.allContainer.y;
			
			allMask.graphics.beginFill( 0 );
			allMask.graphics.drawRect( 0, 0, contentArea.width, contentArea.height );
			allMask.graphics.endFill();
			
			allContainer.mask = allMask;
			
			addChild( allContainer );
			addChild( allMask );
			
			pageBar = addChild( new PageBar( skin['$mcPageBar'] ) ) as PageBar;
			pageBar.setUpdateFun( pageUpdate );
		}
		
		protected function get contentArea():Rectangle
		{
			return _contentArea;
		}
		
		protected function pageUpdate(page:int):void
		{
			if(currentPage != page)
			{
				this.contentEffect.bitmapData	= new BitmapData(contentArea.width, contentArea.height, true, 0);
				this.contentEffect.bitmapData.draw(this.contentContainer);
				this.contentEffect.alpha		= 1;
				
				var effectX:int				= 0;
				
				if(currentPage > page)
				{
					this.contentContainer.x	= 0 - contentArea.width;
					this.contentEffect.x		= 0;
					
					effectX					= 0 + contentArea.width + 20;
				}else if(currentPage < page)
				{
					this.contentContainer.x	= 0 + contentArea.width;
					this.contentEffect.x		= 0;
					
					effectX					= 0 - contentArea.width - 20;
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
		protected function updateContent(page:int):void
		{
			
		}
		
		override public function close():void
		{
			try
			{
				this.contentEffect.bitmapData.dispose();
			}catch(e:Error){};
			
			super.close();
		}
	}
}
package app.mvc.view.ui.component.pagebar
{
	import com.jfw.engine.core.data.IStruct;
	import com.jfw.engine.core.mvc.view.BPanel;
	import com.jfw.engine.utils.FontUtil;
	
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * 简单分页条
	 * 
	 *  样式：
	 * 		<< < 50/100 > >>
	 * 
	 */
	public class PageBar extends BPanel implements IPageBar
	{
		public var $pbPrevPageButton:SimpleButton = null;
		public var $pbNextPageButton:SimpleButton = null;
		
		public var $pbFirstButton:SimpleButton = null;
		public var $pbEndButton:SimpleButton = null;
		
		public var $txNumText:TextField = null;
		
		private var current:int	= 1;
		private var _max:int	= 1;
		private var _min:int	= 1;
		
		private var updateFun:Function = null;
		
		public function PageBar(cls_ref:Object=null)
		{
			super(cls_ref);
			
			FontUtil.setText( $txNumText,'1/1');
			this.mouseEnabled = false;
		}
		
		//
		// 设置更新方法
		//	
		public function setUpdateFun( updateFun:Function ):void
		{
			this.updateFun = updateFun;
		}
		
		//
		// 设置最大页数
		// 
		public function set max( len:int ):void
		{
			_max	= Math.max( len, 1);
			current = Math.min( current, _max );
			updateMe( current );
		}
		
		public function get max():int
		{
			return _max;
		}
		
		public function get min():int
		{
			return _min;
		}
		
		//
		// 设置最小页数
		// 
		public function set min( val:int ):void
		{
			this._min = val;
		}
		
		//
		// 设置当前页数
		//	
		public function goto( page:int ):void
		{
			updateMe( page );
		}
		
		private function updateMe( page:int ):void
		{
			if ( current != page )
			{
				current = page;
				if ( null != updateFun )
					updateFun( current );
			}
			FontUtil.setText( $txNumText, current + '/' + max );
			
			checkBtnStatus( page );
		}
		
		override protected function onMouseClick(evt:MouseEvent):void
		{
			switch( evt.currentTarget )
			{
				case $pbPrevPageButton:
					onPrevButtonClick();
					break;
				case $pbNextPageButton:
					onNextButtonClick();
					break;
				case $pbFirstButton:
					onFirstButtonClick();
					break;
				case $pbEndButton:
					onEndButtonClick();
					break;
			}
		}
		
		private function onPrevButtonClick():void
		{
			var page:int = current;
			--page;
			page = Math.max( page, min ); 
			updateMe( page );
		}
		
		private function onNextButtonClick():void
		{
			var page:int = current;
			++page;
			page = Math.min( page, max );
			updateMe( page );
		}
		
		private function onFirstButtonClick():void
		{
			updateMe( min );
		}
		
		private function onEndButtonClick():void
		{
			updateMe( max );
		}
		
		
		private function checkBtnStatus( page:int ):void
		{
			disableMc( $pbPrevPageButton , true );
			disableMc( $pbNextPageButton , true );
			disableMc( $pbFirstButton, true );
			disableMc( $pbEndButton, true );
			
			if( page >= max )
			{
				disableMc( $pbNextPageButton, false );
				disableMc( $pbEndButton, false );
			}
			if( page <= min )
			{
				disableMc( $pbPrevPageButton, false );
				disableMc( $pbFirstButton, false );
			}
		}
	}
}
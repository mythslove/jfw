package app.view.ui.component.pagebar
{
	import com.jfw.engine.core.data.IStruct;
	import com.jfw.engine.core.mvc.view.BPanel;
	import com.jfw.engine.utils.FontUtil;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * 简单分页条
	 *  样式：
	 * 			< 50/100 >
	 * @author 
	 * 
	 */
	public class PageBar extends BPanel implements IPageBar
	{
		
		public var $pbPrevButton:MovieClip = null;
		public var $pbNextButton:MovieClip = null;
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
		}
		
		override protected function onMouseClick(evt:MouseEvent):void
		{
			switch( evt.currentTarget )
			{
				case $pbPrevButton:
					onPrevButtonClick();
					break;
				case $pbNextButton:
					onNextButtonClick();
					break;
			}
		}
		
		private function onPrevButtonClick():void
		{
			var page:int = current;
			--page;
			page = Math.max( page, 1 ); 
			updateMe( page );
		}
		
		private function onNextButtonClick():void
		{
			var page:int = current;
			++page;
			page = Math.min( page, max );
			updateMe( page );
		}
	}
}
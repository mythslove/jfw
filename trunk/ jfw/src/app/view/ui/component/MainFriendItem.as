package app.view.ui.component
{
	import app.view.ui.component.interfaces.IList;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class MainFriendItem extends BaseListItem
	{
		static private const NORMAL:int = 1;
		static private const LIGHT:int = 2;
		
		public var $txName:TextField ;
		public var $txLevel:TextField;
		public var $txFriendly:TextField;
		public var $txVip:TextField;
		public var $mcFace:MovieClip;
		private var image:Image = null;
		
		public function MainFriendItem(list:IList)
		{
			super(list);
			
			image = new Image( 50, 50 );
			$mcFace.addChild( image );
			image.mouseEnabled = false;
			
			addEventListener( MouseEvent.CLICK, onMouseClick );
			addEventListener( MouseEvent.ROLL_OVER, onMouseOver );
			addEventListener( MouseEvent.ROLL_OUT, onMouseOut );
		}
		
		override protected function onMouseClick(evt:MouseEvent):void
		{
			this.selected = true;
			if( this.selected )
				setBgFrame( LIGHT );
			else
				setBgFrame( NORMAL );
		}
		
		override protected function initData():void
		{
			
		}
		
		override protected function onMouseOver(evt:MouseEvent):void
		{
//			setBgFrame( LIGHT );
		}
		
		override protected function onMouseOut(evt:MouseEvent):void
		{
//			setBgFrame( NORMAL );
		}
		
		private function setBgFrame( frame:int ):void
		{
			this.$mcBg.gotoAndStop( frame );
		}
	}
}
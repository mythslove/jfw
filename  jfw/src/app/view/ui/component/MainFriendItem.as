package app.view.ui.component
{
	import app.view.ui.component.interfaces.IList;
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	public class MainFriendItem extends BaseListItem
	{
		
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
		}
	}
}
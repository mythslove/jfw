package app.mvc.views.components
{
	import app.mvc.models.res.BattleDataProxy;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	import org.puremvc.as3.patterns.facade.Facade;

	public class PicturePanel extends Sprite
	{
		private var battleDataProxy:BattleDataProxy;
		private var bit:Bitmap;
		
		public function PicturePanel(name:String)
		{
			super();
			battleDataProxy=Facade.getInstance().retrieveProxy(BattleDataProxy.NAME) as BattleDataProxy;
			bit=battleDataProxy.getBitmapByName(name);
			this.addChild(bit);
		}
		
		public function dispose():void
		{
			bit.bitmapData.dispose();
			this.removeChild(bit);
			bit=null;
		}
	}
}
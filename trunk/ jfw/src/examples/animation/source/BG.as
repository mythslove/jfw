package examples.animation.source
{
	import com.isolib.as3isolib.display.IsoSprite;
	import com.isolib.as3isolib.geom.Pt;
	import com.isolib.as3isolib.utils.IsoDrawingUtil;
	
	import flash.display.Sprite;
	import app.manager.AssetsManager;
	
	public class BG extends IsoSprite
	{
		public function BG(descriptor:Object=null)
		{
			super(descriptor);
			
			this.sprites = [AssetsManager.Instance.getEmbedResource("MyMapBg")];  
		}
	}
}
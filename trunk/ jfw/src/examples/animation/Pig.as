package examples.animation
{
	import com.isolib.as3isolib.display.IsoSprite;
	import com.isolib.as3isolib.geom.Pt;
	import com.isolib.as3isolib.utils.IsoDrawingUtil;
	
	import flash.display.Sprite;
	
	public class Pig extends IsoSprite
	{
		[Embed(source="unknown.jpg")]
		public var UnknownIcon:Class;
		
		public function Pig(descriptor:Object=null)
		{
			super(descriptor);
			
			var base:Sprite = new Sprite();  
			
			base.graphics.beginFill(0x336699);  
			
			IsoDrawingUtil.drawIsoRectangle(base.graphics, new Pt(), 100,100);  
			
			base.graphics.endFill();  
			
			this.sprites = [base,new UnknownIcon()];  
		}
	}
}
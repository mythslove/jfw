package app.view.iso.isoSprites.charactor
{
	import app.view.iso.isoSprites.MapItem;
	
	import com.isolib.as3isolib.display.primitive.IsoBox;
	import com.isolib.as3isolib.graphics.SolidColorFill;
	
	public class AIMonster extends IsoBox
	{
		public function AIMonster(id:String,width:int,height:int)
		{
			setSize(width*30, height*30, 60);
			fill = new SolidColorFill(0x00cc00, .8);
		}
	}
}
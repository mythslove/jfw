package app.view.iso.isoSprites.building
{
	import com.jfw.engine.core.animation.BmdMovieClip;
	
	import flash.display.BitmapData;
	
	public class AbstractBuilding extends BmdMovieClip
	{
		public function AbstractBuilding( bmds:Vector.<BitmapData>, fps:Number=12 )
		{
			super(bmds, fps);
		}
	}
}
package app.view.iso.isoSprites.building
{
	import app.view.iso.isoSprites.MapItem;
	
	import com.jfw.engine.core.base.Core;
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.system.ApplicationDomain;
	import flash.utils.Timer;

	public class MapBuilding extends MapItem
	{
		public static var glowFilter:GlowFilter = new GlowFilter( 0xFFFFFF, 1, 6, 6, 10 );
		
		private var _buildingId:String ;	
		
		private var bmpMC:MovieClip;
		
		public function MapBuilding( id:String,width:int, height:int )
		{
			super();
			
			this._buildingId = id;
			this.bmpMC = Core.getInstance().assetsModel.getDisplayObj( _buildingId ) as MovieClip;
			spriteContainer.buttonMode = false;
			spriteContainer.addChild( this.bmpMC );
			
			setSize( width * 30, height * 30, 10 );
			this.
			init();
		}
		
		private function init():void
		{
		}
		override public function hitTestPoint( x:Number, y:Number, shapeFlag:Boolean = false ):Boolean
		{
			if ( !bmpMC )
				return false;
			return bmpMC.hitTestPoint( x, y, shapeFlag );
		}
		
		public function get buildingId():String
		{
			return _buildingId;
		}
		
		
		public function set buildingId( id:String ):void
		{
			_buildingId = id;
		}
		
		public function get gridX():int
		{
			return x / 30;
		}
		
		public function get gridY():int
		{
			return y / 30;
		}
		
		public function get gridWidth():int
		{
			return width / 30;
		}
		
		public function get gridHeight():int
		{
			return length / 30;
		}
		
		public function setState( state:String, level:int=-1 ):void
		{
			spriteContainer.buttonMode = false;
			
//			var mc:MovieClip = getMovieClip( assetsDomain, className );
//			bmpMC = new BmpMovieClip( mc, _assetsPath + className );
//			bmpMC.addEventListener( BmpMovieClipEvent.BMPMC_MOUSE_OVER, onMouseOver );
//			bmpMC.addEventListener( BmpMovieClipEvent.BMPMC_MOUSE_OUT, onMouseOut );
//			bmpMC.addEventListener( BmpMovieClipEvent.BMPMC_CLICK, onClick );
//			bmpMC.addEventListener( BmpMovieClipEvent.BMPMC_MOUSE_DOWN, onMouseDown );
//			bmpMC.play();
//			spriteContainer.addChild(  );
			
		}
		
	
	}

}
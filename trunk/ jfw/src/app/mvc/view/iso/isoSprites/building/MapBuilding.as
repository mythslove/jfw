package app.mvc.view.iso.isoSprites.building
{
	import app.mvc.view.iso.isoSprites.MapItem;
	
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
			
			bmpMC.addEventListener( MouseEvent.MOUSE_OUT, onMouseOut5 );
			bmpMC.addEventListener( MouseEvent.MOUSE_OVER, onMouseOver5 );
			
			setSize( width * 30, height * 30, 10 );
			init();
		}
		
		private function onMouseOut5(event:MouseEvent):void
		{
			this.setHighLight(false);
//			trace(event.target.toString());
			
		}
		
		private  function onMouseOver5(event:MouseEvent):void
		{
			this.setHighLight(true);
//			trace(event.target.toString());
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
		
	}

}
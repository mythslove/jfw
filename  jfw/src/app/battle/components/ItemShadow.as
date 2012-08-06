package app.mvc.views.components
{
	import com.pianfeng.engine.isolib.isometric.IsoTile;
	import com.pianfeng.engine.isolib.map.data.MapData;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class ItemShadow extends IsoTile
	{
		protected var _isDropEnable:Boolean=true;//是否可放置状态
		protected var _mapElement:Sprite=null; 
		protected var mapData:MapData=null;
		public var gridX:int=0;
		public var gridY:int=0;
		
		public function ItemShadow(mapData:MapData)
		{
			super(mapData.cellSize, 0x336600, 1);
			this.mapData=mapData;
			this.mouseChildren=false;
			this.mouseEnabled=false;
		}
		/** 
		 * Draws the tile. 
		 */ 
		override protected function draw():void 
		{ 
			graphics.clear(); 
			graphics.beginFill(_color,_alpha); 
			graphics.lineStyle(0, 0x336600, 1); 
			graphics.moveTo(-size, 0); 
			graphics.lineTo(0, -size * .5); 
			graphics.lineTo(size, 0); 
			graphics.lineTo(0, size * .5); 
			graphics.lineTo(-size, 0); 
			graphics.endFill();
			graphics.beginFill(0x663300,_alpha); 
			graphics.lineTo(-size, 3); 
			graphics.lineTo(0, size * .5+3);  
			graphics.lineTo(size,3);
			graphics.lineTo(size,0);
			graphics.lineTo(0, size * .5); 
			graphics.lineTo(-size, 0); 
			graphics.endFill();
		} 
		
		public function set isDropEnable(value:Boolean):void
		{
			_isDropEnable=value;
			
			if(_isDropEnable)
				this.color=0x003300;
			else
				this.color=0x990000;
		}
		
		public function get isDropEnable():Boolean
		{
			return this._isDropEnable;
		}
		
		public function setIsoPosition(gridX:int,gridY:int):void
		{
			var p2d:Point=mapData.GridToScreen(new Point(gridX,gridY));
			this.ScrX=p2d.x;
			this.ScrY=p2d.y-3;
			this.gridX=gridX;
			this.gridY=gridY;
		}
	}
}
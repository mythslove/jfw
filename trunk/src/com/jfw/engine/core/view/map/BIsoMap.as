package com.jfw.engine.core.view.map
{
	import com.isolib.as3isolib.display.IsoView;
	import com.isolib.as3isolib.display.scene.IsoGrid;
	import com.isolib.as3isolib.display.scene.IsoScene;
	import com.isolib.as3isolib.graphics.Stroke;
	
	import com.jfw.engine.core.data.IStruct;
	import com.jfw.engine.core.view.BView;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * 支持iso的视图基类
	 * 
	 * @author jianzi
	 */	
	public class BIsoMap extends BView implements IIsoMap
	{
		protected var mapWidth:int = 24;
		protected var mapHeight:int = 24;
		protected var cellWidth:int = 30;
		protected var cellHeight:int = 30;
		
		protected var isoView:IsoView;
		protected var isoScene:IsoScene;
		protected var isoGrid:IsoGrid;
		
		protected var gridStartX:int = 0;
		protected var gridStartY:int = 0;
		protected var downPt:Point = null;
		
		protected var sceneRect:Rectangle = null;
		
		public function BIsoMap(data:IStruct=null)
		{
			super(data);
		}
		
		override protected function onInit():void
		{
			this.initMapBg();
			this.initScene();
		}
		
		public function initMapBg():void
		{
			
		}
		
		public function initScene():void
		{
			sceneRect = new Rectangle( 0, 0, 2400, 2400 );
			
			this.isoGrid = new IsoGrid();
			this.isoGrid.showOrigin = true;
			this.isoGrid.gridlines = new Stroke( 0,0x888888,.5);
			this.isoGrid.setGridSize( mapWidth,mapHeight );
			this.isoGrid.cellSize = cellWidth;
			this.isoGrid.container.cacheAsBitmap = true;
			
			gridStartX = sceneRect.width * .5;
			gridStartY = sceneRect.height * .5 - cellWidth * mapWidth * .5;
			
			this.isoScene = new IsoScene();
			this.isoScene.render();
			
			isoView = new IsoView();
			isoView.setSize( sceneRect.width, sceneRect.height );
			isoView.showBorder = false;
			isoView.panTo( 0, cellWidth * mapWidth * .5 );
			isoView.addScene( isoScene );
			
			addChild( isoView );
			
			addEventListener( MouseEvent.CLICK, onClick );
			addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
			addEventListener( MouseEvent.MOUSE_UP, onMouseUp );
			addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
		}
		
		protected function onMouseMove(event:MouseEvent):void
		{
			
		}
		
		protected function onMouseUp(event:MouseEvent):void
		{
			stopDrag();
		}
		
		protected function onMouseDown(event:MouseEvent):void
		{
			startDrag( false, new Rectangle( 
				stage.stageWidth - sceneRect.width, 
				stage.stageHeight - sceneRect.height, 
				sceneRect.width - stage.stageWidth, 
				sceneRect.height - stage.stageHeight ) );
			
			downPt = new Point( event.stageX, event.stageY );
		}
		
		protected function onClick(event:MouseEvent):void
		{
			// 移动过大，表示正在拖动场景
			if ( Math.abs( event.stageX - downPt.x ) > 2 || 
				Math.abs( event.stageY - downPt.y ) > 2 ) 
				return;
			
		}
		
		public function gridToView(pt:Point):Point
		{
			return null;
		}
		
		public function viewToGrid( pt:Point ):Point
		{
			return null;
		}
		
		public function addItem():void
		{
			
		}
		
		public function removeItem():void
		{
			
		}
		
		public function getItemByPos( x:int,y:int ):void
		{
			
		}
		
		public function showGrid( show:Boolean ):void
		{
			if ( show )
			{
				if ( -1 == this.isoScene.getChildIndex( this.isoGrid ) )
				{
					this.isoScene.addChildAt( this.isoGrid, 0 );
					this.isoScene.render();
				}
			}
			else
			{
				if ( -1 != this.isoScene.getChildIndex( this.isoGrid ) )
				{
					this.isoScene.removeChild( this.isoGrid );
					this.isoScene.render();
				}
			}
		}
		
		public function makeCenter():void
		{
			x = ( stage.stageWidth - sceneRect.width ) * 0.5;
			y = 0;
		}
	}
}
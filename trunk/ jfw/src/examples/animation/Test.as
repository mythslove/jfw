package examples.animation
{
	import com.isolib.as3isolib.display.IsoSprite;
	import com.isolib.as3isolib.display.IsoView;
	import com.isolib.as3isolib.display.scene.IsoGrid;
	import com.isolib.as3isolib.display.scene.IsoScene;
	import com.isolib.as3isolib.geom.IsoMath;
	import com.isolib.as3isolib.geom.Pt;
	import com.jfw.engine.animation.Juggler;
	
	import examples.animation.RoleView;
	import examples.animation.animation.AnimationConst;
	import examples.animation.geom.isolib.map.consts.DirectionConst;
	import examples.animation.geom.isolib.map.data.AStar;
	import examples.animation.geom.isolib.map.data.IMapData;
	import examples.animation.geom.isolib.map.data.MapData;
	import examples.animation.geom.isolib.map.data.Tile;
	import examples.animation.source.AssetsManager;
	import examples.animation.source.BG;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	
	[SWF(width="768",height="610",frameRate="24", backgroundColor="#ffffff")]
	
	public class Test extends Sprite
	{
		private var juggler:Juggler=null;
		private var mLastFrameTimestamp:Number;
		private var role:RoleView=null;
		
		public function Test()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded (e:Event):void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			
			juggler=new Juggler();
//			var role:RoleView=new RoleView("Role",12);
//			juggler.add(role);
//			role.move(100,100);
			var bg:Bitmap=AssetsManager.Instance.getEmbedResource("MyMapBg") as Bitmap;
			var data:XML=XML(AssetsManager.Instance.getEmbedResource("MyMapData"));
//			this.addChild(bg);
			
			var mapData:IMapData=new MapData(data);

		//	var roleClass:String="RoleTexture";
		//	var roleData:String="RoleData";
		//	var bmdAtlas:BmdAtlas=new BmdAtlas((AssetsManager.Instance.getEmbedResource(roleClass) as Bitmap).bitmapData,XML(AssetsManager.Instance.getEmbedResource(roleData)));
			var grid:IsoGrid=new IsoGrid();
			grid.cellSize=30;
			grid.showOrigin=true;
			grid.setGridSize(24,24);
			
			

			var scene:IsoScene=new IsoScene();
			scene.hostContainer=this;
			
			scene.addChild(new BG());
			
			scene.addChild(grid);
			
			role=new RoleView("Role");
			scene.addChild(role);
			var pt:Pt=IsoMath.screenToIso(new Pt(mapData.bgWidth>>1,mapData.bgHeight-mapData.cellSize*mapData.gridCols>>1));
			
			role.moveBy(pt.x,pt.y,pt.z);
//			grid.moveBy(pt.x,pt.y,pt.z);
//			scene.render();

			var view:IsoView=new IsoView();
			this.addChild(view);
			view.addScene(scene);
//			view.setSize(stage.stageWidth,stage.stageHeight);
			view.setSize(mapData.bgWidth,mapData.bgHeight);
			view.panBy(mapData.bgWidth>>1,mapData.bgHeight>>1);

//			view.render();
			juggler.add(role);
			role.MapData=mapData;
			scene.render();
		//	var tile:Tile=mapData.getTilesByData("1")[0];
		//	var ptt:Point=mapData.GridToScreen(new Point(tile.getXIndex(),tile.getZIndex()));
//			role.move(ptt.x,ptt.y);
	//		role.moveTo(0,00,0);
	//		role.render();
//			role.setPosition(tile.getXIndex(),tile.getZIndex());
//			trace(tile.getXIndex(),tile.getZIndex());
			mLastFrameTimestamp = getTimer() / 1000.0;
			stage.removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			stage.addEventListener(Event.ENTER_FRAME,onEnterFrame);
			stage.addEventListener(MouseEvent.CLICK,onClick);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
		}
		
		private function onClick(e:MouseEvent):void
		{
			var p3d:Point=role.MapData.screenToGrid(new Point(e.stageX,e.stageY));
			trace(p3d.x,p3d.y);
			
			if(!role.MapData.getPointOverRide(p3d.x,p3d.y))
			{
				var star:AStar=new AStar(role.MapData);
				star.findPath(role.gridX,role.gridY,p3d.x,p3d.y,conditions);
				role.WalkPath=star.Path;
				role.StartMove();
				role.setPosition(p3d.x,p3d.y);
			}
		}
		
		private function conditions(tile:Tile):Boolean
		{
			return true;
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			switch(e.keyCode) 
			{ 
				case Keyboard.LEFT: 
					role.ActionType =AnimationConst.FIGHT; 
					break; 
				case Keyboard.RIGHT: 
					role.ActionType =AnimationConst.HURT; 
					break; 
				case Keyboard.UP: 
					role.ActionType =AnimationConst.STOP; 
					break; 
				case Keyboard.DOWN: 
					role.ActionType =AnimationConst.WALK; 
					break; 
			} 
		}
		
		private function advanceTime():void
		{
			var now:Number = getTimer() / 1000.0;
			var passedTime:Number = now - mLastFrameTimestamp;
			mLastFrameTimestamp = now;
			
			juggler.advanceTime(passedTime);
			
			trace(role.XOffset,role.YOffset);
		}
		
		private function onEnterFrame(e:Event):void
		{
			advanceTime();
		}
	}
}
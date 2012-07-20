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
	import com.jfw.engine.motion.AnimationConst;
	import com.jfw.engine.isolib.map.consts.DirectionConst;
	import com.jfw.engine.isolib.map.data.AStar;
	import com.jfw.engine.isolib.map.data.IMapData;
	import com.jfw.engine.isolib.map.data.MapData;
	import com.jfw.engine.isolib.map.data.Tile;
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
		private var mapData:IMapData=null;
		
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
			
			role=new RoleView("Role");
			


			
			role.MapData=mapData;
			role.setPosition(0,0);

			juggler.add(role);
			
			mLastFrameTimestamp=getTimer() / 1000.0;
			
			stage.addEventListener(Event.ENTER_FRAME,onEnterFrame);
			stage.addEventListener(MouseEvent.CLICK,onClick);
			
			
		}
		
		private function onClick(e:MouseEvent):void
		{
			var p:Point=mapData.screenToGrid(new Point(e.stageX,e.stageY));
			trace(p.x,p.y);
			role.walkTo(p.x,p.y);
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
		}
		
		private function onEnterFrame(e:Event):void
		{
			advanceTime();
		}
	}
}
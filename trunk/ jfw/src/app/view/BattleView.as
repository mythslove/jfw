package app.view
{
	import app.control.events.LoadingEvent;
	import app.model.BattleModel;
	
	import com.jfw.engine.animation.Juggler;
	import com.jfw.engine.core.base.Core;
	import com.jfw.engine.core.data.IStruct;
	import com.jfw.engine.core.mvc.view.BView;
	import com.jfw.engine.isolib.map.consts.DirectionConst;
	import com.jfw.engine.isolib.map.data.Tile;
	
	import examples.animation.RoleView;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.ui.KeyboardType;
	import flash.utils.getTimer;
	
	/**
	 * 地图场景
	 * @author jianzi
	 * 
	 */	
	public class BattleView extends BView
	{
		private var battleModel:BattleModel=null;
		private var juggler:Juggler=null;
		private var mLastFrameTimestamp:Number;
		private var roleArr:Array=null;
		
		public function BattleView(mapContainer:DisplayObjectContainer,data:IStruct=null)
		{
			super(data);
			sendEvent( LoadingEvent.LOADING_HIDE );
			
			if( mapContainer )
				mapContainer.addChild( this );
			
			roleArr=[];
			
			battleModel=Core.getInstance().retModel("BattleModel") as BattleModel;
			this.addChild(battleModel.mapBG);
			
			juggler=new Juggler();
			mLastFrameTimestamp=getTimer() / 1000.0;
			
			for(var k:int=0;k<500;k++)
			{
				var role:RoleView=battleModel.createRole("10006");
				var toX:int=Math.round(Math.random()*23);
				var toY:int=Math.round(Math.random()*23);
				role.MapData=battleModel.mapdata;
				role.setPosition(toX,toY);
				this.addChild(role);
				roleArr.push(role)
				juggler.add(role);
				role.walkTo(11,11);
			}

			this.addEventListener(Event.ENTER_FRAME,onEnterFrame);
			this.addEventListener(MouseEvent.CLICK,onClick);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
			
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			if(e.keyCode==Keyboard.DOWN)
				(roleArr[0] as RoleView).Direction=DirectionConst.LEFTDOWN;
			else if(e.keyCode==Keyboard.UP)
				(roleArr[0] as RoleView).Direction=DirectionConst.RIGHTUP;
		}
		
		private function onClick(e:MouseEvent):void
		{
			var p:Point=battleModel.mapdata.screenToGrid(new Point(e.stageX,e.stageY));
			trace(p.x,p.y);
			(roleArr[0] as RoleView).walkTo(p.x,p.y);
		}
		
		private function conditions(tile:Tile):Boolean
		{
			return true;
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
package app.view
{
	import app.battle.ProcedureManager;
	import app.control.events.LoadingEvent;
	import app.manager.AnimationManager;
	import app.model.BattleModel;
	import app.timer.CountdownTimer;
	import app.timer.DalayCall;
	import app.timer.SubTimer;
	import app.timer.TimerManager;
	import app.vo.RoundVO;
	import app.vo.TeamVO;
	
	import com.jfw.engine.AbsGameWorld;
	import com.jfw.engine.animation.Juggler;
	import com.jfw.engine.core.base.Core;
	import com.jfw.engine.core.data.IStruct;
	import com.jfw.engine.core.mvc.view.BView;
	import com.jfw.engine.isolib.map.consts.DirectionConst;
	import com.jfw.engine.isolib.map.data.Tile;
	import com.jfw.engine.utils.HitTest;
	
	import examples.animation.RoleView;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
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
		private var manager:AnimationManager=null;
		private var roleArr:Array=null;
		private var isMoving:Boolean=false;
		private var text:TextField=null;
		private var count:int=0;
		private var roundArr:Vector.<RoundVO>;
		private var countdownTimer:CountdownTimer=null;
		
		public function BattleView(mapContainer:DisplayObjectContainer,data:IStruct=null)
		{
			super(data);
			sendEvent( LoadingEvent.LOADING_HIDE );
			
			if( mapContainer )
				mapContainer.addChild( this );
			
			roundArr=new Vector.<RoundVO>();
			
			for(var i:int=0;i<5;i++)
			{
				var round:RoundVO=new RoundVO();	
				round.dalay=3;
				round.team.dalay=1;
				
				for(var j:int=0;j<3;j++)
				{
					round.team.members.push("10006");
				}

				roundArr.push(round);
			}
			
			roleArr=[];
			battleModel=Core.getInstance().retModel("BattleModel") as BattleModel;
			this.addChild(battleModel.mapBG);
			
			manager=AnimationManager.Instance(24);
	//		TimerManager.Instance().changeSpeed(100);
			
//			ProcedureManager.Instance().setData(roundArr,onTeam,onMember);
//			ProcedureManager.Instance().start();
//			countdownTimer=new CountdownTimer(5,onStep,onComplete);
//			countdownTimer.start();

		}
		
		private function onStep():void
		{
			trace(countdownTimer.CurrSecond);
		}
		
		private function onComplete():void
		{
			trace("complete");
		}
			
		private function onTeam():void
		{
			trace("team");
		}
		
		private function onMember():void
		{
			trace("member");
			var id:String=ProcedureManager.Instance().CurrMember;
			var role:RoleView=battleModel.createRole(id);
			var toX:int=0;//Math.round(Math.random()*23);
			var toY:int=11;//Math.round(Math.random()*23);
			role.MapData=battleModel.mapdata;
			role.setPosition(toX,toY);
			this.addChild(role);
			roleArr.push(role)
			manager.add(role);
			role.walkTo(Math.round(Math.random()*23),Math.round(Math.random()*23));
		}
		
		//			roleArr=[];
		//			
		//			battleModel=Core.getInstance().retModel("BattleModel") as BattleModel;
		//			this.addChild(battleModel.mapBG);
		//			
		//			manager=AnimationManager.Instance(100);
		//
		//			for(var i:int=0;i<2;i++)
		//			{
		//				var role:RoleView=battleModel.createRole("10006");
		//				var toX:int=Math.round(Math.random()*23);
		//				var toY:int=Math.round(Math.random()*23);
		//				role.MapData=battleModel.mapdata;
		//				role.setPosition(toX,toY);
		//				role.alpha=0.5;
		//				this.addChild(role);
		//				roleArr.push(role)
		//				manager.add(role);
		//			}
		//			//role.walkTo(0,11);
		//	
		//			this.addEventListener(MouseEvent.CLICK,onClick);
		//			this.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
		//			this.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
		//			stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
		//			this.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
		//			
		//
		//			text=new TextField();
		//			this.addChildAt(text,this.numChildren-1);
		//			text.x=200;
		//			text.y=200;
		//			TimerManager.Instance().changeSpeed();
		//			var timer:SubTimer=new SubTimer(10);
		//			timer.addEventListener(SubTimerEvent.TIME_STEP,onTimer);
		//			timer.start();
		
//		private function onTimer(e:SubTimerEvent):void
//		{
//			trace(count++);
//		}
//		
//		private function onKeyDown(e:KeyboardEvent):void
//		{
//			if(manager.isPause)
//				manager.Resume();
//			else
//				manager.Pause();
//		}
//		
//		private function onClick(e:MouseEvent):void
//		{
////			var p:Point=battleModel.mapdata.screenToGrid(new Point(e.stageX,e.stageY));
////			trace(p.x,p.y);
////			(roleArr[0] as RoleView).walkTo(p.x,p.y);
//		}
//		
//		private function onMouseDown(e:MouseEvent):void
//		{
//			(roleArr[0] as RoleView).startDrag();
//			this.isMoving=true;
//		}
//		
//		private function onMouseUp(e:MouseEvent):void
//		{
//			(roleArr[0] as RoleView).stopDrag();
//			this.isMoving=false;
//		}
//		
//		private function onMouseMove(e:MouseEvent):void
//		{	
//			if(this.isMoving)
//			{
//				if(HitTest.hitTestObject(roleArr[0],roleArr[1],0.4))
//				{
//					(roleArr[1] as RoleView).alpha=0.3;
//				}
//				else
//				{
//					(roleArr[1] as RoleView).alpha=0.5;
//				}
//			}
//		}
	}
}
package app.mvc.view
{
	import app.battle.buff.Buff;
	import app.battle.buff.BuffConst;
	import app.battle.buff.BuffManager;
	import app.battle.effect.BaseEffect;
	import app.battle.interfaces.IRole;
	import app.battle.magic.SkillItem;
	import app.battle.manager.ProcedureManager;
	import app.battle.role.Role;
	import app.battle.timer.CountdownTimer;
	import app.battle.timer.DalayCall;
	import app.battle.timer.SubTimer;
	import app.battle.timer.TimerManager;
	import app.battle.utils.SphereMetrics;
	import app.manager.AnimationManager;
	import app.manager.ResourceManager;
	import app.mvc.control.events.LoadingEvent;
	import app.mvc.model.BattleModel;
	import app.vo.RoundVO;
	import app.vo.SkillVO;
	import app.vo.TeamVO;
	
	import com.jfw.engine.AbsGameWorld;
	import com.jfw.engine.animation.Juggler;
	import com.jfw.engine.core.base.Core;
	import com.jfw.engine.core.data.IStruct;
	import com.jfw.engine.core.mvc.view.BView;
	import com.jfw.engine.isolib.map.consts.DirectionConst;
	import com.jfw.engine.isolib.map.data.Tile;
	import com.jfw.engine.motion.BaseAnimation;
	import com.jfw.engine.utils.HitTest;
	
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
		private var role:IRole=null;
		
		public function BattleView(mapContainer:DisplayObjectContainer,data:IStruct=null)
		{
			super(data);
			sendEvent( LoadingEvent.LOADING_HIDE );
			
			if( mapContainer )
				mapContainer.addChild( this );
			
//			role=new Role("10006");
//			var buff:Buff=new Buff(BuffConst.ACT_DOWN,5,0,role,10006);
//			buff.onTimerCallBack=onTimeCallBack;
//			role.getBuffManager().addBuff(buff);
			

		
			roundArr=new Vector.<RoundVO>();
	
			for(var i:int=0;i<1;i++)
			{
				var round:RoundVO=new RoundVO();	
				round.dalay=3;
				round.team.dalay=1;
				
				for(var j:int=0;j<1;j++)
				{
					round.team.members.push("10006");
				}
				
				roundArr.push(round);
			}
//			
			roleArr=[];
			battleModel=Core.getInstance().retModel("BattleModel") as BattleModel;
			this.addChild(battleModel.mapBG);
//			
			manager=AnimationManager.Instance;
			manager.Speed=1;
			TimerManager.Instance.Speed=5;
//
			ProcedureManager.Instance().setData(roundArr,onTeam,onMember);
			ProcedureManager.Instance().start();
			
//			countdownTimer=new CountdownTimer(5,onStep,onComplete);
//			countdownTimer.start();
			
//			var effect:BaseEffect=new BaseEffect('20001',true);
//			this.addChild(effect);
//			effect.play();
//			effect.move(0,0);
//			manager.Add(effect);
//			var source:String="-1,1|2,-2|-2,1|1,2";
//			var arr:Vector.<Tile>=SphereMetrics.getSphereOfMagic(battleModel.mapdata,source,3,3,DirectionConst.RIGHT);
//			var item:SkillItem=new SkillItem(null,battleModel.mapdata);
//			this.addChild(item);
//			item.play();
//			item.setPosition(0,0);
//			manager.Add(item);
		}
		
		private function onTimeCallBack(role:IRole,buff:Buff,value:Number):void
		{
			trace(11111);
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
			var role:IRole=battleModel.createRole(id);
			var toX:int=0;//Math.round(Math.random()*23);
			var toY:int=11;//Math.round(Math.random()*23);
			role.MapData=battleModel.mapdata;
			role.setPosition(toX,toY);
			this.addChild(role.Instance);
			roleArr.push(role)
			manager.Add(role);
			role.Speed=1;
			role.walkTo(Math.round(Math.random()*23),Math.round(Math.random()*23));
		}
	}
}
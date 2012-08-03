package app.statemachine.states
{
	import app.battle.battle.RoomManager;
	import app.battle.message.QueueManager;
	import app.charactor.Charactor;
	import app.globals.consts.CharactorConst;
	import app.globals.consts.ItemConst;
	import app.globals.consts.MapConst;
	import app.globals.events.GameEvent;
	import app.globals.interfaces.IBattleItem;
	import app.globals.interfaces.ICharactor;
	import app.globals.interfaces.IWalkPath;
	import app.mvc.models.manager.BattleItemManager;
	import app.mvc.models.manager.BattleMagicManager;
	import app.mvc.models.manager.BattleManager;
	import app.mvc.models.manager.BattleMonsterManager;
	import app.mvc.models.manager.BattleNpcManager;
	import app.mvc.models.manager.StatisticManager;
	import app.mvc.models.manager.TeamManager;
	import app.mvc.models.res.BattleDataProxy;
	import app.mvc.views.buff.Buff;
	import app.mvc.views.buff.BuffConst;
	import app.mvc.views.game.mapItem.base.BaseBattleItem;
	import app.mvc.views.game.mapItem.base.BaseItem;
	import app.mvc.views.game.mapItem.item.PortalItem;
	import app.mvc.views.game.mapItem.item.StopItem;
	import app.mvc.views.game.mapItem.magic.MagicItem;
	import app.statemachine.StateConst;
	import app.statemachine.StateMachine;
	
	import com.pianfeng.engine.animation.manager.AnimationManager;
	import com.pianfeng.engine.animation.manager.IAnimationable;
	import com.pianfeng.engine.animation.motion.BevelLineMotion;
	import com.pianfeng.engine.animation.motion.IMotionable;
	import com.pianfeng.engine.global.events.PlayAnimationEvent;
	import com.pianfeng.engine.isolib.map.data.MapData;
	import com.pianfeng.engine.isolib.map.data.Tile;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;

	public class BaseState implements IState
	{
		public var stateName:String;
		public var npc:ICharactor;
		public var stateMachine:StateMachine;
		
		public var battleDataProxy:BattleDataProxy;
		protected var battleManager:BattleManager;
		protected var teamManager:TeamManager;
		protected var battleItemManager:BattleItemManager;
		protected var battleMagicManager:BattleMagicManager;
		protected var battleMonsterManager:BattleMonsterManager;
		protected var battleNpcManager:BattleNpcManager;
		protected var queueManager:QueueManager;
		protected var roomManager:RoomManager;	
		protected var statisticManager:StatisticManager;//战斗结果统计管理器
		
		protected var mapData:MapData;	
		protected var currentItem:IBattleItem=null;
		protected var currentMagic:IBattleItem=null;
		protected var currentTile:Tile=null;
		protected var currentMonster:ICharactor=null;
		protected var mainRoadPath:Array=null;//主路径
		protected var master:ICharactor=null;
	
		public function BaseState(stateMachine:StateMachine,npc:ICharactor=null,battleDataProxy:BattleDataProxy=null)
		{
			this.stateMachine=stateMachine;
			this.battleManager=BattleManager.getInstance();
			this.teamManager=TeamManager.getInstance();
			this.battleItemManager=BattleItemManager.getInstance();
			this.battleMagicManager=BattleMagicManager.getInstance();
			this.battleMonsterManager=BattleMonsterManager.getInstance();
			this.battleNpcManager=BattleNpcManager.getInstance();
			this.queueManager=QueueManager.getInstance();
			this.roomManager=RoomManager.getInstance();
			this.statisticManager=StatisticManager.getInstance();
		}
		
		public function getName():String
		{
			return this.stateName;
		}
//---------------------------------处理方法,需要在子类中重写--------------------------------------------------------------------------------------------------	
		/**
		 *处理状态判断分支 
		 * 需要子类重写
		 */		
		public function execute():void
		{
			
		}
		/**
		 *退出状态 
		 * 此状态一般为由外部改变的持续性状态,比如战斗,调整状态
		 */		
		public function exit():void
		{
			
		}
		/**
		 *恢复上一个状态 
		 * 
		 */		
		public function reset():void
		{
			npc.NpcState=npc.OldState;
			this.getOldPath();
			//this.getPathToEnd();
		}
//-----------------------------------------检查条件----------------------------------------------------------------------------------------------------------//
		/**
		 *检查是否有法宝道具
		 * @return 
		 * 
		 */		
		protected function checkMagicItem():Boolean
		{
			this.currentMagic=this.battleMagicManager.getItemAt(npc.GridX,npc.GridY);//获取当前位置的道具,无道具则返回null
			return currentMagic!=null;
		}
		/**
		 *是否有法术道具 
		 * @return 
		 * 
		 */		
		protected function checkItem():Boolean
		{
			this.currentItem=this.battleItemManager.getItemAt(npc.GridX,npc.GridY);//获取当前位置的道具,无道具则返回null
			return currentItem!=null;
		}
		/**
		 *是否为转向 
		 * @return 
		 * 
		 */		
		protected function checkCorner():Boolean
		{
			return currentItem.Type==ItemConst.SPELL_TURN_CORNER;
		}
		/**
		 *是否为停止道具 
		 * @return 
		 * 
		 */		
		protected function checkStopWalking():Boolean
		{
			return currentItem.Type==ItemConst.SPELL_STOP_WALKING;
		}
		/**
		 *是否为传送门 
		 * @return 
		 * 
		 */		
		protected function checkPortal():Boolean
		{
			return currentItem.Type==ItemConst.SPELL_SEND_AWAY;
		}
		/**
		 *判断母门
		 * @return 
		 * 
		 */		
		protected function checkMainPortal():Boolean
		{	
			var otherPortal:PortalItem=battleItemManager.getItemByID((currentItem as PortalItem).PortalID) as PortalItem;
			
			if((currentItem as PortalItem).PassTimes==0&&otherPortal.PassTimes==0)
				return true;
			else
				return false;	
		}
		/**
		 *判断子门
		 * @return 
		 * 
		 */		
		protected function checkMinPortal():Boolean
		{	
			var otherPortal:PortalItem=battleItemManager.getItemByID((currentItem as PortalItem).PortalID) as PortalItem;
			
			if((currentItem as PortalItem).PassTimes==0&&otherPortal.PassTimes==1)
				return true;
			else
				return false;
		}
		/**
		 * 检查停止状态是否结束 
		 * @return 判断自己是否有停止buff
		 * true 为结束
		 */		
		protected function checkStopComplete():Boolean
		{
			return !npc.getBuffManager().hasBuffOfType(BuffConst.STOP_ACTION);
		}
		/**
		 *检查法术作用对象索引是否与某队员索引相同
		 * @return 
		 * 
		 */		
		protected function checkActionIndex(actionIndex:int=0):Boolean
		{
			if(npc.IsJoinedTeam)
				return this.teamManager.getNpcIndex(npc)==actionIndex;
			else
				return true;
		}
		/**
		 *判断当前块是主路还是支路 
		 * @return 主路为true,支路为false
		 * 此方法主要用于被传送回之后做判断
		 */		
		protected function checkMainOrMinRoad():Boolean
		{
			var tile:Tile=npc.CurrTile;
			
			if(tile.getData()==MapConst.SIDE_ROAD||tile.getData()==MapConst.MAIN_ROAD)
				return true;
			else if(tile.getData()==MapConst.MIN_ROAD)
				return false;
			
			return false;
		}
		/**
		 *检查像素坐标是否与格子坐标相等(格子中心点) 
		 * return Boolean
		 */	
		protected function checkGridPoint():Boolean
		{
			var tile:Tile=npc.CurrTile;		
			this.mapData=this.battleDataProxy.mapData;
			var p2d:Point=mapData.GridToScreen(new Point(npc.GridX,npc.GridY));
			
			return npc.ScrX==p2d.x&&npc.ScrY==p2d.y;
		}	
		/**
		 *检查npc是否死亡,战斗结果
		 * @return 
		 * 
		 */		
		protected function checkNpcDied():Boolean
		{
			return npc.Status==CharactorConst.DIED;
		}
		/**
		 *检测是否与队伍发生碰撞,准备入队 
		 * @return 
		 * 
		 */		
		protected function checkJoinTeamReady():Boolean
		{
			return this.teamManager.isJoinTeamReady(npc);
		}
		/**
		 * 检查自身速度是否异常
		 * @return true 为异常false为正常
		 * 
		 */		
		protected function checkSpeedException():Boolean
		{
			var char:Charactor=npc as Charactor;
			return char.checkSpeedException();
		}
		/**
		 * 检查队长是否死亡
		 * @return 
		 * 
		 */		
		protected function checkMasterDied():Boolean
		{
			var mmaster:ICharactor=this.getMaster();
			
			if(mmaster)
				return mmaster.CurrHP<=0;
			else
				return false;
		}
		/**
		 *检查自己是否死亡 
		 * @return 
		 * 
		 */		
		protected function checkSelfDied():Boolean
		{
			return npc.CurrHP<=0;
		}
		/**
		 *检查队伍是否在战斗中 
		 * @return 
		 * 
		 */		
		protected function checkTeamFighting():Boolean
		{
			return this.teamManager.isTeamFighting();
		}
		/**
		 *检查队伍是否在调整中
		 * @return 
		 * 
		 */		
		protected function checkTeamAdjusting():Boolean
		{
			return this.teamManager.isTeamAdjusting();
		}
		/**
		 *检查npc是否在队伍中
		 * @return 
		 * 
		 */		
		protected function checkIsJoinedTeam():Boolean
		{
			return npc.IsJoinedTeam;
		}
		/**
		 *检查是否遇到闲着的妖将 
		 * @return 
		 * 
		 */		
		protected function checkIdleMonster():Boolean
		{
			var monster:ICharactor=this.getMonster();
			
			if(npc.CurrHP<=0)
				return false;
			
			if(monster)
				if(monster.NpcState.getName()==StateConst.MONSTER_NOMAL_STATE)
					return true;
			
			return false;
		}
		/**
		 *判断是否是终点(胜利)
		 * 
		 * @return 
		 * 
		 */		
		protected function checkGameOver():Boolean
		{
			var tile:Tile=npc.CurrTile;
			return tile.getData()==MapConst.END_ROAD;
		}	
//--------这些方法中包含npc状态的设置,和(或)寻路方式-----------------------------------------------------------------------------------------------
		/**
		 *准备出发状态处理方法 
		 * 
		 */		
		protected function executeReadyToGo():void
		{
			this.getPathToEnd();
		}
		/**
		 *处理传送到岛上的处理方法
		 * 
		 */	
		protected function executeIsLand():void
		{
			var portal:PortalItem=currentItem as PortalItem;
			var otherPortal:PortalItem=battleItemManager.getItemByID((currentItem as PortalItem).PortalID) as PortalItem;
			
			this.mapData=this.battleDataProxy.mapData;
			
			portal.PassTimes=1;//让母门开启
			portal.OldDirectTile=npc.OldTile;//记录旧路径以便传送回到支路时选择方向
			
			this.stopWalking();					
			npc.IsJoinedTeam=false;//设置离队,队伍管理器调整队形	
			//派发一个离队事件给队伍管理器
			npc.dispatchEvent(new GameEvent(GameEvent.LEAVE_TEAM,npc));
			
			var p2d:Point=mapData.GridToScreen(new Point(otherPortal.GridX,otherPortal.GridY));//直接移动坐标
			npc.move(p2d.x,p2d.y);
			npc.GridX=portal.GridX;
			npc.GridY=portal.GridY;
			npc.OldTile=null;	
			npc.CurrTile=mapData.getTileAtGrid(otherPortal.GridX,otherPortal.GridY);//初始点为对应门的格子对应的块
			
			this.getNormalPath();//寻找路径继续行走
		}
		/**
		 *遇到子门被传送回的处理方法 
		 * 
		 */		
		protected function executeReturnBack():void
		{
			var portal:PortalItem=currentItem as PortalItem;
			var otherPortal:PortalItem=battleItemManager.getItemByID((currentItem as PortalItem).PortalID) as PortalItem;
			
			this.mapData=this.battleDataProxy.mapData;
			
			portal.PassTimes=1;//设置当前门为不可碰撞
			
			this.battleItemManager.removeItem(portal);//此处播放传送门消失动画,并且从列表中删除
			this.battleItemManager.removeItem(otherPortal);
			portal.parent.removeChild(portal);
			otherPortal.parent.removeChild(otherPortal);
			
			this.stopWalking();	
			
			var p2d:Point=mapData.GridToScreen(new Point(otherPortal.GridX,otherPortal.GridY));//直接移动坐标
			npc.move(p2d.x,p2d.y);
			npc.GridX=portal.GridX;
			npc.GridY=portal.GridY;
			npc.OldTile=otherPortal.OldDirectTile;//此处需要旧位置
			npc.CurrTile=mapData.getTileAtGrid(otherPortal.GridX,otherPortal.GridY);
			//后续判断到主路还是支路
		}
		/**
		 *刚回到主路 
		 * 
		 */		
		protected function executeBackToMainRoad():void
		{
			this.executeDirection();//此方法后边根查询队长方法
		}
		/**
		 *被传送回支路 
		 * 
		 */		
		protected function executeBackToMinRoad():void
		{		
			this.getPathToCorner();//从当前位置继续找支路走
		}
		/**
		 *被转向到支路 
		 *组队情况 
		 */		
		protected function executeTurningCorner():void
		{
			if(npc.IsJoinedTeam)
			{
				npc.IsJoinedTeam=false;//派发一个离队事件给队伍管理器	
				npc.dispatchEvent(new GameEvent(GameEvent.LEAVE_TEAM,npc,true,true));
			}
			
			this.battleItemManager.removeItem(this.currentItem);
			this.currentItem.Instance.parent.removeChild(this.currentItem.Instance);
			this.getPathToCorner();//望支路走
		}
		/**
		 * 队长忽略无视法术 
		 * 
		 */		
		protected function executeIgnoreItem():void
		{
			npc.dispatchEvent(new GameEvent(GameEvent.AGAINST_DEFITEM,{char:npc,item:this.currentItem},true,true));//派发遇到法术事件
			this.battleItemManager.removeItem(this.currentItem);
			this.currentItem.Instance.parent.removeChild(this.currentItem.Instance);
		}
		/**
		 *处理被暂停状态 
		 * 
		 */		
		protected function executeStopWalking():void
		{		
			var stopItem:StopItem=this.currentItem as StopItem;
			var buff:Buff=new Buff(BuffConst.STOP_ACTION,stopItem.DT,0,npc);
			npc.getBuffManager().addBuff(buff);
			
			if(npc.IsJoinedTeam)
			{
				npc.IsJoinedTeam=false;
				npc.dispatchEvent(new GameEvent(GameEvent.LEAVE_TEAM,npc,true,true));
			}
			
			this.stopWalking();
			npc.Status=CharactorConst.SILENT;
			this.stateMachine.changeState(StateConst.STOP_WALKING_STATE);
			this.battleItemManager.removeItem(this.currentItem);
			this.currentItem.Instance.parent.removeChild(this.currentItem.Instance);
		}
		/**
		 *处理被停止状态结束 
		 * @param evt
		 * 
		 */		
		protected function executeStopComplete():void
		{
			if(npc.NpcState.getName()==StateConst.IS_DIED_STATE)
				return;
			
			if(npc.OldState.getName()==StateConst.WALKING_TOGETHER_STATE)//如果是从队伍中分离出来的则跳到追寻队长状态
				executeDirection();
			else//否则恢复原来状态
				this.reset();
		}
		/**
		 *处理离开队伍 
		 * 
		 */		
		protected function executeLeaveTeam():void
		{
			this.stateMachine.changeState(StateConst.IS_LEFT_TEAM_STATE);
			npc.IsJoinedTeam=false;
			npc.dispatchEvent(new GameEvent(GameEvent.LEAVE_TEAM,npc,true,true));
		}
		/**
		 *被转向到支路 
		 *单独行动时 
		 */		
		protected function executeTurningCornerAlone():void
		{	
			npc.OldTile=null;
			this.battleItemManager.removeItem(currentItem);
			currentItem.Instance.parent.removeChild(currentItem.Instance);
			this.getPathToCorner();//望支路走
		}
		/**
		 * 判断方向,追寻队长
		 * @param tile
		 * 此方法以包含状态设置
		 */		
		protected function executeDirection():void
		{	
			var mainpath:Array=this.getMainPath();
			var npcIndex:int=mainpath.indexOf(npc.CurrTile);//队员在自然坐标系的索引
			
			if(!this.checkMasterDied())
			{
				var firstMember:ICharactor = this.teamManager.getFirstMember();//遇到队长
				var firstMemberIndex:int=mainpath.indexOf(firstMember.CurrTile);//队长在自然坐标系的索引	
				
				this.stateMachine.changeState(StateConst.WALKING_TO_MASTER_STATE);//设置状态为追寻队长
				
				if(npcIndex>firstMemberIndex)//如果队员比队长离终点近,则望起点走
				{
					npc.OldTile=mainpath[npcIndex+1] as Tile;//取根队长方向相反的相邻格子作为路过的格子
					this.getPathToStart(npcIndex);
				}
				else if(npcIndex<=firstMemberIndex)//如果队员比队长离终点远,则望终点走
				{
					npc.OldTile=mainpath[npcIndex-1] as Tile;//取根队长方向相反的相邻格子作为路过的格子
					this.getPathToEnd(npcIndex);
				}		
			}
			else
			{
				this.stateMachine.changeState(StateConst.WALKING_ALONE_STATE);//设置状态为朝向主路
				
				npc.OldTile=mainpath[npcIndex-1] as Tile;//取根队长方向相反的相邻格子作为路过的格子
				this.getPathToEnd(npcIndex);//如果队长死了,则望终点走
			}
		}	
		/**
		 *队长战斗死亡后,其他人的处理方式
		 * 
		 */		
		protected function executeMasterDied():void
		{
			npc.IsJoinedTeam=false;
			npc.dispatchEvent(new GameEvent(GameEvent.LEAVE_TEAM,npc,true,true));//派发离开队伍事件
			//调整自己速度为原来速度
			var npcIndex:int=this.getMainPath().indexOf(npc.CurrTile);//队员在自然坐标系的索引	
			npc.OldTile=this.getMainPath()[npcIndex-1] as Tile;//取根队长方向相反的相邻格子作为路过的格子
			this.getPathToEnd(npcIndex);//如果队长死了,则望终点走
		}	
		/**
		 *处理自己死亡 
		 * 子类里要重写
		 */		
		protected function executeSelfDied():void
		{
			if(npc.Status==CharactorConst.WALK)
				this.stopWalking();
			
			npc.IsJoinedTeam=false;
			npc.Status=CharactorConst.DIED;
			this.stateMachine.changeState(StateConst.IS_DIED_STATE);
			npc.dispatchEvent(new GameEvent(GameEvent.LEAVE_TEAM,npc,true,true));//派发离开队伍事件
		}
		/**
		 * 加入队伍处理办法
		 * 不需要自己寻路,由队伍管理器控制
		 */		
		protected function executeJoinTeam():void
		{
			npc.IsJoinedTeam=true;		
			npc.CurrSpeed=this.getMaster().CurrSpeed;
			npc.dispatchEvent(new GameEvent(GameEvent.ADD_TEAM,npc,true,true));//派发加入队伍事件
		}
		/**
		 * 等待加入队伍处理办法
		 */		
		protected function executeWaitToJoin():void
		{
			this.stopWalking();
		}
		/**
		 *处理单独战斗 
		 * 
		 */		
		protected function executeNpcFight():void
		{	
			var monster:ICharactor=this.getMonster();
			npc.dispatchEvent(new GameEvent(GameEvent.SELF_FIGHT,{char:npc,monster:monster},true,true));
		}	
		/**
		 *队伍遇到战斗
		 * 
		 */		
		protected function executeWaitTeamFighting():void
		{
			var monster:ICharactor=this.getMonster();
			npc.dispatchEvent(new GameEvent(GameEvent.TEAM_FIGHT,{char:npc,monster:monster},true,true));//派发队伍战斗事件
		}	
		/**
		 *默认自由行走 
		 * 
		 */		
		protected function executeAcknowledgeWalk():void
		{
			this.getNormalPath();
		}
		/**
		 *队形调整完成后的处理 
		 * 
		 */		
		protected function executeAdjustTeam():void
		{
			this.getPathToEnd();
		}
		/**
		 *处理遇到法术
		 * 
		 */		
		protected function executeDefItem():void
		{
			npc.dispatchEvent(new GameEvent(GameEvent.AGAINST_DEFITEM,{char:npc,item:this.currentItem},true,true));//派发遇到法术事件
		}
		/**
		 *处理遇到法宝 
		 * 
		 */		
		protected function executeMagicItem():void
		{
			npc.dispatchEvent(new GameEvent(GameEvent.AGAINST_MAGICITEM,{char:npc,item:this.currentMagic as MagicItem},true,true));//派发遇到法宝事件
		}
//---------------------------------获取方法--------------------------------------------------------------------------------------------------			
		/**
		 *得到队长
		 * @return 
		 * 
		 */	
		protected function getMaster():ICharactor
		{
			if(this.master!=null)
				return this.master;
			else
				return battleNpcManager.getMaster();
		}
		/**
		 *判断遇到的妖将 
		 * @return 
		 * 
		 */		
		protected function getMonster():ICharactor
		{
			var walkPath:Array=(npc as IWalkPath).WalkPath
			var index:int=walkPath.indexOf(npc.CurrTile);
			
			if(index==walkPath.length-1)
				return null;

			var tile:Tile=walkPath[index+1] as Tile;
			this.currentMonster=battleMonsterManager.getMemberAtGrid(tile.getXIndex(),tile.getZIndex());

			if(this.currentMonster!=null)
				return this.currentMonster;
			
			return null
		}
		/**
		 *得到主路径 
		 * @return 
		 * 
		 */		
		protected function getMainPath():Array
		{
			if(this.mainRoadPath!=null)
				return this.mainRoadPath;
			
			this.mapData=this.battleDataProxy.mapData;
			var startTile:Tile=mapData.getTilesByData(MapConst.START_ROAD)[0];
			this.mainRoadPath=MapData.getPath(mapData,startTile.getXIndex(),startTile.getZIndex(),findPathEndCallBack,findPathCallBack);
			return this.mainRoadPath;
		}
		/**
		 *强制中断人物移动 
		 * 
		 */		
		protected function stopWalking():void
		{
			if(npc.Status==CharactorConst.WALK)
				AnimationManager.getInstance().stopEnterFrame(npc);
		}	
		/**
		 *强制中断队伍移动 
		 * 
		 */		
		protected function stopTeamWalking():void
		{
			for each(var char:ICharactor in this.teamManager.charArr)
			{
				AnimationManager.getInstance().stopEnterFrame(npc);
				npc.Status=CharactorConst.SILENT;	
			}
		}
		/**
		 *触发道具望支路走 
		 * 
		 */		
		protected function getPathToCorner():void
		{
			var tile:Tile=npc.CurrTile;
			
			this.mapData=this.battleDataProxy.mapData;
			npc.WalkPath=MapData.getPath(mapData,tile.getXIndex(),tile.getZIndex(),endCondition1,siftCondition1,npc.OldTile);
			this.addWalk(npc);
		}
		/**
		 *从停止状态恢复行走 
		 * 
		 */		
		protected function getOldPath():void
		{
			if(this.checkIsJoinedTeam())
				npc.WalkPath=this.getMainPath().slice(this.getMainPath().indexOf(npc.CurrTile));
			else
				npc.WalkPath=npc.WalkPath.slice(npc.WalkPath.indexOf(npc.CurrTile));
			
			this.addWalk(npc);
		}
		/**
		 * 当前位置开始向起点走
		 * 
		 */		
		protected function getPathToStart(npcIndex:int=0):void
		{
			var tile:Tile=npc.CurrTile;
			this.mapData=this.battleDataProxy.mapData;
			npc.OldTile=this.getMainPath()[npcIndex+1] as Tile;//取根队长方向相反的相邻格子作为路过的格子
			npc.WalkPath=MapData.getPath(mapData,tile.getXIndex(),tile.getZIndex(),endCondition31,siftCondition31,npc.OldTile);
			this.addWalk(npc);
		}
		/**
		 * 当前位置开始向终点走
		 * 
		 */		
		protected function getPathToEnd(npcIndex:int=-1):void
		{
			this.mapData=this.battleDataProxy.mapData;
			npc.CurrTile=this.mapData.getTileAtGrid(npc.GridX,npc.GridY);	
			
			if(npcIndex==-1)
				npcIndex=this.getMainPath().indexOf(npc.CurrTile);

			var tile:Tile=npc.CurrTile;	
			npc.OldTile=npcIndex==0?null:this.getMainPath()[npcIndex-1] as Tile;//取根队长方向相反的相邻格子作为路过的格子
			npc.WalkPath=MapData.getPath(mapData,tile.getXIndex(),tile.getZIndex(),endCondition32,siftCondition32,npc.OldTile);
			this.addWalk(npc);
		}
		/**
		 *默认行走方式 此方法只能用在当前路块为非5号和6号路上的时候
		 */		
		protected function getNormalPath():void
		{	
			var tile:Tile=npc.CurrTile;
			this.mapData=this.battleDataProxy.mapData;
			
			switch(tile.getData())
			{	
				case MapConst.SIDE_ROAD://在岔路口,需要判断队长位置			
					npc.WalkPath=MapData.getPath(mapData,tile.getXIndex(),tile.getZIndex(),endCondition2,siftCondition2,npc.OldTile);
					this.addWalk(npc);																						
					break;		
				case MapConst.ISLAND_ROAD://在岛图路块上					
					npc.WalkPath=MapData.getPath(mapData,tile.getXIndex(),tile.getZIndex(),endCondition4,siftCondition4,null);
					this.addWalk(npc);	
					break;			
				case MapConst.DOOMED_ROAD://在死胡同			
					npc.WalkPath=MapData.getPath(mapData,tile.getXIndex(),tile.getZIndex(),endCondition5,siftCondition5,null);
					this.addWalk(npc);											
					break;		
				default:
					break;//其他路块,直接忽略	
			}
		}
//-----------------------处理函数------------------------------------------------------------------------------------------------------------------
		/**
		 *遇到转向的处理办法 
		 * @param tile
		 * @return 
		 * 
		 */		
		protected function endCondition1(tile:Tile):Boolean
		{
			if(tile.getData()==MapConst.SIDE_ROAD||tile.getData()==MapConst.DOOMED_ROAD)
				return true;
			else
				return false;
		}
		
		protected function siftCondition1(tile:Tile):Boolean
		{
			if(tile.getData()==MapConst.SIDE_ROAD||tile.getData()==MapConst.DOOMED_ROAD||tile.getData()==MapConst.MIN_ROAD)
				return true;
			else
				return false;
		}
		/**
		 *开始路块上 
		 * @param tile
		 * @return 
		 * 
		 */		
		protected function endCondition2(tile:Tile):Boolean
		{
			if(tile.getData()==MapConst.SIDE_ROAD||tile.getData()==MapConst.END_ROAD)
				return true;
			else
				return false;
		}

		protected function siftCondition2(tile:Tile):Boolean
		{
			if(tile.getData()==MapConst.STAND_ROAD||tile.getData()==MapConst.SIDE_ROAD||tile.getData()==MapConst.END_ROAD||tile.getData()==MapConst.MAIN_ROAD)
				return true;
			else
				return false;
		}
		/**
		 * 在岔路口,需要判断队长位置，如果队员比队长离终点近,则望起点走
		 * @param tile
		 * @return 
		 * 
		 */	
		protected function endCondition31(tile:Tile):Boolean
		{
			if(tile.getData()==MapConst.START_ROAD)
				return true;
			else
				return false;
		}
		
		protected function siftCondition31(tile:Tile):Boolean
		{
			if(tile.getData()==MapConst.SIDE_ROAD||tile.getData()==MapConst.STAND_ROAD||tile.getData()==MapConst.START_ROAD||tile.getData()==MapConst.MAIN_ROAD)
				return true;
			else
				return false;
		}
		/**
		 * 如果队员比队长离终点远,则望终点走
		 * @param tile
		 * @return 
		 * 
		 */	
		protected function endCondition32(tile:Tile):Boolean
		{
			if(tile.getData()==MapConst.END_ROAD)
				return true;
			else
				return false;
		}
		
		protected function siftCondition32(tile:Tile):Boolean
		{
			if(tile.getData()==MapConst.SIDE_ROAD||tile.getData()==MapConst.STAND_ROAD||tile.getData()==MapConst.END_ROAD||tile.getData()==MapConst.MAIN_ROAD)
				return true;
			else
				return false;
		}
		/**
		 *在岛上 
		 * @param tile
		 * @return 
		 * 
		 */		
		protected function endCondition4(tile:Tile):Boolean
		{
			if(tile.getData()==MapConst.ISLAND_ROAD)
				return true;
			else
				return false;
		}
	
		protected function siftCondition4(tile:Tile):Boolean
		{
			if(tile.getData()==MapConst.ISLAND_ROAD||tile.getData()==MapConst.MIN_ROAD)
				return true;
			else
				return false;
		}
		/**
		 *死胡同 
		 * @param tile
		 * @return 
		 * 
		 */		
		protected function endCondition5(tile:Tile):Boolean
		{
			if(tile.getData()==MapConst.SIDE_ROAD)
				return true;
			else
				return false;
		}

		protected function siftCondition5(tile:Tile):Boolean
		{
			if(tile.getData()==MapConst.DOOMED_ROAD||tile.getData()==MapConst.SIDE_ROAD||tile.getData()==MapConst.MIN_ROAD)
				return true;
			else
				return false;
		}
		/**
		 * 获得主路径结束条件
		 * @param testTile
		 * @return 
		 * 
		 */		
		protected function findPathEndCallBack(testTile:Tile):Boolean
		{
			var type:String=testTile.getData().toString();
			if(type==MapConst.END_ROAD)
				return true;
			else 
				return false;
		}
		/**
		 * 获得主路径筛选条件
		 * @param testTile
		 * @return 
		 * 
		 */	
		protected function findPathCallBack(testTile:Tile):Boolean
		{
			var type:String=testTile.getData().toString();
			if(type==MapConst.END_ROAD||type==MapConst.STAND_ROAD||type==MapConst.SIDE_ROAD||type==MapConst.ISLAND_ROAD||type==MapConst.MAIN_ROAD)
				return true;
			else 
				return false;
		}
//---------------------运动播放方法-----------------------------------------------------------------------------------------------------------------
		protected function addWalk(mc:IMotionable):void 
		{
			this.mapData=this.battleDataProxy.mapData;
			
			var path:Array = (mc as IWalkPath).WalkPath;
			
			if(null != path && 0 < path.length)
			{
				var montion:IAnimationable = new BevelLineMotion(mc,mapData,path);
				AnimationManager.getInstance().addAnimation(montion);
				if((mc as ICharactor).Status != CharactorConst.WALK)
				{
					(mc as ICharactor).Status=CharactorConst.WALK;
					mc.getAnimationInstance().addEventListener(PlayAnimationEvent.ANIMATION_PLAY_END, animationEnd);
				}
			}
		}
		
		protected function animationEnd(evt:PlayAnimationEvent):void
		{
			if (npc == evt.animation&&(evt.animation as ICharactor).Status == CharactorConst.WALK) 
			{
				evt.animation.removeEventListener(PlayAnimationEvent.ANIMATION_PLAY_END, animationEnd);
				execWalkEnd(evt.animation);
			}
		}
		
		protected function execWalkEnd(obj:DisplayObject):void
		{
			var role:ICharactor = obj as ICharactor;
			role.Status=CharactorConst.SILENT;
			AnimationManager.getInstance().addAnimation(role);
			
		}
	}
}
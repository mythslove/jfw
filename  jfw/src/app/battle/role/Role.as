package app.battle.role
{
	import app.battle.DataProvider;
	import app.battle.buff.BuffConst;
	import app.battle.buff.BuffManager;
	import app.battle.consts.AppandAttrConst;
	import app.battle.interfaces.IRole;
	import app.battle.interfaces.ISkill;
	import app.battle.message.IActionMessage;
	import app.battle.message.QueueManager;
	import app.battle.statemachine.IStateMachine;
	import app.battle.statemachine.states.IState;
	import app.manager.AnimationManager;
	import app.manager.IResourceManager;
	import app.manager.ResourceManager;
	import app.vo.AttrVO;
	import app.vo.EquipVO;
	import app.vo.RoleVO;
	
	import com.jfw.engine.isolib.map.consts.DirectionConst;
	import com.jfw.engine.isolib.map.data.AStar;
	import com.jfw.engine.isolib.map.data.Tile;
	import com.jfw.engine.motion.AnimationConst;
	import com.jfw.engine.motion.AnimationEvent;
	import com.jfw.engine.motion.bottom.AsynBottomMotion;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class Role extends AsynBottomMotion implements IRole
	{
		protected var vo:RoleVO=null;
		protected var sourceManager:IResourceManager=null;
		protected var dataProvider:DataProvider=null;
		
		public function Role(id:String,rvo:RoleVO=null)
		{
			sourceManager=ResourceManager.Instance;
			dataProvider=DataProvider.Instance;
			
			if(rvo==null)
				vo=new RoleVO();
			else
				vo=rvo;
			
			vo.buffManager=new BuffManager(this);
			
			super(dataProvider.getRoleAttrById(id,"sid"), sourceManager, vo.dir, vo.act,sourceManager.getDefaultSource(), vo.speed, vo.fps);

			this.YAdjust=5;
			this.addEventListener(AnimationEvent.WALK_COMPLETE,onWalkComplete);
		}

		public function walkTo(gdx:Number,gdy:Number):void
		{
			if(!_mapData.checkPointOverRide(gdx,gdy))
			{
				var star:AStar=new AStar(_mapData);
				
				if(this.WalkPath==null)
				{
					if(star.findPath(vo.gridX,vo.gridX,gdx,gdy,conditions))
					{
						if(this.isMoving)
							this.StopMove();
						
						this._path=star.Path;
						this.StartMove();
					}
				}
				else
				{
					var tile:Tile=this.WalkPath[this._pathIndex] as Tile;
					
					if(star.findPath(tile.getXIndex(),tile.getZIndex(),gdx,gdy,conditions))
					{
						if(this.isMoving)
							this.StopMove();
						
						this._path=star.Path;
						this.StartMove();
					}
				}
			}
		}

		public function stopWalk():void
		{
			this.PauseMove();
		}
		
		protected function conditions(tile:Tile):Boolean
		{
			return true;
		}
		
		override protected function onAnimationEnd(evt:Event):void
		{
			
		}
		
		protected function onWalkComplete(evt:AnimationEvent):void
		{
			evt.stopImmediatePropagation();
			var toX:int=Math.round(Math.random()*23);
			var toY:int=Math.round(Math.random()*23);
			walkTo(toX,toY);
		}
		
		public function setPosition(gdx:int=0,gdy:int=0):void
		{
			vo.gridX=gdx;
			vo.gridY=gdy;
			
			var p:Point=this._mapData.gridToScreen(new Point(gdx,gdy));
			
			this.OriginX=p.x;
			this.OriginY=p.y;
		}
		
		override protected function onUpdate(tile:Tile):void
		{
			vo.gridX=tile.getXIndex();
			vo.gridY=tile.getZIndex();
			this.CurrTile=tile;
		}

		public function get Uid():int
		{
			return vo.uid;
		}
		
		public function set Uid(id:int):void
		{
			vo.uid=id;
		}
		
		public function get Name():String
		{
			return vo.name;
		}
		
		public function set Name(value:String):void
		{
			vo.name=value;
		}
		
		public function get Sex():Boolean
		{
			return vo.sex;
		}
		
		public function set Sex(sex:Boolean):void
		{
			vo.sex=sex;
		}
		
		public function get Camps():int
		{
			return vo.camps;
		}
		
		public function set Camps(cam:int):void
		{
			vo.camps=cam;
		}
		
		public function get Turns():int
		{
			return vo.turns;
		}
		
		public function set Turns(value:int):void
		{
			vo.turns=value;
		}

		public function get Quality():int
		{
			return vo.quality;
		}

		public function set Quality(value:int):void
		{
			vo.quality=value;	
		}
		
		public function getStateMachine():IStateMachine
		{
			return vo.stateMachine;
		}
		
		public function setStateMachine(value:IStateMachine):void
		{
			vo.stateMachine=value;
		}
		
		public function get State():IState
		{
			return vo.npcState;
		}
		
		public function set State(state:IState):void
		{
			if(vo.npcState!=state)
			{
				vo.oldState=vo.npcState;
				vo.npcState=state;
			}
		}
		
		public function get OldState():IState
		{
			return vo.oldState;
		}
		
		public function set OldState(state:IState):void
		{
			vo.oldState=state;
		}
		
		public function get OldFightState():int
		{
			return vo.oldFightState;
		}
		
		public function get FightState():int
		{
			return vo.fightState;
		}
		
		public function set FightState(state:int):void
		{
			if(vo.fightState!=state)
			{
				vo.oldFightState=vo.fightState;
				vo.fightState=state;
			}
		}
		
		public function get FightAction():int
		{
			return vo.fightAction;
		}
		
		public function set FightAction(value:int):void
		{
			vo.fightAction=value;
		}
		
		public function get IsActive():Boolean
		{
			return vo.isActive;
		}
		
		public function set IsActive(value:Boolean):void
		{
			vo.isActive=value;
		}
		
		public function getBuffManager():BuffManager
		{
			return vo.buffManager;
		}
		
		public function get MaxHP():int
		{
			return vo.maxHP;
		}
		
		public function set MaxHP(value:int):void
		{
			vo.maxHP=value;
		}
		
		public function get CurrMaxHP():int
		{
			return vo.currMaxHP;
		}
		
		public function set CurrMaxHP(value:int):void
		{
			if(value>vo.currMaxHP)
			{
				var n:int=value-vo.currMaxHP;
				vo.currMaxHP=value;
				vo.currHP+=n;
			}
			else if(value<vo.currMaxHP)
			{
				var m:int=value-vo.currMaxHP;
				vo.currMaxHP=value;
				
				if(vo.currHP>value)
				{
					vo.currHP=value;
				}
			}
		}
		
		public function get CurrHP():int
		{
			return vo.currHP
		}
		
		public function set CurrHP(value:int):void
		{
			vo.currHP=value;
		}
		
		public function get Attack():Number
		{
			return this.vo.attack+this.getBaseAttr(AppandAttrConst.ATTACK)+vo.buffManager.getBuffValueOfType(BuffConst.ACT_UP)-vo.buffManager.getBuffValueOfType(BuffConst.ACT_DOWN);
		}
		
		public function set Attack(value:Number):void
		{
			vo.attack=value;
		}
		
		public function get Defence():Number
		{
			return this.vo.defence+this.getBaseAttr(AppandAttrConst.DEFENCE)+vo.buffManager.getBuffValueOfType(BuffConst.DEF_UP)-vo.buffManager.getBuffValueOfType(BuffConst.DEF_DOWN);
		}
		
		public function set Defence(value:Number):void
		{
			vo.defence=value;
		}
		
		public function get Speed():Number
		{
			return vo.speed;
		}
		
		override public function get Spd():Number
		{
			return AnimationManager.Instance.Speed*(this.vo.speed+vo.buffManager.getBuffValueOfType(BuffConst.SPD_UP)-vo.buffManager.getBuffValueOfType(BuffConst.SPD_DOWN));
		}
		
		public function set Speed(value:Number):void
		{
			this.vo.speed=value;
			this._currSpd=value;
		}
		
		public function get Recover():int
		{
			return this.vo.increaseHP+this.getBaseAttr(AppandAttrConst.RECOVER);
		}
		
		public function set Recover(value:int):void
		{
			vo.increaseHP=value;
		}
		
		public function get Lucky():Number
		{
			return vo.lucky+vo.buffManager.getBuffValueOfType(BuffConst.LUCKY_UP)-vo.buffManager.getBuffValueOfType(BuffConst.LUCKY_DOWN);
		}
		
		public function set Lucky(value:Number):void
		{
			vo.lucky=value;
		}

		public function get FrameRate():Number
		{
			return vo.frameRate;
		}

		public function set FrameRate(value:Number):void
		{
			vo.frameRate=value;
		}

		public function get Crit():Number
		{
			return vo.crit;
		}

		public function set Crit(value:Number):void
		{
			vo.crit=value;	
		}

		public function get Firmly():Number
		{
			return vo.firmly;
		}

		public function set Firmly(value:Number):void
		{
			vo.firmly=value;
		}

		public function get Parry():Number
		{
			return vo.parry;
		}

		public function set Parry(value:Number):void
		{
			vo.parry=value;
		}
		
		override public function advanceTime(time:Number):void
		{
			this.fps=this.vo.fps*(vo.frameRate+vo.buffManager.getBuffValueOfType(BuffConst.FIGHT_RATE_UP)-vo.buffManager.getBuffValueOfType(BuffConst.FIGHT_RATE_DOWN));
			this.CurrMaxHP=vo.maxHP+this.getBaseAttr(AppandAttrConst.HP)+vo.buffManager.getBuffValueOfType(BuffConst.MAXHP_UP)-vo.buffManager.getBuffValueOfType(BuffConst.MAXHP_DOWN);
			super.advanceTime(time);
		}
		
		public function showName():void
		{
			
		}
		
		public function showStatusBar(bool:Boolean):void
		{
			
		}
		
		public function checkSpeedException():Boolean
		{
			return vo.buffManager.getBuffValueOfType(BuffConst.SPD_UP)+vo.buffManager.getBuffValueOfType(BuffConst.SPD_DOWN)==0;
		}
		
		public function get OldTile():Tile
		{
			return vo.oldTile;
		}
		
		public function set OldTile(tile:Tile):void
		{
			vo.oldTile=tile;
		}
		
		public function get CurrTile():Tile
		{
			return vo.currTile;
		}
		
		public function set CurrTile(tile:Tile):void
		{
			if(tile!=vo.currTile)
			{
				vo.oldTile=vo.currTile;
				vo.currTile=tile;
			}
		}
		
		public function get RoomID():int
		{
			return vo.roomID;
		}
		
		public function set RoomID(value:int):void
		{
			vo.roomID=value;
		}
		
		public function get Offensive():int
		{
			return vo.offensive;
		}
		
		public function set Offensive(value:int):void
		{
			vo.offensive=value;
		}
		
		public function get IsLock():Boolean
		{
			return vo.isLock;
		}
		
		public function set IsLock(value:Boolean):void
		{
			vo.isLock=value;
		}
		
		public function get IsEquiped():Boolean
		{
			return getEquipList().length>0;
		}
		
		public function getEquipList():Array
		{
			return null;
		}
		
		public function getEquip(type:int):EquipVO
		{
			return null;
		}
		
		public function getAttr(e:EquipVO, key:int):AttrVO
		{
			return null;
		}
		
		public function getBaseAttr(key:int):int
		{
			return 0;
		}
		
		public function get CostMP():int
		{
			return vo.costMP;
		}
		
		public function set CostMP(value:int):void
		{
			vo.costMP=value;
		}
		
		public function get CostMoney():int
		{
			return vo.costMoney;
		}
		
		public function set CostMoney(value:int):void
		{
			vo.costMoney=value;
		}
		
		public function get IsVip():Boolean
		{
			return vo.isVip;
		}
		
		public function set IsVip(value:Boolean):void
		{
			vo.isVip=value;
		}
		
		public function get IsDropped():Boolean
		{
			return vo.isDropped;
		}
		
		public function set IsDropped(value:Boolean):void
		{
			vo.isDropped=value;
		}
		
		public function get DType():int
		{
			return vo.dragType;
		}
		
		public function get Instance():DisplayObject
		{
			return this;	
		}
		
		public function get Visible():Boolean
		{
			return this.visible;
		}
		
		public function set Visible(value:Boolean):void
		{
			this.visible=value;
		}
		
		public function get Alpha():Number
		{
			return this.alpha;
		}
		
		public function set Alpha(value:Number):void
		{
			this.alpha=value;
		}
		
		public function get ScrX():Number
		{
			return this.x;
		}
		
		public function get ScrY():Number
		{
			return this.y;
		}
		
		public function move(x:Number=0, y:Number=0):void
		{
			this.OriginX=x;
			this.OriginY=y;
			
			if(this._mapData)
			{
				var p:Point=_mapData.screenToGrid(new Point(x,y));
				vo.gridX=p.x;
				vo.gridY=p.y;
				this.CurrTile=_mapData.getTileAtGrid(p.x,p.y);
			}
		}
		
		public function get ID():int
		{
			return vo.id;
		}
		
		public function set ID(id:int):void
		{
			vo.id=id;
		}
		
		public function get SingleID():int
		{
			return vo.id;
		}
		
		public function set SingleID(sid:int):void
		{
			vo.id=sid;
		}
		
		public function get SrcID():String
		{
			return vo.srcid;
		}
		
		public function set SrcID(srcid:String):void
		{
			vo.srcid=srcid;
		}
		
		public function get Type():int
		{
			return vo.type;
		}
		
		public function set Type(type:int):void
		{
			vo.type=type;
		}
		
		public function get Level():int
		{
			return vo.level;
		}
		
		public function set Level(lv:int):void
		{
			vo.level=lv;
		}
		
		public function get VO():*
		{
			return vo;
		}
		
		public function get GridX():int
		{
			return vo.gridX;
		}
		
		public function set GridX(gridX:int):void
		{
			vo.gridX=gridX;
		}
		
		public function get GridY():int
		{
			return vo.gridY;
		}
		
		public function set GridY(gridY:int):void
		{
			vo.gridY=gridY;
		}
		
		public function get TotalSkillGrid():int
		{
			return vo.skillTiles;
		}
		
		public function get TotalSkill():int
		{
			return vo.realSkills.length;
		}
		
		public function get ActiveSkills():int
		{
			return 0; //根据妖魂数计算
		}
		
		public function getSkillByIndex(index:int):ISkill
		{
			return vo.skillQueue[index];
		}
		
		public function setSkillLock(index:int, value:Boolean=true):void
		{
			vo.skillQueue[index].isLock=value;
		}
		
		public function checkSkillLock(index:int):Boolean
		{
			return vo.skillQueue[index].isLock;
		}
		
		public function get MonsterSoul():int
		{
			return vo.souls;
		}
		
		public function set MonsterSoul(value:int):void
		{
			vo.souls=value;
		}
		
		public function get SkillQueue():Vector.<ISkill>
		{
			return vo.skillQueue;
		}
		
		public function clearSkills():void
		{
			vo.skillQueue.length=0;
		}
		
		public function get Sender():IRole
		{
			return this;
		}
		
		public function get Receiver():IRole
		{
			return this;
		}
		
		public function sendMessage(msg:IActionMessage):void
		{
			QueueManager.getInstance().push(msg);
		}
		
		public function push(msg:IActionMessage):void
		{
			vo.queue.push(msg);
		}
		
		public function shift():IActionMessage
		{
			return vo.queue.shift();
		}
		
		public function get queueLength():int
		{
			return vo.queue.length;
		}
		
		public function get empty():Boolean
		{
			return vo.queue.length==0;
		}
		
		public function clear():void
		{
			vo.queue.length=0;
		}
		
		override public function destroy():void
		{
			super.destroy();
			
			vo.buffManager.clearAll();
			vo.stateMachine=null;

			sourceManager=null;
			dataProvider=null;
			vo=null;
			
			if(this.hasEventListener(AnimationEvent.WALK_COMPLETE))
				this.removeEventListener(AnimationEvent.WALK_COMPLETE,onWalkComplete);
		}
	}
}
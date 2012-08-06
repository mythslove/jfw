package app.vo
{
	import app.battle.consts.GlobalConst;
	import app.battle.buff.BuffManager;
	import app.battle.components.StatusBar;
	import app.battle.consts.DragConst;
	import app.battle.interfaces.ISkill;
	import app.battle.message.IActionMessage;
	import app.battle.statemachine.IStateMachine;
	import app.battle.statemachine.states.IState;
	import app.battle.utils.ArrayUtils;
	
	import com.jfw.engine.isolib.map.consts.DirectionConst;
	import com.jfw.engine.isolib.map.data.Tile;
	import com.jfw.engine.motion.AnimationConst;
	
	import flash.text.TextField;

	public class RoleVO 
	{
		/** 角色Id */
		public var id:int;
		/**临时唯一id*/		
		public var singleID:int;
		/**资源id*/	
		public var srcid:String;
		/**后端唯一id*/	
		public var uid:int=0;
		/** 类型: 自己、npc、妖将 */
		public var type:int;	
		/** 性别 true 男 */
		public var sex:Boolean;	
		/** 级别 */
		public var level:int;
		/** 名字 */
		public var name:String;
		/** 阵营 0:攻击方,1:防守方,2:中立势力 */
		public var camps:int=0;
		/** 转生数*/
		public var turns:int=0;
		/** 品质*/
		public var quality:int=0;
		/** 是否是攻击方 */
		public var isActive:Boolean=true;
		/** 保存角色行走路径 */
		public var walkPath:Array = [];
		/** 角色刚走过的路块 */
		public var oldTile:Tile=null;
		/** 角色当前路块 */
		public var currTile:Tile=null;
		/** 角色格子坐标和像素坐标 */
		public var gridX:int=0;
		public var gridY:int=0;
		/** 角色是否加入队伍 */
		public var isJoinedTeam:Boolean=true;
		/** 在队伍中的绝对位置(非索引）*/
		public var teamIndex:int=-1;
		/** 角色当前状态 */
		public var npcState:IState=null;
		/** 角色上一个状态 */
		public var oldState:IState=null;
		/** 旧战斗状态 */
		public var oldFightState:int=0;
		/** 角色战斗子状态0:正常,1:被控制,冰冻或眩晕 */
		public var fightState:int=0;
		/** 战斗动作,用来记录当前人物动作 */
		public var fightAction:int=0;
		/** 状态机 */
		public var stateMachine:IStateMachine;
		/** buff管理器 */
		public var buffManager:BuffManager;
		/** 角色战斗属性 */
		public var maxHP:int=0;
		public var currMaxHP:int=0;
		public var currHP:int=0;
		public var attack:Number=0;
		public var defence:Number=0;
		public var speed:Number=1;
		/** 爆击*/
		public var crit:Number=0;
		/** 搁挡 */
		public var firmly:Number=0;
		/** 坚守 */
		public var parry:Number=0;
		/** 血美妙恢复量 */
		public var increaseHP:int=0;
		/** 幸运*/
		public var lucky:Number=0;
		/** 攻击频率,范围为0.5到5 */
		public var frameRate:Number=1.0;
		/** 妖魂数 */
		public var souls:int=0;
		/** 携带的技能 */		
		public var skillQueue:Vector.<ISkill>=new Vector.<ISkill>();
		/** 开启的技能栏位置 */
		public var skillTiles:int=0;
		/** 身上具备的技能 */
		public var realSkills:Vector.<ISkill>=new Vector.<ISkill>();
		/** 是否激活 */
		public var isLock:Boolean=true;
		/** 消耗的mp */
		public var costMP:int=0;
		/** 消耗的金钱 */
		public var costMoney:int=0;
		/** 是否是vip */
		public var isVip:Boolean=false;
		/** 是否已经放到地图上*/
		public var isDropped:Boolean=false;
		/** 拖拽的类型*/
		public var dragType:int=DragConst.MONSTER;
		/** 角色名字 */
		public var nameTxt:TextField;
		/** 状态条 */
		public var statusBar:StatusBar;
		/** 起始标签 */
		public var startLabel:String;
		/** 结束标签 */
		public var endLabel:String	
		/** 动画播放速度 */
		public var playSpeed:int;
		/** 是否重复播放 */
		public var isPlayRpeat:Boolean = true;
		/** 播放次数 */
		public var playTimes:int = 0;	
		/** 暂停标志 */
		public var pause:Boolean=false;
		/** 消息队列 */
		public var queue:Vector.<IActionMessage>=new Vector.<IActionMessage>();
		/** 临时战斗房间号 */
		public var roomID:int=-1;
		/** 是否先手标志,0后手1先手 */
		public var offensive:int=0;
		/** 方向 */
		public var dir:String=DirectionConst.LEFTDOWN;
		/** 动作 */
		public var act:String=AnimationConst.WALK;
		/** 贞数 */
		public var fps:Number=GlobalConst.FPS;
	}
}
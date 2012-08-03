package app.battle.interfaces
{
	import app.battle.buff.BuffManager;
	import app.battle.statemachine.IStateMachine;
	import app.battle.statemachine.states.IState;
	
	import com.jfw.engine.core.base.IDestory;
	import com.jfw.engine.isolib.map.data.Tile;
	import com.jfw.engine.motion.IMotion;

	public interface IRole extends IMotion,IEquip,ICost,IDataVO,IDrag,ISkillable,ISender,IReceiver
	{
		/** 运动到某一点 */
		function walkTo(gdx:Number,gdy:Number):void;
		
		/** 停止行走 */
		function stopWalk():void;
			
		/** 后端唯一id */
		function get Uid():int;
		function set Uid(id:int):void;
		
		/** 角色名字 */
		function get Name():String;
		function set Name(value:String):void;
	
		/** 性别 true 男 */
		function get Sex():Boolean;	
		function set Sex(sex:Boolean):void;
		
		/** 阵营 0:攻击方,1:防守方,2:中立势力 */
		function get Camps():int;
		function set Camps(cam:int):void;
		
		/** 转生次数 */
		function get Turns():int;
		function set Turns(value:int):void;
		
		/** 品质 */
		function get Quality():int;
		function set Quality(value:int):void;
		
		/** 状态机 */
		function getStateMachine():IStateMachine;
		
		/** 状态机 */
		function setStateMachine(value:IStateMachine):void;
		
		/** 角色状态机当前状态 */
		function get State():IState;
		function set State(state:IState):void;
		
		/** 角色上一个状态 */
		function get OldState():IState;
		function set OldState(state:IState):void;
		
		/** 旧战斗状态 */
		function get OldFightState():int;
		
		/** 角色战斗子状态0:正常,1:眩晕或冰冻 */
		function get FightState():int;
		function set FightState(state:int):void;
		
		/** 角色战斗动作,记录战斗时的动作 */
		function get FightAction():int;
		function set FightAction(value:int):void;
		
		/** 是否是攻击方 */
		function get IsActive():Boolean;
		function set IsActive(value:Boolean):void;
		
		/** buff管理器 */
		function getBuffManager():BuffManager;
		
		/** 角色最大血 */
		function get MaxHP():int;
		function set MaxHP(value:int):void;
		
		/** 角色当前最大血量 */
		function get CurrMaxHP():int;
		function set CurrMaxHP(value:int):void;
		
		/** 角色当前血 */
		function get CurrHP():int;
		function set CurrHP(value:int):void;
		
		/** 角色攻击 */
		function get Attack():Number;
		function set Attack(value:Number):void;
		
		/** 角色防御 */
		function get Defence():Number;
		function set Defence(value:Number):void;
		
		/** 角色本身速度 */
		function get Speed():Number;
		function set Speed(value:Number):void;
		
		/** 角色每秒回血速度 */
		function get Recover():int;
		function set Recover(value:int):void;
		
		/** 角色幸运值 */
		function get Lucky():Number;
		function set Lucky(value:Number):void;
		
		/** 角色爆击*/
		function get Crit():Number;
		function set Crit(value:Number):void;
		
		/** 角色搁挡*/
		function get Firmly():Number;
		function set Firmly(value:Number):void;
		
		/** 角色坚守*/
		function get Parry():Number;
		function set Parry(value:Number):void;

		/** 角色攻击频率*/
		function get FrameRate():Number;
		function set FrameRate(value:Number):void;
		
		/** 角色名字ui */
		function showName():void;
		
		/** 显示状态条 */
		function showStatusBar(bool:Boolean):void;
		
		/** 检查速度是否异常true 为异常 */
		function checkSpeedException():Boolean;
		
		/** 角色刚走过的路块 */
		function get OldTile():Tile;
		function set OldTile(tile:Tile):void;
		
		/** 角色当前路块 */
		function get CurrTile():Tile;
		function set CurrTile(tile:Tile):void;
			
		/**得到战斗房间号 */	
		function get RoomID():int;	
		function set RoomID(value:int):void;

		/**是否先手0后手1先手 */		
		function get Offensive():int;	
		function set Offensive(value:int):void;
		
		/**是否生效false为生效 */	
		function get IsLock():Boolean;
		function set IsLock(value:Boolean):void;
	}
}
package app.battle.battle
{
	import app.battle.message.QueueManager;
	import app.globals.consts.AppConst;
	import app.globals.consts.CharactorConst;
	import app.globals.interfaces.ICharactor;
	import app.globals.utils.IDUtils;
	import app.mvc.models.manager.TeamManager;
	import app.mvc.views.buff.BuffConst;
	import app.statemachine.StateConst;
	
	import org.puremvc.as3.patterns.facade.Facade;

	public class RoomManager
	{
		protected static var instance:RoomManager;
		protected var rooms:Array;
		
		public function RoomManager()
		{
			rooms=[];
		}
		
		public static function getInstance():RoomManager
		{
			if(instance==null)
				instance=new RoomManager();
			
			return instance;
		}
		/**
		 * 增加房间
		 * @param act
		 * 
		 */		
		public function push(one:ICharactor,other:ICharactor):void
		{
			var roomid:int=IDUtils.createNewID();
			one.RoomID=roomid;
			other.RoomID=roomid;
			one.Offensive=1;
			other.Offensive=0;
			rooms[roomid]=new Room(roomid,one,other);
		}
		/**
		 * 房间管理 
		 * 
		 */		
		public function execute():void
		{
			for(var key:String in rooms)
			{
				if(rooms[key].isEnd)
				{
					executeFightOver(rooms[key].arr[0]);
					executeFightOver(rooms[key].arr[1]);
					delete rooms[key];
					//rooms[key]=null;
				}
			}
		}
		/**
		 * 房间管理 
		 * @param char
		 * 
		 */		
		private function executeFightOver(char:ICharactor):void
		{
			if(char.CurrHP==0)
			{
				if(char.NpcState.getName()==StateConst.WAIT_TEAM_FIGHTING_STATE)
				{
					if(char.Type==CharactorConst.MEMBER)
					{
						char.StateMachine.initState(StateConst.IS_DIED_STATE);
						TeamManager.getInstance().removeMember(char);
						Facade.getInstance().sendNotification(AppConst.APP_TEAM_ADJUST,null,"leaveTeam");
					}
				}
				else// if(char.NpcState.getName()==StateConst.FIGHTING_STATE)
				{
					char.StateMachine.initState(StateConst.IS_DIED_STATE);		
				}
			}
			else
			{
				//清空所有针对对方的消息,包括总队列里的
				QueueManager.getInstance().removeByReceiver(getOther(char));
				char.clear();
				
				if(char.NpcState.getName()==StateConst.WAIT_TEAM_FIGHTING_STATE)
				{
					for each(var c:ICharactor in TeamManager.getInstance().charArr)
					{
						c.StateMachine.exitState();
					}
				}
				else if(char.NpcState.getName()==StateConst.FIGHTING_STATE)
				{
					char.StateMachine.exitState();	
				}
				else//if(char.NpcState.getName()==StateConst.MONSTER_FIGHTING_STATE)
				{
					char.StateMachine.exitState();	
				}
			}
		}

		/**
		 * 删除指定房间
		 * @param act
		 * 
		 */		
		public function remove(roomid:int):void
		{
			delete rooms[roomid];
		}
		/**
		 * 清空队列 
		 * 
		 */		
		public function clearAll():void
		{
			rooms=[];
		}
		/**
		 * 得到战斗目标
		 * @return 
		 * 
		 */		
		public function getOther(char:ICharactor):ICharactor
		{
			return (rooms[char.RoomID] as Room).getOther(char);
		}
		/**
		 * 根据id得到指定的房间 
		 * @param id
		 * @return 
		 * 
		 */		
		public function getRoom(id:int):Room
		{
			return rooms[id];
		}
	}
}
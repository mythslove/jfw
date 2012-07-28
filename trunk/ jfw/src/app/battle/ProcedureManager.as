package app.battle
{
	import app.timer.DalayCall;
	import app.vo.RoundVO;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	/**
	 * 战场人物出场控制器 
	 * @author Administrator
	 * 
	 */	
	public class ProcedureManager extends EventDispatcher
	{
		private static var instance:ProcedureManager=null;

		public var roundArr:Vector.<RoundVO>=null;
		public var teamInterval:Number=5;
		public var memberInterval:Number=1;
		public var executeTeam:Function=null;
		public var executeMember:Function=null;
		public var teamIndex:int=0;
		public var memberIndex:int=0;
		private var dalayCall:DalayCall=null;
		
		public function ProcedureManager(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public static function Instance():ProcedureManager
		{
			return instance||=new ProcedureManager();
		}
		
		public function setData(roundArr:Vector.<RoundVO>,executeTeam:Function=null,executeMember:Function=null):void
		{
			this.roundArr=roundArr;
			this.executeTeam=executeTeam;
			this.executeMember=executeMember;
		}
		
		public function start():void
		{
			if(roundArr==null)
				return;
			
			if(teamIndex==roundArr.length-1&&memberIndex>=roundArr[teamIndex].team.members.length-1)
				return;
			
			startTeam();
		}
		
		public function get CurrMember():String
		{
			return roundArr[teamIndex].team.members[memberIndex];
		}
		
		private function startMember():void
		{
			memberInterval=roundArr[teamIndex].team.dalay;
			
			if(memberIndex==0)
			{
				onMemberCallBack();
			}
			else
			{
				dalayCall=new DalayCall(memberInterval,onMemberCallBack);
				dalayCall.start();
			}
		}
		
		private function startTeam():void
		{
			teamInterval=roundArr[teamIndex].dalay;
			
			if(teamIndex==0)
			{
				onTeamCallBack();
			}
			else
			{
				dalayCall=new DalayCall(teamInterval,onTeamCallBack);
				dalayCall.start();
			}
		}
		
		private function onMemberCallBack():void
		{
			if(executeMember!=null)
				executeMember();
			
			if(teamIndex==roundArr.length-1)
			{
				if(memberIndex>=roundArr[teamIndex].team.members.length-1)
				{
					dispose();
				}
				else
				{
					memberIndex++;
					startMember();
				}
			}
			else if(teamIndex<roundArr.length-1)
			{
				if(memberIndex>=roundArr[teamIndex].team.members.length-1)
				{
					memberIndex=0;
					teamIndex++;
					startTeam();
				}
				else
				{
					memberIndex++;
					startMember();
				}
			}
		}
		
		private function onTeamCallBack():void
		{
			if(executeTeam!=null)
				executeTeam();
			
			startMember();
		}
		
		public function dispose():void
		{
			roundArr=null;
			executeTeam=null;
			executeMember=null;
			dalayCall.stop();
		}
	}
}
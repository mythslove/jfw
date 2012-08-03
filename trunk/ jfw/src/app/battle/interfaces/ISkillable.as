package app.battle.interfaces
{
	public interface ISkillable
	{
		/**
		 * 总技能槽数 
		 * @return 
		 * 
		 */		
		function get TotalSkillGrid():int;
		/**
		 * 技能数
		 * @return 
		 * 
		 */		
		function get TotalSkill():int;
		/**
		 * 激活的技能数
		 * @return 
		 * 
		 */		
		function get ActiveSkills():int;
		/**
		 * 根据索引获取技能
		 * @param index
		 * @return 
		 * 
		 */		
		function getSkillByIndex(index:int):ISkill;
		/**
		 * 设置技能锁定
		 * @param index
		 * @param value
		 * 
		 */		
		function setSkillLock(index:int,value:Boolean=true):void;
		/**
		 * 判断技能是否锁定
		 * @param index
		 * @return 
		 * 
		 */		
		function checkSkillLock(index:int):Boolean;
		/**
		 * 妖魂数
		 * @return 
		 * 
		 */		
		function get MonsterSoul():int;
		/**
		 * 妖魂数
		 * @return 
		 * 
		 */	
		function set MonsterSoul(value:int):void;
		/**
		 * 获取技能队列 
		 * @return 
		 * 
		 */		
		function get SkillQueue():Vector.<ISkill>;
		/**
		 * 清除技能 
		 * 
		 */		
		function clearSkills():void;
	}
}
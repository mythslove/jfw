package app.battle.consts
{
	public class RoleConst
	{
		/** 阵营 0:攻击方,1:防守方,2:中立势力 */
		
		/** 攻击方 */
		static public const ATTACK:int = 0;
		/** 防守方 */
		static public const DEFEND:int = 1;
		/** 中立势力 */
		static public const IMPARTIAL:int = 2;
		/** 登陆玩家自己 */
		static public const SELF:int = 3;
		
		/** 角色类型 */
		//队长
		static public const MASTER:int = 2;
		//队员
		static public const MEMBER:int = 3;
		//元神
		static public const SOUL:int = 4;
		//妖将&怪物
		static public const MONSTER:int = 5;
	}
}
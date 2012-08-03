package app.battle.interfaces
{
	import com.jfw.engine.isolib.map.data.Tile;
	import com.jfw.engine.motion.IAnimation;

	public interface IBattleItem extends IAnimation,IDataVO,IDrag
	{
		/** 道具名字 */
		function get Name():String;
		
		/** 道具描述 */
		function get Desc():String;
		
		/** 所属阵营,1为中立，0为玩家 */
		function get Belong():int;
		function set Belong(value:int):void;
		
		/** 所属人 */
		function get Owner():IRole;
		function set Owner(value:IRole):void;
		
		/** 影响范围 */
		function get EffectSphere():Vector.<Tile>;
	}
}
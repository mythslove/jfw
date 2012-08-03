package app.battle.interfaces
{
	import app.vo.AttrVO;
	import app.vo.EquipVO;

	/**
	 * 装备操作接口 
	 * @author PianFeng
	 * 
	 */	
	public interface IEquip
	{
		/** 是否穿了装备 */
		function get IsEquiped():Boolean;
		
		/** 装备集合 */
		function getEquipList():Array;
		
		/** 得到某部位的装备,有可能为null */
		function getEquip(type:int):EquipVO;
		
		/** 根据词缀类型获取附加属性 */
		function getAttr(e:EquipVO,key:int):AttrVO;
		
		/** 获取所有装备的同种基础属性值的和 1,2,3 */
		function getBaseAttr(key:int):int;
	}
}
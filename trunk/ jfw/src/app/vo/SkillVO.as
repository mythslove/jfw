package app.vo
{

	/**
	 * 技能基类 
	 * @author PianFeng
	 *
	 */	
	public class SkillVO
	{
		/**技能id*/
		public var skillID:int=0;
		/**特效资源id,技能发出者*/
		public var skillSrcID:int=0;
		/**技能物品资源id*/
		public var skillItemSrcID:String;
		/**级别*/
		public var level:int=0;
		/**触发概率*/
		public var prob:int=0;
		/**技能名称*/
		public var skillName:String;
		/**技能描述*/
		public var skillDesc:String;
		/**是否是被动技能*/
		public var isPassive:int=0;
		/**法术释放位置0:头上,1:中间,2:脚下*/
		public var point:int=0;
		/**法术作用范围*/
		public var sphere:String;

		public var vo1:BuffVO;
		public var vo2:BuffVO;
		public var vo3:BuffVO;
		
		public var voArr:Array;
		
		public function SkillVO(xml:XML)
		{
			this.skillID=xml.@id;//技能id
			this.skillSrcID=xml.@sid;//资源id
			this.level=xml.@lv;//级别
			this.skillName=xml.@name;//技能名称
			this.skillDesc=xml.@desc;//技能描述
			this.isPassive=xml.@isPas
			this.prob=xml.@prob;
			this.point=xml.@pt;
			this.sphere=xml.@sp;//作用范围
			
			vo1=new BuffVO();
			vo2=new BuffVO();
			vo3=new BuffVO();
			voArr=[];

			vo1.type=xml.@type1;
			vo1.value=xml.@value1;
			vo1.hasBuff=Boolean(xml.@flag1);
			vo1.buffType=xml.@btype1;
			vo1.dt=xml.@dt1;
			vo1.buffEffectID=xml.@beid1;
			vo1.target=xml.@tar1;
			vo1.effectID=xml.@eid1;
			vo1.effectTarget=xml.@etar1;
			vo1.point=xml.@pt1;

			vo2.type=xml.@type2;
			vo2.value=xml.@value2;
			vo2.hasBuff=Boolean(xml.@flag2);
			vo2.buffType=xml.@btype2;
			vo2.dt=xml.@dt2;
			vo2.buffEffectID=xml.@beid2;
			vo2.target=xml.@tar2;
			vo2.effectID=xml.@eid2;
			vo2.effectTarget=xml.@etar2;
			vo2.point=xml.@pt2;
			
			vo3.type=xml.@type3;
			vo3.value=xml.@value3;
			vo3.hasBuff=Boolean(xml.@flag3);
			vo3.buffType=xml.@btype3;
			vo3.dt=xml.@dt3;
			vo3.buffEffectID=xml.@beid3;
			vo3.target=xml.@tar3;
			vo3.effectID=xml.@eid3;
			vo3.effectTarget=xml.@etar3;
			vo3.point=xml.@pt3;
			
			voArr.push(vo1,vo2,vo3);
		}
		
		public function hasBuff():Boolean
		{
			return vo1.hasBuff||vo2.hasBuff||vo3.hasBuff;
		}
	}
}
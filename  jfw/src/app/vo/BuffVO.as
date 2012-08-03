package app.vo
{
	/**
	 * 技能信息 
	 * @author PianFeng
	 * 
	 */	
	public class BuffVO
	{
		/**技能类型,普通伤害算普通技能*/
		public var type:int=0;
		/**动作数值*/
		public var value:Number=0;
		
		public var hasBuff:Boolean=false;
		/**buff类型*/
		public var buffType:int=-1;
		/**对自己buff持续时间/s,0代表没有*/
		public var dt:int=0;
		/**buff效果资源id*/
		public var buffEffectID:String;
		/**作用目标,0代表自己,1代表对方*/
		public var target:int=0;
		/**动作特效资源id*/
		public var effectID:String;
		/**特效目标0自己,1对方*/
		public var effectTarget:int=0;
		/** 特效位置0头上1中间2脚下*/
		public var point:int=0;
		
		public function BuffVO(type:int=0,value:Number=0,hasBuff:int=0,buffType:int=-1,dt:int=0,buffEffectID:String='',target:int=0,effectID:String='',effectTarget:int=0,point:int=0)
		{
			this.type=type;
			this.value=value;
			this.hasBuff=Boolean(hasBuff);
			this.buffType=buffType;
			this.dt=dt;
			this.buffEffectID=buffEffectID;
			this.target=target;
			this.effectID=effectID;
			this.effectTarget=effectTarget;
			this.point=point;
		}
	}
}
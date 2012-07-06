package com.jfw.engine.utils.operation.effect
{
	import com.jfw.engine.utils.operation.Oper;
	import com.jfw.engine.utils.operation.TweenOper;
	
	import flash.display.DisplayObject;
	

	/**
	 * 透明度闪烁效果
	 * 
	 */
	public class FlashEffect extends RepeatEffect
	{
		/**
		 * 持续时间
		 */
		public var duration:int;
		/**
		 * 起始透明度
		 */
		public var fromAlpha:Number;
		/**
		 * 结束透明度 
		 */
		public var toAlpha:Number;
		
		public function FlashEffect(target:*=null, duration:int=1000, fromAlpha:Number = 1.0, toAlpha:Number = 0.5, loop:int = -1)
		{
			super(null, loop);
			
			this.target = target;
			this.duration = duration;
			this.fromAlpha = fromAlpha;
			this.toAlpha = toAlpha;
		}
		
		public override function halt():void
		{
			this.clearCurrent();
			super.halt();
		}
		
		public function clearCurrent():void
		{
			if (children && index >= 0 && index < children.length)
				children[index].halt();
		
			(target as DisplayObject).alpha = fromAlpha;
		}
		
		/** @inheritDoc*/
		public override function execute():void
		{
			if (this.step == Oper.RUN)//清理重复调用
			{
				this.end();
				this.clearCurrent();
			}
			
			this.children = [new TweenOper(target,duration,{alpha:toAlpha}),
							new TweenOper(target,duration,{alpha:fromAlpha})];
			
			super.execute();
		}
	}
}
package com.jfw.engine.core.data
{
	/** 数据结构基类 */
	public class BaseStruct extends Object implements IStruct
	{
		public function BaseStruct(obj:Object = null)
		{
			if(obj != null)
				this.parse(obj);
		}
		
		public function clone():Object
		{
			return new Object();
		}
		
		/** 用Object实例初始化本类实例 */
		protected function parse(obj:Object):void
		{
			
		}
	}
}
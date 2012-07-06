package com.jfw.engine.core.view
{
	public interface IPanel
	{
		/** 注册面板中的button */
		function regButtons():void;
		
		/** 注销面板中的button */
		function unregButtons():void;
		
		/** 缓动方法 
		 * @param duration	持续时间
		 * @param params	缓动参数
		 * @param delay		延迟时间
		 * @param invert	是否倒放
		 */
		function tweenTo(duration:int,params:Object,delay:int = 100):void;
		
//		/** 显示面板 */
//		function show():void;
//		
//		/** 隐藏面板 */
//		function hide():void;
	}
}
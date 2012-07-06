package com.jfw.engine.core.interfaces
{
	public interface IAnimatable
	{
		/** 
		 * 可驱动接口
		 * Advance the time by a number of seconds. 
		 * @param time in seconds. 
		 */
		function advanceTime(time:Number):void;
	}
}
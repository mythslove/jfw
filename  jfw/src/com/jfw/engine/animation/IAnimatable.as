package com.jfw.engine.animation
{
	public interface IAnimatable
	{
		/** 
		 * Advance the time by a number of seconds. 
		 * @param time in seconds. 
		 */
		function advanceTime(time:Number):void;
	}
}
package com.jfw.engine.core.mvc.view
{
	import com.jfw.engine.core.data.IStruct;
	import com.jfw.engine.utils.IQueueItem;
	
	/** 窗口接口 */
	public interface IWindow extends IQueueItem
	{
		function close():void;
	}
}
package com.jfw.engine.core.model
{
	import com.jfw.engine.core.data.IStruct;

	public interface IModelData
	{
		function set data(v:IStruct):void;
		function get data():IStruct;
	}
}
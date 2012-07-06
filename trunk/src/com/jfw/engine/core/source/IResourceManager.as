package com.pianfeng.engine.resource 
{
	import com.pianfeng.engine.animation.data.IAnimationObj;
	import com.pianfeng.engine.global.interfaces.IDispose;
	
	/**
	 * 资源管理接口
	 * 
	 */	
	 
	public interface IResourceManager extends IDispose
	{
		/**
		* 取得资源
		* @param 			资源名字
		* @param 			资源路径
		* 
		* @return			资源接口
		*/
		function getAnimation(name: String): IAnimationObj;
		
		/**
		* 取得缺省资源
		* @param 			无
		* 
		* @return			缺省资源接口
		*/
		function getDefaultAnimation(): IAnimationObj;
		
		//function getDefaultResName(): String;
	}
	
}
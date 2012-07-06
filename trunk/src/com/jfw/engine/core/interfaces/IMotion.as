package com.jfw.engine.core.interfaces
{
	/**
	 * 可运动接口类
	 * 
	 */
	public interface IMotion extends IAnimation
	{
		/**
		* 运动每一帧执行回调函数
		* @param 			当前运动方向
		* 
		* @return			无
		*/
		function onMontionEnterFrame(obj:Object): void;
		/**
		* 获取运动对象的X,Y坐标
		* @param 			无
		* 
		* @return			X,Y坐标
		*/
		function get PosX(): Number; 
		function get PosY(): Number; 
		/**
		* 设置运动对象的X,Y坐标
		* @param 			X,Y坐标
		* 
		* @return			null
		*/
		function setPosX(posx: Number): void; 
		function setPosY(posy: Number): void; 
		/**
		* 取得运动对象的步长
		* @param 			null
		* 
		* @return			运动对象的步长
		*/
		function get Speed():Number;
	}
}
package com.pianfeng.engine.animation.data 
{
	import com.pianfeng.engine.global.interfaces.IDispose;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * 动画播放接口，实现播放动画需要的接口
	 * 经测试CPU耗时主要在画图成BitmapData上，优化采用把MC所有帧每帧都事先转换成BitmapData，画屏时直接取出BitmapData即可
	 * 
	 * @author jayxsjf
	 */
	public interface IAnimationObj extends IDispose
	{
		/**
		 * 取得动画效果对象总帧数
		 * @param 			无
		 * 
		 * @return			动画效果对象总帧数
		 */
		function getTotalFrames(): int;
		
		/**
		 * 取出mc帧标签对应的帧数
		 *
		 * @param frameLabel 	帧标签
		 * 
		 * @return				帧标签对应的帧数
		 */
		function getFrameByLabel(frameLabel: String): int;
		
		/**
		 * 根据帧取出相应BitmapData
		 * @param iFrame	对应帧数
		 * 
		 * @return			当前帧对应的BitmapData
		 */
		function getBitmapDataByFrame(iFrame: int = 1):BitmapData;
		
		/**
		 * 根据帧取出相应BitmapData并画在Graphics上
		 * @param Graphics		要画的Graphics对象
		 * @param iFrame		对应帧数
		 * 
		 * @return			true--成功  false--失败
		 */
		function drawFrameToGraphics(graphics: Graphics, iFrame: int = 1): Boolean;
		
		/**
		 * 根据帧取出相应DisplayObject
		 * 这里主要是把这帧对应的BitmapData重新生成一个DisplayObject,并且这个新的DisplayObject原点和原始的MC原点一样
		 * 
		 * @param iFrame	对应帧数
		 * 
		 * @return			当前帧对应的BitmapData
		 */
		function getDisplayObjectByFrame(iFrame: int = 1):DisplayObject;
		
		/**
		 * 根据帧取出相应的Bounds用于重画原点
		 * @param iFrame	对应帧数
		 * 
		 * @return			当前帧对应的Bounds
		 */
		function getBoundsByFrame(iFrame: int = 1):Rectangle;
		
		/**
		 * 获取显示对象的原点，主要用于合成物体时防止位置变动，只有合成对象改变时，才改变原点，
		 * 
		 * @param iFrame	对应帧数
		 * 
		 * @return			当前帧对应的Bounds
		 */
		function getOrigin(): Rectangle;
	}
	
}
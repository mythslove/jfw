package com.jfw.engine.core.interfaces
{
	import com.jfw.engine.core.animation.BmdMovieClip;

	/**
	 * 动画播放接口
	 * 
	 */
	public interface IAnimation extends IAnimatable,IDispose
	{
		/**
		 * 取得动画效果显示对象，用于在动画管理器里做唯一标志
		 * 
		 * @param 			无
		 * 
		 * @return			动画效果对象
		 */
		function get Instance(): BmdMovieClip;
		/**
		 * 播放
		 * @param 			无
		 * 
		 * @return			无
		 */
		function play(): void;
		/**
		 * 暂停 
		 * 
		 */		
		function pause(): void;
		/**
		 * 停止 
		 * 
		 */		
		function stop(): void;
		/**
		 * 动画效果对象是否正在播放
		 * @param 			无
		 * 
		 * @return			true是 false否
		 */
		function get isPlaying(): Boolean;
		/**
		 * 动作类型 
		 * @param value
		 * 
		 */		
		function set ActionType(value:String):void;
		/**
		 * 设置运动对象的方向
		 * @param 			运动对象的方向
		 * 
		 * @return			null
		 */
		function set Direction(dir: String): void;	
	}
}
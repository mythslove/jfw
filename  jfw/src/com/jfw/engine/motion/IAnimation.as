package com.jfw.engine.motion
{
	import com.jfw.engine.animation.IAnimatable;
	import com.jfw.engine.core.base.IDestory;
	
	import flash.display.DisplayObject;

	/**
	 * 动画播放接口
	 * 
	 */
	public interface IAnimation extends IAnimatable,IDestory
	{
		/**
		 * 取得动画效果显示对象，用于在动画管理器里做唯一标志
		 * 
		 * @param 			无
		 * 
		 * @return			动画效果对象
		 */
		function get Instance():DisplayObject;
		/**
		 * 动作类型 
		 * @param value
		 * 
		 */		
		function set ActionType(value:String):void;
		function get ActionType():String;
		/**
		 * 设置运动对象的方向
		 * @param 			运动对象的方向
		 * 
		 * @return			null
		 */
		function set Direction(dir: String):void;	
		function get Direction():String;
		
		/**
		 * 动画对象相对原点偏移量 
		 * @return 
		 * 
		 */		
		function get XOffset():Number;
		function get YOffset():Number;
		/**
		 * 脚下isoX坐标
		 * @return 
		 * 
		 */		
		function get FootX():Number;
		function set FootX(value:Number):void;
		/**
		 * 脚下isoY坐标
		 * @return 
		 * 
		 */			
		function get FootY():Number;
		function set FootY(value:Number):void;

		/** 播放动画 */
		function play():void;
		
		/** 暂停 */
		function pause():void;
		
		/** 停止 */
		function stop():void;
		
		/**
		 * 是否正在播放 
		 * @return 
		 * 
		 */		
		function get isPlaying():Boolean;
	}
}
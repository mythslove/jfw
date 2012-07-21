package com.jfw.engine.motion
{
	import com.jfw.engine.animation.IAnimatable;
	import com.jfw.engine.animation.Texture;
	import com.jfw.engine.core.base.IDestory;
	
	import flash.display.DisplayObject;

	/**
	 * 动画播放接口
	 * 
	 */
	public interface IAnimation extends IAnimatable,IDestory
	{
		/**
		 * 取得动画效果显示对象,承载资源
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
		 * 设置动画对象相对原点偏移量 ,此设置不会影响动画本身偏移量,主要用来给用户调整用
		 * @return 
		 * 
		 */		
		function set XAdjust(value:Number):void;
		function set YAdjust(value:Number):void;
		
		/**
		 * 脚下isoX坐标
		 * @return 
		 * 
		 */		
		function get OriginX():Number;
		function set OriginX(value:Number):void;
		/**
		 * 脚下isoY坐标
		 * @return 
		 * 
		 */			
		function get OriginY():Number;
		function set OriginY(value:Number):void;

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
		/**
		 * 当前贞标签
		 * @return 
		 * 
		 */		
		function get currentFrame():int;
		/**
		 * 根据贞标签获取纹理
		 * @param value
		 * @return 
		 * 
		 */		
		function getFrameTexture(frameID:int):Texture;
	}
}
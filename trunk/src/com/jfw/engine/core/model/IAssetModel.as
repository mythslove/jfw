package com.jfw.engine.core.model
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.IEventDispatcher;
	
	/** 静态资源库接口 */
	public interface IAssetModel
	{
		/** 是否存在该类 */
		function hasClass( name:String ):Boolean;
		
		/** 根据类名获取类 */
		function getClass( name:String ):Class;
		
		/** 根据类名获取类实例 */
		function getDisplayObj( name:String ):DisplayObject;
		
		/** 根据类名获取位图 */
		function getBitmap( name:String ):Bitmap;
		
		/** 根据类名获取位图数据 */
		function getBitmapData( name:String ):BitmapData;
	}
}
package app.battle.interfaces
{
	import flash.display.DisplayObject;

	public interface IDisplayObject
	{
		/** 获取对象本身*/	
		function get Instance():DisplayObject;
			
		/** 是否可见*/	
		function get Visible():Boolean;
		
		/** 是否可见*/	
		function set Visible(value:Boolean):void;
		
		/** 透明度*/	
		function get Alpha():Number;
		
		/** 透明度*/	
		function set Alpha(value:Number):void;
		
		/** 屏幕x坐标 */
		function get ScrX():Number;
		
		/** 屏幕y坐标 */
		function get ScrY():Number;
		
		/** 设置屏幕坐标 */
		function move(x:Number=0,y:Number=0):void;
		
		/** 暂停标志 */
		function get isPlaying():Boolean;
	}
}
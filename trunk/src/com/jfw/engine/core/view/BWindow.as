package com.jfw.engine.core.view
{
	import com.jfw.engine.core.base.CoreConst;
	import com.jfw.engine.core.data.IStruct;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	/** 窗口基类 */
	public class BWindow extends BPanel implements IWindow
	{
		/** 是否模式窗口 */
		public var isModal:Boolean = true;
		
		/** 是否可拖曳 */
		public var isDrag:Boolean = true;
		
		/** 是否支持缓动 */
		public var isTween:Boolean = true;
		
		/** 背景 */
		public var $bg:MovieClip = null;
		
		public function BWindow(cls_ref:Object=null, data:IStruct=null)
		{
			super( cls_ref, data );
		}
		
		override protected function onMouseClick(evt:MouseEvent):void
		{
			super.onMouseClick( evt );
			
			switch( getMcName( evt.target as DisplayObject ) )
			{
				case CoreConst.TAG_PB + 'Close':
					dispatchEvent( new Event( Event.CLOSE ) );
					break;
			}
		}
		
		override protected function onMouseDown(evt:MouseEvent):void
		{
			super.onMouseDown( evt );
			
			switch( getMcName( evt.target as DisplayObject ) )
			{
				case CoreConst.TAG_PB + 'Drag':
					var dragObj:Sprite = evt.target as Sprite;
					var w:int = dragObj.parent.stage.stageWidth - dragObj.parent.width;
					var h:int = dragObj.parent.stage.stageHeight - dragObj.height;
					var rect:Rectangle = new Rectangle(0,0,w,h);
					(dragObj.parent as Sprite).startDrag(false,rect);
					break;
			}
		}
		
		override protected function onMouseUp(evt:MouseEvent):void
		{
			super.onMouseUp( evt );
			
			switch (getMcName( evt.target as DisplayObject ) )
			{
				case CoreConst.TAG_PB + 'Drag':
					evt.target.parent.stopDrag();
					break;
			}
		}
		
		override public function get width():Number
		{
			if ( null != $bg )
				return $bg.width * scaleX;
			else
				return super.width * scaleX;
		}
		
		override public function get height():Number
		{
			if ( null != $bg )
				return $bg.height * scaleY;
			else
				return super.height * scaleY;
		}
	}
}
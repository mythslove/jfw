package com.jfw.engine.utils
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BitmapFilterType;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.filters.GradientGlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class FilterUtil
	{
		// 变灰
		public static function applyblack( child:DisplayObject ):void 
		{      
            var matrix:Array = new Array();
            matrix = matrix.concat([0.3086,0.6094,0.082,0,0]); // red
            matrix = matrix.concat([0.3086,0.6094,0.082,0,0]); // green
            matrix = matrix.concat([0.3086,0.6094,0.082,0,0]); // blue
            matrix = matrix.concat([0,0,0,1,0]); // alpha

            applyFilter(child, matrix);
        }
		
        public static function applyRed(child:DisplayObject):void {
           
            var matrix:Array = new Array();
            matrix = matrix.concat([1, 0, 0, 0, 0]); // red
            matrix = matrix.concat([0, 0, 0, 0, 0]); // green
            matrix = matrix.concat([0, 0, 0, 0, 0]); // blue
            matrix = matrix.concat([0, 0, 0, 1, 0]); // alpha

            applyFilter(child, matrix);
        }

        public static function applyGreen(child:DisplayObject):void {
            var matrix:Array = new Array();
            matrix = matrix.concat([0, 0, 0, 0, 0]); // red
            matrix = matrix.concat([0, 1, 0, 0, 0]); // green
            matrix = matrix.concat([0, 0, 0, 0, 0]); // blue
            matrix = matrix.concat([0, 0, 0, 1, 0]); // alpha

            applyFilter(child, matrix);
        }

        public static function applyBlue(event:Event):void {
            var child:DisplayObject = DisplayObject(event.target.loader);
            var matrix:Array = new Array();
            matrix = matrix.concat([0, 0, 0, 0, 0]); // red
            matrix = matrix.concat([0, 0, 0, 0, 0]); // green
            matrix = matrix.concat([0, 0, 1, 0, 0]); // blue
            matrix = matrix.concat([0, 0, 0, 1, 0]); // alpha

            applyFilter(child, matrix);
        }
		
		public static function applyContrast( child:DisplayObject, filter:ColorMatrixFilter = null ):void
		{
			if( !filter )
				filter = new ColorMatrixFilter([2.69,-0.61,-0.08,0,-128,-0.31,2.39,-0.08,0,-128,-0.31,-0.61,2.92,0,-128,0,0,0,1,0]);
			child.filters = [ filter ];
		}

        public static function applyFilter(child:DisplayObject, matrix:Array):void 
		{
            var filter:ColorMatrixFilter = new ColorMatrixFilter(matrix);
            var filters:Array = new Array();
            filters.push(filter);
            child.filters = filters;
        }
		
		/** 
		 * 鼠标经过楼体的滤镜效果
		 * @param 
		 */
		public static function setGlowFilter(child:DisplayObject,blurSize:int = 2,strengthSize:int = 1, col:uint = 0xffff00):void 
		{
				var color:Number=0xffffff;
				var alpha:Number=1;
				var blur:Number=blurSize;
				var strength:Number=strengthSize;
				var inner:Boolean=false;
				var knockout:Boolean=false;
				var quality:Number=BitmapFilterQuality.HIGH;
				//var _glowFilter:GlowFilter = new GlowFilter(color, alpha, blurX, blurY, strength, quality, inner, knockout);
				var _glowFilter:GradientGlowFilter = new GradientGlowFilter(0, 45, [col, col], [0, 1, 1, 1], [0, 63, 126, 255], blur, blur,strength, BitmapFilterQuality.HIGH, BitmapFilterType.OUTER, false);
				var filters:Array = new Array();
				filters.push(_glowFilter);
				child.filters = filters;
		}
		
		
		/**
		 * 设置字体描边样式
		 *  
		 * @param tx
		 * @param tf
		 * @param color
		 */
		public static function setFontFilter(tx:TextField,color:uint = 0x0,borderSize:int = 2):void 
		{
			var alpha:Number	= 1;
			var blurX:Number	= borderSize;
			var blurY:Number	= borderSize;
			var strength:Number = 10;
			var inner:Boolean	= false;
			var knockout:Boolean = false;
			var quality:Number=BitmapFilterQuality.LOW;
			var _glowFilter:BitmapFilter = new GlowFilter(color,alpha,blurX,blurY,strength, BitmapFilterQuality.LOW, inner, knockout)
			var filters:Array = new Array();
			filters.push(_glowFilter);
			
			tx.filters = filters;
		}
		
		/**
		 * 清除滤镜效果 
		 * 
		 */
		public static function clearGlowFilter(child:DisplayObject):void
		{
			child.filters = [];
		}
		
		/** 
		 * 鼠标移出墙纸的滤镜效果
		 * @param 
		 */
		public static function getGlowFilter(color:Number):GlowFilter
		{
			var _glowFilter:GlowFilter = null;
			var color:Number = color;
			var alpha:Number = 1;
			var blurX:Number = 6;
			var blurY:Number = 6;
			var strength:Number = 6;
			var inner:Boolean = false;
			var knockout:Boolean = false;
			var quality:Number = BitmapFilterQuality.HIGH;
			_glowFilter = new GlowFilter(color, alpha, blurX, blurY, strength, quality, inner, knockout);
			
			return _glowFilter;
		}
	}

}
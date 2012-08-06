package com.jfw.engine.utils
{
	import flash.display.BitmapData;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class ImageUtil
	{
		/**
		 * 为bitmapdata创建倒影
		 * pBitmpData: 需要制作倒影的BitmapData
		 * pMaxAlpha: 倒影的最大透明度
		 * pRate: 倒影的可见高度与实际图片的高度比
		 * pBlurValue: 倒影的虚化程度
		 */
		public static function getReflectionBitmapData(pBitmapData:BitmapData, pMaxAlpha:Number=1, pRate:Number=.67, pBlurValue:Number=-1):BitmapData
		{
			//建立一个空的BitmapData实例，与原图片大小相等。
			var bitmapdata:BitmapData = new BitmapData(pBitmapData.width,pBitmapData.height,true);
			//计算倒影需要显示的高度
			var drawHeight:Number = pRate*bitmapdata.height;
			//做一个循环，开始描绘倒影
			for(var j:int=0;j<=bitmapdata.height;j++)
			{
				//计算每一个纵向位置的透明度
				var alpha:int =Math.max(0,int((1-j/drawHeight)*pMaxAlpha*256));
				//将这个透明度换算成16进制的字符
				var str:String = alpha.toString(16);
				str = "0x"+str+"000000";
				//用这个透明度定义一个位图，用来提取透明度信息
				var alphaBitmapData:BitmapData = new BitmapData(bitmapdata.width, drawHeight, true, Number(str));
				//描绘倒影，一方面从原图片中反向提取颜色值，一方面从上一行定义的位图中提取透明度信息，每次描绘一个像素的高度
				bitmapdata.copyPixels(pBitmapData, new Rectangle(0,Math.floor(pBitmapData.height-j-1), bitmapdata.width,1), new Point(0,j),alphaBitmapData);
			}
			
			if(pBlurValue!=-1)
			{
				for(var c:int=0;c<=drawHeight;c++)
				{
					//给倒影添加虚化效果，最小为2，最大为2+pBlurValue，效果为横纵双向模糊
					var blur:int = 2+int(c*pBlurValue/drawHeight);
					bitmapdata.applyFilter(bitmapdata,new Rectangle(0,c,bitmapdata.width,1), new Point(0,c),new BlurFilter(blur,blur));
				}
			}
			//返回做好的倒影位图
			return bitmapdata;
		}
		
		/**
		 * 获取图片放入容器内可显示的最大位置、尺寸
		 * @param pImageW 图片宽度
		 * @param pImageH 图片高度
		 * @param pBoxW 容器宽度
		 * @param pBoxH 容器高度
		 * @return 
		 */		
		public static function getMaxSize(pImageW:Number,pImageH:Number,pBoxW:Number,pBoxH:Number):Rectangle
		{
			var rect:Rectangle = new Rectangle(0,0,10,10);
			//求得图片的宽高比例，然后和容器的宽高比例相对比，来决定到底是按照容器的宽还是高来resize图片
			var rate:Number = pImageW/pImageH;
			var rateBox:Number = pBoxW/pBoxH;
			if(rate > rateBox)
			{
				rect.width = pBoxW;
				rect.height = pBoxW/rate;
			}else
			{
				rect.height = pBoxH;
				rect.width = pBoxH*rate;
			}
			rect.x = pBoxW/2-rect.width/2;
			rect.y = pBoxH/2-rect.height/2;
			
			return rect;
		}
		
		/**
		 * 获取图片放入容器内可显示的最小位置、尺寸
		 * @param pImageW 图片宽度
		 * @param pImageH 图片高度
		 * @param pBoxW 容器宽度
		 * @param pBoxH 容器高度
		 * @return 
		 */	
		public static function getMinSize(pImageW:Number,pImageH:Number,pBoxW:Number,pBoxH:Number):Rectangle
		{
			var rect:Rectangle = new Rectangle(0,0,10,10);
			var rate:Number = pImageW/pImageH;
			var rateBox:Number = pBoxW/pBoxH;
			if(rate > rateBox)
			{
				rect.height = pBoxH;
				rect.width = pBoxH*rate;
			}else
			{
				rect.width = pBoxW;
				rect.height = pBoxW/rate;
			}
			rect.x = pBoxW/2-rect.width/2;
			rect.y = pBoxH/2-rect.height/2;
			
			return rect;
		}
	}
}
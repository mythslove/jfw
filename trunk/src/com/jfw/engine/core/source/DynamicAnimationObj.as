package com.pianfeng.engine.animation.data 
{
	import com.pianfeng.engine.global.interfaces.IDispose;
	import com.pianfeng.engine.resource.IResourceManager;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.system.System;
	/**
	 * 单个动态动画类，主要把一个MovieClip转换成IAnimationObj接口,这是动态动画类，如果第一次没有则先去下载这个文件
	 * 这个动态动画类和CombinDynamicAnimationObj动态动画类区别在于：DynamicAnimationObj可以取到源MovieClip的Bounds,并画在源MovieClip原点上
	 * 所以DynamicAnimationObj画出来的和源MovieClip一样的，原点都对齐了
	 * 
	 * 而CombinDynamicAnimationObj因为动画是合成的，所以没有整个的MovieClip的Bounds，但是可以取最底的图像Bounds为基准
	 * 
	 */
	public class DynamicAnimationObj extends AbsDynamicAnimationObj implements IAnimationObj
	{
		private var FName: String;
		private var FHeight:int = 0;
		
		/**
		 * 构造函数
		 * 
		 * @param resourceManager 	关联的资源管理器
		 * @param name				资源在资源管理器的唯一ID
		 * @param drawDefault		当资源不存在是否用资源管理器的缺省代替，默认为是(true)
		 * 
		 */		
		public function DynamicAnimationObj(resourceManager: IResourceManager,name: String,drawDefault: Boolean=true) 
		{
			FName = name;
			super(resourceManager, drawDefault);
		}
		
		/**
		 * 根据帧取出相应BitmapData并画在Graphics上
		 * @param Graphics	要画的Graphics对象
		 * @param iFrame	对应帧数
		 * 
		 * @return			true--成功  false--失败
		 */
		override public function drawFrameToGraphics(graphics: Graphics, iFrame: int = 1): Boolean {
			if (graphics == null) return false;
			var _animation: IAnimationObj = FResourceManager.getAnimation(FName);
			if (_animation == null) return super.drawFrameToGraphics(graphics,iFrame);
			
			var _bmpdata: BitmapData = _animation.getBitmapDataByFrame(iFrame);
			var _bounds: Rectangle = _animation.getBoundsByFrame(iFrame);				
			if ((_bmpdata == null) || (_bounds == null)) return false;
			
			with (graphics) {
				clear();
				beginBitmapFill(_bmpdata, new Matrix(1, 0, 0, 1, _bounds.x, _bounds.y), false, false);
				drawRect(_bounds.x, _bounds.y, _bmpdata.width, _bmpdata.height);
				endFill();
				
				//如果没有取到原点则取原点
				if (!FOrginGeted) {
					FOrgin = _bounds;
					FOrginGeted = true;
				}
			}
			
			if(_bounds.height > this.FHeight)
				this.FHeight = _bounds.height;
				
			return true;
		}
		
		/**
		 * 取出mc对应帧的BitmapData
		 *
		 * @param iFrame 	对应帧数
		 * 
		 * @return			当前帧对应的BitmapData
		 */
		override public function getBitmapDataByFrame(iFrame: int = 1): BitmapData {
			var _animation: IAnimationObj = FResourceManager.getAnimation(FName);
			if (_animation == null) return super.getBitmapDataByFrame(iFrame);
			else return _animation.getBitmapDataByFrame(iFrame);
		}
		
		/**
		 * 根据帧取出相应DisplayObject
		 * 这里主要是把这帧对应的BitmapData重新生成一个DisplayObject,并且这个新的DisplayObject原点和原始的MC原点一样
		 * 
		 * @param iFrame	对应帧数
		 * 
		 * @return			当前帧对应的BitmapData
		 */
		override public function getDisplayObjectByFrame(iFrame: int = 1):  DisplayObject{
			var _animation: IAnimationObj = FResourceManager.getAnimation(FName);
			if (_animation == null) return super.getDisplayObjectByFrame(iFrame);
			else return _animation.getDisplayObjectByFrame(iFrame);
		}
		
		/**
		 * 取出mc帧标签对应的帧数
		 *
		 * @param frameLabel 	帧标签
		 * 
		 * @return				帧标签对应的帧数
		 */
		override public function getFrameByLabel(frameLabel: String): int{
			var _animation: IAnimationObj = FResourceManager.getAnimation(FName);
			if (_animation == null) return super.getFrameByLabel(frameLabel);
			return _animation.getFrameByLabel(frameLabel);
		}
		
		/**
		 * 取得动画效果对象总帧数
		 * @param 			无
		 * 
		 * @return			动画效果对象总帧数
		 */
		override public function getTotalFrames(): int{
			var _animation: IAnimationObj = FResourceManager.getAnimation(FName);
			if (_animation == null) return super.getTotalFrames();
			return _animation.getTotalFrames();
		}
		
		/**
		 * 取得动画对象的高度
		 * @param 			无
		 * 
		 * @return			动画对象高度
		 */
		public function getHeight(): int{
			return this.FHeight
		}
		
		
		/**
		 * 根据帧取出相应的Bounds用于重画原点
		 * @param iFrame	对应帧数
		 * 
		 * @return			当前帧对应的Bounds
		 */
		override public function getBoundsByFrame(iFrame: int=1): Rectangle {
			var _animation: IAnimationObj = FResourceManager.getAnimation(FName);
			if (_animation == null) return super.getBoundsByFrame(iFrame);
			else return _animation.getBoundsByFrame(iFrame);
		}
		
		override public function dispose(): void {
			super.dispose();
		}
	}
	
}
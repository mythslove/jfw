package com.pianfeng.engine.animation.data 
{
	import com.pianfeng.engine.global.interfaces.IDispose;
	import com.pianfeng.engine.resource.IResourceManager;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.geom.Rectangle;
	import flash.utils.getQualifiedClassName;
	/**
	 * 动态动画数据类的虚拟类，动态动画数据类关联一个IResourceManager,通过IResourceManager去资源管理器取出资源
	 * 
	 */
	public class AbsDynamicAnimationObj implements IAnimationObj
	{
		/**
		 * 关联的资源管理器
		 */
		protected var FResourceManager: IResourceManager;
		/**
		 * 当资源不存在时，是否返回默认资源的相应函数
		 */			
		protected var FDrawDefault: Boolean;
		/**
		 *第一个资源的Bounds，主要用于合成时保持位置一致 
		 */		
		protected var FOrgin: Rectangle;
		/**
		 * 资源的Bounds是否取到
		 */		
		protected var FOrginGeted: Boolean;
		
		protected var FDefaultResource: IAnimationObj;
		/**
		 * 构造函数
		 * 
		 * @param resourceManager	关联的资源管理器 
		 * @param drawDefault		当资源不存在时，是否返回默认资源的相应函数，缺省为false
		 * 
		 */		
		public function AbsDynamicAnimationObj(resourceManager: IResourceManager,drawDefault: Boolean=true) 
		{
			if (getQualifiedClassName(this) == "com.pianfeng.engine.animation.data::AbsDynamicAnimationObj") {
				throw new ArgumentError("AbsDynamicAnimationObj can't be instantiated directly");
			}
			
			FOrgin = null;
			FOrginGeted = false;
			FDefaultResource = null;
			
			FDrawDefault = drawDefault;
			FResourceManager = resourceManager;
		}
		
		/**
		 * 设置缺省资源，如果为空则取 ResourceManager中的缺省资源
		 * 
		 * @param animation 缺省的资源
		 * @return 
		 * 
		 */				
		public function setDefaultResource(animation: IAnimationObj): void{
			FDefaultResource = animation;
		}
		
		/**
		 * 实现 IAnimation接口，主要调用IResourceManager的缺省资源（IAnimation接口）的操作
		 * 
		 * @param graphics
		 * @param iFrame
		 * @return 
		 * 
		 */		
		
		public function drawFrameToGraphics(graphics: Graphics, iFrame: int = 1): Boolean {
			if (FDrawDefault){
				if (FDefaultResource != null) FDefaultResource.drawFrameToGraphics(graphics, iFrame);
				else if (FResourceManager.getDefaultAnimation() != null) {
					FResourceManager.getDefaultAnimation().drawFrameToGraphics(graphics, iFrame);
				}
			}
			return false;
		}
		
		/**
		 * 实现 IAnimation接口，主要调用IResourceManager的缺省资源（IAnimation接口）的操作
		 * 
		 * @param graphics
		 * @param iFrame
		 * @return 
		 * 
		 */
		public function getBitmapDataByFrame(iFrame: int = 1): BitmapData {
			if (FDrawDefault && (FResourceManager.getDefaultAnimation() != null))
				return FResourceManager.getDefaultAnimation().getBitmapDataByFrame(iFrame);
			else return null;
		}
		
		/**
		 * 实现 IAnimation接口，主要调用IResourceManager的缺省资源（IAnimation接口）的操作
		 * 
		 * @param graphics
		 * @param iFrame
		 * @return 
		 * 
		 */
		public function getDisplayObjectByFrame(iFrame: int = 1): DisplayObject {
			if (FDrawDefault && (FResourceManager.getDefaultAnimation() != null))
				return FResourceManager.getDefaultAnimation().getDisplayObjectByFrame(iFrame);
			else return null;
		}
		
		/**
		 * 实现 IAnimation接口，主要调用IResourceManager的缺省资源（IAnimation接口）的操作
		 * 
		 * @param graphics
		 * @param iFrame
		 * @return 
		 * 
		 */
		public function getFrameByLabel(frameLabel: String): int {
			if (FDrawDefault && (FResourceManager.getDefaultAnimation() != null))
				return FResourceManager.getDefaultAnimation().getFrameByLabel(frameLabel);
			else return 1;
		}
		
		/**
		 * 实现 IAnimation接口，主要调用IResourceManager的缺省资源（IAnimation接口）的操作
		 * 
		 * @param graphics
		 * @param iFrame
		 * @return 
		 * 
		 */
		public function getTotalFrames(): int {
			if (FDrawDefault && (FResourceManager.getDefaultAnimation() != null))
				return FResourceManager.getDefaultAnimation().getTotalFrames();
			else return 1;
		}
		
		/**
		 * 实现 IAnimation接口，主要调用IResourceManager的缺省资源（IAnimation接口）的操作
		 * 
		 * @param graphics
		 * @param iFrame
		 * @return 
		 * 
		 */
		public function getBoundsByFrame(iFrame: int = 1): Rectangle {
			if (FDrawDefault && (FResourceManager.getDefaultAnimation() != null))
				return FResourceManager.getDefaultAnimation().getBoundsByFrame(iFrame);
			else return null;
		}
		
		/**
		 * 实现 IAnimation接口，主要调用IResourceManager的缺省资源（IAnimation接口）的操作
		 * 
		 * @param graphics
		 * @param iFrame
		 * @return 
		 * 
		 */
		public function getOrigin(): Rectangle {
			return FOrgin;
		}
		
		/**
		 * 实现 IAnimation接口，主要调用IResourceManager的缺省资源（IAnimation接口）的操作
		 * 
		 * @param graphics
		 * @param iFrame
		 * @return 
		 * 
		 */
		public function dispose(): void {
			FResourceManager = null;
		}
	}
	
}
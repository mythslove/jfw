package app.manager
{
	import com.jfw.engine.animation.BmdAtlas;
	import com.jfw.engine.animation.Texture;

	public interface IResourceManager
	{
		/**
		 * 资源类名
		 * @param srcID 资源id
		 * @param callBack
		 * 
		 */		
		function loadRes( srcID:String,callBack:Function):void;
		/**
		 * 获取默认图片 
		 * @param type
		 * 
		 */
		function getDefaultSource():Vector.<Texture>;
		/**
		 * 获得资源
		 * @param srcID 资源id
		 * @return 
		 * 
		 */		
		function getSource(srcID:String):BmdAtlas;
	}
}
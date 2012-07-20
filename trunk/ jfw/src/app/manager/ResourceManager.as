package app.manager
{
	import app.model.events.LoadingEvent;
	
	import com.jfw.engine.animation.BmdAtlas;
	import com.jfw.engine.animation.Texture;
	import com.jfw.engine.core.base.Core;
	import com.jfw.engine.core.base.Observer;
	import com.jfw.engine.core.data.LoadStruct;
	import com.jfw.engine.core.mvc.model.IAssetModel;
	import com.jfw.engine.core.mvc.model.IConfigModel;
	import com.jfw.engine.utils.Queue;
	import com.stimuli.loading.BulkLoader;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.Dictionary;

	/**
	 * 
	 * @author 
	 * 
	 */	
	public class ResourceManager extends EventDispatcher implements IResourceManager
	{
		static private var instance:ResourceManager=null;
		/** 下载失败重试次数 */
		static private const RETRY_LIMIT:int = 10;
		
		private var resDic:Vector.<AnimationSource>=null;
		private var loaderDir:Vector.<BulkLoader>=null;
		
		public function ResourceManager(target:IEventDispatcher=null)
		{
			super(target);
			resDic = new Vector.<AnimationSource>();
		}
		
		static public function getInstance():ResourceManager
		{
			if( !instance )
				instance = new ResourceManager();
			return instance;
		}
		/**
		 * 
		 * @param name 暂时用类名
		 * @param callBack
		 * 
		 */		
		public function loadRes(srcID:String,callBack:Function):void
		{
			//加配置文件
			//读取资源根路径
			
//			if(resDic==null)
//				resDic=new Vector.<AnimationSource>();
//
//			if(resDic[name])
//				return;
//			
//			var task:AnimationSource=new AnimationSource();
//			task.className=name;
//			task.callBack=callBack;
//			resDic.push(task);
//			
//			if(loaderDir==null)
//				loaderDir=new Vector.<BulkLoader>();
//			
//			var loader:BulkLoader=new BulkLoader(name);
//			
//			var loaderContext:LoaderContext = new LoaderContext();
//			loaderContext.applicationDomain = ApplicationDomain.currentDomain;
		}
		
		public function getDefaultSource():Vector.<Texture>
		{
//			var bmd:BitmapData=AssetsManager.Instance.getTexture("UnknownIcon");
//			textures.push( new Texture(bmd,bmd.rect,bmd.rect));
			return null;
		}
	
		public function getSource(srcID:String):BmdAtlas
		{
			return null;
		}
		
		/**
		 * 获取配置model 
		 * @return 
		 * 
		 */
		private function get config():IConfigModel
		{
			return Core.getInstance().configModel;
		}
		
		/**
		 * 获取资源model 
		 * @return 
		 * 
		 */
		private function get assets():IAssetModel
		{
			return Core.getInstance().assetsModel;
		}
	}
}
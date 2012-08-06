package app.manager
{
	import app.battle.consts.PrefixConst;
	
	import com.jfw.engine.animation.BmdAtlas;
	import com.jfw.engine.animation.Texture;
	import com.jfw.engine.core.base.Core;
	import com.jfw.engine.core.data.LoadStruct;
	import com.jfw.engine.core.mvc.model.IAssetModel;
	import com.jfw.engine.core.mvc.model.IConfigModel;
	import com.stimuli.loading.BulkLoader;
	import com.stimuli.loading.BulkProgressEvent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	/**
	 * 
	 * @author 
	 * 只有判断xml于bitmap同时存在才返回指定纹理
	 * 资源名必须为C打头,纹理名必须是T打头
	 */	
	public class ResourceManager extends EventDispatcher implements IResourceManager
	{
		static private var instance:ResourceManager=null;
		/** 下载失败重试次数 */
		static private const RETRY_LIMIT:int = 10;
		
		private var resDic:Dictionary=null;
		private var bulkLoader:BulkLoader=null;
		private var loaderContext:LoaderContext=null;
		
		public function ResourceManager(target:IEventDispatcher=null)
		{
			super(target);
			resDic = new Dictionary();
			bulkLoader=new BulkLoader('animation');
			bulkLoader.logLevel = BulkLoader.LOG_ERRORS;
			loaderContext= new LoaderContext();
			loaderContext.applicationDomain = ApplicationDomain.currentDomain;
		}
		
		static public function get Instance():ResourceManager
		{
			if( !instance )
				instance = new ResourceManager();
			return instance;
		}
		/**
		 * 
		 * @param srcID 不带前缀
		 * @param callBack
		 * 
		 */		
		public function loadRes(srcID:String,callBack:Function):void
		{
			if(resDic[srcID])
			{
				(resDic[srcID] as AnimationSource).callBackArr.push(callBack);
				return;
			}
			else
			{
				var task:AnimationSource=new AnimationSource(srcID,callBack);
				resDic[srcID]=task;
			}
			
			var cName:String=PrefixConst.CHAR_SRC+srcID;
			var bmd:BitmapData=assetsModel.getBitmapData(cName);
			
			if(bmd==null)
				this.addTask(cName);

			var tName:String=PrefixConst.TEXTURE+srcID;
			var xml:XML=assetsModel.getXML(tName);
			
			if(xml==null)
				this.addTask(tName);
		}
		
		public function getDefaultSource():BitmapData
		{
			return assetsModel.getBitmapData(PrefixConst.DEFAULT);
		}
		/**
		 * 根据id
		 * 获取纹理资源 
		 * @param srcID 无标签id 
		 * @return 
		 * 
		 */	
		public function getSource(srcID:String):BmdAtlas
		{
			var cName:String=PrefixConst.CHAR_SRC+srcID;
			var tName:String=PrefixConst.TEXTURE+srcID;
			
			var bmd:BitmapData=assetsModel.getBitmapData(cName);
			var xml:XML=assetsModel.getXML(tName);
			
			if(bmd==null||xml==null)
				return null;
			else
				return new BmdAtlas(bmd,xml);
		}

		private function onSingleLoaded(evt:BulkProgressEvent):void
		{
			if(bulkLoader.isFinished)
				bulkLoader.removeEventListener(BulkProgressEvent.SINGLE_COMPLETE,onSingleLoaded);
			
			if( LoadStruct.TYPE_BINARY == evt.item.type )
			{
				var content:ByteArray = bulkLoader.getBinary( evt.item.id );
				
				try
				{
					content.uncompress( );
				}
				catch( e:Error )
				{
					throw e;
				}
				
				assetsModel.addXML(evt.item.id,XML( content ));
			}

			bulkLoader.remove(evt.item.id);
			var bmdAtlas:BmdAtlas=getSource(this.getID(evt.item.id));
			
			if(bmdAtlas)
			{
				var source:AnimationSource=resDic[this.getID(evt.item.id)];
				
				for each(var back:Function in source.callBackArr)
				{
					back(bmdAtlas);
				}

				source.dispose();
				delete resDic[this.getID(evt.item.id)];
				source=null;
			}
		}
		/**
		 *  
		 * @param id 带前缀的id
		 * @param type
		 * @return 
		 * 
		 */		
		public function addTask(id:String):void
		{
			var assets:LoadStruct=getConfigObj(id);
			
			if(assets==null)
				return;
			
			bulkLoader.add( assets.path, 
				{ 
					id:assets.id,
					maxTries:RETRY_LIMIT,
					type:assets.type,
					context:loaderContext 
				} 
			);
			
			if(!(bulkLoader.isRunning&&bulkLoader.itemsTotal>0))
			{
				bulkLoader.addEventListener( BulkProgressEvent.SINGLE_COMPLETE, onSingleLoaded );
				bulkLoader.start();
			}
		}
		/**
		 * 去掉前缀 
		 * @param id
		 * @return 
		 * 
		 */	
		private function getID(id:String):String
		{
			return id.substring(1,id.length);
		}
		/**
		 * 判断是否有此资源 
		 * @param id
		 * @return 
		 * 
		 */		
		private function getConfigObj(id:String):LoadStruct
		{
			var assetsAry:Array = configModel.configData[PrefixConst.ASSETS];
			
			for each(var obj:Object in assetsAry)
			{
				if(obj.id==id)
					return new LoadStruct(obj);
			}
			
			return null;
		}
		
		public function dispose():void
		{

			for each(var key:String in resDic)
			{
				(resDic[key] as AnimationSource).dispose();
				delete resDic[key];
				resDic[key]=null;
			}
			
			resDic=null;
			bulkLoader.clear();
			bulkLoader.removeEventListener(BulkProgressEvent.SINGLE_COMPLETE, onSingleLoaded );
			bulkLoader=null;
			loaderContext=null;
		}
		/**
		 * 获取配置model 
		 * @return 
		 * 
		 */
		private function get configModel():IConfigModel
		{
			return Core.getInstance().configModel;
		}
		
		/**
		 * 获取资源model 
		 * @return 
		 * 
		 */
		private function get assetsModel():IAssetModel
		{
			return Core.getInstance().assetsModel;
		}
	}
}
package examples.resourceManager
{
	import app.control.events.LoadingEvent;
	
	import com.jfw.engine.core.base.Core;
	import com.jfw.engine.core.base.Observer;
	import com.jfw.engine.core.data.LoadStruct;
	import com.jfw.engine.core.mvc.model.ILoadModel;
	import com.jfw.engine.core.mvc.model.IConfigModel;
	import com.jfw.engine.utils.Queue;
	
	import flash.utils.Dictionary;

	/**
	 * 
	 * @author 
	 * 
	 */	
	public class ResourceManager extends Observer implements IResourceManager
	{
		static private var instance:ResourceManager
		
		private var resDic:Dictionary ;
		
		public function ResourceManager()
		{
			super();
			
			if( instance )
				throw new Error("ResourceManager 是单例类");
			instance = this;
			
			resDic = new Dictionary();
		}
		
		static public function getInstance():ResourceManager
		{
			if( !instance )
				instance = new ResourceManager();
			return instance;
		}
		
		public function loadRes( name:String,callBack:Function = null ):void
		{
			if( !this.assets.hasClass( name ) )
			{
				this.resDic[ name ] = callBack;
				var loadStruct:LoadStruct = this.config.getVal( name );
				this.assets.loadRes( [ loadStruct ] );
				return;
			}
			callBack( this.assets.getClass( name ) );
		}
		
		override protected function listEventInterests():Array
		{
			return [
			];
		}
		
		override protected function handleEvent(evt:String, param:Object):void
		{
			super.handleEvent ( evt,param );
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
		private function get assets():ILoadModel
		{
			return Core.getInstance().assetsModel;
		}
	}
}
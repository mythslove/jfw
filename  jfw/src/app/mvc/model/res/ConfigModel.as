package app.mvc.model.res
{
	import app.mvc.model.data.ConfigStruct;
	
	import com.jfw.engine.core.data.IStruct;
	import com.jfw.engine.core.data.LoadStruct;
	import com.jfw.engine.core.mvc.model.IConfigModel;
	import com.jfw.engine.core.mvc.model.LoadModel;
	import com.jfw.engine.utils.data.XMLUtil;
	import com.jfw.engine.utils.json.JSON;
	import com.jfw.engine.utils.logger.Logger;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.system.ApplicationDomain;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	
	public class ConfigModel extends LoadModel implements IConfigModel
	{
		
		/** 配置文件 */
		private var configStruct:ConfigStruct = null;
		
		/** 资源列表,以id为索引 */
		private var assetsAry:Array = null;
		
		public function ConfigModel()
		{
			super();
			assetsAry = [];
		}
		
		public function get configData( ):IStruct
		{
			return this.configStruct;
		}
		
		/**
		 * 根据id获得资源对象
		 * @param id	资源id
		 * @param p		是否是预加载项
		 * @return 
		 * 
		 */
		public function getVal( id:String,p:Boolean = false ):LoadStruct
		{
			var loadStruct:LoadStruct = null;
			var i:int = 0;
			var len:int = 0;
			
			if( p )
			{
				len = this.configStruct.preload.length;
				for( i = 0;i<len;i++ )
				{
					if( id == this.configStruct.preload[i].id )
						loadStruct = new LoadStruct( this.configStruct.preload[i] );
				}
			}
			else
			{
				len = this.configStruct.assets.length;
				for( i = 0;i < len; i++ )
				{
					if( id == this.configStruct.assets[i].id )
						loadStruct = new LoadStruct( this.configStruct.assets[i] );
				}
			}
			
			return loadStruct;
		}
		
		override public function result():void
		{
			Logger.info( "ConfigModel load finish..." );
			this.dispatchEvent( new Event( Event.COMPLETE ) );
		}
		
		override protected function getBaseAssetsList():Array
		{
			var config:LoadStruct = new LoadStruct();
			config.id = 'config';
			config.name = '配置文件';
			config.desc = '游戏主配置文件';
			config.path = 'assets.dat';
			config.type = 'binary';
			
			return [ config	];
		}
		
		override protected function initAssets( ):void
		{
			var content:ByteArray = loader.getBinary( 'config' );
			try
			{
				content.uncompress( );
			}
			catch( e:Error )
			{
//				Debugger.trace( this,e.errorID + ':' + e.message );
			}
//			trace( this,XML( content ) );
//			Debugger.trace( this,XMLUtil.xml2Json(XML(content)));
//			Debugger.trace( this, XMLUtil.xml2Obj( XML( content ) ) );
			this.configStruct = new ConfigStruct( XMLUtil.xml2Obj( XML( content ) ) );
		}
	}
}
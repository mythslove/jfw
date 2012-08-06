package app.mvc.model.data
{
	import com.jfw.engine.core.data.BaseStruct;
	
	public class ConfigStruct extends BaseStruct
	{
		/** 网关 */
		public var gateway:String ;
		
		/** 语言 */
		public var lang:String ;
		
		/** 预加载资源 */
		public var preload:Array;
		
		/** 资源 */
		public var assets:Array ;
		
		public function ConfigStruct(obj:Object=null)
		{
			super(obj);
		}
		
		override public function clone():Object
		{
			var to:Object = super.clone();
			
			to.gateway = this.gateway;
			to.lang = this.lang;
			to.preload = this.preload;
			to.assets = this.assets;
			
			return to;
		}
		
		override protected function parse(obj:Object):void
		{
			super.parse( obj );
			
			this.gateway = String(obj.gateway.url);
			this.lang = String(obj.lang.code);
			this.preload = ( obj.preload.i is Array ) ? obj.preload.i : [obj.preload.i];
			this.assets = ( obj.assets.i is Array ) ? obj.assets.i : [obj.assets.i];
		}
	}
}
package app.mvc.model.data
{
	import com.jfw.engine.core.data.BaseStruct;
	
	import flash.display.Sprite;
	
	public class LoadPicStruct extends BaseStruct
	{
		//显示容器
 		public var mc:Sprite;
		//资源ID
		public var srcid:String;
		//缩放
		public var scale:int = -1;
		
		public function LoadPicStruct(obj:Object=null)
		{
			super(obj);
		}
		
		override protected function parse(obj:Object):void
		{
			super.parse( obj );
			this.mc = obj.mc;
			this.srcid = obj.srcid;
			this.scale = obj.scale ? obj.scale : -1;
		}
	}
}
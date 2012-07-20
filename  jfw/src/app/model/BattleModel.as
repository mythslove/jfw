package app.model
{
	import com.jfw.engine.core.data.IStruct;
	import com.jfw.engine.core.data.LoadStruct;
	import com.jfw.engine.core.mvc.model.LoadModel;
	import com.jfw.engine.isolib.map.data.IMapData;
	
	import flash.display.Bitmap;

	/**
	 * 战斗数据 
	 * @author Administrator
	 * 
	 */	
	public class BattleModel extends LoadModel
	{
		public var createBattleVO:Object=null;
		public var mapdata:IMapData=null;
		public var mapID:String;
		public var mapBG:Bitmap=null;
		
		public function BattleModel()
		{
			super();
		}
		
		
		/**
		 * 启动总加载 
		 * @param vo
		 * 
		 */		
		public function startLoad(vo:Object):void
		{
			var task:LoadStruct=new LoadStruct();
			task.id="3201001";
			task.type=LoadStruct.TYPE_MOVIECLIP;
			
			
		}
		
		protected function addTask():void
		{
			if(baseAssetsList==null)
				baseAssetsList=[];
		
			this.core.configModel.configData['preload'];
//
//				var loadStruct:LoadStruct = new LoadStruct( assetsAry[i] );
//				loadStruct.id = assetsAry[i].id;
//				loadStruct.path = loadStruct.path.replace( '$lang$' , this.core.configModel.configData['lang'] );
//				loadStruct.type = assetsAry[i].type;
//				assets.push( loadStruct );
//			

		}
		
		/**
		 * 需要完成后要做的事
		 * @return 
		 * 
		 */
		override protected function initAssets():void
		{
			
		}
	}
}
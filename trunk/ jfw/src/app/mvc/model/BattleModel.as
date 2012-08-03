package app.mvc.model
{
	import app.battle.DataProvider;
	import app.battle.interfaces.IRole;
	import app.battle.role.Role;
	import app.battle.consts.PrefixConst;
	import app.mvc.control.events.BattleEvent;
	
	import com.jfw.engine.core.data.IStruct;
	import com.jfw.engine.core.data.LoadStruct;
	import com.jfw.engine.core.mvc.model.LoadModel;
	import com.jfw.engine.isolib.map.data.IMapData;
	import com.jfw.engine.isolib.map.data.MapData;
	import com.stimuli.loading.BulkLoader;
	import com.stimuli.loading.BulkProgressEvent;
	
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
		protected var taskList:Array=null;
		
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
			addTask(DataProvider.Instance.getMapBgById('3201001'));
			addTask(DataProvider.Instance.getMapIdById('3201001'));
			this.loadRes(taskList);
		}
		
		public function createRole(id:String):IRole
		{
			return new Role(id);
		}
		
		public function loadMap(id:String):void
		{
			
		}
		
		public function loadCharacter(id:String):void
		{
			
		}
		
		public function loadDefItem(id:String):void
		{
			
		}
		
		public function loadMagicItem(id:String):void
		{
			
		}
		/**
		 * 添加一项加载任务 
		 * @param id
		 * 
		 */		
		protected function addTask(id:String):void
		{
			if(taskList==null)
				taskList=[];
			
			var obj:Object=getConfigObj(id);
			
			if(obj==null)
				return;
			
			var loadStruct:LoadStruct = new LoadStruct(obj);
			taskList.push( loadStruct );
		}
		/**
		 * 判断是否有此资源 
		 * @param id
		 * @return 
		 * 
		 */		
		protected function getConfigObj(id:String):Object
		{
			var assetsAry:Array = this.core.configModel.configData[PrefixConst.ASSETS];
			
			for each(var obj:Object in assetsAry)
			{
				if(obj.id==id)
					return obj;
			}
			
			return null;
		}
		/**
		 * 根据前缀判断类型 
		 * @param prefix
		 * @return 
		 * 
		 */		
		protected function getTypeByPrefix(prefix:String):String
		{
			return null;
		}

		override protected function onSingleAssetLoaded( evt:BulkProgressEvent ):void
		{
			super.onSingleAssetLoaded(evt);
		}
		/**
		 * 需要完成后要做的事
		 * @return 
		 * 
		 */
		override protected function initAssets():void
		{
			this.mapdata=new MapData(this.getXML(DataProvider.Instance.getMapBgById('3201001')));
			this.mapBG=this.getBitmap(DataProvider.Instance.getMapIdById('3201001'));
			
			this.sendEvent(BattleEvent.BATTLE_RES_LOAD_COMPLETE);
		}
	}
}
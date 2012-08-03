package app.battle.magic
{
	import app.battle.consts.DragConst;
	import app.battle.consts.GlobalConst;
	import app.battle.consts.PrefixConst;
	import app.battle.consts.RoleConst;
	import app.battle.interfaces.IBattleItem;
	import app.battle.interfaces.IRole;
	import app.battle.utils.SphereMetrics;
	import app.manager.IResourceManager;
	import app.manager.ResourceManager;
	import app.vo.SkillVO;
	
	import com.jfw.engine.isolib.map.data.IMapData;
	import com.jfw.engine.isolib.map.data.Tile;
	import com.jfw.engine.motion.center.AsynCenterAnimation;
	import com.jfw.engine.motion.center.CenterAnimation;
	
	import flash.display.DisplayObject;
	import flash.geom.Point;

	/**
	 * 技能道具
	 * @author Administrator
	 * 
	 */	
	public class SkillItem extends AsynCenterAnimation implements IBattleItem
	{
		protected var singleId:int=0;
		protected var vo:SkillVO=null;
		protected var mapdata:IMapData=null;
		protected var belong:int=0;
		protected var owner:IRole=null;
		protected var gridX:int=0;
		protected var gridY:int=0;
		protected var type:int=0;
		protected var dType:int=DragConst.MAGIC_ITEM;
		protected var isDroped:Boolean=false;
		protected var sourceManager:IResourceManager=null;
		/**
		 * 
		 * @param vo
		 * @param mapdata
		 * @param owner 所有人
		 * @param belong 所属阵营
		 * 
		 */		
		public function SkillItem(vo:SkillVO=null,mapdata:IMapData=null,owner:IRole=null,belong:int=RoleConst.IMPARTIAL)
		{
			this.vo=vo;
			this.mapdata=mapdata;
			this.owner=owner;
			this.belong=belong;
			this.sourceManager=ResourceManager.Instance;

			super(vo.skillItemSrcID, sourceManager, PrefixConst.SKILL,sourceManager.getDefaultSource(), GlobalConst.FPS);
		}
		
		public function get Name():String
		{
			return vo.skillName;
		}
		
		public function get Desc():String
		{
			return vo.skillDesc;
		}
		
		public function get Belong():int
		{
			return this.belong;
		}
		
		public function set Belong(value:int):void
		{
			this.belong=value;
		}
		
		public function get Owner():IRole
		{
			return this.owner;
		}
		
		public function set Owner(value:IRole):void
		{
			this.owner=value;
		}
		
		public function get EffectSphere():Vector.<Tile>
		{
			return SphereMetrics.getSphereOfSkill(mapdata,gridX,gridY);
		}
		
		public function get ID():int
		{
			return vo.skillID;
		}
		
		public function set ID(id:int):void
		{
			
		}
		
		public function get SingleID():int
		{
			return this.singleId;
		}
		
		public function set SingleID(sid:int):void
		{
			this.singleId=sid;
		}
		
		public function get SrcID():String
		{
			return vo.skillItemSrcID;
		}
		
		public function set SrcID(srcid:String):void
		{
			vo.skillItemSrcID=srcid;
		}
		
		public function get Type():int
		{
			return this.type;
		}
		
		public function set Type(type:int):void
		{
			this.type=type;
		}
		
		public function get Level():int
		{
			return vo.level;
		}
		
		public function set Level(lv:int):void
		{
			vo.level=lv;
		}
		
		public function get VO():*
		{
			return vo;
		}
		
		public function get IsDropped():Boolean
		{
			return this.isDroped;
		}
		
		public function set IsDropped(value:Boolean):void
		{
			this.isDroped=value;
		}
		
		public function get DType():int
		{
			return this.dType;
		}
		
		public function get Instance():DisplayObject
		{
			return this;
		}
		
		public function get Visible():Boolean
		{
			return this.visible;
		}
		
		public function set Visible(value:Boolean):void
		{
			this.visible=value;
		}
		
		public function get Alpha():Number
		{
			return this.alpha;
		}
		
		public function set Alpha(value:Number):void
		{
			this.alpha=value;
		}
		
		public function get ScrX():Number
		{
			return x;
		}
		
		public function get ScrY():Number
		{
			return y;
		}
		
		public function move(x:Number=0, y:Number=0):void
		{
			this.OriginX=x;
			this.OriginY=y;
			
			if(this.mapdata)
			{
				var p:Point=mapdata.screenToGrid(new Point(x,y));
				this.gridX=p.x;
				this.gridY=p.y;
			}
		}
		
		public function get GridX():int
		{
			return this.gridX;
		}
		
		public function set GridX(gridX:int):void
		{
			this.gridX=gridX;
		}
		
		public function get GridY():int
		{
			return this.gridY;
		}
		
		public function set GridY(gridY:int):void
		{
			this.gridY=gridY;
		}
		
		public function setPosition(gdx:int=0, gdy:int=0):void
		{
			this.gridX=gdx;
			this.gridY=gdy;
			
			var p:Point=this.mapdata.gridToScreen(new Point(gdx,gdy));
			
			this.OriginX=p.x;
			this.OriginY=p.y;
		}
		
		override public function destroy():void
		{
			super.destroy();	
			
			this.owner=null;
			this.vo=null;
			this.sourceManager=null;
			this.mapdata=null;
		}
	}
}
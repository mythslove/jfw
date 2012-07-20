package examples.animation
{
	import app.manager.IResourceManager;
	import app.manager.ResourceManager;
	
	import com.isolib.as3isolib.geom.Pt;
	import com.jfw.engine.animation.BmdAtlas;
	import com.jfw.engine.isolib.map.consts.DirectionConst;
	import com.jfw.engine.isolib.map.data.AStar;
	import com.jfw.engine.isolib.map.data.Tile;
	import com.jfw.engine.motion.AnimationConst;
	import com.jfw.engine.motion.IsoActiveAnimation;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * RoleView用于显示人物角色
	 * 
	 */	
	public class RoleView extends IsoActiveAnimation
	{ 
		protected var sourceManager:IResourceManager=null;
		protected var gridX:int=0;
		protected var gridY:int=0;

		public function RoleView(name:String,fps:Number=12)
		{
			sourceManager=ResourceManager.getInstance();
			super(name,sourceManager,DirectionConst.LEFTDOWN,AnimationConst.STOP,5,fps);
		}
		/**
		 * 
		 * @param x
		 * @param y
		 * 
		 */		
		public function walkTo(gdx:Number,gdy:Number):void
		{
			if(!_mapData.checkPointOverRide(gdx,gdy))
			{
				var star:AStar=new AStar(_mapData);
				star.findPath(this.gridX,this.gridY,gdx,gdy,conditions);
				this._path=star.Path;
				this.StartMove();
			}
		}
		
		public function conditions(tile:Tile):Boolean
		{
			return true;
		}

		/**
		 * 移动到指定格子处
		 * @param gdx
		 * @param gdy
		 * 
		 */		
		public function setPosition(gdx:int,gdy:int):void
		{
			gridX=gdx;
			gridY=gdy;
			
			var p:Point=this._mapData.gridToScreen(new Pt(gdx,gdy));
			
			this.FootX=p.x;
			this.FootY=p.y;
		}
		
		override public function onUpdate(tile:Tile):void
		{
			gridX=tile.getXIndex();
			gridY=tile.getZIndex();
		}
		
		/** 停止行走 */
		public function stopWalk():void
		{
			this.PauseMove();
		}
	}
}
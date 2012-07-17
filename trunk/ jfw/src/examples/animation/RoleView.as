package examples.animation
{
	import com.jfw.engine.animation.BmdAtlas;
	
	import examples.animation.animation.IsoActiveAnimation;
	import examples.animation.animation.AnimationConst;
	import examples.animation.geom.isolib.map.consts.DirectionConst;
	import examples.animation.geom.isolib.map.data.Tile;
	import examples.animation.source.AssetsManager;
	
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
		private var animation:IsoActiveAnimation=null;
		public var gridX:int=0;
		public var gridY:int=0;
	
		public function RoleView(name:String,fps:Number=12)
		{
			var roleClass:String=name+"Texture";
			var roleData:String=name+"Data";
			var bmdAtlas:BmdAtlas=new BmdAtlas((AssetsManager.Instance.getEmbedResource(roleClass) as Bitmap).bitmapData,XML(AssetsManager.Instance.getEmbedResource(roleData)));
			super(bmdAtlas,DirectionConst.LEFTDOWN,AnimationConst.STOP,5,fps);
		}
	
		/**
		 * 行走至某处。请在调用此方法前先设置path属性
		 * @param time							经过时间
		 * @param autoChangeDirection	是否开启自动调整方向功能。默认为true
		 * 
		 */		
		public function walkTo(x:Number,y:Number):void
		{
		}
		
		public function move(x:Number,y:Number):void
		{
			this.PosX=x;
			this.PosY=y;
		}
		
		public function setPosition(gdx:int,gdy:int):void
		{
			gridX=gdx;
			gridY=gdy;
		}
		
		override public function onUpdate(tile:Tile):void
		{
			//trace(tile.getXIndex(),tile.getZIndex());
		}
		
		/** 停止行走 */
		public function stopWalk():void
		{
		}
	}
}
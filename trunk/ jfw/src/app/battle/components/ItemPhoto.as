package app.mvc.views.components
{
	import com.pianfeng.engine.animation.manager.AnimationManager;
	import com.pianfeng.engine.isolib.map.data.MapData;
	import com.pianfeng.engine.utils.CommUtils;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Transform;
	
	public class ItemPhoto extends Sprite
	{
		protected var id:int;
		protected var type:int;
		protected var mapData:MapData=null;
		protected var obj:*;
		
		public function ItemPhoto(id:int,type:int,mapData:MapData)
		{
			super();
			
			this.id=id;
			this.type=type;
			this.mapData=mapData;
			this.mouseChildren=false;
			this.mouseEnabled=false;
		}
		
		public function drawPhoto(obj:*):void
		{
			this.obj=obj;
			AnimationManager.getInstance().addAnimation(obj);
			this.addChild(obj);
		}
		
		public function setIsoPosition(gridX:int,gridY:int):void
		{
			var p2d:Point=mapData.GridToScreen(new Point(gridX,gridY));
			this.x=p2d.x;
			this.y=p2d.y-3;
		}
		
		public function dispose():void
		{
			AnimationManager.getInstance().removeAnimation(obj);
			obj.dispose();
		}
		/**
		 *返回拖拽的对象 
		 * @return 
		 * 
		 */		
		public function get Obj():*
		{
			return this.obj	
		}
		
		public function get ID():int
		{
			return this.id;
		}
		
		public function get Type():int
		{
			return this.type;
		}
	}
}
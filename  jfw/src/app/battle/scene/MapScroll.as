package app.battle.scene
{
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.utils.Timer;

	/**
	 * 滚屏类,前提条件是,窗口小于要滚动的层 
	 * @author PianFeng
	 * 
	 */
	public class MapScroll
	{	
		/**
		 * 滚动面板
		 * @param sp 要滚动的层
		 * @param point 要移动的层上的一个点
		 * @param delay 延迟时间
		 * 
		 */		
		static public function ScrollMap(sp:Sprite,point:Point,delay:int=0,callBack:Function=null):void
		{
			var stage:Stage=sp.stage;
			var spStPoint:Point=sp.parent.localToGlobal(new Point(sp.x,sp.y));
			var pStX:Number=spStPoint.x+point.x;
			var pStY:Number=spStPoint.y+point.y;
			var tarX:Number=0;
			var tarY:Number=0;
			var resPt:Point=new Point();
			
			if(pStX<stage.stageWidth/2)
			{
				if(stage.stageWidth/2<point.x)
					tarX=stage.stageWidth/2-point.x;
			}
			
			if(pStX>stage.stageWidth/2)
			{
				if(stage.stageWidth/2<sp.width-point.x)
					tarX=stage.stageWidth/2-point.x;
				else
					tarX=stage.stageWidth-sp.width;
			}
				
			if(pStY<stage.stageHeight/2)
			{
				if(stage.stageHeight/2<point.y)
					tarY=stage.stageHeight/2-point.y;
			}
			
			if(pStY>stage.stageHeight/2)
			{
				if(stage.stageHeight/2<sp.height-point.y)
					tarY=stage.stageHeight/2-point.y;
				else
					tarY=stage.stageHeight-sp.height;
			}

			resPt=sp.parent.globalToLocal(new Point(tarX,tarY));
			
			if(delay==0)
			{
				sp.x=resPt.x;
				sp.y=resPt.y;
				
				if(callBack!=null)
					callBack();
			}
			else
			{
				if(callBack!=null)
					TweenMax.to(sp, delay, {x:resPt.x, y:resPt.y,onComplete:callBack,overwrite:true});
				else
					TweenMax.to(sp, delay, {x:resPt.x, y:resPt.y,overwrite:true});
			}
		}
	}
}
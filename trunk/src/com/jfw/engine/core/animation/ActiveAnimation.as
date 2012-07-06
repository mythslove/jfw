package com.jfw.engine.core.animation
{
	import com.jfw.engine.core.geom.isolib.map.consts.DirectionConst;
	import com.jfw.engine.core.interfaces.IMotion;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class ActiveAnimation extends Sprite implements  IMotion
	{
		protected var bmdAtlas:BmdAtlas=null;
		protected var bmdMc:BmdMovieClip=null;
		protected var currDir:String;
		protected var actType:String;
		protected var currSpd:Number=0;
		protected var fps:int=12;
		
		public function ActiveAnimation(source:Vector.<BitmapData>,dir:String=DirectionConst.DOWN,act:String=AnimationConst.STAND,spd:Number=0,fps:Number=12)
		{
			this.bmdAtlas=source;
			this.currDir=dir;
			this.actType=act;
			this.currSpd=spd;
			this.fps=fps;
			update();
		}
		
		protected function update():void
		{
			var label:String=this.currDir+"_"+this.actType+"_";
			var frames:Vector.<BitmapData> = bmdAtlas.getTextures(label);

			if(frames&&frames.length>0)
				bmdMc=new BmdMovieClip(frames,fps);
		}
		
		public function play(): void
		{
			if(bmdMc)
				bmdMc.play();
		}
	
		public function pause(): void
		{
			if(bmdMc)
				bmdMc.pause();
		}
	
		public function stop(): void
		{
			if(bmdMc)
				bmdMc.stop();
		}
		
		public function onMontionEnterFrame(obj:Object):void
		{
		}
		
		public function get PosX():Number
		{
			return this.x;
		}
		
		public function get PosY():Number
		{
			return this.y;
		}
		
		public function setPosX(x:Number):void
		{
			this.x=x;
		}
		
		public function setPosY(y:Number):void
		{
			this.y=y;
		}
		
		public function set Direction(dir:String):void
		{
			this.currDir=dir;
			update();
		}
		
		public function set ActionType(value:String):void
		{
			this.actType=value;
			update();
		}
		
		public function get Speed():Number
		{
			return this.currSpd;
		}
		
		public function get Instance():BmdMovieClip
		{
			return this.bmdMc;
		}
		
		public function get isPlaying():Boolean
		{
			return this.bmdMc.isPlaying;
		}
	}
}
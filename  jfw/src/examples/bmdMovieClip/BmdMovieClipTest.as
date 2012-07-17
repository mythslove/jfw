package examples.bmdMovieClip
{
	import com.jfw.engine.animation.BmdAtlas;
	import com.jfw.engine.animation.BmdMovieClip;
	import com.jfw.engine.animation.Juggler;
	import com.jfw.engine.animation.Texture;
	import com.jfw.engine.utils.Stats;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	[SWF(width="760",height="600")]
	public class BmdMovieClipTest extends Sprite
	{
		private var juggler:Juggler;
		
		[Embed(source="assets/bg.jpg")]
		private static const BG:Class;
		
		[Embed(source="assets/10001.png")]
		private static const SpriteSheet:Class;
		
		[Embed(source="assets/10001.xml",mimeType="application/octet-stream")]
		public static const SpriteSheetXml:Class;
		
		private var mLastFrameTimestamp:Number;
		private var mStarted:Boolean;
		
		public function BmdMovieClipTest()
		{
			super();
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			
			this.start();
			
			this.addChild( new BG() );
			
			this.juggler = new Juggler();
			this.stage.addEventListener(Event.ENTER_FRAME,onEnter);
			
			var bitmap:Bitmap = new SpriteSheet();
			var bmd:BitmapData = bitmap.bitmapData;
			var xml:XML = XML(  new SpriteSheetXml() );
			for( var i:int = 0; i<10;i++)
			{
				var bmdAtlas:BmdAtlas = new BmdAtlas( bmd,xml );
				var frames:Vector.<Texture> = bmdAtlas.getTextures("rightDown_hurt_");
				var movie:BmdMovieClip = new BmdMovieClip( frames,40 * Math.random() );
				movie.x = stage.stageWidth * Math.random();
				movie.y = stage.stageHeight * Math.random();
				addChild( movie );
				this.juggler.add( movie );
			}
			addChild( new Stats() );
		}
		
		private function start():void
		{
			mStarted = true;
			mLastFrameTimestamp = getTimer() / 1000.0;
		}
		
		public function stop():void 
		{ 
			mStarted = false; 
		}
		
		private function advanceTime():void
		{
			var now:Number = getTimer() / 1000.0;
			var passedTime:Number = now - mLastFrameTimestamp;
			mLastFrameTimestamp = now;
			
			juggler.advanceTime(passedTime);
		}
		
		protected function onEnter(event:Event):void
		{
			if (mStarted) 
				advanceTime();
		}
	}
}
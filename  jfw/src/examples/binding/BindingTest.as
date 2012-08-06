package examples.binding
{
	import com.jfw.engine.utils.binding.Binding;
	import com.jfw.engine.utils.binding.events.PropertyEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	/**
	 * 绑定测试 
	 * 使用Flight框架剥离的binding包
	 * @author 
	 * 
	 */	
	public class BindingTest extends Sprite
	{
		private var sourceBinding:Binding;
		
		public var sourceText:TextField = new TextField();
		public var targetText:TextField = new TextField();
		
		private var isTargetTextBound:Boolean = false;
		
		//as3 binding requires a getter/setter for the property you want to bind to
		private var _source:Number = 0;
		
		public function BindingTest()
		{
			//set up text for visual display
			var textFormat:TextFormat = new TextFormat("Arial", 20, 0x000000);
			sourceText.defaultTextFormat = textFormat;
			targetText.defaultTextFormat = textFormat;
			
			addChild(sourceText);
			targetText.y = 40;
			addChild(targetText);
			
			//setup source of binding
			sourceBinding = new Binding(this, "source");
			//bind to the first text's "text" property
			sourceBinding.bind(sourceText, "text");
			
			//update with timer			
			var timer:Timer = new Timer(100);
			timer.addEventListener(TimerEvent.TIMER, timer_timerHandler);
			timer.start();
			
			stage.addEventListener(MouseEvent.CLICK, stage_clickHandler);
		}
		
		private function timer_timerHandler(event:TimerEvent):void
		{
			//increment the source
			source++;
		}
		
		private function stage_clickHandler(event:MouseEvent):void
		{
			//bind or unbind to second textField on mouse click
			if(isTargetTextBound)
			{
				sourceBinding.unbind(targetText, "text");
			}
			else
			{
				sourceBinding.bind(targetText, "text");
			}
			
			isTargetTextBound = !isTargetTextBound;
		}
		
		public function get source():Number
		{
			return _source;
		}
		
		public function set source(value:Number):void
		{
			var oldValue:Number = _source;
			_source = value;
			//you need to dispatch an event to indicate the binding source has changed
			PropertyEvent.dispatchChange(this, "source", oldValue, _source);
		}
		
	}
}
package app.mvc.view.ui.window.spell
{
	import com.jfw.engine.core.data.IStruct;
	import com.jfw.engine.core.mvc.view.BPanel;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	/**
	 * 法术合成 
	 * @author Administrator
	 * 
	 */	
	public class SpellMixturePage extends BPanel
	{
		public var $pmSpellAdvanced:MovieClip;
		
		public function SpellMixturePage(cls_ref:Object=null, data:IStruct=null)
		{
			super(cls_ref, data);
		}
		
		override protected function onMouseClick(evt:MouseEvent):void
		{
			
			switch( evt.target )
			{
				case $pmSpellAdvanced:
					trace("升阶");
					onSpellAdvancedButtonClick();
					break;
				
				
			}
		}
		
		private function onSpellAdvancedButtonClick():void{
			
			
		}
	}
}
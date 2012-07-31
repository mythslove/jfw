package app.mvc.view.ui.window.spell
{
	import com.jfw.engine.core.data.IStruct;
	import com.jfw.engine.core.mvc.view.BPanel;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	import mx.controls.Button;
	
	/**
	 * 法术升级 
	 * @author Administrator
	 * 
	 */	
	public class SpellUpgradePage extends BPanel
	{
		
		public var $pbCodeTime:MovieClip;
		public var $pbSpellLevelUp:MovieClip;
		
		public function SpellUpgradePage(cls_ref:Object=null, data:IStruct=null)
		{
			super(cls_ref, data);
		}
		
		override protected function onMouseClick(evt:MouseEvent):void
		{
			trace( evt.target.name);
			trace("目标值",evt.currentTarget.name);
			switch( evt.target )
			{
				case $pbCodeTime:
					trace("升级");
					onLevelUpButtonClick();
					break;
				case $pbSpellLevelUp:
					trace("冷却");
					onCodeTimeButtonClick();
					break;
				
			}
		}
		
		private function onLevelUpButtonClick():void{
			
			
		}
		
		private function onCodeTimeButtonClick():void{
			
			
		}
		
		
	}
}
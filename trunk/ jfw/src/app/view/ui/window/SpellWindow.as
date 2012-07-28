package app.view.ui.window
{
	import app.view.ui.component.Navigation;
	import app.view.ui.component.SpellTab;
	
	import com.jfw.engine.core.data.IStruct;
	import com.jfw.engine.core.mvc.view.BWindow;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class SpellWindow extends BWindow
	{
		public var $mcBottomPanel:MovieClip;
		public var $mcSpellPanel:MovieClip;
		
		//tab
		private var tabNav:Navigation;
		private var tabFactory:Array;
		private var currSelectedTab:int = 0;
		
		public function SpellWindow( )
		{
			super();
		}
		
		override protected function onInit():void
		{
			super.onInit();
			
			createTab();
		}
		
		private function createTab():void
		{
			tabFactory = 
				[
					{ tabName: '升级',type: 0 }, 
					{ tabName: '合成法术',type: 1 }
				];
			
			tabNav = new Navigation( tabFactory.length );
			tabNav.spaceBetween = 10;
			for each ( var itemObj:Object in tabFactory )
			{
				tabNav.addItem( new SpellTab( itemObj.tabName ) );
			}
			
			this.$mcSpellPanel.addChild( tabNav );
			tabNav.x = 37;
			tabNav.y = -7;
			tabNav.selectedIndex = 0;
			tabNav.addEventListener(Event.CHANGE, onChangeTab);
		}
		
		protected function onChangeTab(event:Event):void
		{
			
		}		
		
	}
}
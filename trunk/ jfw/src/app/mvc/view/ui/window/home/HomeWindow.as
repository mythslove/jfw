package app.mvc.view.ui.window.home
{
	import app.mvc.view.ui.component.TabStruct;
	import app.mvc.view.ui.window.spell.SpellTab;
	
	import com.jfw.engine.core.data.IStruct;
	import com.jfw.engine.core.mvc.view.BWindow;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	/**
	 *  任务活动面板
	 * @author 
	 * 
	 */	
	public class HomeWindow extends BWindow
	{
		
		public var $mcHomePanel:MovieClip;
		private var HomePanelContaner:Sprite = null;
		
		private var HomePanel:HomeTabPanel = null;
		
		private var dataList:Array = null;
		private var HomePanelMask:Shape = null;
		private var HomePanelEffect:Bitmap = null;
		
		public function HomeWindow( )
		{
			super();
			x = y = 0;
		}
		
		override protected function onInit():void
		{
			super.onInit();
			
			//创建标签页和关联的面板
			createTabContentContainer();
			
		}
		
		
		/**
		 * 标签页面板 
		 * 
		 */
		private function createTabContentContainer():void
		{
			HomePanelContaner = new Sprite();
			
			var tabfactory:Vector.<TabStruct> = new Vector.<TabStruct>();
			tabfactory.push(new TabStruct( { label:'征收',type:1,cls:HomeContainerExpropriation } ) ); 
			tabfactory.push(new TabStruct( { label:'名妖图鉴',type:2,cls:HomeContainerIdentify } ) ); 
			tabfactory.push(new TabStruct( { label:'妖币大转盘',type:3,cls:HomeContaineYB } ) ); 
			tabfactory.push(new TabStruct( { label:'金币大转盘',type:3,cls:HomeContaineGold } ) ); 
			HomePanel = new HomeTabPanel( this.$mcHomePanel,null,tabfactory,SpellTab );
			HomePanelContaner.addChild( HomePanel );
			
			HomePanelMask = new Shape();
			HomePanelMask.x = HomePanelContaner.x;
			HomePanelMask.y = HomePanelContaner.y;
			HomePanelMask.graphics.beginFill( 0xFF00FF, 0.5 );
			HomePanelMask.graphics.drawRect( 0, 0, $mcHomePanel.width, $mcHomePanel.height );
			HomePanelMask.graphics.endFill();
			HomePanelContaner.mask = HomePanelMask;
			
			HomePanelEffect = new Bitmap();
			HomePanelEffect.bitmapData = new BitmapData( HomePanelContaner.width, HomePanelContaner.height, true, 0 );
			HomePanelContaner.addChild( HomePanelEffect );
			
			addChildAt( HomePanelContaner , 1 );
			addChildAt( HomePanelMask, 2 );
		}
	}
}
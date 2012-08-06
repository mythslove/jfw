package app.mvc.view.ui.window.monster
{
	import app.mvc.model.MonsterModel;
	import app.mvc.model.data.EmptyStruct;
	import app.mvc.model.data.MonsterStruct;
	import app.mvc.view.ui.component.List;
	import app.mvc.view.ui.component.Navigation;
	import app.mvc.view.ui.component.TabPanel;
	import app.mvc.view.ui.component.TabStruct;
	import app.mvc.view.ui.component.pagebar.PageBar;
	import app.mvc.view.ui.window.shop.ShopTab;
	import app.mvc.view.ui.window.spell.SpellTab;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	import com.jfw.engine.core.data.IStruct;
	import com.jfw.engine.core.mvc.view.BPanel;
	import com.jfw.engine.core.mvc.view.BWindow;
	import com.jfw.engine.core.mvc.view.IPanel;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * 妖将面板 
	 * @author 
	 * 
	 */	
	public class MonsterWindow extends BWindow
	{
		public var $mcBottomPanel:MovieClip;
		public var $mcMonsterPanel:MovieClip;
		
		private var monsterPanelContaner:Sprite = null;
		private var monsterPanel:MonsterTabPanel = null;
		
		private var dataList:Array = null;
		
		private var pageBar:PageBar = null;
		private var currentPage:int	= 1;
		
		private var list:List = null;
		private var currentItemIndex:int = 0;
		
		private static const listW:int = 670;
		private static const listH:int = 130;
		private static const SPELL_COUNT_DISPLAY:int = 7;
		private static const listHSpace:int	= 0;
		private static const listSpace:int = 4;
		
		private var monsterPanelEffect:Bitmap = null;
		private var monsterPanelContainer:Sprite = null;
		private var monsterPanelMask:Shape = null;
		
		public function MonsterWindow( )
		{
			super();
			x = y = 0;
		}
		
		override protected function onInit():void
		{
			super.onInit();
			
			createContentContainer();
			
			
		}
		
		
		/**
		 * 技能面板 
		 * 
		 */
		private function createContentContainer():void
		{
			monsterPanelContaner = new Sprite();
			
			var tabfactory:Vector.<TabStruct> = new Vector.<TabStruct>();
			tabfactory.push(new TabStruct( { label:'列表',type:1,cls:MonsterContaineList } ) ); 
			tabfactory.push(new TabStruct( { label:'招募',type:2,cls:MonsterContaineRecruit } ) );
			tabfactory.push(new TabStruct( { label:'出战',type:3,cls:MonsterContaineFighter } ) );
			tabfactory.push(new TabStruct( { label:'挂机',type:4,cls:MonsterContaineHangUp } ) );
			tabfactory.push(new TabStruct( { label:'升级',type:5,cls:MonsterContaineUpgrade } ) );
			tabfactory.push(new TabStruct( { label:'升阶',type:6,cls:MonsterContaineMixture } ) );
			monsterPanel = new MonsterTabPanel( this.$mcMonsterPanel,null,tabfactory,SpellTab );
			monsterPanelContaner.addChild( monsterPanel );
			
			monsterPanelMask = new Shape();
			monsterPanelMask.x = monsterPanelContaner.x;
			monsterPanelMask.y = monsterPanelContaner.y;
			monsterPanelMask.graphics.beginFill( 0xFF00FF, 0.5 );
			monsterPanelMask.graphics.drawRect( 0, 0, $mcMonsterPanel.width, $mcMonsterPanel.height );
			monsterPanelMask.graphics.endFill();
			monsterPanelContaner.mask = monsterPanelMask;
			
			monsterPanelEffect = new Bitmap();
			monsterPanelEffect.bitmapData = new BitmapData( monsterPanelContaner.width, monsterPanelContaner.height, true, 0 );
			monsterPanelContaner.addChild( monsterPanelEffect );
			
			addChildAt( monsterPanelContaner , 1 );
			addChildAt( monsterPanelMask, 2 );
		}
		
		

	}
}
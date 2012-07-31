package app.mvc.view.ui.window.spell
{
	import app.mvc.model.MonsterModel;
	import app.mvc.model.spell.SpellModel;
	import app.mvc.view.ui.component.List;
	import app.mvc.view.ui.component.Navigation;
	import app.mvc.view.ui.component.TabPanel;
	import app.mvc.view.ui.component.TabStruct;
	import app.mvc.view.ui.component.pagebar.PageBar;
	
	import com.greensock.TweenLite;
	import com.jfw.engine.core.data.IStruct;
	import com.jfw.engine.core.mvc.view.BPanel;
	import com.jfw.engine.core.mvc.view.BWindow;
	import com.jfw.engine.core.mvc.view.IPanel;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class SpellWindow extends BWindow
	{
		public var $mcBottomPanel:MovieClip;
		public var $mcSpellPanel:MovieClip;
		
		private var spellPanel:SpellTabPanel = null;
		
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
		
		public function SpellWindow( )
		{
			super();
			x = y = 0;
		}
		
		override protected function onInit():void
		{
			super.onInit();
			
			dataList = monsterModel.monsterList;
			
			createListContainer();
			list.data = dataList ;
			
			pageBar = $mcBottomPanel.addChild( new PageBar( $mcBottomPanel['$mcPageBar'] ) ) as PageBar;
			pageBar.setUpdateFun( pageUpdate );
			pageUpdate(1);
			pageBar.goto(1);
			updatePageBar();
			
			createContentContainer();
		}
		
		private function createListContainer():void
		{
			// 好友列表
			list = new List( SpellListItem, listW, listH, listSpace, List.HORIZONTAL );
			list.drag = false;
			list.x = 45;
			list.y = 56;
			$mcBottomPanel.addChild( list );
		}		
		
		private function updatePageBar ():void
		{
			pageBar.max = Math.ceil( dataList.length / SPELL_COUNT_DISPLAY );
			if( currentPage > pageBar.max )
			{
				currentPage = pageBar.max;
			}
			pageUpdate(currentPage);
		}
		
		private function pageUpdate( page:int ):void
		{
			currentItemIndex = ( page - 1 ) * SPELL_COUNT_DISPLAY;
			list.setCurrentItemMoveTo( currentItemIndex );
		}
		
		private function createContentContainer():void
		{
			var tabfactory:Vector.<TabStruct> = new Vector.<TabStruct>();
			tabfactory.push(new TabStruct( { label:'升级',type:1,cls:SpellUpgradePage } ) ); 
			tabfactory.push(new TabStruct( { label:'进阶',type:2,cls:SpellMixturePage } ) );
			spellPanel = new SpellTabPanel( this.$mcSpellPanel,null,tabfactory,SpellTab );
			this.addChildAt( spellPanel,1 );
		}
		
		private function get spellModel():SpellModel
		{
			return this.core.retModel( SpellModel.NAME ) as SpellModel;
		}
		
		private function get monsterModel():MonsterModel
		{
			return this.core.retModel( MonsterModel.NAME ) as MonsterModel;
		}

	}
}
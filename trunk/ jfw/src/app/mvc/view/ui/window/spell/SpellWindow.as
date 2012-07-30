package app.mvc.view.ui.window.spell
{
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
		private var listEffect:Bitmap = null;
		private var listContainer:Sprite = null;
		private var listMask:Shape = null;
		private var listTween:Object = { };
		
		private static const listW:int = 214;
		private static const listH:int = 330;
		private static const SPELL_COUNT_DISPLAY:int = 7;
		
		private static const listHSpace:int	= 0;
		private static const listSpace:int = 3;
		
		public function SpellWindow( )
		{
			super();
			x = y = 0;
		}
		
		override protected function onInit():void
		{
			super.onInit();
			
			dataList = [];
			pageBar = $mcBottomPanel.addChild( new PageBar( $mcBottomPanel['$mcPageBar'] ) ) as PageBar;
			pageBar.setUpdateFun( pageUpdate );
			pageUpdate(1);
			pageBar.goto(1);
			updatePageBar();
			
			createListContainer();
			
			list.data = [] ;
			
			createContentContainer();
		}
		
		private function createListContainer():void
		{
			listContainer = new Sprite();
			listContainer.x = 50;
			listContainer.y = 58;
			
			// 好友列表
			list = new List( SpellListItem, listW, listH, listSpace, List.HORIZONTAL );
			list.drag = false;
			listContainer.addChild( list );
			
			listEffect = new Bitmap();
			listContainer.addChild( listEffect );
			
			listMask = new Shape();
			listMask.x = listContainer.x;
			listMask.y = listContainer.y;
			listMask.graphics.beginFill( 0xFF00FF, 0.5 );
			listMask.graphics.drawRect( 0, 0, listW, listH );
			listMask.graphics.endFill();
			
			listContainer.mask = listMask;
			$mcBottomPanel.addChild( listContainer );
			$mcBottomPanel.addChild( listMask );
			
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
			
		}
		
		private function createContentContainer():void
		{
			var tabfactory:Vector.<TabStruct> = new Vector.<TabStruct>();
			tabfactory.push(new TabStruct( { label:'升级',type:1,cls:SpellUpgradePage } ) ); 
			tabfactory.push(new TabStruct( { label:'法术合成',type:2,cls:SpellMixturePage } ) );
			tabfactory.push( new TabStruct( { label:'法术合成2',type:3,cls:SpellMixturePage2 } ));
			spellPanel = new SpellTabPanel( this.$mcSpellPanel,null,tabfactory,SpellTab );
			this.addChildAt( spellPanel,1 );
		}

	}
}
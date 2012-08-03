package app.mvc.view.ui.window.spell
{
	import app.mvc.control.events.SpellEvent;
	import app.mvc.model.MonsterModel;
	import app.mvc.model.data.EmptyStruct;
	import app.mvc.model.data.MonsterStruct;
	import app.mvc.model.data.SpellStruct;
	import app.mvc.model.spell.SpellModel;
	import app.mvc.view.ui.component.List;
	import app.mvc.view.ui.component.Navigation;
	import app.mvc.view.ui.component.TabPanel;
	import app.mvc.view.ui.component.TabStruct;
	import app.mvc.view.ui.component.pagebar.PageBar;
	
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
	 * 法术面板 
	 * @author 
	 * 
	 */	
	public class SpellWindow extends BWindow
	{
		public var $mcBottomPanel:MovieClip;
		public var $mcSpellPanel:MovieClip;
		
		private var spellPanelContaner:Sprite = null;
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
		
		private var spellPanelEffect:Bitmap = null;
		private var spellPanelContainer:Sprite = null;
		private var spellPanelMask:Shape = null;
		
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
			spellModel.currSelectedMonster = dataList[ this.currentItemIndex ];
			
			pageBar = $mcBottomPanel.addChild( new PageBar( $mcBottomPanel['$mcPageBar'] ) ) as PageBar;
			pageBar.setUpdateFun( pageUpdate );
			pageUpdate(1);
			pageBar.goto(1);
			updatePageBar();
			
			createContentContainer();
			
			addEventListener( SpellEvent.MONSTERLIST_CLICK_ITEM,onMonsterClick,true );
		}
		
		override public function destroy():void
		{
			spellPanelEffect.bitmapData.dispose();
			spellPanelEffect = null;
			spellPanelMask = null;
			spellPanelContainer = null;
			
			removeEventListener( SpellEvent.MONSTERLIST_CLICK_ITEM,onMonsterClick );
			super.destroy();
		}
		
		protected function onMonsterClick( event:SpellEvent ):void
		{
			var spellListItem:SpellListItem = event.data as SpellListItem;
			if( spellListItem.data is EmptyStruct )
			{
				// to do: 点击VIP开格子
				trace("点击VIP开格子");
				
			}
			else if ( spellListItem.data is MonsterStruct )
			{
				this.tweenAction( spellListItem.itemId - 1 );
				
				spellModel.currSelectedMonster = spellListItem.data;
			}
		}
		
		/**
		 * 妖将列表 
		 * 
		 */
		private function createListContainer():void
		{
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
		
		/**
		 * 更新页面 
		 * @param page
		 * 
		 */
		private function pageUpdate( page:int ):void
		{
			currentItemIndex = ( page - 1 ) * SPELL_COUNT_DISPLAY;
			list.setCurrentItemMoveTo( currentItemIndex );
		}
		
		
		private function tweenAction( index:int ):void
		{
			if( ( this.currentItemIndex == index ) || index < 0 )
				return;
			spellPanelEffect.bitmapData.fillRect(spellPanelEffect.bitmapData.rect, 0x00000000);
			spellPanelEffect.bitmapData.draw( spellPanelContaner );
			spellPanelEffect.alpha = 1;
			spellPanel.alpha = 0;
			
			var endA:int = 0;
			var endB:int = 0;
			if( this.currentItemIndex < index )
			{
				spellPanelEffect.x = 0;
				spellPanel.x = listW + listHSpace;
				endA = -( listW + listHSpace );
				endB = 0;
			}
			else if (  this.currentItemIndex > index )
			{
				spellPanelEffect.x = 0;
				spellPanel.x =  -( listW + listHSpace );
				endA = listW + listHSpace ;
				endB = 0;
			}
			
			TweenLite.to( spellPanelEffect, 0.4, { x:endA, alpha:0 ,ease:Expo.easeInOut } );
			TweenLite.to( spellPanel, 0.4, { x:endB ,alpha:1, ease:Expo.easeInOut } );
			
			currentItemIndex = index;
		}
		
		/**
		 * 技能面板 
		 * 
		 */
		private function createContentContainer():void
		{
			spellPanelContaner = new Sprite();
			
			var tabfactory:Vector.<TabStruct> = new Vector.<TabStruct>();
			tabfactory.push(new TabStruct( { label:'升级',type:1,cls:SpellUpgradePage } ) ); 
			tabfactory.push(new TabStruct( { label:'进阶',type:2,cls:SpellMixturePage } ) );
			spellPanel = new SpellTabPanel( this.$mcSpellPanel,dataList[this.currentItemIndex],tabfactory,SpellTab );
			spellPanelContaner.addChild( spellPanel );
			
			spellPanelMask = new Shape();
			spellPanelMask.x = spellPanelContaner.x;
			spellPanelMask.y = spellPanelContaner.y;
			spellPanelMask.graphics.beginFill( 0xFF00FF, 0.5 );
			spellPanelMask.graphics.drawRect( 0, 0, $mcSpellPanel.width, $mcSpellPanel.height );
			spellPanelMask.graphics.endFill();
			spellPanelContaner.mask = spellPanelMask;
			
			spellPanelEffect = new Bitmap();
			spellPanelEffect.bitmapData = new BitmapData( spellPanelContaner.width, spellPanelContaner.height, true, 0 );
			spellPanelContaner.addChild( spellPanelEffect );
			
			addChildAt( spellPanelContaner , 1 );
			addChildAt( spellPanelMask, 2 );
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
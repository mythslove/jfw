package app.mvc.view.ui.window.rank
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
	public class RankWindow extends BWindow
	{
		
		public var $mcRankPanel:MovieClip;
		private var RankPanelContaner:Sprite = null;
		
		private var RankPanel:RankTabPanel = null;
		
		private var dataList:Array = null;
		private var RankPanelMask:Shape = null;
		private var RankPanelEffect:Bitmap = null;
		
		public function RankWindow( )
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
			RankPanelContaner = new Sprite();
			
			var tabfactory:Vector.<TabStruct> = new Vector.<TabStruct>();
			tabfactory.push(new TabStruct( { label:'排行',type:1,cls:RankContainerRank } ) ); 
			tabfactory.push(new TabStruct( { label:'称号',type:2,cls:RankContainerTitle } ) );
			
			RankPanel = new RankTabPanel( this.$mcRankPanel,null,tabfactory,SpellTab );
			RankPanelContaner.addChild( RankPanel );
			
			RankPanelMask = new Shape();
			RankPanelMask.x = RankPanelContaner.x;
			RankPanelMask.y = RankPanelContaner.y;
			RankPanelMask.graphics.beginFill( 0xFF00FF, 0.5 );
			RankPanelMask.graphics.drawRect( 0, 0, $mcRankPanel.width, $mcRankPanel.height );
			RankPanelMask.graphics.endFill();
			RankPanelContaner.mask = RankPanelMask;
			
			RankPanelEffect = new Bitmap();
			RankPanelEffect.bitmapData = new BitmapData( RankPanelContaner.width, RankPanelContaner.height, true, 0 );
			RankPanelContaner.addChild( RankPanelEffect );
			
			addChildAt( RankPanelContaner , 1 );
			addChildAt( RankPanelMask, 2 );
		}
	}
}
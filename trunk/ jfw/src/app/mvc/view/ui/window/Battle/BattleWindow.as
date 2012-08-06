package app.mvc.view.ui.window.Battle
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
	public class BattleWindow extends BWindow
	{
		
		public var $mcBattlePanel:MovieClip;
		private var BattlePanelContaner:Sprite = null;
		
		private var BattlePanel:BattleTabPanel = null;
		
		private var dataList:Array = null;
		private var BattlePanelMask:Shape = null;
		private var BattlePanelEffect:Bitmap = null;
		
		public function BattleWindow( )
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
			BattlePanelContaner = new Sprite();
			
			var tabfactory:Vector.<TabStruct> = new Vector.<TabStruct>();
			tabfactory.push(new TabStruct( { label:'当前关卡',type:1,cls:BattleContainerCurrent } ) ); 
			tabfactory.push(new TabStruct( { label:'区域地图1',type:2,cls:BattleContainerMain } ) ); 
			tabfactory.push(new TabStruct( { label:'区域地图2',type:3,cls:BattleContaineArea1 } ) ); 
			tabfactory.push(new TabStruct( { label:'副本地图',type:3,cls:BattleContaineArea2 } ) ); 
			tabfactory.push(new TabStruct( { label:'世界地图',type:3,cls:BattleContainerWorld } ) ); 
			
			BattlePanel = new BattleTabPanel( this.$mcBattlePanel,null,tabfactory,SpellTab );
			BattlePanelContaner.addChild( BattlePanel );
			
			BattlePanelMask = new Shape();
			BattlePanelMask.x = BattlePanelContaner.x;
			BattlePanelMask.y = BattlePanelContaner.y;
			BattlePanelMask.graphics.beginFill( 0xFF00FF, 0.5 );
			BattlePanelMask.graphics.drawRect( 0, 0, $mcBattlePanel.width, $mcBattlePanel.height );
			BattlePanelMask.graphics.endFill();
			BattlePanelContaner.mask = BattlePanelMask;
			
			BattlePanelEffect = new Bitmap();
			BattlePanelEffect.bitmapData = new BitmapData( BattlePanelContaner.width, BattlePanelContaner.height, true, 0 );
			BattlePanelContaner.addChild( BattlePanelEffect );
			
			addChildAt( BattlePanelContaner , 1 );
			addChildAt( BattlePanelMask, 2 );
		}
	}
}
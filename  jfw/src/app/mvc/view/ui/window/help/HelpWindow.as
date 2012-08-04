package app.mvc.view.ui.window.help
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
	public class HelpWindow extends BWindow
	{
		
		public var $mcHelpPanel:MovieClip;
		private var HelpPanelContaner:Sprite = null;
		
		private var HelpPanel:HelpTabPanel = null;
		
		private var dataList:Array = null;
		private var HelpPanelMask:Shape = null;
		private var HelpPanelEffect:Bitmap = null;
		
		public function HelpWindow( )
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
			HelpPanelContaner = new Sprite();
			
			var tabfactory:Vector.<TabStruct> = new Vector.<TabStruct>();
			tabfactory.push(new TabStruct( { label:'当前帮助',type:1,cls:HelpContainerCurrent } ) ); 
			tabfactory.push(new TabStruct( { label:'新手引导',type:2,cls:HelpContainerPlayerGuide } ) ); 
			tabfactory.push(new TabStruct( { label:'游戏目标',type:3,cls:HelpContainerGameGoal } ) ); 
			tabfactory.push(new TabStruct( { label:'观赏战报',type:4,cls:HelpContainerBattleField } ) ); 
			tabfactory.push(new TabStruct( { label:'FAQ',type:5,cls:HelpContainerFAQ } ) ); 
			tabfactory.push(new TabStruct( { label:'攻略',type:6,cls:HelpContainerRaider } ) ); 
			tabfactory.push(new TabStruct( { label:'论坛精华帖',type:7,cls:HelpContainerForum } ) ); 
			tabfactory.push(new TabStruct( { label:'客服',type:8,cls:HelpContainerCustomerService } ) );
			
			HelpPanel = new HelpTabPanel( this.$mcHelpPanel,null,tabfactory,HelpTab );
			HelpPanelContaner.addChild( HelpPanel );
			
			HelpPanelMask = new Shape();
			HelpPanelMask.x = HelpPanelContaner.x;
			HelpPanelMask.y = HelpPanelContaner.y;
			HelpPanelMask.graphics.beginFill( 0xFF00FF, 0.5 );
			HelpPanelMask.graphics.drawRect( 0, 0, $mcHelpPanel.width, $mcHelpPanel.height );
			HelpPanelMask.graphics.endFill();
			HelpPanelContaner.mask = HelpPanelMask;
			
			HelpPanelEffect = new Bitmap();
			HelpPanelEffect.bitmapData = new BitmapData( HelpPanelContaner.width, HelpPanelContaner.height, true, 0 );
			HelpPanelContaner.addChild( HelpPanelEffect );
			
			addChildAt( HelpPanelContaner , 1 );
			addChildAt( HelpPanelMask, 2 );
		}
	}
}
package app.mvc.view.ui.window.equip
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
	 *  社交活动面板
	 * @author 
	 * 
	 */	
	public class EquipWindow extends BWindow
	{
		
		public var $mcEquipPanel:MovieClip;
		private var equipPanelContaner:Sprite = null;
		
		private var equipPanel:EquipTabPanel = null;
		
		private var dataList:Array = null;
		private var equipPanelMask:Shape = null;
		private var equipPanelEffect:Bitmap = null;
		
		public function EquipWindow( )
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
			equipPanelContaner = new Sprite();
			
			var tabfactory:Vector.<TabStruct> = new Vector.<TabStruct>();
			tabfactory.push(new TabStruct( { label:'强化',type:1,cls:EquiplContainerStrengthen } ) ); 
			tabfactory.push(new TabStruct( { label:'委派',type:2,cls:EquiplContainerAppoint } ) ); 
			tabfactory.push(new TabStruct( { label:'合成',type:3,cls:EquipContainerComposite } ) ); 
			
			equipPanel = new EquipTabPanel( this.$mcEquipPanel,null,tabfactory,SpellTab );
			equipPanelContaner.addChild( equipPanel );
			
			equipPanelMask = new Shape();
			equipPanelMask.x = equipPanelContaner.x;
			equipPanelMask.y = equipPanelContaner.y;
			equipPanelMask.graphics.beginFill( 0xFF00FF, 0.5 );
			equipPanelMask.graphics.drawRect( 0, 0, $mcEquipPanel.width, $mcEquipPanel.height );
			equipPanelMask.graphics.endFill();
			equipPanelContaner.mask = equipPanelMask;
			
			equipPanelEffect = new Bitmap();
			equipPanelEffect.bitmapData = new BitmapData( equipPanelContaner.width, equipPanelContaner.height, true, 0 );
			equipPanelContaner.addChild( equipPanelEffect );
			
			addChildAt( equipPanelContaner , 1 );
			addChildAt( equipPanelMask, 2 );
		}
	}
}
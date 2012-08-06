package app.mvc.view.ui.window.shop
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
	 * 商城 
	 * @author
	 * 
	 */	
	public class ShopWindow extends BWindow
	{
		
		public var $mcShopPanel:MovieClip;
		private var shopPanelContaner:Sprite = null;
		
		private var shopPanel:ShopTabPanel = null;
		
		private var dataList:Array = null;
		private var shopPanelMask:Shape = null;
		private var shopPanelEffect:Bitmap = null;
		
		public function ShopWindow()
		{
			super();
			x=y=0;
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
			shopPanelContaner = new Sprite();
			
			var tabfactory:Vector.<TabStruct> = new Vector.<TabStruct>();
			tabfactory.push(new TabStruct( { label:'商城',type:1,cls:ShopContainerShop } ) ); 
			tabfactory.push(new TabStruct( { label:'八方寻宝',type:2,cls:ShopContainerFindTreasure } ) ); 
			tabfactory.push(new TabStruct( { label:'VIP中心',type:3,cls:ShopContaineVIP } ) ); 
			tabfactory.push(new TabStruct( { label:'礼包',type:4,cls:ShopContainePackage } ) ); 
			
			shopPanel = new ShopTabPanel( this.$mcShopPanel,null,tabfactory,SpellTab );
			shopPanelContaner.addChild( shopPanel );
			
			shopPanelMask = new Shape();
			shopPanelMask.x = shopPanelContaner.x;
			shopPanelMask.y = shopPanelContaner.y;
			shopPanelMask.graphics.beginFill( 0xFF00FF, 0.5 );
			shopPanelMask.graphics.drawRect( 0, 0, $mcShopPanel.width, $mcShopPanel.height );
			shopPanelMask.graphics.endFill();
			shopPanelContaner.mask = shopPanelMask;

			shopPanelEffect = new Bitmap();
			shopPanelEffect.bitmapData = new BitmapData( shopPanelContaner.width, shopPanelContaner.height, true, 0 );
			shopPanelContaner.addChild( shopPanelEffect );
			
			addChildAt( shopPanelContaner , 1 );
			addChildAt( shopPanelMask, 2 );
		}
	}
}
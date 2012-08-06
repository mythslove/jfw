package app.mvc.view.ui.window.social
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
	public class SocialWindow extends BWindow
	{
		
		public var $mcSocialPanel:MovieClip;
		private var socialPanelContaner:Sprite = null;
		
		private var socialPanel:SocialTabPanel = null;
		
		private var dataList:Array = null;
		private var socialPanelMask:Shape = null;
		private var socialPanelEffect:Bitmap = null;
		
		public function SocialWindow( )
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
			socialPanelContaner = new Sprite();
			
			var tabfactory:Vector.<TabStruct> = new Vector.<TabStruct>();
			tabfactory.push(new TabStruct( { label:'好友列表',type:1,cls:SocialContainerFriend } ) ); 
			tabfactory.push(new TabStruct( { label:'礼物',type:2,cls:SocialContainerGift } ) ); 
			tabfactory.push(new TabStruct( { label:'代养',type:3,cls:SocialContaineAgent } ) ); 
			
			socialPanel = new SocialTabPanel( this.$mcSocialPanel,null,tabfactory,SpellTab );
			socialPanelContaner.addChild( socialPanel );
			
			socialPanelMask = new Shape();
			socialPanelMask.x = socialPanelContaner.x;
			socialPanelMask.y = socialPanelContaner.y;
			socialPanelMask.graphics.beginFill( 0xFF00FF, 0.5 );
			socialPanelMask.graphics.drawRect( 0, 0, $mcSocialPanel.width, $mcSocialPanel.height );
			socialPanelMask.graphics.endFill();
			socialPanelContaner.mask = socialPanelMask;
			
			socialPanelEffect = new Bitmap();
			socialPanelEffect.bitmapData = new BitmapData( socialPanelContaner.width, socialPanelContaner.height, true, 0 );
			socialPanelContaner.addChild( socialPanelEffect );
			
			addChildAt( socialPanelContaner , 1 );
			addChildAt( socialPanelMask, 2 );
		}
	}
}
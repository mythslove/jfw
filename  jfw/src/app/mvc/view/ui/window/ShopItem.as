package app.mvc.view.ui.window
{
	
	import app.mvc.view.ui.component.Image;
	
	import com.jfw.engine.core.mvc.view.BSprite;
	import com.jfw.engine.utils.FontUtil;
	import com.jfw.engine.utils.StringUtil;
	import com.jfw.engine.utils.manager.ToolTipManager;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class ShopItem extends BSprite
	{
		public var $pbbuttonBuy:MovieClip;
		public var itemName:TextField;
		public var itemCoin:TextField;
		private var image:Image;
		
		public var hotMark:MovieClip;
		public var vipMark:MovieClip;
		public var newMark:MovieClip;
		
		public var priceLabelField:TextField;
		
		// public var canBuy:Boolean;
		
		public var iconGold:MovieClip;
		public var iconGoldVip:MovieClip;
		public var vipPriceField:TextField;
		public var priceVipLabelField:TextField;
		
		public function ShopItem( panelClass:Object )
		{
			super( panelClass );
			
			this.itemName.mouseEnabled		= false;
			this.itemName.mouseWheelEnabled	= false;
			this.itemCoin.mouseEnabled		= false;
			this.itemCoin.mouseEnabled		= false;
			
			this.image						= new Image( 64, 64, true );
			this.image.x					= 21;
			this.image.y					= 13;
			addChild( this.image );

			FontUtil.setText($pbbuttonBuy.panel_buy_item,"TTTT");
		}
		
		public function setData( value:Object = null ):void
		{
			if ( value )
			{
				itemName.text = value.name;
				FontUtil.setText( itemName, value.name );
				image.load( "http://uc.9ria.com/data/avatar/000/09/86/23_avatar_small.jpg" );
				
				var tipStr:String = value.desc;
				if( tipStr.indexOf("html:") < 0)
				{
					tipStr = StringUtil.transformHtmlText( value.name,new TextFormat( "宋体",14,0xff6600,true)) + "\n"
						+ StringUtil.transformHtmlText( tipStr,new TextFormat( "宋体" ));
					
					tipStr = "html:" + tipStr;
				}
				else
				{
					tipStr = tipStr.substring(5);
					var nameStr:String = StringUtil.transformHtmlText(value.name,new TextFormat("宋体",14,0xff6600,true)) + "\n"
					tipStr = "html:" + nameStr + tipStr;
				}
				ToolTipManager.register( image, tipStr );
				this.visible = true;
				
				
				vipMark.visible = false;
				newMark.visible = Boolean( int( value['new'] ) );
			
				hotMark.visible = Boolean( int( value['hot'] ) ) && !Boolean( int( value['hot'] ) );
				FontUtil.setText( priceLabelField, "Fuck");
				FontUtil.setText( itemCoin, value.cash );
				priceVipLabelField.visible = false;
				vipPriceField.visible = false;
				iconGoldVip.visible = false;
				
				
			}
			else
			{
				visible = false;
			}
		}
		
		private function onBuyClick( evt:MouseEvent ):void
		{
//			openWindow( BuyWindow, { item:data, cash:model.gameModel.cash } );			
		}
	}
}

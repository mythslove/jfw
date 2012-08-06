package app.mvc.view.ui.panel.friends
{
	import app.mvc.control.events.HomeEvent;
	import app.mvc.model.MaterialModel;
	import app.mvc.model.data.player.FriendStruct;
	import app.mvc.model.player.FriendModel;
	import app.mvc.view.ui.component.interfaces.IList;
	
	import com.jfw.engine.utils.FilterUtil;
	import com.jfw.engine.utils.FontUtil;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.FontType;
	import flash.text.TextField;
	import app.mvc.view.ui.component.BaseListItem;
	import app.mvc.view.ui.component.Image;
	import app.mvc.view.ui.component.Tip;
	
	public class MainFriendItem extends BaseListItem
	{
		static private const NORMAL:int = 1;
		static private const LIGHT:int = 2;
		
		public var $txName:TextField ;
		public var $txLevel:TextField;
		public var $txFriendly:TextField;
		public var $txVip:TextField;
		public var $mcFace:MovieClip;
		public var $mcSpar:MovieClip;
		public var $mcBox:MovieClip;
		public var $pbGift:SimpleButton;
		public var $mcIconVip:MovieClip;
		public var $mcFriendly:MovieClip;
		
		private var image:Image = null;
		
		public function MainFriendItem(list:IList)
		{
			super(list);
			
			image = new Image( 50, 50 );
			$mcFace.addChild( image );
			image.mouseEnabled = false;
			
			addEventListener( MouseEvent.CLICK, onMouseClick );
			addEventListener( MouseEvent.ROLL_OVER, onMouseOver );
			addEventListener( MouseEvent.ROLL_OUT, onMouseOut );
		}
		
		override protected function onMouseClick(evt:MouseEvent):void
		{
			switch( evt.target )
			{
				case this.$pbGift:
						return ;
					break;
			}
			
			this.selected = true;
			this.sendEvent(HomeEvent.VISITFRIEND_INIT,friend );	
		}
		
		override protected function initData():void
		{
			this.showVip( (this.friend.vip == 1),this.friend.viplv );
			this.showGetBox( this.friend.isGetBox );
			this.showSendGift( this.friend.isSendGift );
			
			$mcSpar.gotoAndStop( this.friend.type + 1 );
			Tip.register( $mcSpar ,"该玩家的五行山产出" + materialModel.sparColorStr( this.friend.spartype ) );
			Tip.register( $mcBox,'访问玩家领取宝箱' );
			Tip.register( $pbGift,'赠送或索取礼物' );
			Tip.register( $mcFriendly,'好友亲密度' );
			
			FontUtil.setText( this.$txName, this.friend.name );
			FontUtil.setText( $txLevel,'Lv' + this.friend.lv.toString() );
			FontUtil.setText( $txFriendly, this.friend.friendly );
			image.load( this.friend.thumb );
		}
		
		override public function set selected( value:Boolean ):void
		{
			super.selected = value;
			//setBgFrame( value );
			this._list.setSelectItem( this.itemId );
		}
		
		override protected function onMouseOver(evt:MouseEvent):void
		{
			FilterUtil.applyContrast( this.$mcBg );
		}
		
		override protected function onMouseOut(evt:MouseEvent):void
		{
			FilterUtil.clearGlowFilter( this.$mcBg );
		}
		
		/**
		 * 显示VIP图标状态
		 * 
		 * @param vip
		 * @param viplv
		 */
		private function showVip( vip:Boolean,viplv:int ):void
		{
			this.showMc( this.$mcIconVip,vip );
			this.showMc( this.$txVip, vip );
			
			if( vip )
			{
				FontUtil.setText( this.$txVip, viplv );
				Tip.register( $mcIconVip,'玩家VIP级别' );
			}
		}
		
		private function showGetBox( isShowBox:Boolean ):void
		{
			this.$mcBox.visible = !isShowBox;
		}
		
		private function showSendGift( isShowGift:Boolean ):void
		{
			this.$pbGift.visible = !isShowGift;
		}
		
		private function setBgFrame( light:Boolean ):void
		{
			if( light )
				this.$mcBg.gotoAndStop( LIGHT );
			else
				this.$mcBg.gotoAndStop( NORMAL );
		}
		
		private function get friend():FriendStruct
		{
			return data as FriendStruct;
		}
		
		private function get friendModel():FriendModel
		{
			return this.core.retModel( FriendModel.NAME ) as FriendModel;
		}
		
		private function get materialModel():MaterialModel
		{
			return this.core.retModel( MaterialModel.NAME ) as MaterialModel;
		}
	}
}
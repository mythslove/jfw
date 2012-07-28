package app.view.ui
{
	import app.model.data.player.PlayerStruct;
	import app.model.player.PlayerModel;
	import app.view.ui.component.Image;
	import app.view.ui.component.MainFriendPanel;
	import app.view.ui.component.Tip;
	
	import com.jfw.engine.core.data.IStruct;
	import com.jfw.engine.core.mvc.view.BPanel;
	import com.jfw.engine.utils.FontUtil;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import mx.binding.utils.BindingUtils;
	
	public class MainUI extends BPanel
	{
		public var $mcRoleInfo:MovieClip;
		public var $mcTopPanel:MovieClip;
		public var $mcCd:MovieClip;
		public var $mcTaskTitle:MovieClip;
		public var $mcTaskMenu:MovieClip;
		public var $mcGiftPanel:MovieClip;
		
		private var playerModel:PlayerModel;
		private var mainFriendPanel:MainFriendPanel;
		private var playerImg:Image;
		
		public function MainUI( mapContainer:DisplayObjectContainer = null,data:IStruct=null)
		{
			super( null, data );
			
			if( mapContainer )
			{
				mapContainer.addChild( this );
			}
		}
		
		override protected function onInit():void
		{
			super.onInit();
			
			playerModel = this.core.retModel( PlayerModel.NAME ) as PlayerModel;
			
			regTips();
			
			playerImg = new Image(50,50);
			( this.$mcRoleInfo['$mcHeadImg'] as Sprite ).addChild( playerImg );
			playerImg.load( this.playerModel.playerVO.thumb );
			
			mainFriendPanel = new MainFriendPanel();
			addChild( mainFriendPanel );
			
			onStageResize();
			
			this.setBindings();
		}
		
		override public function destroy():void
		{
			removeChild( mainFriendPanel );
			mainFriendPanel = null;
			playerImg = null;
			playerModel = null;
			
			super.destroy();
		}
		
		override protected function onMouseClick(evt:MouseEvent):void
		{
			super.onMouseClick( evt );
		}
		
		private function onStageResize( ):void
		{
			if ( !stage )
				return;
			
			mainFriendPanel.show( false );
		}
		
		private function regTips():void
		{
			Tip.register( this.$mcRoleInfo['$pbAddPower'],'购买猴毛' );
			Tip.register( this.$mcRoleInfo['$pbAddMoney'],'充值' );
			Tip.register( this.$mcRoleInfo['$pbLijin'],'兑换礼金券' );
			Tip.register( this.$mcRoleInfo['$mcVip'],'VIP级别' );
			Tip.register( this.$mcRoleInfo['$mcHp'],'血量' );
			Tip.register( this.$mcRoleInfo['$mcExp'],'经验' );
			Tip.register( this.$mcRoleInfo['$mcPowerHotArea'],'猴毛' );
			Tip.register( this.$mcRoleInfo['$mcCallNameHotArea'],'成就称号' );
			
			Tip.register( this.$mcTopPanel['$mcHotAreaGb'],'金币' );
			Tip.register( this.$mcTopPanel['$mcHotAreaYb'],'妖币' );
			Tip.register( this.$mcTopPanel['$mcHotAreaLucky'],'幸运值' );
			Tip.register( this.$mcGiftPanel['$pbBtnYellowRookie'],'免费礼物' );
			Tip.register( this.$mcGiftPanel['$pbOnLine'],'在线奖励' );
			Tip.register( this.$mcGiftPanel['$pbDailyActive'],'在线活跃度' );
		}
		
		/** 绑定 */
		private function setBindings():void
		{
			BindingUtils.bindSetter( changeAttrBinding,this.playerModel,'playerVO' );
		}
		
		private function changeAttrBinding( playerVO:PlayerStruct ):void
		{
			FontUtil.setText(this.$mcTopPanel['$txGb'],playerVO.gb.toString());
			FontUtil.setText(this.$mcTopPanel['$txYb'],playerVO.yb.toString());
			FontUtil.setText( this.$mcTopPanel['$txLuck'],playerVO.lucky.toString() );
			FontUtil.setText(this.$mcRoleInfo['$mcHp']['$txTxt'],playerVO.hp.toString());
			FontUtil.setText(this.$mcRoleInfo['$mcExp']['$txTxt'],playerVO.exp.toString());
			FontUtil.setText( this.$mcRoleInfo['$txName'],playerVO.uname );
			FontUtil.setText( this.$mcRoleInfo['$txNick'],playerVO.callName );
			FontUtil.setText( this.$mcRoleInfo['$txLv'],playerVO.lv.toString() );
			FontUtil.setText( this.$mcRoleInfo['$mcVip']['$txVip'],playerVO.viplv.toString() );
			FontUtil.setText( this.$mcRoleInfo['$txPower'],playerVO.power.toString() );
			FontUtil.setText( this.$mcRoleInfo['$txPower'],playerVO.power.toString() );
		}
	}
}
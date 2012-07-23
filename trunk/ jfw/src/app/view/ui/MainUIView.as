package app.view.ui
{
	import app.model.data.player.PlayerStruct;
	import app.model.player.PlayerModel;
	import app.view.ui.component.MainFriendPanel;
	import app.view.ui.component.Tip;
	import app.view.ui.component.alert.Alert;
	import app.view.ui.window.NoticeWindow;
	import app.view.ui.window.ShopWindow;
	
	import com.greensock.TweenMax;
	import com.jfw.engine.core.data.IStruct;
	import com.jfw.engine.core.mvc.view.BPanel;
	import com.jfw.engine.utils.FontUtil;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import mx.binding.utils.BindingUtils;
	
	public class MainUIView extends BPanel
	{
		public var $mcRoleInfo:MovieClip;
		public var $mcTopPanel:MovieClip;
		public var $mcCd:MovieClip;
		public var $mcTaskTitle:MovieClip;
		public var $mcTaskMenu:MovieClip;
		public var $mcGiftPanel:MovieClip;
		public var $mcShortcut:MovieClip;
		
		private var playerModel:PlayerModel;
		private var mainFriendPanel:MainFriendPanel;
		
		public function MainUIView( mapContainer:DisplayObjectContainer = null,data:IStruct=null)
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
			
			Tip.register( this.$mcTopPanel['$mcHotAreaGb'],'金币' );
			Tip.register( this.$mcTopPanel['$mcHotAreaYb'],'妖币' );
			Tip.register( this.$mcTopPanel['$mcHotAreaLucky'],'幸运值' );
			Tip.register( this.$mcGiftPanel['$pbBtnYellowRookie'],'免费礼物' );
			Tip.register( this.$mcGiftPanel['$pbOnLine'],'在线奖励' );
			Tip.register( this.$mcGiftPanel['$pbDailyActive'],'在线活跃度' );
			
			Tip.register( this.$mcShortcut['$pbSocial'],'社交' );
			Tip.register( this.$mcShortcut['$pbHelp'],'帮主' );
			Tip.register( this.$mcShortcut['$pbHome'],'回城' );
			Tip.register( this.$mcShortcut['$pbTask'],'任务' );
			Tip.register( this.$mcShortcut['$pbBattle'],'战斗' );
			Tip.register( this.$mcShortcut['$pbBag'],'仓库' );
			Tip.register( this.$mcShortcut['$pbApp'],'应用中心' );
			Tip.register( this.$mcShortcut['$pbRole'],'人物' );
			Tip.register( this.$mcShortcut['$pbEquip'],'装备' );
			Tip.register( this.$mcShortcut['$mcSpell'],'法术' );
			Tip.register( this.$mcShortcut['$pbMagic'],'法宝' );
//			TipManager.createToolTip( this.$mcTopPanel['$pbSocial'],'即将开放' );
			
			mainFriendPanel = new MainFriendPanel();
			addChild( mainFriendPanel );
			
			onStageResize();
			
			this.setBindings();
		}
		
		override protected function onMouseClick(evt:MouseEvent):void
		{
			super.onMouseClick( evt );
			
			switch( evt.target )
			{
				//帮助
				case this.$mcShortcut['$pbHelp']:
					var obj:Object = playerModel.playerVO.clone();
					obj.gb = playerModel.playerVO.gb + 1;
					playerModel.playerVO = new PlayerStruct(obj);
					break;
				//社交
				case this.$mcShortcut['$pbSocial']:

					WindowManager.getInstance().openWindow(new NoticeWindow());

//					Alert.show( '测试',Alert.OK,null,'small' );

					break;
				//任务
				case this.$mcShortcut['$pbTask']:
					WindowManager.getInstance().openWindow(new ShopWindow());
					
					break;
				//背包
				case this.$mcShortcut['$pbBag']:
					break;
				//回城
				case this.$mcShortcut['$pbHome']:
					break;
				//快捷中心
				case this.$mcShortcut['$pbApp']:
					break;
				//战斗
				case this.$mcShortcut['$pbBattle']:
					break;
				//妖将
				case this.$mcShortcut['$pbRole']:
					break;
				//装备
				case this.$mcShortcut['$pbEquip']:
					break;
				//法术
				case this.$mcShortcut['$mcSpell']:
					break;
				//法宝
				case this.$mcShortcut['$pbMagic']:
					break;
			}
		}
		
		override protected function onMouseOver(evt:MouseEvent):void
		{
			trace( evt.target.name,evt.currentTarget.name);
			switch( evt.target )
			{
				case this.$mcShortcut['$pbHelp']:
				case this.$mcShortcut['$pbSocial']:
				case this.$mcShortcut['$pbTask']:
				case this.$mcShortcut['$pbBag']:
				case this.$mcShortcut['$pbHome']:
				case this.$mcShortcut['$pbApp']:
				case this.$mcShortcut['$pbBattle']:
				case this.$mcShortcut['$pbRole']:
				case this.$mcShortcut['$pbEquip']:
				case this.$mcShortcut['$pbSpell']:
				case this.$mcShortcut['$pbMagic']:
					TweenMax.to(evt.target, 0.5, { y:-11 });
					break;
			}
			
		}
		
		override protected function onMouseOut(evt:MouseEvent):void
		{
			switch( evt.target )
			{
				case this.$mcShortcut['$pbHelp']:
				case this.$mcShortcut['$pbSocial']:
				case this.$mcShortcut['$pbTask']:
				case this.$mcShortcut['$pbBag']:
				case this.$mcShortcut['$pbHome']:
				case this.$mcShortcut['$pbApp']:
				case this.$mcShortcut['$pbBattle']:
				case this.$mcShortcut['$pbRole']:
				case this.$mcShortcut['$pbEquip']:
				case this.$mcShortcut['$pbSpell']:
				case this.$mcShortcut['$pbMagic']:
					TweenMax.to(evt.target, 0.5, { y:0 });
					break;
			}
		}
		
		override protected function regTips(obj:Object):void
		{
			switch( obj )
			{
				case this.$mcShortcut['$pmGb']:
//					TipManager.createToolTip( this.$mcTopPanel['$pbHelp'],'即将开放' );
					break;
			}
		}
		
		private function onStageResize( ):void
		{
			if ( !stage )
				return;
			
			mainFriendPanel.show( false );
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
			FontUtil.setText(this.$mcRoleInfo['$mcExp']['$txTxt'],playerVO.exp.toString());
		}
	}
}
package app.view.ui
{
	import app.model.data.player.PlayerStruct;
	import app.model.player.PlayerModel;
	import app.view.ui.component.Tip;
	import app.view.ui.component.alert.Alert;
	
	import com.jfw.engine.core.data.IStruct;
	import com.jfw.engine.core.mvc.view.BPanel;
	import com.jfw.engine.utils.FontUtil;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
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
			Tip.register( this.$mcShortcut['$pbSocial'],'社交' );
			Tip.register( this.$mcShortcut['$pbSocial'],'社交' );
			Tip.register( this.$mcShortcut['$pbSocial'],'社交' );
			Tip.register( this.$mcShortcut['$pbSocial'],'社交' );
//			TipManager.createToolTip( this.$mcTopPanel['$pbSocial'],'即将开放' );
			
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
					Alert.show( '测试',Alert.OK,null,'small' );
					break;
				//任务
				case this.$mcShortcut['$pbTask']:
					break;
			}
		}
		
		override protected function onMouseOver(evt:MouseEvent):void
		{
			super.onMouseOver( evt );
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
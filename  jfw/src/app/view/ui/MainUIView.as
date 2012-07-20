package app.view.ui
{
	import app.model.data.player.PlayerStruct;
	import app.model.player.PlayerModel;
	import app.view.ui.component.Tip;
	import app.view.ui.manager.TipManager;
	
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
			
			(this.$mcTopPanel['$txGb'] as TextField).mouseEnabled = true;
			Tip.register( this.$mcShortcut['$pbSocial'],'武将' );
			
			
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
					TipManager.createToolTip( this.$mcTopPanel['$pbHelp'],'即将开放' );
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
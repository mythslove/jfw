package app.mvc.view.ui.panel
{
	import app.mvc.model.data.player.PlayerStruct;
	import app.mvc.model.player.PlayerModel;
	import app.mvc.view.ui.component.Tip;
	import app.mvc.view.ui.window.NoticeWindow;
	import app.mvc.view.ui.window.ShopWindow;
	import app.mvc.view.ui.window.spell.SpellWindow;
	
	import com.greensock.TweenLite;
	import com.jfw.engine.core.data.IStruct;
	import com.jfw.engine.core.mvc.view.BPanel;
	import com.jfw.engine.core.mvc.view.WindowManager;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	/**
	 * 快捷栏 
	 * @author jianzi
	 * 
	 */	
	public class MainShortCut extends BPanel
	{
		public var $pbSocial:SimpleButton = null;
		public var $pbHelp:SimpleButton = null;
		public var $pbHome:SimpleButton = null;
		public var $pbTask:SimpleButton = null;
		public var $pbBattle:SimpleButton = null;
		public var $pbBag:SimpleButton = null;
		public var $pbApp:SimpleButton = null;
		public var $pbRole:SimpleButton = null;
		public var $pbEquip:SimpleButton = null;
		public var $mcSpell:MovieClip = null;
		public var $pbMagic:SimpleButton = null;
		
		private var playerModel:PlayerModel;
		
		public function MainShortCut( container:DisplayObjectContainer = null,data:IStruct=null)
		{
			super( null, data );
			this.x = 0;
			this.y = 620;
			if( container )
				container.addChild( this );
		}
		
		override protected function onInit():void
		{
			super.onInit();
			
			this.$mcBg.mouseEnabled = false;
			
			playerModel = this.core.retModel( PlayerModel.NAME ) as PlayerModel;
			
			regTips();
		}
		
		override protected function onMouseClick(evt:MouseEvent):void
		{
			super.onMouseClick( evt );
			switch( evt.target )
			{
				//帮助
				case this.$pbHelp:
					var obj:Object = playerModel.playerVO.clone();
					obj.gb = playerModel.playerVO.gb + 1;
					playerModel.playerVO = new PlayerStruct(obj);
					break;
				//社交
				case this.$pbSocial:
					WindowManager.getInstance().openWindow(new NoticeWindow(),null,true);
					//					Alert.show( '测试',Alert.OK,null,'small' );
					break;
				//任务
				case this.$pbTask:
					WindowManager.getInstance().openWindow(new ShopWindow(),null,true);
					
					break;
				//背包
				case this.$pbBag:
					break;
				//回城
				case this.$pbHome:
					break;
				//快捷中心
				case this.$pbApp:
					break;
				//战斗
				case this.$pbBattle:
					break;
				//妖将
				case this.$pbRole:
					break;
				//装备
				case this.$pbEquip:
					break;
				//法术
				case this.$mcSpell['$pbSpell']:
					WindowManager.getInstance().openWindow( new SpellWindow(),null,true);
					break;
				//法宝
				case this.$pbMagic:
					break;
			}
		}
		
		override protected function onMouseOver(evt:MouseEvent):void
		{
			switch( evt.target )
			{
				case this.$pbHelp:
				case this.$pbSocial:
				case this.$pbTask:
				case this.$pbBag:
				case this.$pbHome:
				case this.$pbApp:
				case this.$pbBattle:
				case this.$pbRole:
				case this.$pbEquip:
				case this.$mcSpell:
				case this.$pbMagic:
					TweenLite.to( evt.target,.5 ,{ y:this.height * .5 - 10 } );
					break;
			}
		}
		
		override protected function onMouseOut(evt:MouseEvent):void
		{
			switch( evt.target )
			{
				case this.$pbHelp:
				case this.$pbSocial:
				case this.$pbTask:
				case this.$pbBag:
				case this.$pbHome:
				case this.$pbApp:
				case this.$pbBattle:
				case this.$pbRole:
				case this.$pbEquip:
				case this.$mcSpell:
				case this.$pbMagic:
					TweenLite.to(evt.target, .5, { y:this.height * .5 });
					break;
			}
		}
		
		private function regTips():void
		{
			Tip.register( $pbSocial,'社交' );
			Tip.register( $pbHelp,'帮主' );
			Tip.register( $pbHome,'回城' );
			Tip.register( $pbTask,'任务' );
			Tip.register( $pbBattle,'战斗' );
			Tip.register( $pbBag,'仓库' );
			Tip.register( $pbApp,'应用中心' );
			Tip.register( $pbRole,'人物' );
			Tip.register( $pbEquip,'装备' );
			Tip.register( $mcSpell,'法术' );
			Tip.register( $pbMagic,'法宝' );
		}
	}
}
package app.mvc.view.ui.window.spell
{
	import app.mvc.control.events.ModelEvent;
	import app.mvc.model.data.LoadPicStruct;
	import app.mvc.model.data.MonsterStruct;
	import app.mvc.model.data.SpellStruct;
	import app.mvc.model.net.NetRequest;
	import app.mvc.model.spell.SpellModel;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Back;
	import com.jfw.engine.core.data.IStruct;
	import com.jfw.engine.core.mvc.view.BPanel;
	import com.jfw.engine.utils.FontUtil;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import mx.binding.utils.BindingUtils;
	
	
	/**
	 * 法术合成 
	 * @author Administrator
	 * 
	 */	
	[Bindable]
	public class SpellMixturePage extends BPanel
	{
		public var $pmSpellAdvanced:MovieClip;
		public var $mcMixturelIcon:MovieClip;
		public var $mcMixtureItem:MovieClip;
		
		private const ITEM_NUM:int = 6;
		
		private var spellModel:SpellModel;
		
		private var currSelectIndex:int = 0;
		
		private var _currSpellStruct:SpellStruct = null;
		
		
		public function SpellMixturePage(cls_ref:Object=null, data:IStruct=null)
		{
			super(cls_ref, data);
		}
		
		override protected function onInit():void{
			spellModel = this.core.retModel( SpellModel.NAME ) as SpellModel;
			currSpellStruct = ( spellModel.currSelectedMonster as MonsterStruct ).spell[ currSelectIndex ];
			this.setBindings();
		}
		
		/** 绑定 */
		private function setBindings():void
		{
			BindingUtils.bindSetter( changeAttrBinding,this.spellModel,'currSelectedMonster' );
			BindingUtils.bindSetter( selectSpellChangeBinding,this,'currSpellStruct' );
		}
		
		private function selectSpellChangeBinding( spell:SpellStruct ):void
		{
			if( !spell )
			{
//				FontUtil.setText( $txSpellname,'' );
//				FontUtil.setText( $txSpellLevel,'' );
//				FontUtil.setText( $txSpellType,'' );
//				FontUtil.setText( $txSpellDesc,'' );
//				FontUtil.setText( $txSpellTime,'' );
//				FontUtil.setText( $txSpellEffect,'' );
//				FontUtil.setText( $txSpellYb,'' );
//				FontUtil.setText( $txSpellBookNum,'' );
				
				( $mcMixturelIcon['$mcIcon'] as MovieClip).graphics.clear();
				return;
			}
			
//			FontUtil.setText( $txSpellname,this.currSpellStruct.name );
//			FontUtil.setText( $txSpellLevel,this.currSpellStruct.lv );
//			FontUtil.setText( $txSpellType,this.currSpellStruct.type );
//			FontUtil.setText( $txSpellDesc,this.currSpellStruct.desc );
//			FontUtil.setText( $txSpellTime,this.currSpellStruct.cd );
//			FontUtil.setText( $txSpellEffect,this.currSpellStruct.uptip );
//			FontUtil.setText( $txSpellYb,this.currSpellStruct.yb );
//			FontUtil.setText( $txSpellBookNum,this.currSpellStruct.bookid );
			
			( $mcMixturelIcon['$mcIcon'] as MovieClip).graphics.clear();
			sendEvent( ModelEvent.LOAD_PIC,new LoadPicStruct( { mc:$mcMixturelIcon['$mcIcon'],srcid:currSpellStruct.srcid} ) );
		}
		
		private function changeAttrBinding( monster:IStruct ):void
		{
			
			// TODO： 做成组件
			if( monster is MonsterStruct )
			{
				var monsterStruct:MonsterStruct = monster as MonsterStruct;
				var len:int = monsterStruct.spell.length;
				for( var i:int = 0; i < ITEM_NUM; i++ )
				{
					( $mcMixtureItem['$pmSpell_' + i]['$mcItem']['$mcIcon'] as MovieClip).graphics.clear();
					
					if( i < len )
					{
						var spell:SpellStruct = monsterStruct.spell[i];
						FontUtil.setText( $mcMixtureItem['$pmSpell_' + i]['$txName'],spell.name );
						sendEvent( ModelEvent.LOAD_PIC,new LoadPicStruct( { mc:$mcMixtureItem['$pmSpell_' + i]['$mcItem']['$mcIcon'],srcid:spell.srcid} ) );
					}
					else
					{
						FontUtil.setText( $mcMixtureItem['$pmSpell_' + i]['$txName'],'' );
					}
				}
				
				
				if( len > currSelectIndex )
					currSpellStruct = ( spellModel.currSelectedMonster as MonsterStruct ).spell[ currSelectIndex ];
				else if( len > 0 )
				{
					currSelectIndex = 0;
					currSpellStruct = ( spellModel.currSelectedMonster as MonsterStruct ).spell[ currSelectIndex ];
				} 
				else
				{
					currSpellStruct = null;
				}
				
			}
			
		}
		
		override protected function onMouseClick(evt:MouseEvent):void
		{
			
			switch( evt.target )
			{
				case $pmSpellAdvanced:
					sendEvent(NetRequest.SpellStrengthen,{id:10001});
					break;
				
			}
			
			switch( this.getMcName( evt.target as DisplayObject ) )
			{
				case '$pmSpell':
					var index:int = this.getMcIndex( evt.target as DisplayObject );
					if( index == this.currSelectIndex )
						return;
					TweenLite.to( this.$mcMixtureItem['$mcItemBg'],.2,{ x:evt.target.x,y:evt.target.y,ease:Back.easeOut } );
					this.currSelectIndex = index;
					//
					currSpellStruct = ( spellModel.currSelectedMonster as MonsterStruct ).spell[ currSelectIndex ];
					break;
			}
		}
		
		private function onLevelUpButtonClick():void{
			
			
		}
		
		private function onCodeTimeButtonClick():void{
			
			
		}
		
		public function get currSpellStruct():SpellStruct
		{
			return this._currSpellStruct;
		}
		
		public function set currSpellStruct(value:SpellStruct):void
		{
			_currSpellStruct = value;
		}
		
		private function onSpellAdvancedButtonClick():void{
			
			
		}
	}
}
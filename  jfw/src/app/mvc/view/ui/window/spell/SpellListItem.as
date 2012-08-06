package app.mvc.view.ui.window.spell
{
	import app.mvc.control.events.ModelEvent;
	import app.mvc.control.events.SpellEvent;
	import app.mvc.model.data.EmptyStruct;
	import app.mvc.model.data.LoadPicStruct;
	import app.mvc.model.data.MonsterStruct;
	import app.mvc.view.ui.component.BaseListItem;
	import app.mvc.view.ui.component.Tip;
	import app.mvc.view.ui.component.interfaces.IList;
	
	import com.jfw.engine.utils.FilterUtil;
	import com.jfw.engine.utils.FontUtil;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class SpellListItem extends BaseListItem
	{
		
		public var $txLv:TextField;
		public var $mcLvBg:MovieClip;
		public var $txName:TextField;
		public var $mcPhoto:MovieClip;
		public var $mcLock:MovieClip;
		
		
		public function SpellListItem(list:IList)
		{
			super(list);
			
			addEventListener( MouseEvent.CLICK, onMouseClick );
			addEventListener( MouseEvent.ROLL_OVER, onMouseOver );
			addEventListener( MouseEvent.ROLL_OUT, onMouseOut );
		}
		
		//绑定妖将列表的数据
		override protected function initData():void
		{
			
			if( this.data is EmptyStruct )
			{
				this.showMc( $txLv,false );
				this.showMc( $mcPhoto,false );
				this.showMc( $mcLvBg,false );
				this.showMc( $mcLock,true );
				FontUtil.setText(  $txName ,(this.data as EmptyStruct ).label );
			}
			else
			{
				this.showMc( $txLv,true );
				this.showMc( $mcPhoto,true );
				this.showMc( $mcLvBg,true );
				this.showMc( $mcLock,false );
				FontUtil.setText( $txName ,this.monster.name );
				FontUtil.setText( $txLv,this.monster.lv.toString() );
				this.sendEvent( ModelEvent.LOAD_PIC,new LoadPicStruct( { mc: $mcPhoto['$mcIcon'],srcid:this.monster.srcid } ) );
			}
		}
		
		override public function set selected( value:Boolean ):void
		{
			super.selected = value;
			this._list.setSelectItem( this.itemId );
		}
		
		override protected function onMouseClick(evt:MouseEvent):void
		{
			dispatchEvent( new SpellEvent( SpellEvent.MONSTERLIST_CLICK_ITEM, this ) );		
		}
		
		override protected function onMouseOver(evt:MouseEvent):void
		{
			FilterUtil.applyContrast( this );
		}
		
		override protected function onMouseOut(evt:MouseEvent):void
		{
			FilterUtil.clearGlowFilter( this );
		}
		
		private function get monster():MonsterStruct
		{
			return data as MonsterStruct;
		}
	}
}
package app.mvc.view.ui.component
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	import com.jfw.engine.core.data.IStruct;
	import com.jfw.engine.core.mvc.view.BPanel;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class TabPanel extends BPanel
	{
		//默认属性
		protected var contentW:int = 680;
		protected var contentH:int = 427;
		protected var contentSpace:int = 0;
		protected var contentX:int = 40;
		protected var contentY:int = 40;
		protected var navX:int = 0;
		protected var navY:int = 0;
		protected var navLeftDis:int = 40;
		protected var navSpaceBetween:int = 10;
		
		protected var nav:Navigation ;
		protected var _tabFactory:Vector.<TabStruct>;
		protected var _btnSkin:Class;
		protected var _contentMap:Object ;
		protected var _currContent:*;
		protected var _selectedContent:*;
		protected var currSelectedTab:int = 0;
		
		protected var contentContainer:Sprite = null;
		protected var contentEffect:Bitmap = null;
		protected var contentMask:Shape = null;
		protected var contentTween:Object = { };
		
		public function TabPanel( cls_ref:Object=null, data:IStruct=null, tabfactory:Vector.<TabStruct> = null, tabButtonSkin:Class = null )
		{
			super(cls_ref, data);
			
			if( tabfactory )
				this.tabFactory = tabfactory;
			if( tabButtonSkin )
				this.btnSkin = tabButtonSkin || ToggleButton;
		}
		
		override protected function onInit():void
		{
			super.onInit();
			createTab();
			createContents();
		}
		
		public function setCurrContent( index:int ):void
		{
			this._currContent = this._contentMap[ this.tabFactory[index].type ];
			var type:int = this.tabFactory[index].type;
			for( var key:String in this._contentMap )
			{
				if( type == int(key) )
					this._contentMap[key].visible = true;
				else
					this._contentMap[key].visible = false;
			}
		}
		
		protected function createTab():void
		{
			nav = new Navigation( tabFactory.length );
			nav.leftDistance = navLeftDis;
			nav.spaceBetween = navSpaceBetween;
			nav.x = navX;
			nav.y = navY;
			
			for each ( var itemObj:TabStruct in tabFactory )
			{
				nav.addItem( new btnSkin( itemObj.label ) );
			}
			
			this.addChild( nav );
			nav.selectedIndex = 0;
			nav.addEventListener(Event.CHANGE, onChangeTab);
		}
		
		protected function createContents():void
		{
			contentContainer = new Sprite();
			contentContainer.x = contentX;
			contentContainer.y = contentY;
			
			contentEffect = new Bitmap();
			contentContainer.addChild( contentEffect );
			
			contentMask = new Shape();
			contentMask.x = contentContainer.x;
			contentMask.y = contentContainer.y;
			contentMask.graphics.beginFill( 0xFF00FF, 0.5 );
			contentMask.graphics.drawRect( 0, 0, this.contentW, this.contentH );
			contentMask.graphics.endFill();
			
			contentContainer.mask = contentMask;
			
			addChild( contentContainer );
			addChild( contentMask );
			
			_contentMap = {};
			for( var i:int = 0, len:int = this.tabFactory.length; i < len; i++ )
			{
				_contentMap[ this.tabFactory[i].type ] = new this.tabFactory[i].cls; 
				this.contentContainer.addChild( _contentMap[ this.tabFactory[i].type ] );
			}
			
			setCurrContent( 0 );
		}
		
		protected function onChangeTab( evt:Event ):void
		{
			contentEffect.bitmapData = new BitmapData( this.contentW, this.contentH, true, 0 );
			contentEffect.bitmapData.draw( _currContent );
			contentEffect.alpha = 1;
			
			var endA:int = 0;
			var endB:int = 0;
			
			_selectedContent = this._contentMap[ this.tabFactory[ nav.selectedIndex ].type ];
			_selectedContent.visible = true;
			//this.contentContainer.addChild( _selectedContent );
			
			if ( this.currSelectedTab < nav.selectedIndex )
			{
				contentEffect.x = 0;
				_currContent.x = 0;
				_selectedContent.x = this.contentW + this.contentSpace;
				endA = -( this.contentW + this.contentSpace );
				endB = 0;
			}
			else if ( this.currSelectedTab > nav.selectedIndex )
			{
				contentEffect.x = 0;
				_currContent.x = 0;
				_selectedContent.x =  -( this.contentW + this.contentSpace );
				endA = this.contentW + this.contentSpace ;
				endB = 0;
			}
			
			TweenLite.to( contentEffect,0.5,{ x: endA , alpha:0 ,ease:Expo.easeInOut} );
			TweenLite.to( _currContent,0.5,{ x:endA ,alpha:0,ease:Expo.easeInOut} );
			TweenLite.to( _selectedContent,0.5,{ x:endB,alpha:1,ease:Expo.easeInOut } );
			
			currSelectedTab = nav.selectedIndex;
			_currContent = _selectedContent;
		}
		
		public function set tabFactory( tabs:Vector.<TabStruct> ):void
		{
			this._tabFactory = tabs;
		}
		
		public function get tabFactory():Vector.<TabStruct>
		{
			return this._tabFactory;
		}
		
		public function set btnSkin( cls:Class ):void
		{
			this._btnSkin = cls;
		}
		
		public function get btnSkin( ):Class
		{
			return this._btnSkin;
		}
		
		override public function destroy():void
		{
			_tabFactory = null;
			contentContainer = null;
			contentEffect = null;
			contentEffect = null;
			contentMask = null;
			nav.removeEventListener(Event.CHANGE, onChangeTab);
			super.destroy();
		}
	}
}
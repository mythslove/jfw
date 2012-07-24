package app.view.ui.component
{
	import app.view.ui.component.interfaces.IList;
	import app.view.ui.component.interfaces.IListItem;
	
	import com.greensock.TweenLite;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	/**
	 * 多功能列表组件 
	 * @author Sam Wang
	 * 
	 */	
	public class List extends Sprite implements IList
	{
		// 纵向 	
		public static const VERTICAL:String		= "vertical";
		// 横向
		public static const HORIZONTAL:String	= "horizontal";	
		
		//遮罩
		private var _mask:Shape;
		//容器
		private var _container:Sprite
		
		//宽度
		private var _width:int;
		//高度
		private var _height:int;
		//间隔
		private var _space:int;
		
		private var _drawMaskX:int;
		private var _drawMaskY:int;
		private var _drawMaskWidth:int;
		private var _drawMaskHeight:int;
		
		//当前容器位置
		private var _containerPoint:int;
		//子项类
		private var _itemClass:Class;
		//子项实例
		private var _itemInstance:IListItem;
		
//		列表数据
		private var _data:Array;
//		显示列表
		private var _list:Array;
//		垃圾列表
		private var _listTrash:Array;
//		是否允许拖拽
		private var _drag:Boolean	= false;
//		是否允许拖拽特效
		private var _dragEffect:Boolean	= false;
//		拖拽效果检测时间
		private var _dragEffectTimer:Timer;
//		拖拽移动位置
		private var _dragMPoint:int;
//		拖拽特效时间
		private var _dragEffectTime:Number		= 1;
//		拖拽效果最大时间
		private var _dragEffectMaxTime:Number	= 1;
//		拖拽效果最大距离
		private var _dragEffectMaxDistance:int	= 2000;
		
//		选择id
		private var _itemSelectedItemId:int		= -1;
		
		//角度
		private var _direction:String;
		private var _point:String;
		private var _mousePoint:String;
		private var _size:String;
		
		private var _checkTime:int		= 0;
		private var _checkPoint:int		= 0;
		
		public function List(item:Class, width:int, height:int, space:int, direction:String) 
		{
			_width				= width;
			_height				= height;
			_space				= space;
			_itemClass			= item;
			
			_drawMaskX			= 0;
			_drawMaskY			= 0;
			_drawMaskWidth		= _width;
			_drawMaskHeight		= _height;
			
			_itemInstance		= (new _itemClass(this)) as IListItem;
			this.direction		= direction;
			
			this.initilize();
			this.drag			= true;
			this.dragEffect		= true;
		}
		
		public function maskSize(drawX:int, drawY:int, drawWidth:int, drawHeight:int):void
		{
			_drawMaskX		= drawX;
			_drawMaskY		= drawY;
			_drawMaskWidth	= drawWidth;
			_drawMaskHeight	= drawHeight;
			
			drawMask();
		}
		
		/**
		 * 初始化列表数据
		 */
		private function initilize():void
		{
			_list				= [];
			_listTrash			= [];
			
			_containerPoint		= 0;
			_container			= new Sprite();
			_mask				= new Shape();
			
			_container.mask		= _mask;
			
			_dragEffectTimer	= new Timer(400);
			
			addChild(_container);
			addChild(_mask);
			
			refreshListDisplayItems();
			
			drawMask();
		}
		
		/**
		 * 设置列表数据
		 * @param value
		 * 
		 */		
		public function set data(value:Array):void
		{
			_data	= value;
			
			refreshListData(true);
		}
		
		public function get data():Array
		{
			return _data;
		}
		
		/**
		 * 设置是否启用拖拽
		 * @param value
		 * 
		 */		
		public function set drag(value:Boolean):void
		{
			if(_drag != value)
			{
				_drag	= value;
				
				if(_drag)
				{
					_container.addEventListener(MouseEvent.MOUSE_DOWN, onContainerMouseDown);
				}else
				{
					_container.removeEventListener(MouseEvent.MOUSE_DOWN, onContainerMouseDown);
				}
			}
		}
		
		public function get drag():Boolean
		{
			return _drag;
		}
		
		/**
		 * 设置拖拽特效是否开启
		 * @param value
		 * 
		 */		
		public function set dragEffect(value:Boolean):void
		{
			if(_dragEffect != value)
			{
				_dragEffect	= value;
			}
		}
		
		public function get dragEffect():Boolean
		{
			return _dragEffect;
		}
		
		private function onContainerMouseDown(e:MouseEvent):void
		{
			this._dragMPoint	= _containerPoint + this._container[this._mousePoint];
			
			if(this._dragEffect)
			{
				TweenLite.killTweensOf(this);
				
				checkTimeFun();
				
				this._dragEffectTimer.addEventListener(TimerEvent.TIMER, checkTimeFun);
				this._dragEffectTimer.reset();
				this._dragEffectTimer.start();
			}
			
			
			
			this._container.stage.addEventListener(MouseEvent.MOUSE_MOVE, onCotainerMouseMove);
			this._container.stage.addEventListener(MouseEvent.MOUSE_UP, onCotainerMouseUp);
		}
		
		private function onCotainerMouseMove(e:MouseEvent):void
		{
			this.containerPoint	= (this._dragMPoint - this._container[this._mousePoint]);
		}
		
		private function onCotainerMouseUp(e:MouseEvent):void
		{
			this._container.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onCotainerMouseMove);
			this._container.stage.removeEventListener(MouseEvent.MOUSE_UP, onCotainerMouseUp);
			
			if(_dragEffect)
			{
				var t:Number	= (getTimer() - this._checkTime) / 1000;
				var p:Number	= (this._containerPoint - this._checkPoint);
				var s:Number 	= p / t;
				
				var np:Number	= Math.max(Math.min((s * this._dragEffectMaxTime), this._dragEffectMaxDistance), -this._dragEffectMaxDistance);
				var ad:Number	= this._containerPoint + np/4;
				
				TweenLite.to(this, this._dragEffectTime, {containerPoint:ad});
				
				this._dragEffectTimer.removeEventListener(TimerEvent.TIMER, checkTimeFun);
				this._dragEffectTimer.stop();
			}
		}
		
		private function checkTimeFun(e:TimerEvent=null):void
		{
			this._checkPoint	= this.containerPoint;
			this._checkTime		= getTimer();
		}
		
		/**
		 * 设置当前显示子项移动到什么位置
		 * @param value
		 * 
		 */		
		public function setCurrentItemMoveTo(value:int):void
		{
			TweenLite.to(this, this._dragEffectTime, {containerPoint:value * (this.iSize + _space)});
		}
		
		/**
		 * 设置当前显示子项起始位置
		 * @param	value
		 */
		public function setCurrentItem(value:int,refresh:Boolean=true):void
		{
			TweenLite.killTweensOf(this);
			_containerPoint	= value * (this.iSize + _space);
			if(refresh)
			{
				refreshListData();
			}
		}
		
		
		
		
		/**
		 * 设置选中item项
		 * @param	value
		 */
		public function setSelectItem(value:int):void
		{
			_itemSelectedItemId	= value;
			refreshListData();
		}
		
		/**
		 * 刷新显示对象中的元素
		 */
		private function refreshListDisplayItems():void
		{
			var i:int
			var max:int	= maxDisplayNum();
			var item:IListItem;
			
			for (i = 0; i < max; i++)
			{
				item		= getNewItem();
				item.itemId	= i;
				_list.push(item);
			}
		}
		
		/**
		 * 刷新显示对象中的数据
		 */
		protected function refreshListData(isAll:Boolean=false):void
		{
			var i:int
			var j:int;
			var max:int			= _list.length;
			var point:int;
			var selected:Boolean;
			var itemSize:int	= getItemSize();
			var item:IListItem;
			
			var isNeed:Boolean;
			var ss:Array		= [];
			var needList:Array	= [];
			var outList:Array	= [];
			//item.data	= _data[item.itemId];
			if (isAll)
			{
				for (i = 0; i < max; i++)
				{
					item				= _list[i];
					item.itemId			= int((_containerPoint + (i * itemSize)) / itemSize);
					item.data			= _data[(item.itemId-1)];
					selected			= Boolean(item.itemId == this._itemSelectedItemId);
					if(item.selected != selected)
					{
						item.selected		= selected;
					}
					item[this._point]	= (item.itemId * itemSize)-_containerPoint-itemSize;
				}
			}else
			{
				//查询列表中需求itemId
				for (i = 0; i < max; i++)
				{
					needList.push(Math.ceil((_containerPoint + (i* itemSize)) / itemSize));
				}
				
				//找到显示区域外的子项
				for (i = 0; i < max; i++)
				{
					item		= _list[i];
					isNeed		= false;
					for (j = 0; j < needList.length; j++)
					{
						if (item.itemId == needList[j])
						{
							isNeed	= true;
							needList.splice(j, 1);
							break;
						}
					}
					if (!isNeed)
					{
						outList.push(item);
					}else
					{
						item[this._point]	= (item.itemId * itemSize) - _containerPoint-itemSize;
					}
				}
				//列表外的子项修正到显示区域内
				max	= outList.length;
				for (i = 0; i < max; i++)
				{
					item				= outList[i];
					item.itemId			= needList[i];
					item.data			= _data[(item.itemId-1)];
					selected			= Boolean(item.itemId == this._itemSelectedItemId);
					if(item.selected != selected)
					{
						item.selected		= selected;
					}
					item[this._point]	= (item.itemId * itemSize) - _containerPoint-itemSize;
				}
			}
			
			//广播更新位置事件
		}
		
		/**
		 * 获取子项的尺寸
		 * @return
		 */
		protected function getItemSize():int
		{
			return this.iSize + _space;
		}
		
		/**
		 * 获取最大的显示数量
		 * @return
		 */
		protected function maxDisplayNum():int
		{
			return Math.ceil(this.lSize / getItemSize()) + 1;
		}
		
		/**
		 * 绘制遮罩
		 */
		protected function drawMask():void
		{
			_mask.graphics.clear();
			_mask.graphics.beginFill(0, 1);
			_mask.graphics.drawRect(_drawMaskX, _drawMaskY, _drawMaskWidth, _drawMaskHeight);
			_mask.graphics.endFill();
		}
		
		/**
		 * 获取新的子项
		 * @return
		 */
		protected function getNewItem():IListItem
		{
			var item:IListItem;
			if (_listTrash.length > 0)
			{
				item	= _listTrash.shift() as IListItem;
			}else
			{
				item	= _container.addChild(new _itemClass(this)) as IListItem;
			}
			return item;
		}
		
		/**
		 * 获取子项
		 * @return
		 */
		protected function getItemInstance():IListItem
		{
			return _itemInstance;
		}
		
		/**
		 * 设置方向
		 * @param value
		 * 
		 */		
		protected function set direction(value:String):void
		{
			if(_direction!=value)
			{
				_direction	= value;
				
				if(_direction == HORIZONTAL)
				{
					this._point			= 'x';
					this._mousePoint	= 'mouseX';
					this._size			= 'width';
				}else if(_direction == VERTICAL)
				{
					this._point			= 'y';
					this._mousePoint	= 'mouseY';
					this._size			= 'height';
				}
			}
		}
		
		protected function get direction():String
		{
			return _direction;
		}
		
		/**
		 * 设置容器位置，并更新相应数据
		 * @param value
		 * 
		 */		
		public function set containerPoint(value:int):void
		{
			this._containerPoint	= value;
			refreshListData();
		}
			
		public function get containerPoint():int
		{
			return this._containerPoint;
		}
		
		/**
		 * 当前容器的实际位置
		 * @param value
		 * 
		 */		
		protected function set cPoint(value:Number):void
		{
			this._container[this._point]	= value;
		}
		
		protected function get cPoint():Number
		{
			return this._container[this._point];
		}
		
		/**
		 * 列表尺寸
		 * @return 
		 * 
		 */		
		protected function get lSize():Number
		{
			return this["_" + this._size];
		}
		
		/**
		 * 子项尺寸
		 * @return 
		 * 
		 */		
		protected function get iSize():Number
		{
			return getItemInstance()[this._size];
		}
		
		public function getItemById(id:int):IListItem
		{
			var max:int			= _list.length;
			var i:int;
			var item:IListItem;
				for (i = 0; i < max; i++)
				{
					
					item				= _list[i];
					if(item.itemId == id)
					{
						return item;
					}
				}
				
			return null;
		}
	}
}
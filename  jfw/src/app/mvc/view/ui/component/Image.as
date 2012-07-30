package app.mvc.view.ui.component
{
	import com.jfw.engine.utils.ImageUtil;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	public class Image extends Sprite
	{
		private var _container:Sprite;
		private var _mask:Shape;
		private var _loader:Loader;
		private var _round:int	= 0;
		private var _width:int	= 0;
		private var _height:int	= 0;
		private var _cache:Boolean;
		
		private var _bmp:Bitmap;
		
		private var _temp:String		= "";
		private var _errorUrl:String	= "";
		private var _url:String="";
		private var _showAll:Boolean	= true;
		
		public function Image( defaultWidth:int=0, defaultHeight:int=0, cache:Boolean=false ) 
		{
			_container		= new Sprite();
			_loader			= new Loader();
			_bmp			= new Bitmap();
			_mask			= new Shape();
			
			_width			= defaultWidth;
			_height			= defaultHeight;
			_cache			= cache;
			
			_container.mask	= _mask;
			
			configureListeners(_loader.contentLoaderInfo);
			
			_bmp.visible	= _cache;
			_bmp.smoothing = true;
			_loader.visible	= !_cache;
			
			_container.addChild(_bmp);
			_container.addChild(_loader);
			addChild(_container);
			addChild(_mask);
			
			drawMask();
		}
		
		
		private function configureListeners(dispatcher:IEventDispatcher):void
		{
			dispatcher.addEventListener(Event.COMPLETE, loaderCompleteHandler);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, loaderIoErrorHandler);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, loaderProgressHandler);
		}
		
		private function loaderCompleteHandler(e:Event):void
		{
			if (_cache)
			{
				//_bmp.visible	= false;
				_bmp.bitmapData	= new BitmapData(_loader.width, _loader.height, true, 0);
				_bmp.bitmapData.draw(_loader);
				
				if(_width != 0 && _height != 0)
				{
					_bmp.width = _width;
					_bmp.height = _height;
				}
				_bmp.smoothing = true;
				//_bmp.visible	= true;
				//_bmp.smoothing = true;
				_loader.unload();
			}else
			{
				if(_width != 0 && _height != 0)
				{
					resize();
				}
			}
		}
		
		private function resize():void
		{
			var rect:Rectangle;
			
			if(_showAll)
			{
				rect	= ImageUtil.getMaxSize(_loader.width, _loader.height, _width, _height);
			}else
			{
				rect	= ImageUtil.getMinSize(_loader.width, _loader.height, _width, _height);
			}
			
			_loader.width 	= rect.width;
			_loader.height 	= rect.height;
			_loader.x 		= rect.x;
			_loader.y 		= rect.y;
		}
		
		private function loaderIoErrorHandler(e:IOErrorEvent):void
		{
			if (_errorUrl.length > 0)
			{
				load(_errorUrl);
			}
		}
		
		private function loaderProgressHandler(e:ProgressEvent):void
		{
			
		}
		
		/**
		 * 载入图片
		 * @param url
		 * @param errorUrl
		 * 
		 */		
		public function load(url:String, errorUrl:String=''):void
		{
			_errorUrl	= errorUrl;
			_url=url;
			
			if (url.length > 0)
			{
				//if (_temp != url)
				//{
					//_temp	= url;
					clearCache();
					try
					{
						_loader.load(new URLRequest(url));
					}catch (e:Error) { };
				//}
			}else
			{
				clearCache();
				try
				{
					_loader.unload();
				}catch (e:Error) { };
			}
		}
		
		private function clearCache():void
		{
			if (_cache)
			{
				if (_bmp.bitmapData)
				{
					_bmp.bitmapData.dispose();
				}
			}
		}
		
		/**
		 * 图片是否全部显示在区域内
		 * @param value
		 * 
		 */		
		public function set showAll(value:Boolean):void
		{
			this._showAll	= value;
			this.resize();
		}
		
		/**
		 * 图片是否全部显示在区域内
		 * @return 
		 * 
		 */		
		public function get showAll():Boolean
		{
			return this._showAll;
		}
		
		override public function get width():Number { return _width; }
		
		override public function set width(value:Number):void 
		{
			_width		= value;
			drawMask();
		}
		
		override public function get height():Number { return _height; }
		
		override public function set height(value:Number):void 
		{
			_height	= value;
			drawMask();
		}
		
		public function get Url():String{return _url;}
			
		public function get round():Number { return _round; }
		
		public function set round(value:Number):void
		{
			_round	= value;
		}
		
		private function drawMask():void
		{
			_mask.graphics.clear();
			_mask.graphics.beginFill(0x000000, 1);
			_mask.graphics.drawRoundRect(0, 0, _width, _height, _round, _round);
			_mask.graphics.endFill();
		}
	}
}
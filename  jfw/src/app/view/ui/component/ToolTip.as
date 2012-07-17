package app.view.ui.component
{
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.*;
	
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.geom.*;
	import flash.text.*;
	import flash.utils.Timer;

	
	/**
	 * 		Tooltip类
	 * 
	 *		tipWidth 				Number				tooltip宽度
	 *		titleFormat				TextFormat			标题格式
	 * 		stylesheet				StyleSheet			样式表
	 *		contentFormat			TextFormat			内容样式
	 *		titleEmbed				Boolean				标题嵌入字体
	 *		contentEmbed			Boolean				内容嵌入字体
	 *		align					String				对齐方式：left, right, center
	 *		delay					Number				显示延时（毫秒数）
	 *		hook					Boolean				指示箭头
	 *		hookSize				Number				指示箭头尺寸
	 *		cornerRadius			Number				圆角半径
	 *		colors					Array				背景颜色( [0xXXXXXX, 0xXXXXXX] ); 
	 *		autoSize				Boolean				自适应内容
	 * 		border					Number				边框： 0xFFFFFF
	 *		borderSize				Number				边框尺寸
	 *		buffer					Number				内间距padding
	 * 		bgAlpha					Number				背景透明度
	 *
	 * 例:
	 
	 		var tf:TextFormat = new TextFormat();
			tf.bold = true;
			tf.size = 12;
			tf.color = 0xff0000;
			
			var tt:ToolTip = new ToolTip();
			tt.hook = true;
			tt.hookSize = 20;
			tt.cornerRadius = 20;
			tt.align = "center";
			tt.titleFormat = tf;
			tt.show( DisplayObject, "标题", "内容" );
	 */
	 
	public class ToolTip extends Sprite 
	{
		private var _stage:Stage;
		private var _parentObject:DisplayObject;
		private var _tf:TextField; 
		private var _cf:TextField; 
		private var _contentContainer:Sprite = new Sprite(); 
		private var _tween:Tween;
		
		//格式
		private var _titleFormat:TextFormat;
		private var _contentFormat:TextFormat;
		
		//样式表
		private var _stylesheet:StyleSheet;
		
		private var _styleOverride:Boolean = false;
		
		private var _titleOverride:Boolean = false;
		private var _contentOverride:Boolean = false;
		
		//嵌入字体
		private var _titleEmbed:Boolean = false;
		private var _contentEmbed:Boolean = false;
		
		//初始值
		private var _defaultWidth:Number = 200;
		private var _defaultHeight:Number;
		private var _buffer:Number = 10;
		private var _followMouse:Boolean = true;
		private var _align:String = "center";
		private var _tipPosition:String = "top";
		private var _cornerRadius:Number = 12;
		private var _bgColors:Array = [0xFFFFFF, 0x9C9C9C];
		private var _autoSize:Boolean = false;
		private var _hookEnabled:Boolean = false;
		private var _hookPosition:String = "bottom";
		private var _delay:Number = 0;  //毫秒
		private var _hookSize:Number = 10;
		private var _border:Number;
		private var _borderSize:Number = 1;
		private var _hitSizeWidth:Number = 20;
		private var _hitSizeHeight:Number = 20;
		private var _hideOnMouseOut:Boolean = true;
		private var _bgAlpha:Number = 1; 
		
		//箭头偏移量
		private var _offSet:Number;
		private var _yOffset:Number;
		private var _hookOffSet:Number;
		
		//延时
		private var _timer:Timer;
		
		//尺寸
		private var _myHeight:Number;
		private var _myWidth:Number;
	
		public function ToolTip():void 
		{
			this.mouseEnabled = false;
			this.buttonMode = false;
			this.mouseChildren = false;
			_timer = new Timer(this._delay, 1);
            _timer.addEventListener("timer", timerHandler);
		}
		
		public function setContent( title:String, content:String = null ):void 
		{
			this.graphics.clear();
			this.addCopy( title, content );
			this.setOffset();
			this.drawBG();
		}
		
		public function show( p:DisplayObject, title:String, content:String=null ):void 
		{
			this._stage = p.stage;
			this._parentObject = p;
			var onStage:Boolean = this.addedToStage( this._contentContainer );
			if( ! onStage ){
				this.addChild( this._contentContainer );
			}
			this.addCopy( title, content );
			this.setOffset();
			
			var parentCoords:Point;
			if (_followMouse) {
				//动态
				parentCoords = new Point( _parentObject.mouseX, _parentObject.mouseY );
				var globalPoint:Point = p.localToGlobal(parentCoords);
				this.x = globalPoint.x + this._offSet;
				this.y = globalPoint.y - this.height - 10;
				alignTip(_parentObject, this._tipPosition);
			} else {
				//静态
				parentCoords = new Point( _parentObject.x + (_parentObject.width/2), _parentObject.y );
				alignTip(_parentObject, this._tipPosition);
			}
			this.drawBG();
			this.bgGlow();
			
			this.alpha = 0;
			this._stage.addChild( this );
			if (_hideOnMouseOut) {
				this._parentObject.addEventListener( MouseEvent.MOUSE_OUT, this.onMouseOut );
			}
			//this._parentObject.addEventListener( MouseEvent.MOUSE_MOVE, this.onMouseMovement );
			
			if (_followMouse) {
				this.follow( true );
			} 
            _timer.start();
		}
		
		private function positionTip(parentObj:DisplayObject, positionToParent:String = "top", pointOverride:Point = null, speedOverride:Number = 1):void
		{
			var parentPoint:Point = pointOverride;
			if (pointOverride == null) parentPoint = new Point( parentObj.x, parentObj.y );
			var preDrawAdd:Number = 0;
			if (this._followMouse == false) {
				preDrawAdd = (this._buffer * 2);
			}
			this._myHeight = (this.height + preDrawAdd);
			this._myWidth = (this.width + preDrawAdd);
			this._tipPosition = positionToParent;
			if (positionToParent == "right") {
				//RIGHT
				this._hookPosition = "left";
				setOffset();
				this._myWidth += this._hookSize;
				this.x = (parentPoint.x + _hitSizeWidth + this._hookSize);
				this.y = (parentPoint.y + (_hitSizeHeight/2) + this._offSet);
			} else if (positionToParent == "left") {
				//LEFT
				this._hookPosition = "right";
				setOffset();
				this._myWidth += this._hookSize;
				this.x = (parentPoint.x - this._myWidth);
				this.y = (parentPoint.y + (_hitSizeHeight/2) + this._offSet);
			} else if (positionToParent == "bottom") {
				//BOTTOM
				this._hookPosition = "top";
				setOffset();
				this._myHeight += this._hookSize;
				this.x = (parentPoint.x + (_hitSizeWidth/2) + this._offSet);
				this.y = (parentPoint.y + _hitSizeHeight + this._hookSize);
			} else if (positionToParent == "bottom_right") {
				//BOTTOM RIGHT
				this._hookPosition = "top_left";
				setOffset();
				this._myHeight += this._hookSize;
				this._myWidth += this._hookSize;
				this.x = (parentPoint.x + _hitSizeWidth + this._hookSize);
				this.y = (parentPoint.y + _hitSizeHeight + this._hookSize);
			} else if (positionToParent == "bottom_left") {
				//BOTTOM LEFT
				this._hookPosition = "top_right";
				setOffset();
				this._myHeight += this._hookSize;
				this._myWidth += this._hookSize;
				this.x = (parentPoint.x - this._myWidth);
				this.y = (parentPoint.y + _hitSizeHeight + this._hookSize);
			} else if (positionToParent == "top_right") {
				//TOP RIGHT
				this._hookPosition = "bottom_left";
				setOffset();
				this._myHeight += this._hookSize;
				this._myWidth += this._hookSize;
				this.x = (parentPoint.x + _hitSizeWidth + this._hookSize);
				this.y = (parentPoint.y - this._myHeight);
			} else if (positionToParent == "top_left") {
				//TOP LEFT
				this._hookPosition = "bottom_right";
				setOffset();
				this._myHeight += this._hookSize;
				this._myWidth += this._hookSize;
				this.x = (parentPoint.x - this._myWidth);
				this.y = (parentPoint.y - this._myHeight);
			} else {
				//TOP
				this._hookPosition = "bottom";
				setOffset();
				this._myHeight += this._hookSize;
				this.x = (parentPoint.x + (_hitSizeWidth/2) + this._offSet);
				this.y = (parentPoint.y - this._myHeight);
			}			
		}
		public function alignTip(parentObj:DisplayObject, positionToParent:String = "top", pointOverride:Point = null, speedOverride:Number = 1, tries:Number = 0):void
		{
			if (tries <= 4) {
				tries++;
				if (pointOverride == null) pointOverride = new Point( parentObj.x, parentObj.y );
				positionTip(parentObj, positionToParent, pointOverride, speedOverride);
	
				if( this._stage.stageWidth < (this._myWidth + this.x) ){
					if( this._stage.stageHeight < (this._myHeight + this.y) ){
						alignTip(parentObj,"top_left", pointOverride, speedOverride, tries);
					} else if( (this.y) < 0 ){
						alignTip(parentObj,"bottom_left", pointOverride, speedOverride, tries);
					} else {
						if ((this._tipPosition == "top") || (this._tipPosition == "top_right")) {
							alignTip(parentObj,"top_left", pointOverride, speedOverride, tries);
						} else if ((this._tipPosition == "bottom") || (this._tipPosition == "bottom_right")) {
							alignTip(parentObj,"bottom_left", pointOverride, speedOverride, tries);
						} else {
							alignTip(parentObj,"left", pointOverride, speedOverride, tries);
						}
					}
				} else if( this.x < 0 ) {
					if( this._stage.stageHeight < (this._myHeight + this.y) ){
						alignTip(parentObj,"top_right", pointOverride, speedOverride, tries);
					} else if( ((this.y) < 0) ){
						alignTip(parentObj,"bottom_right", pointOverride, speedOverride, tries);
					} else {
						if ((this._tipPosition == "top") || (this._tipPosition == "top_left")) {
							alignTip(parentObj,"top_right", pointOverride, speedOverride, tries);
						} else if ((this._tipPosition == "bottom") || (this._tipPosition == "bottom_left")) {
							alignTip(parentObj,"bottom_right", pointOverride, speedOverride, tries);
						} else {
							alignTip(parentObj,"right", pointOverride, speedOverride, tries);
						}
					}
				} else if( this._stage.stageHeight < (this._myHeight + this.y) ){
					if ((this._tipPosition == "right") || (this._tipPosition == "bottom_right")) {
						alignTip(parentObj,"top_right", pointOverride, speedOverride, tries);
					} else if ((this._tipPosition == "left") || (this._tipPosition == "bottom_left")) {
						alignTip(parentObj,"top_left", pointOverride, speedOverride, tries);
					} else {
						alignTip(parentObj,"top", pointOverride, speedOverride, tries);
					}
				} else if( (this.y) < 0 ){
					if ((this._tipPosition == "right") || (this._tipPosition == "top_right")) {
						alignTip(parentObj,"bottom_right", pointOverride, speedOverride, tries);
					} else if ((this._tipPosition == "left") || (this._tipPosition == "top_left")) {
						alignTip(parentObj,"bottom_left", pointOverride, speedOverride, tries);
					} else {
						alignTip(parentObj,"bottom", pointOverride, speedOverride, tries);
					}
				}
			}
		}
		
		public function hide():void {
			this.animate( false );
		}
		
		private function timerHandler( event:TimerEvent ):void {
			this.animate(true);
		}

		private function onMouseOut( event:MouseEvent ):void {
			event.currentTarget.removeEventListener(event.type, arguments.callee);
			this.hide();
		}
		
		private function follow( value:Boolean ):void {
			if( value ){
				addEventListener( Event.ENTER_FRAME, this.eof );
			}else{
				removeEventListener( Event.ENTER_FRAME, this.eof );
			}
		}
		
		private function eof( event:Event ):void {
			this.position();
		}
		
		private function position():void {
			var speed:Number = 3;
			var parentCoords:Point = new Point( _parentObject.mouseX, _parentObject.mouseY );
			var globalPoint:Point = _parentObject.localToGlobal(parentCoords);
			alignTip(_parentObject, this._tipPosition, globalPoint, speed);
			
/*			var xp:Number = globalPoint.x + this._offSet;
			var yp:Number = globalPoint.y - this.height - 10;
			
			var overhangRight:Number = this._defaultWidth + xp;
			if( overhangRight > stage.stageWidth ){
				xp =  stage.stageWidth -  this._defaultWidth;
			}
			if( xp < 0 ) {
				xp = 0;
			}
			if( (yp) < 0 ){
				yp = 0;
			}
			this.x += ( xp - this.x ) / speed;
			this.y += ( yp - this.y ) / speed;
*/
		}

		private function addCopy( title:String, content:String = null ):void {
			if( this._tf == null ){
				this._tf = this.createField( this._titleEmbed ); 
			}
			// 标题使用样式表
			if( this._styleOverride ){
				this._tf.styleSheet = this._stylesheet;
			}
			this._tf.htmlText = title;
			
			// 不使用样式表
			if( ! this._styleOverride ){
				// 设置默认格式
				if( ! this._titleOverride ){
					this.initTitleFormat();
				}
				this._tf.setTextFormat( this._titleFormat );
			}
			if( this._autoSize ){
				this._defaultWidth = this._tf.textWidth + 4 + ( _buffer * 2 );
			}else{
				this._tf.width = this._defaultWidth - ( _buffer * 2 );
			}
			
			
				
			this._tf.x = this._tf.y = this._buffer;
			this.textGlow( this._tf );
			this._contentContainer.addChild( this._tf );
			
			//如果内容不为空
			if( content != null ){
				
				if( this._cf == null ){
					this._cf = this.createField( this._contentEmbed );
				}
				
				// 内容使用样式表
				if( this._styleOverride ){
					this._cf.styleSheet = this._stylesheet;
				}
			
				this._cf.htmlText = content;
				
				if( ! this._styleOverride ){
					if( ! this._contentOverride ){
						this.initContentFormat();
					}
					this._cf.setTextFormat( this._contentFormat );
				}
			
				var bounds:Rectangle = this.getBounds( this );
				this._cf.x = this._buffer;
				this._cf.y = this._tf.y +  this._tf.textHeight;
				this.textGlow( this._cf );
				
				if( this._autoSize ){
					var cfWidth:Number = this._cf.textWidth + 4 + ( _buffer * 2 )
					this._defaultWidth = cfWidth > this._defaultWidth ? cfWidth : this._defaultWidth;
				}else{
					this._cf.width = this._defaultWidth - ( _buffer * 2 );
				}
				this._contentContainer.addChild( this._cf );	
			}
		}
		
		private function createField( embed:Boolean ):TextField {
			var tf:TextField = new TextField();
			tf.embedFonts = embed;
			tf.gridFitType = "pixel";
			//tf.border = true;
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.selectable = false;
			if( ! this._autoSize ){
				tf.multiline = true;
				tf.wordWrap = true;
			}
			return tf;
		}
		
		private function drawBG():void {
			this.graphics.clear();
			var bounds:Rectangle = this.getBounds( this );

			var h:Number = isNaN( this._defaultHeight ) ? bounds.height + ( this._buffer * 2 ) : this._defaultHeight;
			var fillType:String = GradientType.LINEAR;
		   	//var colors:Array = [0xFFFFFF, 0x9C9C9C];
		   	var alphas:Array = [ this._bgAlpha, this._bgAlpha];
		   	var ratios:Array = [0x00, 0xFF];
		   	var matr:Matrix = new Matrix();
			var radians:Number = 90 * Math.PI / 180;
		  	matr.createGradientBox(this._defaultWidth, h, radians, 0, 0);
		  	var spreadMethod:String = SpreadMethod.PAD;
			if( ! isNaN( this._border )){
				this.graphics.lineStyle( _borderSize, _border, 1 );
			}
		  	this.graphics.beginGradientFill(fillType, this._bgColors, alphas, ratios, matr, spreadMethod); 
			if( this._hookEnabled ){
				var xp:Number = 0; var yp:Number = 0; var w:Number = this._defaultWidth; 
				if (_hookPosition == "left") {
					this.graphics.moveTo ( xp + this._cornerRadius, yp );
					this.graphics.lineTo ( xp + w - this._cornerRadius, yp );
					this.graphics.curveTo ( xp + w, yp, xp + w, yp + this._cornerRadius );
					this.graphics.lineTo ( xp + w, yp + h - this._cornerRadius );
					this.graphics.curveTo ( xp + w, yp + h, xp + w - this._cornerRadius, yp + h );
					this.graphics.lineTo ( xp + this._cornerRadius, yp + h );
					this.graphics.curveTo ( xp, yp + h, xp, yp + h - this._cornerRadius );
					
					//箭头
					this.graphics.lineTo ( xp, yp + this._hookOffSet + this._hookSize );
					this.graphics.lineTo ( xp - this._hookSize, yp + this._hookOffSet );
					this.graphics.lineTo ( xp, yp + this._hookOffSet - this._hookSize );
					this.graphics.lineTo ( xp, yp + this._cornerRadius );
					
					//this.graphics.lineTo ( xp, yp + this._cornerRadius );
					this.graphics.curveTo ( xp, yp, xp + this._cornerRadius, yp );
					this.graphics.endFill();
				} else if (_hookPosition == "right") {
					this.graphics.moveTo ( xp + this._cornerRadius, yp );
					this.graphics.lineTo ( xp + w - this._cornerRadius, yp );
					this.graphics.curveTo ( xp + w, yp, xp + w, yp + this._cornerRadius );
					
					this.graphics.lineTo ( xp + w, yp + this._hookOffSet - this._hookSize );
					this.graphics.lineTo ( xp + w + this._hookSize, yp + this._hookOffSet );
					this.graphics.lineTo ( xp + w, yp + this._hookOffSet + this._hookSize );
					this.graphics.lineTo ( xp + w, yp + h - this._cornerRadius );
					
					//this.graphics.lineTo ( xp + w, yp + h - this._cornerRadius );
					this.graphics.curveTo ( xp + w, yp + h, xp + w - this._cornerRadius, yp + h );
					this.graphics.lineTo ( xp + this._cornerRadius, yp + h );
					this.graphics.curveTo ( xp, yp + h, xp, yp + h - this._cornerRadius );
					this.graphics.lineTo ( xp, yp + this._cornerRadius );
					this.graphics.curveTo ( xp, yp, xp + this._cornerRadius, yp );
					this.graphics.endFill();
				} else if (_hookPosition == "top") {
					this.graphics.moveTo ( xp + this._cornerRadius, yp );
					
					this.graphics.lineTo ( xp + this._hookOffSet - this._hookSize, yp );
					this.graphics.lineTo ( xp + this._hookOffSet , yp - this._hookSize );
					this.graphics.lineTo ( xp + this._hookOffSet + this._hookSize, yp );
					this.graphics.lineTo ( xp + w - this._cornerRadius, yp );
					
					//this.graphics.lineTo ( xp + w - this._cornerRadius, yp );
					this.graphics.curveTo ( xp + w, yp, xp + w, yp + this._cornerRadius );
					this.graphics.lineTo ( xp + w, yp + h - this._cornerRadius );
					this.graphics.curveTo ( xp + w, yp + h, xp + w - this._cornerRadius, yp + h );
					this.graphics.lineTo ( xp + this._cornerRadius, yp + h );
					this.graphics.curveTo ( xp, yp + h, xp, yp + h - this._cornerRadius );
					this.graphics.lineTo ( xp, yp + this._cornerRadius );
					this.graphics.curveTo ( xp, yp, xp + this._cornerRadius, yp );
					this.graphics.endFill();
				} else if (_hookPosition == "top_left") {
					this.graphics.moveTo ( xp + this._cornerRadius, yp );
					this.graphics.lineTo ( xp + w - this._cornerRadius, yp );
					this.graphics.curveTo ( xp + w, yp, xp + w, yp + this._cornerRadius );
					this.graphics.lineTo ( xp + w, yp + h - this._cornerRadius );
					this.graphics.curveTo ( xp + w, yp + h, xp + w - this._cornerRadius, yp + h );
					this.graphics.lineTo ( xp + this._cornerRadius, yp + h );
					this.graphics.curveTo ( xp, yp + h, xp, yp + h - this._cornerRadius );
					this.graphics.lineTo ( xp, yp + this._cornerRadius );
					//this.graphics.curveTo ( xp, yp, xp + this._cornerRadius, yp );

					this.graphics.curveTo ( xp, yp, xp - this._hookSize, yp - this._hookSize );
					this.graphics.curveTo ( xp, yp, xp + this._cornerRadius, yp );

					this.graphics.endFill();
				} else if (_hookPosition == "top_right") {
					this.graphics.moveTo ( xp + this._cornerRadius, yp );
					this.graphics.lineTo ( xp + w - this._cornerRadius, yp );

					this.graphics.curveTo ( xp + w, yp, xp + w + this._hookSize, yp - this._hookSize );
					this.graphics.curveTo ( xp + w, yp, xp + w, yp + this._cornerRadius );

					//this.graphics.curveTo ( xp + w, yp, xp + w, yp + this._cornerRadius );
					this.graphics.lineTo ( xp + w, yp + h - this._cornerRadius );
					this.graphics.curveTo ( xp + w, yp + h, xp + w - this._cornerRadius, yp + h );
					this.graphics.lineTo ( xp + this._cornerRadius, yp + h );
					this.graphics.curveTo ( xp, yp + h, xp, yp + h - this._cornerRadius );
					this.graphics.lineTo ( xp, yp + this._cornerRadius );
					this.graphics.curveTo ( xp, yp, xp + this._cornerRadius, yp );

					this.graphics.endFill();
				} else if (_hookPosition == "bottom_right") {
					this.graphics.moveTo ( xp + this._cornerRadius, yp );
					this.graphics.lineTo ( xp + w - this._cornerRadius, yp );
					this.graphics.curveTo ( xp + w, yp, xp + w, yp + this._cornerRadius );
					this.graphics.lineTo ( xp + w, yp + h - this._cornerRadius );

					this.graphics.curveTo ( xp + w, yp + h, xp + w + this._hookSize, yp + h + this._hookSize );
					this.graphics.curveTo ( xp + w, yp + h, xp + w - this._cornerRadius, yp + h );

					//this.graphics.curveTo ( xp + w, yp + h, xp + w - this._cornerRadius, yp + h );
					this.graphics.lineTo ( xp + this._cornerRadius, yp + h );
					this.graphics.curveTo ( xp, yp + h, xp, yp + h - this._cornerRadius );
					this.graphics.lineTo ( xp, yp + this._cornerRadius );
					this.graphics.curveTo ( xp, yp, xp + this._cornerRadius, yp );

					this.graphics.endFill();
				} else if (_hookPosition == "bottom_left") {
					this.graphics.moveTo ( xp + this._cornerRadius, yp );
					this.graphics.lineTo ( xp + w - this._cornerRadius, yp );
					this.graphics.curveTo ( xp + w, yp, xp + w, yp + this._cornerRadius );
					this.graphics.lineTo ( xp + w, yp + h - this._cornerRadius );
					this.graphics.curveTo ( xp + w, yp + h, xp + w - this._cornerRadius, yp + h );
					this.graphics.lineTo ( xp + this._cornerRadius, yp + h );

					this.graphics.curveTo ( xp, yp + h, xp - this._hookSize, yp + h + this._hookSize );
					this.graphics.curveTo ( xp, yp + h, xp, yp + h - this._cornerRadius );

					//this.graphics.curveTo ( xp, yp + h, xp, yp + h - this._cornerRadius );
					this.graphics.lineTo ( xp, yp + this._cornerRadius );
					this.graphics.curveTo ( xp, yp, xp + this._cornerRadius, yp );

					this.graphics.endFill();
				} else {
					this.graphics.moveTo ( xp + this._cornerRadius, yp );
					this.graphics.lineTo ( xp + w - this._cornerRadius, yp );
					this.graphics.curveTo ( xp + w, yp, xp + w, yp + this._cornerRadius );
					this.graphics.lineTo ( xp + w, yp + h - this._cornerRadius );
					this.graphics.curveTo ( xp + w, yp + h, xp + w - this._cornerRadius, yp + h );
					
					this.graphics.lineTo ( xp + this._hookOffSet + this._hookSize, yp + h );
					this.graphics.lineTo ( xp + this._hookOffSet , yp + h + this._hookSize );
					this.graphics.lineTo ( xp + this._hookOffSet - this._hookSize, yp + h );
					this.graphics.lineTo ( xp + this._cornerRadius, yp + h );
					
					this.graphics.curveTo ( xp, yp + h, xp, yp + h - this._cornerRadius );
					this.graphics.lineTo ( xp, yp + this._cornerRadius );
					this.graphics.curveTo ( xp, yp, xp + this._cornerRadius, yp );
					this.graphics.endFill();
				}
			}else{
				this.graphics.drawRoundRect( 0, 0, this._defaultWidth, h, this._cornerRadius );
			}
		}

		
		
		
		
		private function animate( show:Boolean ):void {
			var end:int = show == true ? 1 : 0;
			if( _tween != null && _tween.isPlaying ) {
				_tween.stop();
			}
		    _tween = new Tween( this, "alpha", Strong.easeOut, this.alpha, end, .5, true );
			if( ! show ){
				_tween.addEventListener( TweenEvent.MOTION_FINISH, onComplete );
				_timer.reset();
			}
		}
		
		private function onComplete( event:TweenEvent ):void {
			event.currentTarget.removeEventListener(event.type, arguments.callee);
			this.cleanUp();
		}
	
		/** Getters / Setters */
		
		public function set followMouse( value:Boolean ):void {
			this._followMouse = value;
		}
		
		public function get followMouse():Boolean {
			return this._followMouse;
		}
		
		public function set buffer( value:Number ):void {
			this._buffer = value;
		}
		
		public function get buffer():Number {
			return this._buffer;
		}
		
		public function set bgAlpha( value:Number ):void {
			this._bgAlpha = value;
		}
		
		public function get bgAlpha():Number {
			return this._bgAlpha;
		}

		public function set hitSizeWidth( value:Number ):void {
			this._hitSizeWidth = value;
		}
		
		public function get hitSizeWidth():Number {
			return this._hitSizeWidth;
		}
		
		public function set hitSizeHeight( value:Number ):void {
			this._hitSizeHeight = value;
		}
		
		public function get hitSizeHeight():Number {
			return this._hitSizeHeight;
		}
		
		public function set tipPosition( value:String ):void {
			this._tipPosition = value;
		}
		
		public function get tipPosition():String {
			return this._tipPosition;
		}
		
		public function set tipWidth( value:Number ):void {
			this._defaultWidth = value;
		}
		
		public function set titleFormat( tf:TextFormat ):void {
			this._titleFormat = tf;
			if( this._titleFormat.font == null ){
				this._titleFormat.font = "_sans";
			}
			this._titleOverride = true;
		}
		
		public function set contentFormat( tf:TextFormat ):void {
			this._contentFormat = tf;
			if( this._contentFormat.font == null ){
				this._contentFormat.font = "_sans";
			}
			this._contentOverride = true;
		}
		
		public function set stylesheet( ts:StyleSheet ):void {
			this._stylesheet = ts;
			this._styleOverride = true;
		}
		
		public function set align( value:String ):void {
			var a:String = value.toLowerCase();
			var values:String = "right left center";
			if( values.indexOf( value ) == -1 ){
				throw new Error( this + " : Invalid Align Property, options are: 'right', 'left' & 'center'" );
			}else{
				this._align = a;
			}
		}
		
		public function set delay( value:Number ):void {
			this._delay = value;
			this._timer.delay = value;
		}
		
		public function set hook( value:Boolean ):void {
			this._hookEnabled = value;
		}

		public function get hookPosition():String {
			return this._hookPosition;
		}
		
		public function set hookPosition( value:String ):void {
			this._hookPosition = value;
		}
		
		public function set hookSize( value:Number ):void {
			this._hookSize = value;
		}
		
		public function set cornerRadius( value:Number ):void {
			this._cornerRadius = value;
		}
		
		public function set colors( colArray:Array ):void {
			this._bgColors = colArray;
		}
		
		public function set autoSize( value:Boolean ):void {
			this._autoSize = value;
		}
		
		public function set hideOnMouseOut( value:Boolean ):void {
			this._hideOnMouseOut = value;
		}
		
		public function set border( value:Number ):void {
			this._border = value;
		}
		
		public function set borderSize( value:Number ):void {
			this._borderSize = value;
		}
		
		public function set tipHeight( value:Number ):void {
			this._defaultHeight = value;
		}

		public function set titleEmbed( value:Boolean ):void {
			this._titleEmbed = value;
		}
		
		public function set contentEmbed( value:Boolean ):void {
			this._contentEmbed = value;
		}
		
		private function textGlow( field:TextField ):void {
			var color:Number = 0x000000;
            var alpha:Number = 0.35;
            var blurX:Number = 2;
            var blurY:Number = 2;
            var strength:Number = 1;
            var inner:Boolean = false;
            var knockout:Boolean = false;
            var quality:Number = BitmapFilterQuality.HIGH;

           var filter:GlowFilter = new GlowFilter(color,
                                  alpha,
                                  blurX,
                                  blurY,
                                  strength,
                                  quality,
                                  inner,
                                  knockout);
            var myFilters:Array = new Array();
            myFilters.push(filter);
        	field.filters = myFilters;
		}
		
		private function bgGlow():void {
			var color:Number = 0x000000;
            var alpha:Number = 0.20;
            var blurX:Number = 5;
            var blurY:Number = 5;
            var strength:Number = 1;
            var inner:Boolean = false;
            var knockout:Boolean = false;
            var quality:Number = BitmapFilterQuality.HIGH;

           var filter:GlowFilter = new GlowFilter(color,
                                  alpha,
                                  blurX,
                                  blurY,
                                  strength,
                                  quality,
                                  inner,
                                  knockout);
            var myFilters:Array = new Array();
            myFilters.push(filter);
            filters = myFilters;
		}
		
		private function initTitleFormat():void {
			_titleFormat = new TextFormat();
			_titleFormat.font = "_sans";
			_titleFormat.bold = true;
			_titleFormat.size = 20;
			_titleFormat.color = 0x333333;
		}
		
		private function initContentFormat():void {
			_contentFormat = new TextFormat();
			_contentFormat.font = "_sans";
			_contentFormat.bold = false;
			_contentFormat.size = 14;
			_contentFormat.color = 0x333333;
		}
	
		private function addedToStage( displayObject:DisplayObject ):Boolean {
			var hasStage:Stage = displayObject.stage;
			return hasStage == null ? false : true;
		}
		/*
		//Check if font is a device font
		private function isDeviceFont( format:TextFormat ):Boolean {
			var font:String = format.font;
			var device:String = "_sans _serif _typewriter";
			return device.indexOf( font ) > -1;
			//_sans
			//_serif
			//_typewriter
		}
		
		private function isDeviceStyleSheet( sheet:StyleSheet ):Boolean {
			var styleNames:Array = sheet.styleNames;
			var len:int = styleNames.length;
			var isDevice:Boolean = false;
			for( var i:int = 0; i < len; i++ ){
				//var style:String = styleNames[i];
				var style:Object = sheet.getStyle(styleNames[i]);
				var fmt:TextFormat = new TextFormat();
				fmt = sheet.transform( style );
				var isDeviceFont:Boolean = this.isDeviceFont( fmt );
				//trace("IS DEVICE FONT : " + isDeviceFont );
			}
			return false;
		}
		*/
		
		private function setOffset():void {
			var preDrawAdd:int = (_buffer * 2);
			if ((this._tipPosition == "top_left") || (this._hookPosition == "top_right") || (this._hookPosition == "bottom_right") || (this._hookPosition == "bottom_left")) {
				this._offSet = 0 - ( (this.width + preDrawAdd) / 2 );
				this._yOffset = 0 - ( (this.height + preDrawAdd) / 2 )
			} else {
				switch( this._align ){
					case "left":
						//this._offSet = - _defaultWidth +  ( _buffer * 3 ) + this._hookSize; 
						this._hookOffSet = (this.width + preDrawAdd) - ( _buffer * 3 ) - this._hookSize; 
						if ((this._hookPosition == "left") || (this._hookPosition == "right")) {
							if (this.height < 50) {
								this._hookSize = 6;
							}
							this._hookOffSet = (this.height + preDrawAdd) - ( _buffer * 3 ) - this._hookSize; 
						}
					break;
					
					case "right":
						//this._offSet = 0 - ( _buffer * 3 ) - this._hookSize;
						if ((this._hookPosition == "left") || (this._hookPosition == "right")) {
							if (this.height < 50) {
								this._hookSize = 6;
							}
						}
						this._hookOffSet =  _buffer * 3 + this._hookSize;
					break;
					
					case "center":
						//this._offSet = - ( _defaultWidth / 2 );
						this._hookOffSet =  ( (this.width + preDrawAdd) / 2 );
						if ((this._hookPosition == "left") || (this._hookPosition == "right")) {
							if (this.height < 50) {
								this._hookSize = 6;
							}
							this._hookOffSet =  ( (this.height + preDrawAdd) / 2 );
						}
					break;
					
					default:
						//this._offSet = - ( _defaultWidth / 2 );
						this._hookOffSet =  ( (this.width + preDrawAdd) / 2 );
						if ((this._hookPosition == "left") || (this._hookPosition == "right")) {
							if (this.height < 50) {
								this._hookSize = 6;
							}
							this._hookOffSet =  ( (this.height + preDrawAdd) / 2 );
						}					
					break;
				}
				this._offSet = 0 - this._hookOffSet;
			}

		}
		
		private function cleanUp():void {
			this._parentObject.removeEventListener( MouseEvent.MOUSE_OUT, this.onMouseOut );
			//this._parentObject.removeEventListener( MouseEvent.MOUSE_MOVE, this.onMouseMovement );
			this.follow( false );
			this._tf.filters = [];
			this.filters = [];
			this._contentContainer.removeChild( this._tf );
			this._tf = null;
			if( this._cf != null ){
				this._cf.filters = []
				this._contentContainer.removeChild( this._cf );
			}
			this.graphics.clear();
			removeChild( this._contentContainer );
			parent.removeChild( this );
		}
		
		/* 
		private function onMouseMovement( event:MouseEvent ):void {
			var parentCoords:Point = new Point( _parentObject.mouseX, _parentObject.mouseY );
			var globalPoint:Point = _parentObject.localToGlobal(parentCoords);
			this.x = globalPoint.x - this.width;
			this.y = globalPoint.y - this.height - 10;
			event.updateAfterEvent();
		}
		*/
		
	}
}

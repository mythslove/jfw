package com.pianfeng.engine.animation.data 
{
	import com.pianfeng.engine.global.interfaces.IDispose;
	import com.pianfeng.engine.utils.CommUtils;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.FrameLabel;
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	//import flash.utils.getTimer;
	
	/**
	 * 静态单个动画类，主要把一个MovieClip转换成IAnimation接口,这是静态动画类，前提是MovieClip已经下载了
	 * 
	 */
	public class StaticAnimationObj implements IAnimationObj
	{
		private var FBitmapDataArr: Array;
		private var FFrameLabelArr: Object;
		private var FBoundsArr: Array;
		private var FTransRectArr: Array;
		
		private var FOrgin: Rectangle;
		private var FDisplayObject: DisplayObject;
		/**
		 *构造函数 
		 * @param displayobj	要转换的显示对象
		 * 
		 */		
		public function StaticAnimationObj(displayobj: DisplayObject) 
		{
			FDisplayObject = displayobj;
			getAllFrameLabel(displayobj);				
			getAllBitmapData(displayobj);
			
			FOrgin = FBoundsArr[1] ;
		}
		
		/**
		 * 取出mc所有帧标签
		 *
		 * @param displayobj 要提取信息的MC
		 * 
		 * @return			
		 */
		private function getAllFrameLabel(displayobj: DisplayObject): void{
			FFrameLabelArr = {}; 	
			if (!(displayobj is MovieClip)) return;
			var _labels:Array = (displayobj as MovieClip).currentLabels;		
			for (var i:int = 0,len:int=_labels.length; i < len; i++){
    			var _label: FrameLabel = _labels[i];
    			FFrameLabelArr[_label.name] = _label.frame;
			}
		}
		
		/**
		 * 取出mc所有帧转换成BitmapData
		 *
		 * @param displayobj 要转换的MC
		 * 
		 * @return			
		 */
		private function getAllBitmapData(displayobj: DisplayObject): void{
			//FBitmapDataArr = [null];
			//FBoundsArr = [null];
			if (displayobj == null){
				FBitmapDataArr = [null];
				FBoundsArr = [null];
				return;
			} 
			if (displayobj is MovieClip){
				var _mc: MovieClip = displayobj as MovieClip;
				FBitmapDataArr = new Array(_mc.totalFrames+1);
				FBoundsArr = new Array(_mc.totalFrames+1);
				FTransRectArr = new Array(_mc.totalFrames+1);
				/*for (var i:int = 1, len: int = _mc.totalFrames; i <= len; i++) {
					_mc.gotoAndStop(i);
					if ((_mc.width > 0) && (_mc.height > 0)) {
						FBitmapDataArr[i] = null;// CommFunc.drawDisplayObject(_mc);
						FBoundsArr[i] = _mc.getBounds(_mc);
					}else {
						FBitmapDataArr[i] = null;
						FBoundsArr[i] = null;
					}
				}*/
			}
			else{
				FBitmapDataArr = [null];
				FBoundsArr = [null];
				FBitmapDataArr[1] = CommUtils.drawDisplayObject(displayobj);
				FBoundsArr[1] = displayobj.getBounds(displayobj);
			}
		}
		
		private function getBitmapData(iFrame: int): BitmapData {
			/*if (FBitmapDataArr[iFrame] == null) {
				if (FDisplayObject is MovieClip) {
					trace("-------->",System.totalMemory / 1024);
					var _mc: MovieClip = FDisplayObject as MovieClip;
					_mc.gotoAndStop(iFrame);
					trace("3-------->",System.totalMemory / 1024);
					if ((_mc.width > 0) && (_mc.height > 0)) {
						FBitmapDataArr[iFrame] = CommFunc.drawDisplayObject(_mc);
					}else {
						FBitmapDataArr[iFrame] = null;
					}
					trace("1-------->",System.totalMemory / 1024);
					_mc.gotoAndStop(49);
					trace("2-------->",System.totalMemory / 1024);
				}
			}
			return FBitmapDataArr[iFrame];*/
			if (FBitmapDataArr[iFrame] != null) return FBitmapDataArr[iFrame];//
			if (FDisplayObject is MovieClip){
				var _mc: MovieClip = FDisplayObject as MovieClip;
				_mc.gotoAndStop(iFrame);
				if ((_mc.width > 1) && (_mc.height > 1)) {
					var _tbmp: BitmapData = CommUtils.drawDisplayObject(_mc);
					var _r: Rectangle = _tbmp.getColorBoundsRect(0xFFFFFFFF, 0x0, false);
					if ((_r.width == 0) || (_r.height == 0)){
						_r = new Rectangle(0,0,_tbmp.width,_tbmp.height);
					}
					var _ebmp: BitmapData = new BitmapData(_r.width, _r.height);
					_ebmp.copyPixels(_tbmp, _r, new Point());
					_tbmp.dispose();
					FTransRectArr[iFrame] = _r;		
					FBitmapDataArr[iFrame] = _ebmp;//	
					return _ebmp;
				}else {
					return null;
				}
			}
			else{
				return FBitmapDataArr[iFrame];
			}
		}
		
		/**
		 * 取出mc对应帧的BitmapData
		 *
		 * @param iFrame 	对应帧数
		 * 
		 * @return			当前帧对应的BitmapData
		 */
		public function getBitmapDataByFrame(iFrame: int = 1): BitmapData {
			if ((iFrame > 0) && (iFrame < FBitmapDataArr.length)) return getBitmapData(iFrame);
			else return FBitmapDataArr[1];
		}
		
		/**
		 * 根据帧取出相应BitmapData并画在Graphics上
		 * @param Graphics	要画的Graphics对象
		 * @param iFrame	对应帧数
		 * 
		 * @return			true--成功  false--失败
		 */
		public function drawFrameToGraphics(graphics: Graphics, iFrame: int = 1): Boolean {
			if (graphics == null) return false;
			if ((iFrame < 0) || (iFrame >= FBitmapDataArr.length)) return false;
			var _bmpdata: BitmapData = getBitmapData(iFrame);
			var _bounds: Rectangle = getBoundsByFrame(iFrame);
			if ((_bmpdata == null) || (_bounds == null)) return false;
			
			with(graphics){
				clear();
				beginBitmapFill(_bmpdata, new Matrix(1, 0, 0, 1, _bounds.x, _bounds.y), false, false);
				drawRect(_bounds.x, _bounds.y, _bmpdata.width, _bmpdata.height);
				endFill();
			}
			return true;
		}
				
		/**
		 * 取出mc帧标签对应的帧数
		 *
		 * @param frameLabel 	帧标签
		 * 
		 * @return				帧标签对应的帧数
		 */
		public function getFrameByLabel(frameLabel: String): int{
			if (FFrameLabelArr[frameLabel] == null) return 1;
			return FFrameLabelArr[frameLabel];
		}
		
		/**
		 * 取得动画效果对象总帧数
		 * @param 			无
		 * 
		 * @return			动画效果对象总帧数
		 */
		public function getTotalFrames(): int{
			if (FBitmapDataArr == null) return 0;
			return FBitmapDataArr.length;
		}
		
		/**
		 * 根据帧取出相应的Bounds用于重画原点
		 * @param iFrame	对应帧数
		 * 
		 * @return			当前帧对应的Bounds
		 */
		public function getBoundsByFrame(iFrame: int=1): Rectangle {
			if ((iFrame > 0) && (iFrame < FBoundsArr.length)) {
				if(FBoundsArr[iFrame] == null){
					if (FDisplayObject is MovieClip) {
						var _mc: MovieClip = FDisplayObject as MovieClip;
						_mc.gotoAndStop(iFrame);
				
						if ((_mc.width > 1) && (_mc.height > 1)) {
							if (FTransRectArr[iFrame] == null) getBitmapData(iFrame);
							var _rect: Rectangle = _mc.getBounds(_mc);
							//trace("FTransRectArr[iFrame]",FTransRectArr[iFrame],iFrame);
							_rect.x += (FTransRectArr[iFrame] as Rectangle).x;
							_rect.y += (FTransRectArr[iFrame] as Rectangle).y;
							_rect.width = (FTransRectArr[iFrame] as Rectangle).width;
							_rect.height = (FTransRectArr[iFrame] as Rectangle).height;
							FBoundsArr[iFrame] = _rect;
						}else {
							FBoundsArr[iFrame] = null;
						}
					}
				}
				return FBoundsArr[iFrame];
			}
			else return FBoundsArr[1];
		}
		
		/*private function getOffsetBounds(bounds: Rectangle): Rectangle{
			
		}*/
		
		public function getOrigin(): Rectangle {
			return FOrgin;
		}
		
		/**
		 * 根据帧取出相应DisplayObject
		 * 这里主要是把这帧对应的BitmapData重新生成一个DisplayObject,并且这个新的DisplayObject原点和原始的MC原点一样
		 * 
		 * @param iFrame	对应帧数
		 * 
		 * @return			当前帧对应的BitmapData
		 */
		public function getDisplayObjectByFrame(iFrame: int = 1): DisplayObject {
			var _sp: Sprite = new Sprite();
			if (drawFrameToGraphics(_sp.graphics, iFrame)) return _sp;
			else return null;
		}
		
		public function dispose(): void {
			FDisplayObject = null;
			FFrameLabelArr = null;
			for (var i:* in FBitmapDataArr) {//释放BitmapData内存
				if ((FBitmapDataArr[i] != null) && (FBitmapDataArr[i] is BitmapData)) {
					(FBitmapDataArr[i] as BitmapData).dispose();
				}
				FBitmapDataArr[i] = null;
				delete FBitmapDataArr[i];
			}
			FBitmapDataArr = null;
			FTransRectArr = null;
		}
	}	
}
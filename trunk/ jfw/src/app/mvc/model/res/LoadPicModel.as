package app.mvc.model.res
{
	import app.mvc.model.data.LoadPicStruct;
	
	import com.jfw.engine.core.mvc.model.LoadModel;
	import com.jfw.engine.utils.logger.Logger;
	
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	
	public class LoadPicModel extends LoadModel
	{
		static public const NAME:String = "LoadPicModel";
		
		public function LoadPicModel()
		{
			super();
		}
		
		public function drawPic( data:LoadPicStruct ):void 
		{
			var clsName:String = data.srcid;
			var bmd:BitmapData = assetsModel.getBitmapData( clsName ) as BitmapData;
			var pyX:Number;
			var pyY:Number;
			var matrix:Matrix=new Matrix() ;
			if (bmd != null)
			{
				if( data.scale != -1 )
				{
					pyX = (data.mc.width - data.scale) / 2;
					pyY = (data.mc.height - data.scale) / 2;
					matrix.tx = pyX;
					matrix.ty = pyY;
					matrix.scale(data.scale / bmd.width, data.scale / bmd.height);
					data.mc.graphics.beginBitmapFill(bmd, matrix);
					data.mc.graphics.drawRect(pyX, pyY, data.scale, data.scale);
				} else {
					pyX = (data.mc.width - bmd.width) / 2;
					pyY = (data.mc.height - bmd.height) / 2;
					matrix.tx = pyX;
					matrix.ty = pyY;
					data.mc.graphics.beginBitmapFill(bmd, matrix);
					//data.mc.graphics.beginBitmapFill(bmd);
					data.mc.graphics.drawRect(pyX, pyY, bmd.width, bmd.height);
					//data.mc.graphics.drawRect(0, 0, bmd.width, bmd.height);
				}
				data.mc.mouseEnabled = true;
			}
			else 
			{
				Logger.error("no pic id---->",clsName)
			}
		}
		
		private function get assetsModel():AssetsModel
		{
			return this.core.retModel( AssetsModel.NAME ) as AssetsModel;
		}
	}
}
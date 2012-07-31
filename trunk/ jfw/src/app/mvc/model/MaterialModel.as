package app.mvc.model
{
	import com.jfw.engine.core.mvc.model.BModel;
	
	public class MaterialModel extends BModel
	{
		
		static public const NAME:String = 'MaterialModel';
		
		/** 品质颜色 */
		private var qualityColor:Array = [ 0xFFFFFF,0x00ff00,0x3399ff,0xff6600,0xff0000,0xff00ff ];
		
		/** 晶石名称 */
		private var sparNames:Array = ['','金晶石','木晶石','水晶石','火晶石','土晶石'];
		
		/** 晶石颜色 */
		private var sparColors:Array = ['#000000','#ffff00','#00ff00','#66ffff','#ff0000','#cc9900'];
		
		public function MaterialModel()
		{
			super( NAME );
		}
		
		/**
		 * 晶石颜色 
		 * @param spar
		 * @return 
		 * 
		 */
		public function sparColor( spar:int ):String
		{
			return this.sparColors[ spar ];
		}
		
		/**
		 * 晶石名称 
		 * @param spar
		 * @return 
		 * 
		 */
		public function sparName( spar:int ):String
		{
			return sparNames[ spar ];
		}
		
		/**
		 *  
		 * @param spar
		 * @return 
		 * 
		 */
		public function sparColorStr( spar:int ):String
		{
			return "<font color='" + sparColor( spar ) + "'>" + sparName( spar ) + "</font>";
		}
		
		/**
		 * 将 0xFF0000 -> #FF0000 
		 * @param q
		 * @return 
		 * 
		 */
		public function qualityColorStr( q:int ):String
		{
			return '#' + this.qualityColor[q].toString().split( '0x' )[1];
		}
	}
}
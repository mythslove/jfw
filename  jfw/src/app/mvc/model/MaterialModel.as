package app.mvc.model
{
	import com.jfw.engine.core.mvc.model.BModel;
	
	public class MaterialModel extends BModel
	{
		
		static public const NAME:String = 'MaterialModel';
		
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
	}
}
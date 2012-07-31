package app.mvc.model.spell
{
	import com.jfw.engine.core.mvc.model.BModel;
	import app.mvc.model.data.SpellStruct;
	
	public class SpellModel extends BModel
	{
		static public const NAME:String = 'SpellModel';
		
		private var _spellList:Array = null;
		
		public function SpellModel( )
		{
			super( NAME );
		}
		
		/**
		 * 初始化法术列表 
		 * @param info
		 * 
		 */
		public function initSpellList( info:Array ):void
		{
			this._spellList = [];
			for( var i:int = 0,len:int = info.length;i<len;i++ )
			{
				this._spellList.push( new SpellStruct( info[i] ) );
					
			}
		}
		
		public function get spellList():Array
		{
			return this._spellList;	
		}
		
		public function set spellList( spells:Array ):void
		{
			this._spellList = spells;
		}
	}
}
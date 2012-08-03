package app.mvc.model.spell
{
	import app.mvc.model.data.SpellStruct;
	
	import com.jfw.engine.core.data.IStruct;
	import com.jfw.engine.core.mvc.model.BModel;
	
	[Bindable]
	public class SpellModel extends BModel
	{
		static public const NAME:String = 'SpellModel';
		
		//主角的法术列表
		private var _spellList:Array = null;
		
		//当前选择的妖将数据
		private var _currSelectedMonster:IStruct = null;
		
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
		
		public function get currSelectedMonster():IStruct
		{
			return this._currSelectedMonster;
		}
		
		public function set currSelectedMonster( data:IStruct ):void
		{
			this._currSelectedMonster = data;
		}
	}
}
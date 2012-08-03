package app.mvc.model
{
	import app.mvc.model.data.EmptyStruct;
	import app.mvc.model.data.MonsterStruct;
	
	import com.jfw.engine.core.mvc.model.BModel;
	
	public class MonsterModel extends BModel
	{
		public static const NAME:String = 'MonsterModel';
		
		private const MONSTER_MAX_NUM:int = 11; 
		private var _monsterList:Array ;
		
		public function MonsterModel( )
		{
			super( NAME );
			
			_monsterList = [];
		}
		/**
		 * 初始化妖将 
		 * @param info
		 * 
		 */
		public function initMonsterList( info:Array ):void
		{
			_monsterList = [];
			for( var i:int = 0; i < MONSTER_MAX_NUM; i++ )
			{
				if( i < info.length )
					this.monsterList.push( new MonsterStruct( info[i] ) );
				else
					this.monsterList.push( new EmptyStruct( { label:'VIP' } ) );
			}
		}
		
		public function get monsterList():Array
		{
			return this._monsterList;
		}
		
		public function set monsterList( list:Array ):void
		{
			this._monsterList = list;	
		}
	}
}
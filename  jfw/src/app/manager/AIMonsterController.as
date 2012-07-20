package app.manager
{
	import app.view.iso.isoSprites.charactor.AIMonster;

	/**
	 *  AI Monsters
	 * @author 
	 * 
	 */	
	public class AIMonsterController
	{
		static private var instance:AIMonsterController;
		
		private var _aiMonster:Vector.<AIMonster>;
		
		public function AIMonsterController()
		{
			if( instance )
				throw new Error( "" );
			instance = this;
		}
		
		static public function getInstance():AIMonsterController
		{
			if( !instance )
				instance = new AIMonsterController();
			return instance;
		}
		
		public function addAIMonster( ):void
		{
			
		}
		
		public function removeAllAIMonsters():void
		{
			var i:int = 0;
			var len:int = this._aiMonster.length;
			while( i < len )
			{
				i++;
			}
		}
		
	}
}
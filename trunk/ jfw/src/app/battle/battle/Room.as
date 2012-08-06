package app.battle.battle
{
	import app.globals.interfaces.ICharactor;

	public class Room
	{
		private var id:int=0;
		public var arr:Array;
		
		public function Room(id:int=0,one:ICharactor=null,other:ICharactor=null)
		{
			arr=[];
			this.id=id;
			arr.push(one);
			arr.push(other);
		}
		/**
		 * 得到战斗目标
		 * @return 
		 * 
		 */		
		public function getOther(char:ICharactor):ICharactor
		{			
			return arr[1-arr.indexOf(char)] as ICharactor;
		}
		/**
		 * 房间是否结束 
		 * @return 
		 * 
		 */		
		public function get isEnd():Boolean
		{
			return (arr[0] as ICharactor).CurrHP==0||(arr[1] as ICharactor).CurrHP==0;
		}
	}
}
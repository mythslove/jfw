package app.battle.utils
{
	public class IDUtils
	{
		static private var idArr:Array=[];
		/**
		 *创建唯一id 
		 * @return 
		 * 
		 */		
		static public function createNewID(len:int=int.MAX_VALUE):int
		{
			var id:int=Math.random()*100000;
			
			while(true)
			{
				if(idArr[id]==null)
				{
					idArr[id]=id;
					return id;
				}
				else
				{
					id=Math.random()*100000;
				}
			}
			
			return 0;
		}
		
		static public function clear():void
		{
			idArr.splice(0,idArr.length);
		}
	}
}
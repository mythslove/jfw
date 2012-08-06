package app.battle.interfaces
{
	public interface IDataVO
	{
		/** 实例id */
		function get ID():int;
		
		/** 实例id */
		function set ID(id:int):void;	
			
		/**临时唯一id*/	
		function get SingleID():int;	
		
		/**临时唯一id*/	
		function set SingleID(sid:int):void;	
		
		/**资源id*/	
		function get SrcID():String;	
		
		/**资源id*/	
		function set SrcID(srcid:String):void;	
		
		/** 类型*/
		function get Type():int;
		
		/** 类型*/
		function set Type(type:int):void;
		
		/** 级别 */
		function get Level():int;
		
		/** 级别 */
		function set Level(lv:int):void;
		
		/** 得到vo,需要子类重写*/
		function get VO():*;
	}
}
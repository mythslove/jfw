package app.model.net
{
	import app.control.net.InitCmd;
	
	import flash.net.getClassByAlias;
	
	/**
	 * @author jianzi
	 */	
	public class NetRequest
	{
		static private var instance:NetRequest ;
		static public const CALLBACK:String = '.callback';
		
		private var _netCommands:Array = [];

		/** 游戏初始化 */
		static public const UserInit:String 				= 'InitAction.userInit';
		
		/** 妖王府收获妖币 */
		static public const CollectYb:String 				= 'BuildAction.harvestYWF';
		static public const ExtraCollectYb:String 		= 'BuildAction.chargeYWF';
		
		public function init():void
		{
			bindingNetID( UserInit ,InitCmd );
		}
		
		public function NetRequest():void
		{
			if( instance )
				throw new Error();
			instance = this;
		}
		
		static public function getInstance():NetRequest
		{
			if( !instance )
				instance = new NetRequest();
			return instance;
		}
		
		public function get netCommands():Array
		{
			return this._netCommands;
		}
		
		// helper
		
		private function bindingNetID( netId:String ,cmdCls:Class ):void
		{
			_netCommands[ netId ] = [ cmdCls,netId,netId + CALLBACK ];
		}
	}
}
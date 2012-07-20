package app.consts
{
	import app.control.InitCmd;
	import app.control.Test2Cmd;
	import app.control.TestCmd;
	
	import flash.net.getClassByAlias;
	
	public class NetConst
	{
		static private var instance:NetConst ;
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
			bindingNetID( CollectYb,TestCmd );
			bindingNetID( ExtraCollectYb,Test2Cmd );
		}
		
		public function NetConst():void
		{
			if( instance )
				throw new Error();
			instance = this;
		}
		
		static public function getInstance():NetConst
		{
			if( !instance )
				instance = new NetConst();
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
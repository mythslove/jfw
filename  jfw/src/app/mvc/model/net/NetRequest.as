package app.mvc.model.net
{
	import app.mvc.control.SpellCodeTimeCmd;
	import app.mvc.control.SpellStrengthenCmd;
	import app.mvc.control.SpellUpgradeCmd;
	import app.mvc.control.net.InitCmd;
	
	import flash.net.getClassByAlias;
	
	/**
	 * @author jianzi
	 */	
	public class NetRequest
	{
		static private var instance:NetRequest ;
		static public const CALLBACK:String = '.callback';
		
		/** 是否使用调试数据，不使用网络 */
		static public const USE_DEBUG_DATA:Boolean = true;
		
		private var _netCommands:Array = [];

		/** 游戏初始化 */
		static public const UserInit:String 				= 'InitAction.userInit';
		
		/** 妖王府收获妖币 */
		static public const CollectYb:String 				= 'BuildAction.harvestYWF';
		static public const ExtraCollectYb:String 		= 'BuildAction.chargeYWF';
		
		/** 法术堂升级 */
		static public const SpellUpgrade:String 		    = 'InitAction.spellUpgrade';
		static public const SpellCodeTime:String 			= 'InitAction.spellCodeTime';
		static public const SpellStrengthen:String 		= 'InitAction.spellStrengthen';
		
		public function init():void
		{
			bindingNetID( UserInit ,InitCmd );
			bindingNetID( SpellUpgrade ,SpellUpgradeCmd );
			bindingNetID( SpellCodeTime ,SpellCodeTimeCmd );
			bindingNetID( SpellStrengthen ,SpellStrengthenCmd );
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
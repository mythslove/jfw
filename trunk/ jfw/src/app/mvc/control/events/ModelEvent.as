package app.mvc.control.events
{
	import flash.events.Event;
	
	/** 游戏事件 */
	public class ModelEvent extends Event
	{
		public static const STAGERESIZE:String 			= 'stageResize';			//舞台大小改变
		
		static public const LOAD_PIC:String 				= 'app_load_pic';
		
		public static const GAME_INIT:String				= 'game_init';
		
		public static const BASEASSETS_LOADING:String 	= 'baseassets_loading';	//公共资源下载中
		public static const BASEASSETS_LOADED:String 		= 'baseassets_loaded';	//公共资源下载完
		
		public static const LOGIN_START:String			= 'login_start';			// 开始登陆
		public static const INITWORLD_START:String		= 'initworld_start';		// 开始初始化
		public static const GAMEINFO_INIT:String			= 'gameinfo_init';		// 初始化游戏数据
		public static const MYARMYINFO_INIT:String		= 'myarmyinfo_init';		// 初始化自己的部队信息
		public static const VISITARMYINFO_INIT:String		= 'visitarmyinfo_init';	// 初始化访问好友的部队信息
		public static const COLONY_INIT:String			= 'colony_init';			// 初始化驻军信息
		public static const MYSEIZE_INIT:String			= 'myseize_init';			// 初始化自己的占领者信息
		public static const VISITSEIZE_INIT:String		= 'visitseize_init';		// 初始化当前访问好友的占领者信息
		public static const MYMAPINFO_INIT:String			= 'mymapinfo_init';		// 初始化地图数据
		public static const VISITMAPINFO_INIT:String		= 'visitmapinfo_init';	// 初始化地图数据
		public static const INITFRIENDLIST:String 		= 'initfriendlist';		// 初始化好友列表
		public static const ENTER_GAME:String				= 'enter_game';			// 所有初始化工作完成,正式进入游戏
		public static const LOGIN_FAILURE:String			= 'login_failure';		// 登陆失败提示
		public static const FRIEND_ERROR:String			= 'friend_error';			// 获取好友列表失败
		

		/** 消息提示 */
		public static const ERROR_REFRESH_ALERT:String		= 'message_alert' ; 
		
		public static const VISITFRIEND_INIT:String		= 'visitfriend_init';		// 拜访好友初始化
		
		public function ModelEvent( type:String, bubbles:Boolean=false, cancelable:Boolean=false )
		{
			super( type, bubbles, cancelable );
		}
	}
}
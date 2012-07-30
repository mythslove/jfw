package app.mvc.model.player
{
	import app.mvc.model.data.player.FriendStruct;
	
	import com.jfw.engine.core.mvc.model.BModel;

	public class FriendModel extends BModel
	{
		static public const NAME:String = 'FriendModel';
		
		/** 好友列表 */
		public var friendList:Array = [];
		
		/** 仇人列表 */
		public var foeList:Array = [];
		
		public function FriendModel( )
		{
			super( NAME );
		}
		
		/**
		 * 根据类型获取列表 
		 * @param type 0 好友 1 仇人 2 ...
		 * @return 
		 * 
		 */
		public function getData( type:int ):Array
		{
			//return type ? this.foeList : this.friendList;
			var data:Array = [];
			switch( type )
			{
				case 0:
					data = this.friendList;
					break;
				case 1:
					data = this.foeList;
					break;
			}
			return data;
		}
		
		/**
		 * 初始化仇人 
		 * @param foes
		 */
		public function initFoeList( foes:Array ):void
		{
			foeList = [];
			var foeStruct:FriendStruct = null;
			for each( var info:Object in foes )
			{
				foeStruct = new FriendStruct( info );
				foeList.push( foeStruct );
			}
			foeList.sort( sortLv );
		}
		
		/**
		 * 初始化好友 
		 * @param friends
		 */
		public function initFriendList( friends:Array = null ):void
		{
			friendList = [];
			
			// 初始化好友列表
			var frdStruct:FriendStruct = null;
			for each( var info:Object in friends )
			{
				frdStruct = new FriendStruct( info );
				friendList.push( frdStruct );
			}
			
			//friendList.sort( sortVip );
			friendList.sort( sortLv );
			var rank:int = 1;
			for each ( var friend:FriendStruct in friendList )
			{
				if ( friend.isNpc )
					continue;
				friend.rank = rank++;
			}
		}
		
		/**
		 * 根据是否VIP排序 
		 * 	若返回值为负，则表示 A 在排序后的序列中出现在 B 之前。
			若返回值为 0，则表示 A 和 B 具有相同的排序顺序。
			若返回值为正，则表示 A 在排序后的序列中出现在 B 之后。
		 */
		private function sortVip( frdStruct1:FriendStruct,frdStruct2:FriendStruct ):Number
		{
			if ( frdStruct1.viplv > frdStruct2.viplv )
				return -1;
			else if ( frdStruct1.viplv == frdStruct2.viplv )
				return 0;
			else 
				return 1;
		}
		
		/**
		 * 根据等级排序 
		 * 
		 */
		private function sortLv( frdStruct1:FriendStruct,frdStruct2:FriendStruct ):Number
		{
			if( frdStruct1.lv >frdStruct2.lv )
				return -1;
			else if( frdStruct1.lv == frdStruct2.lv )
				return 0;
			else
				return 1;
		}
	}
}
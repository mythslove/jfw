package app.mvc.control.net
{
	import app.mvc.control.events.ModelEvent;
	import app.mvc.model.DebugModel;
	import app.mvc.model.net.NetModel;
	import app.mvc.model.net.NetRequest;
	import app.mvc.model.player.FriendModel;
	import app.mvc.model.player.PlayerModel;
	
	import com.jfw.engine.core.base.Core;
	import com.jfw.engine.core.mvc.control.BCmd;
	
	public class InitCmd extends BCmd
	{
		override public function execute(evt:String, param:Object):void
		{
			if( !Core.getInstance().hasModel( NetModel.NAME ) )
				new NetModel();
			var netModel:NetModel = Core.getInstance().retModel( NetModel.NAME ) as NetModel;
		
			switch( evt )
			{
				case NetRequest.UserInit:
					netModel.call( evt );
					break;
				
				case NetRequest.UserInit + NetRequest.CALLBACK:
					handlerNetObj( param );
					break;
			}
		}
		
		private function handlerNetObj( netObj:Object ):void
		{
			//玩家对象
			( Core.getInstance().retModel( PlayerModel.NAME ) as PlayerModel ).initPlayerVO( netObj.playerInfo );
			//初始化好友列表
			( Core.getInstance().retModel( FriendModel.NAME ) as FriendModel ).initFriendList( netObj.friendList );
			//初始化仇人列表
			( Core.getInstance().retModel( FriendModel.NAME ) as FriendModel ).initFoeList( netObj.foeList );
			
			sendEvent( ModelEvent.GAME_INIT );
		}
	}
}
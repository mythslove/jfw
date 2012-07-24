package app.control.net
{
	import app.control.events.ModelEvent;
	import app.model.net.NetModel;
	import app.model.net.NetRequest;
	import app.model.player.FriendModel;
	
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
					var netObj:Object = param;
					
					//初始化好友列表
					( Core.getInstance().retModel( FriendModel.NAME ) as FriendModel ).initFriendList( );
					
					sendEvent( ModelEvent.GAME_INIT );
					break;
			}
		}
		
	}
}
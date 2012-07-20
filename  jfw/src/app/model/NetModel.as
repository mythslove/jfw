package app.model
{
	import app.consts.NetConst;
	import app.model.data.ConfigStruct;
	
	import com.jfw.engine.core.mvc.model.BModel;
	import com.jfw.engine.net.nc.NetErrorType;
	import com.jfw.engine.net.nc.NetManager;
	import com.jfw.engine.net.nc.NetVO;
	import com.jfw.engine.utils.logger.Logger;
	
	/** 网络模块 */
	public class NetModel extends BModel
	{
		public static const NAME:String = 'NetModel';
		
		public function NetModel()
		{
			super( NAME );
		}
		
		//网关
		private var gateWay:String = '';
		
		override public function onRegister():void
		{
			this.gateWay = (this.core.configModel.configData as ConfigStruct).gateway;
		}
		
		
		public function call( netCmd:String,param:Object = null ):void
		{
			if ( null == param )
				param = { };
			
			Logger.info( 'Call net command: ',netCmd );
			NetManager.getInstance().call( this.gateWay, netCmd, param, onResult );
		}
		
		private function onResult( netVO:NetVO ):void
		{
			/** 系统错误处理 */
			if ( !netVO.returnResult )
			{
				Logger.error( netVO.returnError ,netVO.returnErrorType,netVO.returnErrorNumber);
				switch ( netVO.returnErrorType )
				{
					case NetErrorType.NET_ERROR:
						//sendEvent( );
						// 网络错误
//						sendNotification(AppConst.APP_SHOW_GAME_MSG,NetErrorType.NET_ERROR);
						break;
					case NetErrorType.SERVER_ERROR:
						// 服务器返回的错误
//						sendNotification(AppConst.APP_SHOW_GAME_MSG,NetErrorType.SERVER_ERROR);
						break;
					default:
						break;
				}
				return;
			}
			
			/** 程序逻辑错误处理  */
			if( netVO.returnParams )
			{
				if(0 != netVO.returnParams.code)
				{
//					sendNotification(AppConst.APP_SHOW_GAME_MSG,vo.returnParams.code);
					return;
				}
			}
			
			sendEvent( netVO.sendCommand + NetConst.CALLBACK,netVO.returnParams );
			Logger.info( 'Call net command callback:',netVO.sendCommand );			
		}
		
	}
}
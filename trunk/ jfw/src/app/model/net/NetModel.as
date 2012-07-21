package app.model.net
{
	import app.model.data.ConfigStruct;
	import app.control.events.ModelEvent;
	
	import com.jfw.engine.core.mvc.model.BModel;
	import com.jfw.engine.net.nc.NetErrorType;
	import com.jfw.engine.net.nc.NetManager;
	import com.jfw.engine.net.nc.NetVO;
	import com.jfw.engine.utils.ServiceDate;
	import com.jfw.engine.utils.logger.Logger;
	
	/** 网络模块 */
	public class NetModel extends BModel
	{
		public static const NAME:String = 'NetModel';
		private var gateWay:String = '';
		
		public function NetModel()
		{
			super( NAME );
		}
		
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
			var errno:int = -1;
			
			/** 系统错误 */
			if ( !netVO.returnResult )
			{
				Logger.error( '[' + netVO.returnErrorNumber + '] ' + netVO.returnError , ' error type:' + netVO.returnErrorType);
				sendEvent( ModelEvent.ERROR_REFRESH_ALERT, netVO.returnErrorType );
				return;
			}
			
			if( netVO.returnParams )
			{
				/** 设置服务器时间 */
				ServiceDate.instance.setServiceTime( netVO.returnParams['ts'] );
				
				/** 协议错误  */
				if(0 != netVO.returnParams.code)
				{
					Logger.error( '[' + netVO.returnErrorNumber + '] ' + 'protocol errno:' + netVO.returnParams.code);
					sendEvent( ModelEvent.ERROR_REFRESH_ALERT, netVO.returnParams.code);
					return;
				}
				
				/** 正确返回 */
				sendEvent( netVO.sendCommand + NetRequest.CALLBACK,netVO.returnParams );
				Logger.info( 'Call net command callback:',netVO.sendCommand );
			}
		}
		
	}
}
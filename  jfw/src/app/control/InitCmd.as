package app.control
{
	import app.consts.NetConst;
	import app.model.NetModel;
	
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
				case NetConst.UserInit:
					netModel.call( evt );
					break;
				case NetConst.UserInit + NetConst.CALLBACK:
					break;
			}
		}
	}
}
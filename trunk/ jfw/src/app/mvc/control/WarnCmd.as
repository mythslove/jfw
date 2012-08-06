package app.mvc.control
{
	import app.mvc.control.events.ModelEvent;
	import app.mvc.model.WarnModel;
	import app.mvc.view.ui.component.alert.Alert;
	
	import com.jfw.engine.core.base.Core;
	import com.jfw.engine.core.mvc.control.BCmd;
	
	public class WarnCmd extends BCmd
	{
		override public function execute(evt:String, param:Object):void
		{
			switch( evt )
			{
				case ModelEvent.ERROR_REFRESH_ALERT:
					Alert.show( warnModel.getError( param.toString() ), Alert.REFRESH );
					break;
			}
		}
		
		private function get warnModel():WarnModel
		{
			return Core.getInstance().retModel( WarnModel.NAME ) as WarnModel;
		}
		
	}
}
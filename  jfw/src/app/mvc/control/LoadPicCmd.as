package app.mvc.control
{
	import app.mvc.control.events.ModelEvent;
	import app.mvc.model.data.LoadPicStruct;
	import app.mvc.model.res.LoadPicModel;
	
	import com.jfw.engine.core.base.Core;
	import com.jfw.engine.core.mvc.control.BCmd;
	
	public class LoadPicCmd extends BCmd
	{
		override public function execute(evt:String, param:Object):void
		{
			switch( evt )
			{
				case ModelEvent.LOAD_PIC:
					loadPicModel.drawPic( param as LoadPicStruct );
					break;
			}
		}
		
		private function get loadPicModel():LoadPicModel
		{
			return Core.getInstance().retModel( LoadPicModel.NAME ) as LoadPicModel;
		}
	}
}
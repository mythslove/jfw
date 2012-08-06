package app.mvc.control
{
	import app.mvc.control.events.ModelEvent;
	import app.mvc.control.events.SpellEvent;
	import app.mvc.model.net.NetModel;
	import app.mvc.model.net.NetRequest;
	import app.mvc.model.spell.SpellModel;
	import app.mvc.view.ui.component.alert.Alert;
	
	import com.jfw.engine.core.base.Core;
	import com.jfw.engine.core.mvc.control.BCmd;
	
	public class SpellCodeTimeCmd extends BCmd
	{
		override public function execute(evt:String, param:Object):void
		{
			if( !Core.getInstance().hasModel( NetModel.NAME ) )
				new NetModel();
			var netModel:NetModel = Core.getInstance().retModel( NetModel.NAME ) as NetModel;
			trace("spell ",evt);
			switch( evt )
			{
				case NetRequest.SpellCodeTime:
					netModel.call( evt );
					break;
				case NetRequest.SpellCodeTime + NetRequest.CALLBACK:
					handlerNetObj( param );
					break;
			}
		}
		
		private function handlerNetObj( netObj:Object ):void
		{
			trace("ddddddddddddddddd");
			
		}
		
		private function get spellModel():SpellModel
		{
			return Core.getInstance().retModel( SpellModel.NAME ) as SpellModel;
		}
		
	}
}
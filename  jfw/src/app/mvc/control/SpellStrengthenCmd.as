package app.mvc.control
{
	import app.mvc.control.events.ModelEvent;
	import app.mvc.control.events.SpellEvent;
	import app.mvc.model.data.SpellStruct;
	import app.mvc.model.net.NetModel;
	import app.mvc.model.net.NetRequest;
	import app.mvc.model.spell.SpellModel;
	import app.mvc.view.ui.component.alert.Alert;
	
	import com.jfw.engine.core.base.Core;
	import com.jfw.engine.core.mvc.control.BCmd;
	
	public class SpellStrengthenCmd extends BCmd
	{
		override public function execute(evt:String, param:Object):void
		{
			if( !Core.getInstance().hasModel( NetModel.NAME ) )
				new NetModel();
			var netModel:NetModel = Core.getInstance().retModel( NetModel.NAME ) as NetModel;
			
			switch( evt )
			{
				case NetRequest.SpellStrengthen:
					netModel.call( evt );
					break;
				case NetRequest.SpellStrengthen + NetRequest.CALLBACK:
					handlerNetObj( param );
					break;
			}
		}
		
		private function handlerNetObj( netObj:Object ):void
		{
			var _spellList:Array=[];
			
			//更新列表
			for( var i:int = 0,len:int = spellModel.spellList.length;i<len;i++ )
			{
				if(netObj.id  ==  spellModel.spellList[i].id ){
					_spellList.push( new SpellStruct( netObj ) );
				}else{
					_spellList.push(spellModel.spellList[i]);
				}			
			}
			//更新当前选择项
			
			
			spellModel.spellList=_spellList;
			
		}
		
		private function get spellModel():SpellModel
		{
			return Core.getInstance().retModel( SpellModel.NAME ) as SpellModel;
		}
	}
}
package app.mvc.control
{
	import app.mvc.control.events.ModelEvent;
	import app.mvc.control.events.SpellEvent;
	import app.mvc.model.data.MonsterStruct;
	import app.mvc.model.data.SpellStruct;
	import app.mvc.model.net.NetModel;
	import app.mvc.model.net.NetRequest;
	import app.mvc.model.spell.SpellModel;
	import app.mvc.view.ui.component.alert.Alert;
	
	import com.jfw.engine.core.base.Core;
	import com.jfw.engine.core.data.IStruct;
	import com.jfw.engine.core.mvc.control.BCmd;
	
	import mx.binding.utils.BindingUtils;
	
	public class SpellUpgradeCmd extends BCmd
	{
		override public function execute(evt:String, param:Object):void
		{
			if( !Core.getInstance().hasModel( NetModel.NAME ) )
				new NetModel();
			var netModel:NetModel = Core.getInstance().retModel( NetModel.NAME ) as NetModel;
			
			switch( evt )
			{
				case NetRequest.SpellUpgrade:
					netModel.call( evt );
					break;
				case NetRequest.SpellUpgrade + NetRequest.CALLBACK:
					handlerNetObj( param );
					break;
			}
		}
		
		
		private function handlerNetObj( netObj:Object ):void
		{
			var _spellList:Array=[];
			
			var spell:SpellStruct = new SpellStruct( netObj );
			//更新列表
//			for( var i:int = 0,len:int = spellModel.spellList.length;i<len;i++ )
//			{
//				if(spell.id ==  spellModel.spellList[i].id ){
//					_spellList.push( spell );	
//				}else{
//					_spellList.push(spellModel.spellList[i]);
//				}			
//			}
//			spellModel.spellList=_spellList;
			
			//更新当前选择项
			var monsterObj:Object ;
			for( var i:int = 0,len:int = ( this.spellModel.currSelectedMonster as MonsterStruct ).spell.length; i < len; i++ )
			{
				if( spell.id == ( spellModel.currSelectedMonster as MonsterStruct ).spell[i].id )
					( spellModel.currSelectedMonster as MonsterStruct ).spell[i] = spell;
			}
			monsterObj = ( spellModel.currSelectedMonster as MonsterStruct ).clone();
			spellModel.currSelectedMonster =  new MonsterStruct( monsterObj );
			
		}
		
		private function get spellModel():SpellModel
		{
			return Core.getInstance().retModel( SpellModel.NAME ) as SpellModel;
		}
		
	}
}
package app.battle.statemachine.states
{
	public interface IState
	{
		function execute():void;
		
		function exit():void;
		
		function reset():void;//返回旧状态
		
		function getName():String;
			
	}
}
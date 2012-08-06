package app.battle.statemachine
{
	public interface IStateMachine
	{
		function initState(stateName:String):void;
		function changeState(stateName:String=null):void;
		function resetState():void;
		function keepState():void;
		function exitState():void;
	}
}
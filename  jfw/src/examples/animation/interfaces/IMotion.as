package examples.animation.interfaces
{
	import examples.animation.geom.isolib.map.data.IMapData;

	/**
	 * 可运动接口类
	 * 
	 */
	public interface IMotion extends IAnimation
	{
		function get PosX():Number;
		function set PosX(value:Number):void;
		
		function get PosY():Number;
		function set PosY(value:Number):void;
		/**
		* 取得运动对象的步长
		* @param 			null
		* 
		* @return			运动对象的步长
		*/
		function get Spd():Number;
		/**
		 * 行走路径 
		 * @param value
		 * 
		 */		
		function set WalkPath(value:Array):void;
		function get WalkPath():Array;
		/**
		 * 设置地图
		 * @param value
		 * 
		 */		
		function set MapData(value:IMapData):void;
		function get MapData():IMapData;
		/**
		 * 开始移动 
		 * 
		 */		
		function StartMove():void;
		/**
		 * 暂停移动 
		 * 
		 */		
		function PauseMove():void;
		/**
		 * 恢复移动 
		 * 
		 */		
		function ResumeMove():void;
		/**
		 * 移动状态 
		 * @return 
		 * 
		 */		
		function get isMoving():Boolean;
	}
}
package com.jfw.engine.core.geom.isolib.map.data
{
	import flash.geom.Point;

	public interface IMapData
	{
		/**
		 * 根据x,z索引得到该位置的路点,可以先调用getPointOverRide(x:int,z:int)函数判断是否越界
		 * @param x x轴格子索引
		 * @param z z轴格子索引
		 * @return	该格子所代表的地图标号
		 */
		function getTileAtGrid(x:int,z:int):Tile;
		/**
		 * 根据x,z索引得到该位置的路点,可以先调用getPointOverRide(x:int,z:int)函数判断是否越界
		 * @param x x轴格子索引
		 * @param z z轴格子索引
		 * @return	该格子所代表的地图标号
		 */
		function getTileAtGrid(x:int,z:int):Tile;
		/**
		 * 根据路点值查询路点集合
		 * @param obj	路点对象包含的值
		 * @return 
		 * 此方法频繁调用效率低下
		 */
		function getTilesByData(data:Object=null):Array;
		/**
		 * 判断指定的点是否越界
		 * @param x x轴索引
		 * @param z z轴索引
		 * @return 	如果越界则返回true,否则返回false
		 */		
		function getPointOverRide(x:int,z:int):Boolean;
		/**
		 * 根据屏幕坐标求网格坐标
		 */
		function screenToGrid(p:Point):Point;
		/**
		 * 根据网格坐标求屏幕坐标
		 */
		function GridToScreen(p:Point):Point;
		/**
		 * 背景宽
		 */	
		function get bgWidth():Number;
		/**
		 * 背景高
		 */			
		function get bgHeight():Number;
		/**
		 * 菱形格子的短对角线2d长度;
		 */	
		function get cellSize():Number;
		/**
		 * 露点网格列数
		 */
		function get gridCols():int;
		/**
		 * 露点网格行数
		 */
		function get gridRows():int;
		/**
		 * 网格屏幕高
		 */
		function get gridHeight():Number;
		/**
		 * 网格屏幕宽
		 */
		function get gridWidth():Number;
		/**
		 * 网格3d坐标系中x轴偏移量
		 */
		function get isoXOffset():Number;
		/**
		 * 网格3d坐标系中z轴偏移量
		 */
		function get isoZOffset():Number;
	}
}
package examples.animation.interfaces
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * 坐标转换接口
	 * 
	 */
	public interface ICoordinate 
	{
		/**
		 * 鼠标位置转换成地图格子索引
		 * @param p_mouse_x	鼠标位置
		 * @param p_mouse_y	鼠标位置
		 * @return			地图格子索引
		 */
		function mouseToGrid(p_mouse_x : Number, p_mouse_y : Number) : Point;
		
		/**
		 * 地图格子索引转换成鼠标位置
		 * @param p_mouse_x	地图格子索引
		 * @param p_mouse_y	地图格子索引
		 * @return			鼠标位置
		 */
		function gridToMouse(p_grid_x: int,p_grid_y: int): Point;
		
		/**
		 * 获取地图两格子的方向
		 * @param p_start_x	开始地图格子索引
		 * @param p_start_y	开始地图格子索引
		 * @param p_end_x   结束地图格子索引
		 * @param p_end_y   结束地图格子索引
		 * @return			相对方向(八方向-->"down","rightDown","right","rightUp","up","leftUp","left","leftDown")
		 */
		 function getDirection(p_start_x: int, p_start_y: int, p_end_x: int, p_end_y: int): String;	
		 
		 /**
		 * 创建对应的图层Sprite
		 * @param _width	图层宽度
		 * @param _height	图层高度
		 * @return			图层
		 */
		 function createLayer(_width: int, _height: int): Sprite;
		 
		 function gridCenter(p_grid_x: int,p_grid_y: int): Point;
	}	
}
package examples.animation.geom.isolib.map.data
{
	import examples.animation.geom.isolib.isometric.IsoUtils;
	import examples.animation.geom.isolib.isometric.Point3D;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.PerspectiveProjection;
	import flash.geom.Point;

	/**
	 * 
	 * @author pianfeng
	 * 地图相关类,包括坐标系转换等
	 * 可以保存bg图片数据,但不显示
	 * 
	 */	
	public class MapData implements IMapData
	{
		protected var _name:String;//地图名
		protected var _bgPath:String//背景图片路径
		protected var _BG:BitmapData;//背景图片
		protected var _gridCols:int;//路点格子z轴列数
		protected var _gridRows:int;//路点格子x轴行数
		protected var _cellSize:Number//菱形格子的短对角线2d长度;
		protected var _bgWidth:Number;//背景图片2d宽度
		protected var _bgHeight:Number;//背景图片2d高度
		protected var _data:Array;//路点矩阵集合
		protected var _isoXOffset:Number;//x轴偏移量
		protected var _isoZOffset:Number;//z轴偏移量	
		/**
		 * @param name	地图名
		 * @param gridCols	路点网格x轴列数
		 * @param gridRows   路点网格z轴行数
		 * @param cellSize   菱形块短对角线屏幕长度
		 * @param bgWidth    背景宽
		 * @param bgHeight   背景高
		 * @param bgPath   背景图路径
		 */
		public function MapData(xml:XML)
		{
			this._name=xml.@name;
			this._gridCols=xml.@mapW;
			this._gridRows=xml.@mapH;
			this._cellSize=xml.@cellW;
			this._bgWidth=xml.@bgWidth;
			this._bgHeight=xml.@bgHeight;
			this._bgPath=xml.@bgPath;
			//加载矩阵数据
			loadGridData(xml);
			//更新坐标系原点便宜量
			var p3d:Point3D=IsoUtils.screenToIso(new Point(this._bgWidth>>1,this._bgHeight-this._cellSize*this._gridRows>>1));
			this._isoXOffset=p3d.x;
			this._isoZOffset=p3d.z;
		}
		/**
		 * 
		 * 读取矩阵数据
		 * @param xml	导入的xml文件信息
		 * 
		 */		
		protected function loadGridData(xml:XML):void
		{
			this._data=[];
			
			for(var i:int=0;i<xml.grids.children().length();i++)
			{
				var str:String=xml.grids.x[i];
				var arr:Array=str.split(",");
				var tempArr:Array=[];
				for(var j:int=0;j<arr.length;j++)
				{
					var tile:Tile=new Tile(j,i,arr[j]);
					tempArr.push(tile);
				}
				
				this._data.push(tempArr);
			}
		}
		/**
		 * 根据x,z索引得到该位置的路点,可以先调用getPointOverRide(x:int,z:int)函数判断是否越界
		 * @param x x轴格子索引
		 * @param z z轴格子索引
		 * @return	该格子所代表的地图标号
		 */
		public function getTileAtGrid(x:int,z:int):Tile
		{
			return this._data[z][x] as Tile;
		}
		/**
		 * 根据路点值查询路点集合
		 * @param obj	路点对象包含的值
		 * @return 
		 * 此方法频繁调用效率低下
		 */
		public function getTilesByData(data:Object=null):Array
		{
			if(!data)
				return this._data.concat();
			
			var arr:Array=[];
			
			for(var i:int=0;i<this._data.length;i++)
			{
				for(var j:int=0;j<this._data[0].length;j++)
				{
					if((this._data[i][j] as Tile).getData()===data)
						arr.push(this._data[i][j]);
				}
			}
			
			return arr;
		}
		/**
		 * 判断指定的点是否越界
		 * @param x x轴索引
		 * @param z z轴索引
		 * @return 	如果越界则返回true,否则返回false
		 */		
		public function getPointOverRide(x:int,z:int):Boolean
		{
			if(x<0||x>this._gridCols-1||z<0||z>this._gridRows-1)
				return true;
			else
				return false;
		}
		/**
		 * 根据屏幕坐标求网格坐标
		 */
		public function screenToGrid(p:Point):Point
		{
			var p3d:Point3D=IsoUtils.screenToIso(p);
			var p2d:Point=new Point();
			p2d.x=Math.floor((p3d.x-this._isoXOffset+this._cellSize/2)/this._cellSize);
			p2d.y=Math.floor((p3d.z-this._isoZOffset+this._cellSize/2)/this._cellSize);
			return p2d;
		}
		/**
		 * 根据网格坐标求屏幕坐标
		 */
		public function GridToScreen(p:Point):Point
		{
			var p3d:Point3D=new Point3D(p.x*this._cellSize+_isoXOffset,0,p.y*this._cellSize+_isoZOffset);
			var p2d:Point=IsoUtils.isoToScreen(p3d);
			return p2d;
		}
		/**
		 * 地图名
		 */	
		public function get name():String
		{
			return this._name;
		}
		/**
		 * 背景图路径
		 */			
		public function get bgPath():String
		{
			return this._bgPath;
		}	
		/**
		 * 背景宽
		 */	
		public function get bgWidth():Number
		{
			return this._bgWidth;
		}
		/**
		 * 背景高
		 */			
		public function get bgHeight():Number
		{
			return this._bgHeight;
		}
		/**
		 * 设置背景图片
		 */	
		public function set BG(value:BitmapData):void
		{
			this._BG=value;
			this._bgWidth=value.width;
			this._bgHeight=value.height;
		}
		/**
		 * 路点矩阵
		 */	
		public function get data():Array
		{
			return this._data.concat();
		}
		/**
		 * 菱形格子的短对角线2d长度;
		 */	
		public function get cellSize():Number
		{
			return this._cellSize;
		}
		/**
		 * 露点网格列数
		 */
		public function get gridCols():int
		{
			return this._gridCols;
		}
		/**
		 * 露点网格行数
		 */
		public function get gridRows():int
		{
			return this._gridRows;
		}
		/**
		 * 网格屏幕高
		 */
		public function get gridHeight():Number
		{
			return this._cellSize*this._gridRows;
		}
		/**
		 * 网格屏幕宽
		 */
		public function get gridWidth():Number
		{
			return 2*this._cellSize*this._gridCols;
		}
		/**
		 * 网格3d坐标系中x轴偏移量
		 */
		public function get isoXOffset():Number
		{
			return this._isoXOffset;
		}
		/**
		 * 网格3d坐标系中z轴偏移量
		 */
		public function get isoZOffset():Number
		{
			return this._isoZOffset;
		}
	}
}
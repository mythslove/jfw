package app.battle.utils
{
	import com.jfw.engine.isolib.map.consts.DirectionConst;
	import com.jfw.engine.isolib.map.data.IMapData;
	import com.jfw.engine.isolib.map.data.MapData;
	import com.jfw.engine.isolib.map.data.Tile;
	
	import flash.geom.Point;

	public class SphereMetrics
	{
		/**
		 * 法术作用范围
		 * @param mapdata 地图信息
		 * @param source 配置数据格式为"x,y|x,y|x,y"
		 * @param gridx 原点位置
		 * @param gridy
		 * @param direct
		 * @return 如果无值范围null
		 * 
		 */	
		public static function getSphereOfMagic(mapdata:IMapData,source:String,gridx:int,gridy:int,direct:String):Vector.<Tile>
		{
			var arr:Array=source.split('|');
			var result:Vector.<Tile>=null;
			var xResult:int;
			var yResult:int;
			
			for(var i:int=0,j:int=arr.length;i<j;i++)
			{
				var pArr:Array=arr[i].toString().split(',');
				
				switch(direct)
				{
					case DirectionConst.RIGHT:
						xResult=-Number(pArr[1]);
						yResult=Number(pArr[0]);
						break;	
					case DirectionConst.DOWN:
						xResult=-Number(pArr[0]);
						yResult=-Number(pArr[1]);
						break;
					case DirectionConst.LEFT:
						xResult=Number(pArr[1]);
						yResult=-Number(pArr[0]);
						break;
					default:
						xResult=Number(pArr[0]);
						yResult=Number(pArr[1]);
				}
				
				xResult+=gridx;
				yResult+=gridy;
				
				if(!mapdata.checkPointOverRide(xResult,yResult))
				{
					if(result==null)
						result=new Vector.<Tile>();

					result.push(mapdata.getTileAtGrid(xResult,yResult));
				}
			}
			
			return result;
		}
		/**
		 * 技能影响范围
		 * @param mapdata
		 * @param gridx
		 * @param gridy
		 * @param length 圈数
		 * @return 无有效值返回null
		 * 
		 */		
		public static function getSphereOfSkill(mapdata:IMapData,gridx:int,gridy:int,length:int=1):Vector.<Tile>
		{
			var startX:int = Math.max(0, gridx - length);
			var endX:int = Math.min(mapdata.gridCols - 1, gridx + length);
			var startY:int = Math.max(0, gridy - length);
			var endY:int = Math.min(mapdata.gridRows - 1, gridy + length);
			var result:Vector.<Tile>=null;
			
			for(var i:int=startX;i<endX;i++)
			{
				for(var j:int=startY;j<endY;j++)
				{
					if(!mapdata.checkPointOverRide(i,j))
					{
						if(result==null)
							result=new Vector.<Tile>();

						result.push(mapdata.getTileAtGrid(i,j));
					}
				}
			}
			
			return result;
		}
	}
}
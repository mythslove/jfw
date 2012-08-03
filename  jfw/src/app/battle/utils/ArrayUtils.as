package app.battle.utils
{
	public class ArrayUtils
	{
		/**
		 * 生成多维数组 
		 * @param args 每位的数字表示该纬度数组的长度
		 * @return 
		 * 
		 */		
		static public function CreateMutiArray(...args):Array
		{
			if(args.length>3)
				throw new Error("can not create array of 3dimensiona");
			else
				return CreateArray(args);
			
			function CreateArray(arr:Array,resArr:Array=null,index:int=0):Array
			{
				if(resArr==null)resArr=[];
				
				var j:int=arr[index];	
				if(j==0)throw new Error("number can not be 0");
				
				for(var i:int=0;i<j;i++)
				{
					if(index==arr.length-1)
					{
						resArr.push(null);
					}
					else
					{
						resArr.push(CreateArray(arr,null,index+1));
					}
				}
				
				return resArr;
			}
		}
		/**
		 * 根据对象属性排序，用于非索引对象集合的排序，取副本
		 * @param arr
		 * @param attr
		 * @param desc true从小到大排
		 * @return 
		 * 
		 */		
		static public function SortOn(arr:Array,attr:String,desc:Boolean=true):Array
		{
			var result:Array=[];
			
			for each(var obj:Object in arr)
			{
				result.push(obj);
			}

			result.sortOn(attr,Array.NUMERIC);
		
			if(!desc)
				result.reverse();
			
			return result;
		}
		/**
		 * 随机排序 
		 * @param _arr
		 * @return 
		 * 
		 */		
		static public function RandArray(_arr:Array):Array 
		{
			var rand:Function=function():int
			{
				var i:Number=Math.random()-0.5;
				
				if(i<0)
					return -1;
				else
					return 1;
			};
				
			var _ar:Array=_arr.slice();
			_ar.sort(rand);
			return _ar;
		}

		/**
		 * 把一个array里的元素按前缀分组成array
		 * @param arr
		 * @return arr
		 * 
		 */		
		static public function CovertArrayToGroup(arr:Array,reg:String):Array
		{
			var result:Array=[];
			
			for(var i:int=0,j:int=arr.length;i<j;i++)
			{
				var name:String=arr[i].toString().split(reg)[0];
				
				if(result[name]==null)
					result[name]=[arr[i]];
				else
					result[name].push(arr[i]);
			}
			
			return result;
		}
		/**
		 * 把一个array里的元素按前缀分组成xml
		 * @param arr
		 * @return xml
		 * 
		 */		
		static public function CovertArrayToXML(arr:Array,reg:String):XMLList
		{
			var result:XMLList=new XMLList(<note/>);
			
			for(var i:int=0,j:int=arr.length;i<j;i++)
			{
				var name:String=arr[i].toString().split(reg)[0];
				
				if(result.elements(name).length()==0)	
					result.appendChild(<{name}/>);
				
				var xml:XML=result.elements(name)[0];
				xml.appendChild(<name>{arr[i]}</name>);
			}
			
			return result;
		}
	}
}
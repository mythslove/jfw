package app.manager
{
	import flash.display.Bitmap;

	public class AnimationSource
	{
		public var className:String;
		public var callBackArr:Array=null;
		
		public function AnimationSource(className:String,callBack:Function)
		{
			this.className=className;
			
			if(callBackArr==null)
				callBackArr=[];
			
			callBackArr.push(callBack);
		}
		
		public function dispose():void
		{
			if(callBackArr)
			{
				for each(var call:Function in callBackArr)
				{
					call=null;
				}
				
				callBackArr=null;
			}
		}
	}
}
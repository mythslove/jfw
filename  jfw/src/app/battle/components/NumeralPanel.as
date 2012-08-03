package app.mvc.views.components
{
	import app.mvc.models.res.BattleDataProxy;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import org.puremvc.as3.patterns.facade.Facade;

	/**
	 *战斗数字显示类 
	 * @author PianFeng
	 * 
	 */	
	public class NumeralPanel extends Sprite
	{
		private var battleDataProxy:BattleDataProxy;
		private var arr:Array=[];
		private var sign:Bitmap=null;
		private var signOffset:int=0;
		
		public function NumeralPanel()
		{
			super();
			battleDataProxy=Facade.getInstance().retrieveProxy(BattleDataProxy.NAME) as BattleDataProxy;
		}
		/**
		 * 添加数字 
		 * @param operater 操作符true为+,false为-
		 * @param number 数字
		 * @param color 颜色0:红色,1:绿色,2:黄色
		 * 
		 */		
		public function addNewNumber(opt:Boolean=true,num:String="0",color:int=0):void
		{
			signOffset=12*color;//绿色
			
			if(opt)
				sign=battleDataProxy.getBitmapByName("num_"+(10+signOffset));
			else
				sign=battleDataProxy.getBitmapByName("num_"+(11+signOffset));
			
			this.arr.push(sign);
			this.addChild(sign);
			
			for(var i:int=0;i<num.length;i++)
			{
				var number:String=num.charAt(i);
				var bit:Bitmap=battleDataProxy.getBitmapByName("num_"+(int(number)+signOffset));
				this.arr.push(bit);
				this.addChild(bit);
				bit.x=(this.arr.length-1)*bit.width;
			}
		}
		
		public function dispose():void
		{
			for each(var b:Bitmap in this.arr)
			{
				b.bitmapData.dispose();
				this.removeChild(b);
				b=null;
			}
		}
	}
}
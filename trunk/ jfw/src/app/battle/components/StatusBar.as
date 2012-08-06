package app.battle.components
{

	import app.battle.interfaces.IRole;
	
	import com.jfw.engine.core.base.IDestory;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	/**
	 * 角色血条 
	 * @author PianFeng
	 * 
	 */	
	public class StatusBar extends Sprite implements IDestory
	{
		private var char:IRole=null;
		private var lvText:TextField;
		private var eleText:*;
		private var maxNum:Number=100;
		private var minNum:Number=0;
		private var currNum:Number=100;
		private var hpBg:*;
		private var hpBar:*;
		
		public function StatusBar(char:IRole,maxNum:Number,minNum:Number,currNum:Number,level:int,ele:int)
		{
			super();
			
//			this.char=char;
//			
//			this.hpBg=battleDataProxy.getDisplayObjectByName("statusbg");
//			
//			if(char.Camps==CharactorConst.SELF||char.Camps==CharactorConst.DEFEND)
//				this.hpBar=battleDataProxy.getDisplayObjectByName("statusbar_green");
//			else if(char.Camps==CharactorConst.IMPARTIAL)
//				this.hpBar=battleDataProxy.getDisplayObjectByName("statusbar_yellow");
//			else
//				this.hpBar=battleDataProxy.getDisplayObjectByName("statusbar_red");
//
//			this.eleText=battleDataProxy.getDisplayObjectByName("ele_"+ele.toString());
//			this.maxNum=maxNum;
//			this.minNum=minNum;
//			this.currNum=currNum;	
//			this.lvText=GameUtils.getTextField(char.Camps);
//			this.lvText.text="Lv:"+level.toString();
//			this.lvText.selectable=false;
//			
//			this.addChild(this.lvText);
//			this.addChild(this.eleText);
//			this.addChild(this.hpBg);
//			this.addChild(this.hpBar);
//			this.hpBg.gotoAndStop(1);
//			this.hpBar.gotoAndStop(1);
//			this.eleText.gotoAndStop(1);
//			
//			resize();
//			
//			this.mouseChildren=false;
//			this.mouseEnabled=false;
		}
		
		private function resize():void
		{
			this.lvText.x=0;
			this.hpBg.x=this.lvText.textWidth+3;
			this.hpBg.y=7;
			this.hpBg.scaleY=0.8;
			this.hpBar.x=this.hpBg.x+1;
			this.hpBar.y=8;
			this.hpBar.scaleX=percent;
			this.hpBar.scaleY=0.8;
			this.eleText.x=this.hpBg.x+this.hpBg.width;
		}
		
		private function get percent():Number
		{
			if(this.currNum>this.maxNum)
				return 1;
			
			if(this.currNum<this.minNum)
				return 0;
			
			return this.currNum/(this.maxNum-this.minNum);
		}
		
		public function move(x:Number,y:Number):void
		{
			this.x=x;
			this.y=y;
		}
		
		public function set currentHp(value:Number):void
		{
			this.currNum=value;
			resize();
		}
		
		public function set Level(value:int):void
		{
			this.lvText.text="Lv:"+value.toString();
			resize();
		}
		
		
		public function destroy():void
		{
		}
	}
}
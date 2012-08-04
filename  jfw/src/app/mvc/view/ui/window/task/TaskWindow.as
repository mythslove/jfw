package app.mvc.view.ui.window.task
{
	import app.mvc.view.ui.component.TabStruct;
	import app.mvc.view.ui.window.spell.SpellTab;
	
	import com.jfw.engine.core.data.IStruct;
	import com.jfw.engine.core.mvc.view.BWindow;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	/**
	 *  任务活动面板
	 * @author 
	 * 
	 */	
	public class TaskWindow extends BWindow
	{
		
		public var $mcTaskPanel:MovieClip;
		private var TaskPanelContaner:Sprite = null;
		
		private var TaskPanel:TaskTabPanel = null;
		
		private var dataList:Array = null;
		private var TaskPanelMask:Shape = null;
		private var TaskPanelEffect:Bitmap = null;
		
		public function TaskWindow( )
		{
			super();
			x = y = 0;
		}
		
		override protected function onInit():void
		{
			super.onInit();
			
			//创建标签页和关联的面板
			createTabContentContainer();
			
		}
		
		
		/**
		 * 标签页面板 
		 * 
		 */
		private function createTabContentContainer():void
		{
			TaskPanelContaner = new Sprite();
			
			var tabfactory:Vector.<TabStruct> = new Vector.<TabStruct>();
			tabfactory.push(new TabStruct( { label:'每日任务',type:1,cls:TaskContainerDaily } ) ); 
			tabfactory.push(new TabStruct( { label:'主线任务',type:2,cls:TaskContainerMain } ) ); 
			tabfactory.push(new TabStruct( { label:'循环任务',type:3,cls:TaskContaineCycle } ) ); 
			
			TaskPanel = new TaskTabPanel( this.$mcTaskPanel,null,tabfactory,SpellTab );
			TaskPanelContaner.addChild( TaskPanel );
			
			TaskPanelMask = new Shape();
			TaskPanelMask.x = TaskPanelContaner.x;
			TaskPanelMask.y = TaskPanelContaner.y;
			TaskPanelMask.graphics.beginFill( 0xFF00FF, 0.5 );
			TaskPanelMask.graphics.drawRect( 0, 0, $mcTaskPanel.width, $mcTaskPanel.height );
			TaskPanelMask.graphics.endFill();
			TaskPanelContaner.mask = TaskPanelMask;
			
			TaskPanelEffect = new Bitmap();
			TaskPanelEffect.bitmapData = new BitmapData( TaskPanelContaner.width, TaskPanelContaner.height, true, 0 );
			TaskPanelContaner.addChild( TaskPanelEffect );
			
			addChildAt( TaskPanelContaner , 1 );
			addChildAt( TaskPanelMask, 2 );
		}
	}
}
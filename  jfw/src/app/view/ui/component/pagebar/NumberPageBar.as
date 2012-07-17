package app.view.ui.component.pagebar
{
	import com.jfw.engine.core.data.IStruct;
	import com.jfw.engine.core.mvc.view.BPanel;
	
	import flash.display.MovieClip;
	
	public class NumberPageBar extends BPanel
	{
		
		public var $pbPrevButton:MovieClip = null;
		public var $pbNextButton:MovieClip = null;
		
		public function NumberPageBar(cls_ref:Object=null, data:IStruct=null)
		{
			super(cls_ref, data);
		}
	}
}
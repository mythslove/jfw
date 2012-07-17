package app.view.init
{
	import app.model.data.ProgressDataStruct;
	import app.model.events.LoadingEvent;
	import app.model.events.ModelEvent;
	
	import com.jfw.engine.core.data.IStruct;
	import com.jfw.engine.core.mvc.view.BSprite;
	import com.jfw.engine.utils.FontUtil;
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	/** loading */
	public class LoadingView extends BSprite
	{
		public var $mcProgressBar:MovieClip = null;
		public var $txProgressBar:TextField = null;
		
		public function LoadingView(cls_ref:Object=null, data:IStruct=null)
		{
			super(cls_ref, data);
		}
		
		override protected function onInit( ):void
		{
			
		}
		
		override protected function listEventInterests():Array
		{
			return [
				LoadingEvent.LOADING_PROCESS
			];
		}
		
		override protected function handleEvent(evt:String, param:Object):void
		{
			switch( evt )
			{
				case LoadingEvent.LOADING_PROCESS:
					var progressVO:ProgressDataStruct = ProgressDataStruct( param );
					this.$mcProgressBar.gotoAndStop( progressVO.percent );
					FontUtil.setText( this.$txProgressBar, progressVO.percent.toString() + '%' + '(' + progressVO.description + ')' );
					break;
			}
		}
		
		override public function destroy( ):void
		{
			$mcProgressBar = null;
			$txProgressBar = null;
			
			super.destroy();
		}
	}
}
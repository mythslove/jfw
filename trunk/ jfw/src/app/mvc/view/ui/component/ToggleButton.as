package app.mvc.view.ui.component
{

	import app.mvc.view.ui.component.interfaces.IToggleItem;
	
	import com.jfw.engine.core.mvc.view.BPanel;
	import com.jfw.engine.utils.FilterUtil;
	import com.jfw.engine.utils.FontUtil;
	
	import flash.text.TextField;
	
	public class ToggleButton extends BPanel implements IToggleItem
	{
		static public const DEFAULT:int = 1;
		static public const OVER:int = 3;
		static public const SELECTED:int = 2;
		
		protected var _selected:Boolean;
		protected var count:int;
		
		public var $txName:TextField = null;
		public var $txCount:TextField = null;
		
		public function ToggleButton( label:String )
		{
			FontUtil.setText( $txName, label );
			if( $txCount )
				FilterUtil.setTextLightBorder( $txCount );
			buttonMode = true;
		}
		
		public function set selected(value:Boolean):void
		{
			_selected = value;
			buttonMode = !_selected; 
			updateBg( );
		}
		
		protected function updateBg( ):void
		{
			var frame:int = selected ? SELECTED : DEFAULT; 
			this.$mcBg.gotoAndStop( frame );
		}
		
		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function setCount(value:int):void
		{
			count = value;
			if( value != 0 )
			{
				FontUtil.setText( $txCount, value );
			}else
			{
				FontUtil.setText( $txCount, '' );
			}
		}
		
		public function getCount():int
		{
			return count;
		}
	}
}
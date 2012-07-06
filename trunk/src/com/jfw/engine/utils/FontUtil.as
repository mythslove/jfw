package com.jfw.engine.utils
{
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;

	public class FontUtil
	{
		
		/**
		 * 为TextField设置文字
		 *  
		 * @param txtField
		 * @param str
		 * @param bold
		 * @param color
		 * @param isHtml
		 * 
		 * embedFonts:Boolean = true,
		 */
		static public function setText( txtField:TextField, str:Object, tf:TextFormat = null,isHtml:Boolean=false ,showBorder:Boolean = true,borderColor:uint=0x0,borderSize:int = 2):void
		{
			
			if ( TextFieldType.INPUT != txtField.type )
			{
				txtField.selectable = false;
				txtField.mouseEnabled = false;
			}
			else
				txtField.selectable = true;
			
			if ( false != isHtml )
			{
				str = String( str ).replace(/\[red\]/g,"<font color='#ff0000'>");
				str = String( str ).replace(/\[\/red\]/g,"</font>");
				str = String( str ).replace(/\[yellow\]/g,"<font color='#FFCD00'>");
				str = String( str ).replace(/\[\/yellow\]/g,"</font>");
				str = String( str ).replace(/\[green\]/g,"<font color='#00ff00'>");
				str = String( str ).replace(/\[\/green\]/g,"</font>");
				str = String( str ).replace(/\[b\]/g,"<b>");
				str = String( str ).replace(/\[\/b\]/g,"</b>");
				str = String( str ).replace(/\\n/g,'<br/>');
				txtField.htmlText = String( str );
			}
			else
			{
				str = String( str ).replace(/\\n/g,'');
				txtField.text = String( str );
			}
			
			if( false != showBorder )
				FilterUtil.setFontFilter( txtField,borderColor,borderSize );
			
			if(null != tf)
				txtField.setTextFormat(tf);
			else
				txtField.setTextFormat( new TextFormat("微软雅黑",13) ); 
		}
	}
}
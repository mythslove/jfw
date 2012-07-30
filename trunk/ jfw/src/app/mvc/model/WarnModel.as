package app.mvc.model
{
	import com.jfw.engine.core.mvc.model.BModel;
	
	/**
	 * 系统错误消息
	 * 
	 */	
	public class WarnModel extends BModel
	{
		static public const NAME:String = 'WarnModel';
		
		public function WarnModel(mName:String=null)
		{
			super( NAME );
		}
		
		/**
		 * 获取错误信息 
		 * 
		 * @param errno
		 * @return 
		 */
		public function getError(errno:int):String
		{
			if(errno)
			{
				CONFIG::debug {
					return '[ERR: ' + errno + '] ' + this.core.assetsModel.getXML('warn').i.(@code == errno);
				}
				return this.core.assetsModel.getXML('warn').i.(@code == errno);
			}
			return null;
		}
	}
}
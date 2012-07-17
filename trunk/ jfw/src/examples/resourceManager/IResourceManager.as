package examples.resourceManager
{
	public interface IResourceManager
	{
		function loadRes( clsName:String,callBack:Function = null ):void;
	}
}
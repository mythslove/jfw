package app.mvc.view.ui.component.pagebar
{
	/** 分页条接口 */
	public interface IPageBar
	{
		//设置当前页数
		function goto( page:int ):void;
		
		//获取最大页数
		function get max():int;
		
		//设置最大页数
		function set max( len:int ):void;
		
		//设置更新方法
		function setUpdateFun( updateFun:Function ):void;
	}
}
package com.jfw.engine.core.mvc.model
{
	import com.jfw.engine.core.base.Core;
	import com.jfw.engine.core.base.Observable;
	import com.jfw.engine.core.data.IStruct;
	
	import flash.utils.getQualifiedClassName;

	/** 所有子 model 的基类  */
	public class BModel implements IModel
	{
		/** model名称 */
		protected var modelName:String;
		
		/** model数据 */
		protected var modelData:IStruct;
		
		/** 核心单例类 */
		protected var core:Core = null;
		
		public function BModel( mName:String = null )
		{
			if( mName != null )
				modelName = mName;
			else
				modelName = sign.substr( sign.lastIndexOf("::") + 2 );
			
			core = Core.getInstance( );
			
			//自动注册model
			core.regModel( this );
		}
		
		public function sendEvent( evt:String, param:Object=null ):void
		{
			Observable.getInstance().sendEvent( evt,param );
		}
		
		public function get sign():String
		{
			return getQualifiedClassName( this );
		}
		
		public function getModelName():String
		{
			return this.modelName;
		}
		
		public function onRegister():void
		{
			
		}
		
		public function onRemove():void
		{
			
		}
		
		public function set data( v:IStruct ):void
		{
			modelData = v;
		}
		
		public function get data():IStruct
		{
			return modelData;
		}
	}
}
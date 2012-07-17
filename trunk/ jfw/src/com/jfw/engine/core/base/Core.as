package com.jfw.engine.core.base
{
	import com.jfw.engine.core.mvc.model.IAssetModel;
	import com.jfw.engine.core.mvc.model.IConfigModel;
	import com.jfw.engine.core.mvc.model.IModel;

	public class Core
	{
		protected static const SINGLETON_MSG:String = '';
		
		/** 核心类实例 */
		protected static var instance:Core
		
		/** 数据模型字典 */
		protected var modelMap:Object = { };
		
		/** 静态资源库引用 */
		protected var assetsLibModel:IAssetModel = null;
		
		/** 配置文件 */
		protected var configLibModel:IConfigModel = null;
		
		public function Core()
		{
			if ( null != instance ) 
				throw Error( SINGLETON_MSG );
			instance = this;
		}
		
		public static function getInstance():Core
		{
			if ( null == instance )
				instance = new Core();
			return instance as Core;
		}
		
		/** 获取配置文件 */
		public function get configModel():IConfigModel
		{
			if( this.configLibModel )
				return this.configLibModel;
			else
			{
				for each( var model:* in modelMap )
				{
					if( model is IConfigModel )
					{
						this.configLibModel = model as IConfigModel;
						return model;
					}
				}
			}
			return null;
		}
		
		/** 获取静态资源model */
		public function get assetsModel():IAssetModel
		{
			if( this.assetsLibModel )
				return this.assetsLibModel;
			else
			{
				for each( var model:* in modelMap )
				{
					if( model is IAssetModel )
					{
						this.assetsLibModel = model as IAssetModel;
						return model;
					}
				}
			}
			return null;
		}
		
		/** 添加model */
		public function regModel(model:IModel):void
		{
			modelMap[ model.getModelName() ] = model;
			model.onRegister();
			
			trace( model.getModelName() , "<<<: Reg Model");
		}
		
		/** 删除model */
		public function delModel( modelName:String ):IModel
		{
			var model:IModel = modelMap[ modelName ] as IModel;
			if( model )
			{
				modelMap[ modelName ] = null;
				model.onRemove();
			}
			return model;
		}
		
		/** 获取model */
		public function retModel( modelName:String ):IModel
		{
			return modelMap[ modelName ];
		}
		
		/** 检查model是否已经注册 */
		public function hasModel( modelName:String ):Boolean
		{
			return modelMap[ modelName ] != null;
		}
	}
}
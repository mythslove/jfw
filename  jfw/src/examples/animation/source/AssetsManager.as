package examples.animation.source
{
	import com.jfw.engine.animation.BmdAtlas;
	import com.jfw.engine.animation.Texture;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;

	public class AssetsManager
	{
		//-----------------------------------------默认图标-----------------------------------------------------//
		
		[Embed(source="unknown.jpg")]
		public var UnknownIcon:Class;
		
		//-----------------------------------------角色素材-----------------------------------------------------//
		
		[Embed(source="Role.png")]
		public var RoleTexture:Class;
		[Embed(source="Role.xml", mimeType="application/octet-stream")]
		public var RoleData:Class;
		
		[Embed(source="3201001.jpg")]
		public var MyMapBg:Class;
		[Embed(source="3201001.xml", mimeType="application/octet-stream")]
		public var MyMapData:Class;
		
		private var _textureAtlasFactory:Object = {};//纹理集缓存
		
		private static var _instance:AssetsManager;
		
		public function AssetsManager()
		{
		}
		
		public static function get Instance():AssetsManager
		{
			return _instance||=new AssetsManager();
		}
		
		/** 获取嵌入资源实例 */
		public function getEmbedResource( className:String ):*
		{
			var result:*;
			if( this.hasOwnProperty(className) )
			{
				var cls:Class = this[className] as Class;
				result = new cls();
			}
			else
			{
				trace("未找到指定名称的嵌入素材");
			}
			return result;
		}
		
		/** 获取指定名称对应的Texture实例 */
		public function getTexture( name:String ):BitmapData
		{
			var bmp:Bitmap = getEmbedResource( name ) as Bitmap;
			
			if( bmp )
			{
				return bmp.bitmapData;
			}
			return null;
		}
		
		/** 获取指定名称对应的TextureAtlas实例 */
		public function getTextureAtlas( name:String ):BmdAtlas
		{
			var result:BmdAtlas = _textureAtlasFactory[name];
			
			if( result )
			{
				return result;
			}
			
			var tBMP:Bitmap = getEmbedResource( name + "Texture" ) as Bitmap;
			var tXML:XML = XML(getEmbedResource( name + "Data" ));
			
			if( tBMP && tXML )
			{
				result = new BmdAtlas(tBMP.bitmapData, tXML);
				_textureAtlasFactory[name] = result;
			}
			
			return result;
		}
		
		/**
		 * 得到MovieClip所用的一组纹理序列 
		 * @param textureAtlasName	所用纹理序列所在的TextureAtlas对象名
		 * @param texturesPrefix	所用纹理序列统一前缀名
		 */		
		public function getMCTextures(textureAtlasName:String, texturesPrefix:String):Vector.<Texture>
		{
			var result:Vector.<Texture>;
			var atlas:BmdAtlas = getTextureAtlas(textureAtlasName);
			
			if( atlas )
			{
				result = atlas.getTextures(texturesPrefix);
			}
			
			return result;
		}
	}
}
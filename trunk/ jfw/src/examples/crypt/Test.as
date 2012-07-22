package examples.crypt
{
	import flash.display.Sprite;

	
	public class Test extends Sprite
	{
		
		private const seed:Array = [
			0xD83EFCAB,
			0xB34CABE6,
			0xF74ECAB8,
			0xCABBC2A3,
			0xBACF0CD9,
			0xDFBB07F9,
			0xC66FACB8,
			0xB1F9DE96,
			0xAB95CCAB,
			0xB1F9DE96
		];
		
		public function Test()
		{
			for( var i:int = 0; i < 1000 ; i++ )
			{
				trace( i % 10,seed[ i % 10 ] );
				
			}
		}
	}
}
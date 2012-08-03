package app.battle.utils
{
	import com.hurlant.crypto.Crypto;
	import com.hurlant.crypto.symmetric.ICipher;
	import com.hurlant.util.Base64;
	
	import flash.utils.ByteArray;

	public class DesHelper
	{
		public static var DESKEY:String="11223399";
		
		public function DesHelper()
		{
		}
		
		public static function Encrypt(encryptStr:String):String
		{
			var deskey:ByteArray = new ByteArray();
			
			deskey.writeUTFBytes(DESKEY);			

			var des:ICipher = Crypto.getCipher("des-ecb", deskey, Crypto.getPad("pkcs5")); 

			var encryptArr:ByteArray = new ByteArray();
			
			encryptArr.writeUTFBytes(encryptStr);
			
			encryptArr.position=0;
			
			des.encrypt(encryptArr);
			
			encryptArr.position=0;
			
			var outStr:String = Base64.encodeByteArray(encryptArr);

			return outStr;
		}
		
		public static function Decrypt(decryptStr:String):String
		{
			var deskey:ByteArray = new ByteArray();
			
			deskey.writeUTFBytes(DESKEY);
			
			var des:ICipher = Crypto.getCipher("des-ecb", deskey, Crypto.getPad("pkcs5")); 

			var decryptArr:ByteArray = Base64.decodeToByteArray(decryptStr);

			decryptArr.position=0;
			
			des.decrypt(decryptArr);
			
			decryptArr.position=0;
			
			var outStr:String = decryptArr.readUTFBytes(decryptArr.length);
			
			return outStr;
			
		} 
	}
}
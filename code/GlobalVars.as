package code
{
	import flash.display.Stage;
	
	public class GlobalVars
	{
	
		
		public function GlobalVars()
		{
		
		}
		
		public static function setPath(path:String)
		{
			Stage.prototype.fpath = path;
		}

		
		public static function getPath():String
		{
			if (Stage.prototype.fpath != null)
			{
				return Stage.prototype.fpath as String;
			}
			else
			{
				return "";
			}
		}
		
		public static function getVersion():String
		{
			if (Stage.prototype.version != null)
			{
				return Stage.prototype.version as String;
			}
			else
			{
				return "";
			}
		}
		
		public static function setVserion(version:String)
		{
			Stage.prototype.version = version;
		}
		
		
	}
}
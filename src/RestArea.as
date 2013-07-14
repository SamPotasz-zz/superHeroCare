package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Sam Potasznik
	 */
	public class RestArea extends FlxSprite 
	{
		private static const WIDTH:int = 40;
		private static const HEIGHT:int = 24;
		private static const COLOR:uint = 0xff00cccc;
		
		private static const RATE_LEVELS:Array = [ 2.0, 0.3, 0.1 ];
		
		private var _rate:Number;
		
		public function RestArea() 
		{
			makeGraphic( WIDTH, HEIGHT, COLOR );
			
			_rate = RATE_LEVELS[ FlxG.level ];
		}
		
		public function get rate():Number 
		{
			return _rate;
		}
		
	}

}
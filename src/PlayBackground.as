package  
{
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Sam Potasznik
	 */
	public class PlayBackground extends FlxSprite 
	{
		[Embed( source = "../assets/levelBG.png" )]
		private var BackgroundImage:Class;
		
		private static const ALPHA:Number = 0.58;
		
		public function PlayBackground() 
		{
			loadGraphic( BackgroundImage );
			alpha = ALPHA;
		}
		
	}

}
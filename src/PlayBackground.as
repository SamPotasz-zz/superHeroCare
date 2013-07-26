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
		
		[Embed( source = "../assets/titleBG.png" )]
		private var TitleBGImage:Class;
		
		private static const ALPHA:Number = 0.58;
		
		public function PlayBackground( level:Boolean = true ) 
		{
			if( level )
				loadGraphic( BackgroundImage );
			else
				loadGraphic( TitleBGImage );
				
			alpha = ALPHA;
		}
		
	}

}
package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import states.PlayState;
	
	/**
	 * ...
	 * @author Sam Potasznik
	 */
	public class LandingPad extends FlxSprite 
	{	
		
		
		public function LandingPad( leftSide:Boolean ) 
		{
			super();
			
			//var graphicClass:Class = leftSide ? LeftImage : RightImage;
			//loadGraphic( graphicClass );
			makeGraphic( PlayState.FLOOR_COLS * Main.TILE_SIZE, 3, 0xff154406 );
			
		}
	}
}
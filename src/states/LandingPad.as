package states 
{
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Sam Potasznik
	 */
	public class LandingPad extends FlxSprite 
	{
		public function LandingPad() 
		{
			super();
			makeGraphic( PlayState.FLOOR_COLS * Main.TILE_SIZE, 3 );
		}
	}
}
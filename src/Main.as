package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import org.flixel.*;
	import states.PlayState;
	import states.TitleState;
	import states.WinState;
	
	/**
	 * ...
	 * @author Sam Potasznik
	 */
	public class Main extends FlxGame 
	{	
		public static const TILE_SIZE:int = 8;
		
		public static const NUM_ROWS:int = 18 * 2;
		public static const NUM_COLS:int = 13 * 2;
		
		public static const GAME_WIDTH:int = TILE_SIZE * NUM_COLS; 	//208
		public static const GAME_HEIGHT:int = TILE_SIZE * NUM_ROWS; //288
		
		[SWF( width = "416", height = "576" )]
		public function Main():void 
		{
			super( GAME_WIDTH, GAME_HEIGHT, PlayState, 2 );
		}
	}
	
}
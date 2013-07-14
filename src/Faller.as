package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import states.PlayState;
	
	/**
	 * ...
	 * @author Sam Potasznik
	 */
	public class Faller extends FlxSprite 
	{
		public static const SCORES_DEAD_INDEX:int = 0;
		public static const SCORES_SAVED_INDEX:int = 1;
		public static const SCORES_HEALTH_INDEX:int = 2;
		
		private static const WIDTH:int = 6;
		private static const HEIGHT:int = 6;
		private static const COLOR:uint = 0xffffff00;
		
		public function Faller() 
		{
			makeGraphic( WIDTH, HEIGHT, COLOR );
			
			velocity.y = 100;
			acceleration.y = 0; // PlayState.GRAVITY;
		}
		
		override public function update(): void
		{
			super.update();
			
			if ( !onScreen() )
			{
				FlxG.scores[ SCORES_DEAD_INDEX ] += 1;
				( PlayState )( FlxG.state ).updateDeadText();
				kill();
			}
		}
		
		public function onCaught():void 
		{
			FlxG.scores[ SCORES_SAVED_INDEX ] += 1;
			( PlayState )( FlxG.state ).updateSavedText();
			kill();
		}
	}
}
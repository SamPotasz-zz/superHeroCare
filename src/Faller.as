package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import states.LevelStats;
	import states.PlayState;
	
	/**
	 * ...
	 * @author Sam Potasznik
	 */
	public class Faller extends FlxSprite 
	{
		
		private static const WIDTH:int = 6;
		private static const HEIGHT:int = 6;
		private static const COLOR:uint = 0xffffff00;
		
		private var currStats:LevelStats;
		
		public function Faller() 
		{
			makeGraphic( WIDTH, HEIGHT, COLOR );
			
			velocity.y = 100;
			acceleration.y = 0; // PlayState.GRAVITY;
			
			currStats = FlxG.scores[ FlxG.level ];
		}
		
		override public function update(): void
		{
			super.update();
			
			if ( !onScreen() )
			{
				//FlxG.scores[ SCORES_DEAD_INDEX ] += 1;
				currStats.addDead();
				( PlayState )( FlxG.state ).updateDeadText();
				kill();
			}
		}
		
		public function onCaught():void 
		{
			//FlxG.scores[ SCORES_SAVED_INDEX ] += 1;
			currStats.addSaved();
			( PlayState )( FlxG.state ).updateSavedText();
			kill();
		}
	}
}
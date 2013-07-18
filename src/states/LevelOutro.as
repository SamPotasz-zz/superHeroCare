package states 
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author Sam Potasznik
	 */
	public class LevelOutro extends FlxState 
	{
		private static const FALL_NAMES:Array = [ "mice", "dogs and cats", "people" ];
		
		public static const MEDALS:Array = [[ 5, 10, 15 ], [ 10, 20, 30 ], [ 15, 30, 45 ]];
		private static const GOLD_COLOR:uint = 0xfff2d641;
		private static const SILVER_COLOR:uint = 0xffd9d9f3;
		private static const BRONZE_COLOR:uint = 0xffa67d3d;
		
		private static const TEXT_X:int = 10;
			
		private var currStats:LevelStats;
		
		override public function create(): void
		{
			FlxG.bgColor = 0xff000000;
			
			currStats = FlxG.scores[ FlxG.level ];
		
			add( new PlayBackground() );
			
			var saved:FlxText;
			saved = new FlxText( TEXT_X, 24, Main.GAME_WIDTH - 2*TEXT_X, 
				"You saved " + currStats.numSaved + " out of " + 
				currStats.numFallers + " " + FALL_NAMES[ FlxG.level ] + ".");
			saved.setFormat (null, 16, 0xFFFFFFFF );
			add(saved);
			
			var congrats:FlxText;
			congrats = new FlxText( TEXT_X, 112, FlxG.width - 2 * TEXT_X, 
				"Plus yourself." );
			congrats.setFormat (null, 16, 0xFFFFFFFF );
			add( congrats );
			
			var dead:FlxText;
			dead = new FlxText( TEXT_X, 64, FlxG.width - TEXT_X, 
				"And " + currStats.numDead + " fell." );
			dead.setFormat (null, 16, 0xFFFFFFFF );
			//add(dead);
			
			//addMedal();
			
			var instructions:FlxText = new FlxText( 0, Main.GAME_HEIGHT - 64, FlxG.width, "Press SPACE to continue" );
			instructions.setFormat (null, 12, 0xFFFFFFFF, "center" );
			add(instructions);
		}
		
		override public function update():void
		{
			super.update(); // calls update on everything you added to the game loop
 
			if (FlxG.keys.justPressed("SPACE"))
			{
				FlxG.level++;
				if ( FlxG.level >= PlayState.NUM_LEVELS )
				{
					FlxG.switchState( new WinState() );
				}
				else
				{
					FlxG.switchState( new PlayState() );
				}
			}
		} // end function update
		
		private function addMedal(): void
		{
			var medalIndex:int = medalEarnedIndex;
			
			var medalText:FlxText = new FlxText( 0, 124, FlxG.width, "And you earned\n");
			medalText.setFormat (null, 12, 0xFFFFFFFF );
			var medalString:String;
			var medalSprite:FlxSprite = new FlxSprite(( Main.GAME_WIDTH - 10 ) / 2.0, 160 );
			switch( medalIndex )
			{
				case 0: 
				{
					medalString = "\ta bronze medal.";
					medalSprite.makeGraphic( 10, 10, BRONZE_COLOR );
					break;
				}
				case 1: 
				{
					medalString = "\ta silver medal.";
					medalSprite.makeGraphic( 10, 10, SILVER_COLOR );
					break;
				}
				case 2: 
				{
					medalString = "\ta gold medal.";
					medalSprite.makeGraphic( 10, 10, GOLD_COLOR );
					break;
				}
				default:
				{
					medalString = "\tno medal.";
					break;
				}
			}
			medalText.text += medalString;
			add( medalText );
			add( medalSprite );
		}
		
		//returns -1 for no medal earned
		private function get medalEarnedIndex():int
		{
			var currMedals:Array = MEDALS[ FlxG.level ];
			var saved:int = currStats.numSaved;
			
			var toReturn:int = -1;
			if ( saved >= currMedals[ 2 ])
			{
				toReturn = 2;
				//toReturn = new FlxSprite();
				//toReturn.makeGraphic( 10, 10, GOLD_COLOR );
			}
			else if ( saved >= currMedals[ 1 ])
			{
				toReturn = 1;
				//toReturn = new FlxSprite();
				//toReturn.makeGraphic( 10, 10, SILVER_COLOR );
			}
			else if( saved >= currMedals[ 0 ])
			{
				toReturn = 0;
				//toReturn = new FlxSprite();
				//toReturn.makeGraphic( 10, 10, BRONZE_COLOR );
			}
			return toReturn;
		}
	}

}
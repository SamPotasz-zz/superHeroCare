package states 
{
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.photonstorm.api.FlxKongregate;
	
	/**
	 * ...
	 * @author Sam Potasznik
	 */
	public class GameOverState extends FlxState 
	{
		private var currStats:LevelStats;
		
		override public function create():void
		{
			FlxG.bgColor = 0xff000000;
			
			add( new PlayBackground() );
			
			currStats = FlxG.scores[ FlxG.level ];
			
			var titleString:String = "Oh no!\n\n" + 
				"You've died a martyr.";
			
			var title:FlxText;
			title = new FlxText(0, 20, FlxG.width, titleString );
			title.setFormat (null, 16, 0xFFFFFFFF, "center");
			add( title );
			
			var statString:String = "However, you did manage\nto save " +
				currStats.numSaved + " mice for " + currStats.points + " points before your demise.";
			
			var stats:FlxText;
			stats = new FlxText( 20, 120, FlxG.width - 40, statString );
			stats.setFormat (null, 8, 0xFFFFFFFF );
			add( stats );
			
			addHighScore();
			
			var instructions:FlxText;
			instructions = new FlxText(20, 240, FlxG.width, "Press SPACE to play again.");
			instructions.setFormat (null, 8, 0xFFFFFFFF );
			add(instructions);
		} // end function create
		
		private function addHighScore():void 
		{
			var highScore:int = HighScore.highScore;
			var currPoints:int = currStats.points;
			
			FlxKongregate.submitStats( "highScore", currPoints );
			
			var displayString:String = "";
			if ( currPoints > highScore )
			{
				displayString = "And that's a new best for this session.";
				HighScore.highScore = currPoints;
			}
			else if ( currPoints == highScore )
			{
				displayString = "This ties your best for this session.";
			}
			else
			{
				displayString = "But that's not as good as your \nbest for this session " + 
					"of " + highScore + " points.\nTry saving multiple mice at once for combos.";
			}
			
			var highText:FlxText;
			highText = new FlxText(20, 180, FlxG.width - 40, displayString );
			highText.setFormat (null, 8, 0xFFFFFFFF );
			add(highText);
		}
 
 
		override public function update():void
		{
			super.update(); // calls update on everything you added to the game loop
 
			if (FlxG.keys.justPressed("SPACE"))
			{
				FlxG.level = 0;
				FlxG.switchState( new PlayState() );
			}
		} // end function update
	}

}
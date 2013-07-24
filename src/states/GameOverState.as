package states 
{
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author Sam Potasznik
	 */
	public class GameOverState extends FlxState 
	{
		private var currScore:int;
		
		override public function create():void
		{
			FlxG.bgColor = 0xff000000;
			
			add( new PlayBackground() );
			
			currScore = ( LevelStats )( FlxG.scores[ FlxG.level ]).numSaved;
			
			var titleString:String = "Oh no!\n\n" + 
				"You've died a martyr.";
			
			var title:FlxText;
			title = new FlxText(0, 20, FlxG.width, titleString );
			title.setFormat (null, 16, 0xFFFFFFFF, "center");
			add( title );
			
			var statString:String = "However, you did manage\nto save " +
				currScore + " mice before your demise.";
			
			var stats:FlxText;
			stats = new FlxText( 20, 120, FlxG.width, statString );
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
			
			var displayString:String = "";
			if ( currScore > highScore )
			{
				displayString = "And that's a new all-time best.";
				HighScore.highScore = currScore;
			}
			else if ( currScore == highScore )
			{
				displayString = "This ties your all-time best.";
			}
			else
			{
				displayString = "But that's not as good as your \nall-time best " + 
					"of " + highScore + " mice.";
			}
			
			var highText:FlxText;
			highText = new FlxText(20, 180, FlxG.width - 20, displayString );
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
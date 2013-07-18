package states 
{
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author Sam Potasznik
	 */
	public class WinState extends FlxState 
	{
		override public function create():void
		{
			add( new PlayBackground() );
			
			/*
			var title:FlxText;
			title = new FlxText(0, 20, FlxG.width, "WOO HOO!\n\nYou made it through!");
			title.setFormat (null, 16, 0xFFFFFFFF, "center");
			add(title);
			*/
			
			var instructions:FlxText;
			instructions = new FlxText(20, 48, FlxG.width - 45, "Congratulations on making it through.\n\nYou did it.");
			instructions.setFormat (null, 14, 0xFFFFFFFF );
			add(instructions);
			
			var thanks:FlxText;
			thanks = new FlxText(20, 200, FlxG.width, "Thanks for playing, and\nhit SPACE to play again.");
			thanks.setFormat (null, 11, 0xFFFFFFFF );
			add(thanks);
		} // end function create
 
 
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
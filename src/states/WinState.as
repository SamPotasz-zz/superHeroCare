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
			var title:FlxText;
			title = new FlxText(0, 20, FlxG.width, "WOO HOO!\n\nYou made it through!");
			title.setFormat (null, 16, 0xFFFFFFFF, "center");
			add(title);
			
			var instructions:FlxText;
			instructions = new FlxText(20, 128, FlxG.width, "Congratulations.");
			instructions.setFormat (null, 10, 0xFFFFFFFF );
			add(instructions);
			
			var thanks:FlxText;
			thanks = new FlxText(20, 200, FlxG.width, "Thanks for playing.\nHit SPACE to play again");
			thanks.setFormat (null, 7, 0xFFFFFFFF );
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
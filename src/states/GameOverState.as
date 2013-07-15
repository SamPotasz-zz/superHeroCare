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
		override public function create():void
		{
			var title:FlxText;
			title = new FlxText(0, 20, FlxG.width, "Oh no!  \n\nYou've died a martyr.");
			title.setFormat (null, 16, 0xFFFFFFFF, "center");
			add(title);
			
			var instructions:FlxText;
			instructions = new FlxText(20, 128, FlxG.width, "Press SPACE to play again.");
			instructions.setFormat (null, 8, 0xFFFFFFFF );
			add(instructions);
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
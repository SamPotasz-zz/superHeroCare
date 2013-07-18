package states
{
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author Sam Potasznik
	 */
	public class TitleState extends FlxState 
	{
		override public function create():void
		{
			add( new PlayBackground() );
			
			var title:FlxText;
			title = new FlxText(0, 16, FlxG.width, "Self Care\nSuper Hero");
			title.setFormat (null, 16, 0xFFFFFFFF, "center");
			add(title);
			
			var instructions:FlxText;
			instructions = new FlxText(20, 128, FlxG.width, "Use the ARROW KEYS to move.\n\nPress SPACE to start!");
			instructions.setFormat (null, 12, 0xFFFFFFFF );
			add(instructions);
			
			var byline:FlxText;
			byline = new FlxText(0, FlxG.height - 64, FlxG.width, "by @SamPotasz");
			byline.setFormat (null, 8, 0xFFFFFFFF, "center");
			add(byline);
			
			
 
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
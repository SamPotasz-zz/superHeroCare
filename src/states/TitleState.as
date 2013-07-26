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
	public class TitleState extends FlxState 
	{
		override public function create():void
		{
			FlxG.bgColor = 0xff000000;
			add( new PlayBackground( false ) );
			
			var birdPlane:FlxText = new FlxText( 20, 12, FlxG.width - 40, 
				"It's a bird!\nIt's a plane!\nNo! It's" );
			birdPlane.setFormat (null, 8, 0xFFFFFFFF );
			add( birdPlane );
			
			var title:FlxText;
			title = new FlxText( 0, 58, FlxG.width - 0, "Super Selfless Hero!");
			title.setFormat (null, 24, 0xFFFFFFFF, "center");
			add(title);
			
			var instructions:FlxText;
			instructions = new FlxText(20, 160, FlxG.width - 40, "Use the ARROW KEYS to " + 
				"carry the mice to safety!\n\nPress SPACE to start!\n(and M to mute/unmute)");
			instructions.setFormat (null, 8, 0xFFFFFFFF );
			add(instructions);
			
			var byline:FlxText;
			byline = new FlxText(0, FlxG.height - 48, FlxG.width, "by @SamPotasz");
			byline.setFormat (null, 8, 0xFFFFFFFF, "center");
			add(byline);
			
			var music:FlxText;
			byline = new FlxText(0, FlxG.height - 32, FlxG.width, "Music: 'The Spectator' by Kubbi");
			byline.setFormat (null, 8, 0xFFFFFFFF, "center");
			add(byline);
			
			FlxKongregate.init( onAPILoad );
 
		} // end function create
		
		private function onAPILoad():void 
		{
			FlxKongregate.connect();
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
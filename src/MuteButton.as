package  
{
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import org.flixel.FlxTimer;
	
	/**
	 * ...
	 * @author Sam Potasznik
	 */
	public class MuteButton extends FlxSprite 
	{
		[Embed ( source = "../assets/mute.png" )]
		private var SoundOn:Class;
		
		[Embed ( source = "../assets/muteOff.png" )]
		private var SoundOff:Class;
		
		private static const SOUND_OFF_TEXT:String = "un(M)ute";
		private static const SOUND_ON_TEXT:String = "(M)ute";
		
		private static const SOUND_OFF_X:int = FlxG.width - 82;
		private static const SOUND_ON_X:int = FlxG.width - 68;
		private var directions:FlxText = new FlxText( FlxG.width - 25, 26, 55, "(M)" );
		//private var directions:FlxText = new FlxText( SOUND_ON_X, 7, 55, SOUND_ON_TEXT );
		
		
		public function MuteButton() 
		{
			super( FlxG.width - 30, 5 );
			loadGraphic( SoundOn );
			
			directions.setFormat( "", 8, 0xffffff, "left" );
			FlxG.state.add( directions );
		}
		
		override public function update(): void
		{
			if( FlxG.keys.justPressed( "M" ))// && !timerOn )
			{
				toggleMute();
			}
		}
		
		private function toggleMute():void 
		{
			FlxG.mute = !FlxG.mute;
			if ( FlxG.mute )
			{
				loadGraphic( SoundOff );
				//directions.text = SOUND_OFF_TEXT;
				//directions.x = SOUND_OFF_X;
			}
			else
			{
				loadGraphic( SoundOn );
				//directions.text = SOUND_ON_TEXT;
				//directions.x = SOUND_ON_X;
			}
		}
		
	}

}
package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Sam Potasznik
	 */
	public class HealthPacket extends FlxSprite 
	{
		[Embed(source = "../assets/healthPacket.png")] 
		private var HealthImage:Class;
		
		[Embed(source = "../assets/sound/health.mp3")] 
		private var CaughtSFX:Class;
		
		private var _strength:int = 10;
		
		public function HealthPacket() 
		{
			super();
			loadGraphic( HealthImage );
			
			velocity.y = 100;
			acceleration.y = 0; // PlayState.GRAVITY;
		}
		
		public function onCaught():void 
		{
			FlxG.play( CaughtSFX );
			kill();
		}
		
		public function get strength():int 
		{
			return _strength;
		}
		
	}

}
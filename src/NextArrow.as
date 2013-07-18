package  
{
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Sam Potasznik
	 */
	public class NextArrow extends FlxSprite 
	{
		[Embed(source = "../assets/arrow.png")] 
		private var ArrowImage:Class;

		public function NextArrow() 
		{
			loadGraphic( ArrowImage );
		}
	}
}
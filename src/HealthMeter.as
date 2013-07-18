package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import states.PlayState;
	
	/**
	 * ...
	 * @author Sam Potasznik
	 */
	public class HealthMeter extends FlxObject 
	{
		private static const TEXT_X:int = PlayState.SAVED_TEXT_X;
		private static const TEXT_Y:int = PlayState.SAVED_TEXT_Y - 12;
		private static const TEXT_TEXT:String = "STRENGTH: ";
		private static const TEXT_WIDTH:int = 58;
		
		private static const BOX_Y:int = TEXT_Y + 2;
		
		private var meterFrame:FlxSprite = new FlxSprite( TEXT_X + TEXT_WIDTH, BOX_Y );
		 
		private var inside:FlxSprite = new FlxSprite( TEXT_X + TEXT_WIDTH + 1, BOX_Y + 1 );
		 
		private var meter:FlxSprite = new FlxSprite( TEXT_X + TEXT_WIDTH + 1, BOX_Y + 1 );
		
		private var state:FlxState;
		
		public function HealthMeter( state:FlxState ) 
		{
			this.state = state;
			
			var textBox:FlxText = new FlxText( TEXT_X, TEXT_Y, TEXT_WIDTH, TEXT_TEXT );
			state.add( textBox );
			
			meterFrame.makeGraphic( 50, 10) ; //White frame for the health bar
			//meterFrame.scrollFactor.x = frame.scrollFactor.y = 0;
			state.add( meterFrame );
		
			inside.makeGraphic( 48,8,0xff000000 ); //Black interior, 48 pixels wide
			//inside.scrollFactor.x = inside.scrollFactor.y = 0;
			state.add(inside);
			
			meter.makeGraphic( 1,8,0xffff0000 ); //The red bar itself
			//meter.scrollFactor.x = meter.scrollFactor.y = 0;
			meter.origin.x = meter.origin.y = 0; //Zero out the origin
			meter.scale.x = 48; //Fill up the health bar all the way
			state.add(meter);
		 
			meter.scale.x = 24; //Drop the health bar to half 
		}
		
		override public function update(): void
		{
			//trace( FlxG.scores[ Faller.SCORES_HEALTH_INDEX ] );
			meter.scale.x = FlxG.scores[ Player.SCORES_HEALTH_INDEX ];
		}
	}
}
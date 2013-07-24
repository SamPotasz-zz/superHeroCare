package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxTimer;
	import states.PlayState;
	
	/**
	 * ...
	 * @author Sam Potasznik
	 */
	public class HealthMeter extends FlxObject 
	{
		public static const TEXT_X:int = PlayState.SAVED_TEXT_X;
		public static const TEXT_Y:int = PlayState.SAVED_TEXT_Y - 13;
		private static const TEXT_TEXT:String = "STRENGTH: ";
		private static const TEXT_WIDTH:int = 58;
		
		private static const BOX_Y:int = TEXT_Y - 1;// + 2;
		
		private var meterFrame:FlxSprite = new FlxSprite( TEXT_X + TEXT_WIDTH, BOX_Y );
		private var inside:FlxSprite = new FlxSprite( TEXT_X + TEXT_WIDTH + 1, BOX_Y + 1 );
		private var meter:FlxSprite = new FlxSprite( TEXT_X + TEXT_WIDTH + 1, BOX_Y + 1 );
		
		private static const METER_HEIGHT:int = 12;
		
		private static const INSIDE_COLOR_NORMAL:uint = 0x000000;
		private static const INSIDE_COLOR_FLASH:uint = 0xffffff;
		//private static const INSIDE_COLOR_DECREASE:
		
		private var state:FlxState;
		
		public function HealthMeter( state:FlxState ) 
		{
			this.state = state;
			
			var textBox:FlxText = new FlxText( TEXT_X, TEXT_Y, TEXT_WIDTH, TEXT_TEXT );
			state.add( textBox );
			
			meterFrame.makeGraphic( Player.MAX_HEALTH + 2, METER_HEIGHT + 2 ) ; //White frame for the health bar
			//meterFrame.scrollFactor.x = frame.scrollFactor.y = 0;
			state.add( meterFrame );
		
			inside.makeGraphic( Player.MAX_HEALTH, METER_HEIGHT, 0xffffffff ); //Black interior, 48 pixels wide
			inside.color = INSIDE_COLOR_NORMAL;
			//inside.scrollFactor.x = inside.scrollFactor.y = 0;
			state.add(inside);
			
			meter.makeGraphic( 1, METER_HEIGHT, 0xffff0000 ); //The red bar itself
			//meter.scrollFactor.x = meter.scrollFactor.y = 0;
			meter.origin.x = meter.origin.y = 0; //Zero out the origin
			meter.scale.x = Player.MAX_HEALTH; //Fill up the health bar all the way
			state.add(meter);
		 
			meter.scale.x = 24; //Drop the health bar to half 
		}
		
		override public function update(): void
		{
			//trace( FlxG.scores[ Faller.SCORES_HEALTH_INDEX ] );
			var oldScale:Number = meter.scale.x;
			meter.scale.x = FlxG.scores[ Player.SCORES_HEALTH_INDEX ];
			
			if ( oldScale != meter.scale.x )
			{
				flashBackground();
			}
		}
		
		private function flashBackground():void 
		{
			var flashTimer:FlxTimer = new FlxTimer();
			flashTimer.start( 0.15, 4, onFlashTimer );
		}
		private function onFlashTimer( timer:FlxTimer ): void
		{
			trace( "Old color: " + inside.color );
			var newColor:uint;
			if ( inside.color == INSIDE_COLOR_NORMAL )
			{
				newColor = INSIDE_COLOR_FLASH;
			}
			else if ( inside.color == INSIDE_COLOR_FLASH )
			{
				newColor = INSIDE_COLOR_NORMAL;
			}
			trace( "New color: " + newColor );
			inside.color = newColor;
		}
	}
}
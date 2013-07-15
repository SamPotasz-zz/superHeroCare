package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import states.PlayState;
	
	/**
	 * ...
	 * @author Sam Potasznik
	 */
	public class Player extends FlxSprite 
	{	
		public static const SCORES_HEALTH_INDEX:int = 3;
		
		private static const TEXT_X:int = 3;
		private static const TEXT_Y:int = 3;
		private static const TEXT_TEXT:String = "HEALTH: ";
		private static const TEXT_WIDTH:int = 20;
		
		private static const MAX_HEALTH:int = 48;
		private static const HEALTH_DECREASE:Number = 0.05;	//how fast health decresases
		private static const HEALTH_INCREASE:Number = 0.1;
		
		private var meterFrame:FlxSprite = new FlxSprite( TEXT_X + TEXT_WIDTH, TEXT_Y );
		 
		private var inside:FlxSprite = new FlxSprite( TEXT_X + TEXT_WIDTH + 1, TEXT_Y + 1 );
		 
		private var meter:FlxSprite = new FlxSprite( TEXT_X + TEXT_WIDTH + 1, TEXT_Y + 1 );
		
		private var wobbly:Boolean = false;
		
		public function Player() 
		{
			super( FlxG.width - 15 );
			onCreate();
			
			health = ( FlxG.level == 0 ) ? MAX_HEALTH : FlxG.scores[ SCORES_HEALTH_INDEX ];			
		}
		
		private function onCreate():void 
		{
			makeGraphic( 10, 12, 0xffaa1111 );
			maxVelocity.x = 80;
			maxVelocity.y = PlayState.GRAVITY;
			acceleration.y = PlayState.GRAVITY;
			drag.x = maxVelocity.x * 4;
			drag.y = maxVelocity.y * 4;
			
			//createMeter();
		}
		
		override public function update(): void
		{
			acceleration.x = 0;
			
			if ( FlxG.keys.LEFT )
			{
				acceleration.x = -maxVelocity.x * 6;
			}
			if( FlxG.keys.RIGHT )
			{
				acceleration.x = maxVelocity.x * 6;
			}
			if( FlxG.keys.UP )
			{
				velocity.y = -maxVelocity.y/4;
			}
			if ( FlxG.keys.DOWN )
			{
				velocity.y = maxVelocity.y * 2;
			}
			
			//bound movement
			y = Math.max( y, 0 );
			x = Math.max( x, 0 );
			if ( y < PlayState.LEVEL_ADVANCE_Y )
			{
				x = Math.min( x, Main.GAME_WIDTH - width );
			}
			
			if ( !onScreen() )
			{
				if ( x > Main.GAME_WIDTH )
				{
					( PlayState )( FlxG.state ).nextLevel();
				}
				else if ( x < 0 )
				{
					x = 0;
				}
				else
				{
					gameOver();
				}
			}
			
			//update health
			health -= HEALTH_DECREASE;
			//cap health
			health = Math.max( 0, Math.min( health, MAX_HEALTH ));
			//update global health var for the meter
			FlxG.scores[ SCORES_HEALTH_INDEX ] = health;
			
			if ( health <= 0 )
			{
				gameOver();
			}
		}
		
		private function gameOver(): void
		{
			( PlayState )( FlxG.state ).endGame();
		}
		
		public function onRest( increase:Number ): void
		{
			health += increase;
		}
		
	}

}
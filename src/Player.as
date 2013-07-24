package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTimer;
	import states.PlayState;
	
	/**
	 * ...
	 * @author Sam Potasznik
	 */
	public class Player extends FlxSprite 
	{	
		
		[Embed(source = "../assets/player.png")] 
		private var PlayerImage:Class;

		[Embed( source = "../assets/sound/gameOver.mp3" )]
		private var DeathSFX:Class;
		
		public static const SCORES_HEALTH_INDEX:int = 3;
		
		private static const TEXT_X:int = 3;
		private static const TEXT_Y:int = 3;
		private static const TEXT_TEXT:String = "HEALTH: ";
		private static const TEXT_WIDTH:int = 20;
		
		public static const MAX_HEALTH:int = 48;
		private static const HEALTH_DECREASE:Number = 5.0;//0.05;	//how fast health decresases
		private static const HEALTH_INCREASE:Number = 0.1;
		
		private static const MAX_VELOCITY:int = 80;
		private static const MIN_VELOCITY:int = 20;
		
		private var meterFrame:FlxSprite = new FlxSprite( TEXT_X + TEXT_WIDTH, TEXT_Y );
		 
		private var inside:FlxSprite = new FlxSprite( TEXT_X + TEXT_WIDTH + 1, TEXT_Y + 1 );
		 
		private var meter:FlxSprite = new FlxSprite( TEXT_X + TEXT_WIDTH + 1, TEXT_Y + 1 );
		
		private var carrying:Vector.<Faller> = new Vector.<Faller>();
		
		//private var alive:Boolean = true;
		
		public function Player() 
		{
			super( FlxG.width - 24 );
			onCreate();
			
			//health = Math.min( MAX_HEALTH, FlxG.scores[ SCORES_HEALTH_INDEX ] + ( MAX_HEALTH / 4.0 ));
			health = MAX_HEALTH;
			FlxG.scores[ SCORES_HEALTH_INDEX ] = health;
			
			//alive = true;
		}
		
		private function onCreate():void 
		{
			//makeGraphic( 10, 12, 0xffaa1111 );
			loadGraphic( PlayerImage );
			maxVelocity.x = MAX_VELOCITY;
			maxVelocity.y = PlayState.GRAVITY;
			acceleration.y = PlayState.GRAVITY;
			drag.x = maxVelocity.x * 4;
			drag.y = maxVelocity.y * 4;			
		}
		
		override public function update(): void
		{
			acceleration.x = 0;
			
			if ( alive )
			{
				var healthPercent:Number = health / MAX_HEALTH;
				maxVelocity.x = ( MAX_VELOCITY - MIN_VELOCITY ) * healthPercent + MIN_VELOCITY;
				
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
					velocity.y = -maxVelocity.y/3;
				}
				if ( FlxG.keys.DOWN )
				{
					velocity.y = maxVelocity.y * 2;
				}
				
				//bound movement
				y = Math.max( y, 0 );
				x = Math.max( x, 0 );
				x = Math.min( x, Main.GAME_WIDTH - width );
				
				
				if ( !onScreen() )
				{
					if ( x > Main.GAME_WIDTH - width )
					{
						x = Main.GAME_WIDTH - width;
						//( PlayState )( FlxG.state ).nextLevel();
					}
					else if ( x < 0 )
					{
						x = 0;
					}
					else
					{
						onDead();
					}
				}	//end if onscreen
			}		//end if alive
			
			setRotation();
			
			updateCarrying();
		}
		
		private function updateCarrying():void 
		{
			for ( var i:int = 0; i < carrying.length; i++ )
			{
				var currLoad:Faller = carrying[ i ];
				//trace( currLoad.touching );
				
				currLoad.x = x + 5;
				currLoad.y = y + 10 + ( i * 8 );		
				
				FlxObject.separate( currLoad, ( PlayState )( FlxG.state ).level );
				
				if ( !currLoad.onScreen() )
				{
					removeFromCarrying( currLoad );
					i--;
				}
			}
		}
		
		private function updateHealth():void 
		{
			health -= HEALTH_DECREASE;
			//cap health
			health = Math.max( 0, Math.min( health, MAX_HEALTH ));
			//update global health var for the meter
			FlxG.scores[ SCORES_HEALTH_INDEX ] = health;
			
			if ( health <= 0 )
			{
				onDead();
			}
		}
		
		private function setRotation():void 
		{
			var radians:Number = Math.atan2( velocity.y, velocity.x );
			angle = radians * 180 / Math.PI;
		}
		
		private function onDead(): void
		{
			FlxG.play( DeathSFX );
			alive = false;
			
			var deathTimer:FlxTimer = new FlxTimer();
			deathTimer.start( 2.0, 1, onDeathTimer );
		}
		
		private function onDeathTimer( timer:FlxTimer ):void 
		{
			( PlayState )( FlxG.state ).endGame();
		}
		
		public function onRest( increase:Number ): void
		{
			health += increase;
		}
		
		public function onCaught( caught:Faller ):void 
		{
			//health -= HEALTH_DECREASE;
			health -= caught.weight;
			FlxG.scores[ SCORES_HEALTH_INDEX ] = health;
			
			carrying.push( caught );
			caught.x = x + 5;
			caught.y = y + carrying.length * 8;
			
			if ( health <= 0 )
			{
				onDead();
			}
		}
		
		private function get carryingString():String 
		{
			var toPrint:String = "Carrying "; 
			for each( var faller:Faller in carrying )
			{
				toPrint += faller.index + ", ";
			}
			return toPrint
		}
		
		public function onLanded( faller:Faller ):void 
		{
			removeFromCarrying( faller );
		}
		
		private function removeFromCarrying(faller:Faller):void 
		{
			//trace("Before: " + carryingString )
			var index:int = carrying.indexOf( faller );
			//trace( "Removing " + faller.index + " at index " + index );
			carrying.splice( index, 1 );
			//trace( "After: " + carryingString );
		}
		
		public function onHealth( strength:int ):void 
		{
			health += strength;
			health = Math.max( 0, Math.min( health, MAX_HEALTH ));
			FlxG.scores[ SCORES_HEALTH_INDEX ] = health;
		}
	}

}
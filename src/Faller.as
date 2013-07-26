package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import states.PlayState;
	
	/**
	 * ...
	 * @author Sam Potasznik
	 */
	public class Faller extends FlxSprite 
	{
		//private static const WIDTH:int = 6;
		//private static const HEIGHT:int = 6;
		//private static const COLOR:uint = 0xffffff00;
		
		private var _index:int = Math.random() * 100;
		public function get index():int
		{
			return _index;
		}
		
		
		[Embed(source = "../assets/mouse.png")] 
		private var MouseImage:Class;
		
		[Embed(source = "../assets/dog.png")] 
		private var DogImage:Class;
		
		[Embed(source = "../assets/person.png")] 
		private var PersonImage:Class;
		
		
		/**
		 * SOUND EFFECTS
		 */
		[Embed(source = "../assets/sound/catchFaller.mp3")] 
		private var CaughtSFX:Class;
		[Embed(source = "../assets/sound/fallerDie.mp3")] 
		private var OffscreenSFX:Class;
		[Embed(source = "../assets/sound/fallerLand.mp3")] 
		private var LandSFX:Class;
		
		private var currStats:LevelStats;
		
		//being carried by the player?
		//set our position relative to the carrier
		private var _falling:Boolean = true;
		private static const CARRY_OFFSET_X:int = 1;
		private static const CARRY_OFFSET_Y:int = 8;
		
		private static const WALK_SPEED:Number = 5.0;
		
		private var _landed:Boolean = false;
		
		private static const WEIGHT_INCREASE_BY_LEVEL:int = 1;
		private static const WEIGHT_MIN:int = 8;
		private static const WEIGHT_MAX:int = 50;
		
		private var _weight:int;
		
		
		public function Faller( level:int ) 
		{
			//makeGraphic( WIDTH, HEIGHT, COLOR );
			loadImage();
			
			velocity.y = 100;
			acceleration.y = 0; // PlayState.GRAVITY;
			
			_weight = WEIGHT_MIN;// + WEIGHT_INCREASE_BY_LEVEL * level;
			
			currStats = FlxG.scores[ FlxG.level ];
		}
		
		private function loadImage():void 
		{
			switch( FlxG.level )
			{
				case 0:
				{
					loadGraphic( MouseImage );
					break;
				}
				case 1:
				{
					loadGraphic( DogImage );
					break;
				}
				default:
				{
					loadGraphic( PersonImage );
					break;
				}
			}
		}
		
		override public function update(): void
		{
			super.update();
			
			if ( !onScreen() )
			{
				if ( y > Main.GAME_HEIGHT )
				{
					//FlxG.play( OffscreenSFX );
					currStats.addDead();
					( PlayState )( FlxG.state ).updateDeadText();					
				}
				kill();
			}
			
			//if ( !_falling )
			//{
				//trace( touching );
			//}
		}
		
		public function onCaught():void 
		{
			_falling = false;
			velocity.y = 0;
			
			FlxG.play( CaughtSFX );
			/*
			kill();
			*/
		}
		
		public function onLanded():void 
		{
			FlxG.play( LandSFX );
			
			currStats.addSaved();
			( PlayState )( FlxG.state ).updateSavedText();
			
			//walk to nearest exit
			velocity.x = ( x > Main.GAME_WIDTH / 2.0 ) ? WALK_SPEED : -WALK_SPEED;
			
			_landed = true;
		}
		
		public function get isFalling(): Boolean
		{
			return _falling;
		}
		
		public function get alreadyLanded():Boolean 
		{
			return _landed;
		}
		
		public function get weight():int 
		{
			return _weight;
		}
	}
}
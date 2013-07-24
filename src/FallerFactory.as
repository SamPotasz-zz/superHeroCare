package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxText;
	import org.flixel.FlxTimer;
	import states.PlayState;
	/**
	 * ...
	 * @author Sam Potasznik
	 */
	public class FallerFactory extends FlxObject
	{
		private static const FALL_PERIOD_LEVELS:Array = [ 1.0, 0.75, 0.3 ];
		
		private static const HEALTH_PERIODS:Array = [ 4.0, 5.0, 3.0 ];
		
		private static const SAVES_PER_LEVEL:int = 5;
		//multiplier so as to constantly decrease the period
		private static const PERIOD_INCREASE_PER_LEVEL:Number = .90;
		private static const MIN_FALL_PERIOD:Number = 0.3;
		
		private static const LEVEL_TEXT_X:int = HealthMeter.TEXT_X;
		private static const LEVEL_TEXT_Y:int = HealthMeter.TEXT_Y + 24;
		private static const LEVEL_TEXT_STRING:String = "LEVEL: ";
		
		//how many seconds between creations
		private var fallPeriod:Number;
		
		private var healthPeriod:Number;
		
		private var fallTimer:FlxTimer = new FlxTimer();
		
		private var healthTimer:FlxTimer = new FlxTimer();
		
		private var _fallers:FlxGroup = new FlxGroup();
		private var numDead:int = 0;
		
		private var _healths:FlxGroup = new FlxGroup();
		
		private var playState:PlayState;
		
		private var levelText:FlxText = new FlxText( LEVEL_TEXT_X, LEVEL_TEXT_Y, 100 );
		
		//now many fallers will we create for the level
		private var _numFalls:int;
		
		/*
		 * every x num of falls, we go up a level. 
		 * things get faster, possibly heavier, etc.
		 * 0 indexed
		 */
		private var level:int = 0;
		
		public function FallerFactory( playState:PlayState ) 
		{
			this.playState = playState;
			
			fallPeriod = FALL_PERIOD_LEVELS[ 0 ];
			healthPeriod = HEALTH_PERIODS[ 0 ];
			
			//_numFalls = ( LevelStats )( FlxG.scores[ FlxG.level ]).numFallers;
			fallTimer.start( fallPeriod, 0, onTimer );
			healthTimer.start( healthPeriod, 0, onHealthTimer );
			
			playState.add( levelText );
			updateLevelText();
		}
		
		public function onLanded():void 
		{
			var numSaves:int = ( LevelStats )( FlxG.scores[ FlxG.level ]).numSaved;
			if ( numSaves % SAVES_PER_LEVEL == 0 )
			{
				increaseLevel();
			}
		}
		
		private function onTimer( timer:FlxTimer ): void
		{	
			var faller:Faller = new Faller( level );
			faller.x = randomXPosition;
			_fallers.add( faller );
			
			playState.add( faller );
			
			//_numFalls++;
			//if ( _numFalls % SAVES_PER_LEVEL == 0 )
			//{
				//increaseLevel();
			//}
		}
		
		private function increaseLevel():void 
		{
			fallPeriod *= PERIOD_INCREASE_PER_LEVEL;
			fallPeriod = Math.max( MIN_FALL_PERIOD, fallPeriod );
			fallTimer.stop();
			fallTimer.start( fallPeriod, 0, onTimer );
			level++;
			
			updateLevelText();
		}
		
		private function onHealthTimer( timer:FlxTimer ): void
		{
			var health:HealthPacket = new HealthPacket();
			_healths.add( health );
			health.x = randomXPosition;
			
			playState.add( health );
		}
		
		private function get randomXPosition(): int
		{
			//pick a random column to place the faller
			var column:int = Math.floor( Math.random() * PlayState.FLOOR_GAP_COLS );
			column += PlayState.FLOOR_COLS;
			
			return column * Main.TILE_SIZE;
		}
		
		public function get fallers():FlxGroup 
		{
			return _fallers;
		}
		
		public function get healths():FlxGroup 
		{
			return _healths;
		}
		
		private function updateLevelText(): void
		{
			levelText.text = LEVEL_TEXT_STRING + ( level + 1 );
		}
		
		/* 
		 * how many fallers will we create for the level
		 */
		/*
		public function get numFalls():int 
		{
			return _numFalls;
		}
		*/
	}
}
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
		
		private static const FALLS_PER_LEVEL:int = 5;
		//multiplier so as to constantly decrease the period
		private static const PERIOD_INCREASE_PER_LEVEL:Number = .60;
		
		//how many seconds between creations
		private var fallPeriod:Number;
		
		private var healthPeriod:Number;
		
		private var fallTimer:FlxTimer = new FlxTimer();
		
		private var healthTimer:FlxTimer = new FlxTimer();
		
		private var _fallers:FlxGroup = new FlxGroup();
		private var numDead:int = 0;
		
		private var _healths:FlxGroup = new FlxGroup();
		
		private var playState:PlayState;
		
		//now many fallers will we create for the level
		private var _numFalls:int;
		
		private var level:int = 0;
		
		public function FallerFactory( playState:PlayState ) 
		{
			this.playState = playState;
			
			fallPeriod = FALL_PERIOD_LEVELS[ 0 ];
			healthPeriod = HEALTH_PERIODS[ 0 ];
			
			//_numFalls = ( LevelStats )( FlxG.scores[ FlxG.level ]).numFallers;
			fallTimer.start( fallPeriod, 0, onTimer );
			healthTimer.start( healthPeriod, 0, onHealthTimer );
		}
		
		private function onTimer( timer:FlxTimer ): void
		{	
			var faller:Faller = new Faller( level );
			faller.x = randomXPosition;
			_fallers.add( faller );
			
			playState.add( faller );
			
			_numFalls++;
			if ( _numFalls % FALLS_PER_LEVEL == 0 )
			{
				increaseLevel();
			}
		}
		
		private function increaseLevel():void 
		{
			fallPeriod *= PERIOD_INCREASE_PER_LEVEL;
			level++;
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
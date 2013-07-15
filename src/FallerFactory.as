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
		private static const PERIOD_LEVELS:Array = [ 1.5, 0.75, 0.3 ];
		
		//how many seconds between creations
		private var period:Number;
		
		private var timer:FlxTimer = new FlxTimer();
		
		private var _fallers:FlxGroup = new FlxGroup();
		private var numDead:int = 0;
		
		private var playState:PlayState;
		
		//now many fallers will we create for the level
		private var _numFalls:int;
		
		public function FallerFactory( playState:PlayState ) 
		{
			this.playState = playState;
			
			period = PERIOD_LEVELS[ FlxG.level ];
			//_numFalls = FALLS_LEVELS[ FlxG.level ];
			_numFalls = ( LevelStats )( FlxG.scores[ FlxG.level ]).numFallers;
			
			timer.start( period, _numFalls, onTimer );
		}
		
		private function onTimer( timer:FlxTimer ): void
		{	
			//pick a random column to place the faller
			var column:int = Math.floor( Math.random() * PlayState.FLOOR_GAP_COLS );
			column += PlayState.FLOOR_COLS;
			
			var fallerX:int = column * Main.TILE_SIZE;
			
			var faller:Faller = new Faller();
			faller.x = fallerX;
			_fallers.add( faller );
			
			playState.add( faller );
		}
		
		public function get fallers():FlxGroup 
		{
			return _fallers;
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
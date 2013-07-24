package  
{
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Sam Potasznik
	 */
	public class LevelStats 
	{
		private static const FALLERS_LEVELS:Array = [ 10, 25, 60 ];
		
		private var _numDead:int = 0;
		private var _numSaved:int = 0;
		
		private var _numFallers:int = 0;
		
		private var _points:int = 0;
		
		public function LevelStats(){}
		
		public function addSaved(): void
		{
			_numSaved++;
		}
		public function addDead(): void
		{
			_numDead++;
		}
		public function addPoints( value:int ): void
		{
			_points += value;
		}
		
		public function get numSaved():int 
		{
			return _numSaved;
		}
		public function get numDead():int 
		{
			return _numDead;
		}
		public function get points():int
		{
			return _points;
		}
		
		public function get numFallers():int 
		{
			return FALLERS_LEVELS[ FlxG.level ];
		}
		
	}

}
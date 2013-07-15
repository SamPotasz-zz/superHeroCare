package states 
{
	/**
	 * ...
	 * @author Sam Potasznik
	 */
	public class LevelStats 
	{
		private var _numDead:int = 0;
		private var _numSaved:int = 0;
		
		public function LevelStats(){}
		
		public function addSaved(): void
		{
			_numSaved++;
		}
		public function addDead(): void
		{
			_numDead++;
		}
		
		public function get numSaved():int 
		{
			return _numSaved;
		}
		public function get numDead():int 
		{
			return _numDead;
		}
		
	}

}
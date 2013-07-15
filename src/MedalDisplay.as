package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import states.LevelStats;
	
	/**
	 * ...
	 * @author Sam Potasznik
	 */
	public class MedalDisplay extends FlxObject 
	{
		/* 
		 * 2D array: Levels x Medal level.
		 * Indicates how many saves player needs on each level
		 * to achieve the given medal
		 */
		private static const MEDALS:Array = [[ 5, 10, 15 ], [ 10, 20, 30 ], [ 15, 30, 45 ]];
		
		private static const MEDAL_X:int = 3;
		private static const MEDAY_YS:Array = [ 50, 60, 70 ];
		
		private static const TEXT_X:int = 3;
		private static const TEXT_Y:int = 40;
		private static const TEXT_INTRO:String = "Saves needed to medal: ";
		
		private static const GOLD_COLOR:uint = 0xfff2d641;
		private static const SILVER_COLOR:uint = 0xffd9d9f3;
		private static const BRONZE_COLOR:uint = 0xffa67d3d;
			
		private var goldMedal:FlxSprite = new FlxSprite();	
		private var silverMedal:FlxSprite = new FlxSprite();
		private var bronzeMedal:FlxSprite = new FlxSprite();
			
		private var currStats:LevelStats;
		
		override public function create(): void
		{
			currStats = FlxG.scores[ FlxG.level ];
			
			var explain:FlxText = new FlxText( MEDAL_X, 40, Main.GAME_WIDTH, TEXT_INTRO );
			
			FlxG.state.add( explain );
		}
		
		public function updateMedals(): void
		{
			
		}
	}

}
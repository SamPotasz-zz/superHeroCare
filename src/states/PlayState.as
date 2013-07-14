package states
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxTilemap;
	
	/**
	 * ...
	 * @author Sam Potasznik
	 */
	public class PlayState extends FlxState 
	{
		private static const SKY_ROWS:int = 5 * 2;
		
		private static const PLATFORM_ROWS:int = 1 * 2;
		private static const PLATFORM_COLS:int = 3 * 2;
		
		private static const MIDDLE_ROWS:int = 7 * 2;
		
		private static const FLOOR_ROWS:int = 5 * 2;
		public static const FLOOR_COLS:int = 3 * 2;
		
		public static const FLOOR_GAP_COLS:int = Main.NUM_COLS - FLOOR_COLS * 2;
		
		public static const LEVEL_ADVANCE_Y:int = Main.TILE_SIZE * ( SKY_ROWS + PLATFORM_ROWS );
		
		public static const GRAVITY:int = 200;
		
		static public const NUM_LEVELS:int = 3;
		
		public static const SAVED_TEXT_X:int = 3;
		private static const SAVED_TEXT_Y:int = 18;
		private static const SAVED_TEXT_INTRO:String = "NUM SAVED: ";
		private var savedText:FlxText = new FlxText( SAVED_TEXT_X, SAVED_TEXT_Y, 100, SAVED_TEXT_INTRO + "0" );
		
		private static const DEAD_TEXT_X:int = SAVED_TEXT_X;
		private static const DEAD_TEXT_Y:int = SAVED_TEXT_Y + 10;
		private static const DEAD_TEXT_INTRO:String = "NUM DEAD: ";
		private var deadText:FlxText = new FlxText( DEAD_TEXT_X, DEAD_TEXT_Y, 100, DEAD_TEXT_INTRO + "0" );
		
		public var level:FlxTilemap;
		
		public var player:Player = new Player();
		
		private var healthMeter:HealthMeter;
		
		private var fallerFactory:FallerFactory;
		
		private	var restArea:RestArea = new RestArea();
		
		//an array containing our level data
		private var firstMap:Array = new Array();
		
		override public function create(): void
		{
			FlxG.bgColor = 0xffaaaaaa;
			
			createFirstMap();
			
			level = new FlxTilemap();
			var csv:String = FlxTilemap.arrayToCSV( firstMap, Main.NUM_COLS );
			//trace( "CSV: \n" + csv );
			level.loadMap(csv, FlxTilemap.ImgAuto, 0, 0, FlxTilemap.AUTO);
			add(level);
			
			fallerFactory = new FallerFactory( this );
			add( fallerFactory );
			
			//initialize scores
			if ( FlxG.level == 0 )
			{
				FlxG.scores[ Faller.SCORES_SAVED_INDEX ] = 0;
				FlxG.scores[ Faller.SCORES_DEAD_INDEX ] = 0;
			}
			
			add( savedText );
			add( deadText );
			
			restArea.x = Main.GAME_WIDTH - ( Main.TILE_SIZE * ( PLATFORM_COLS - 1 ));
			restArea.y = Main.TILE_SIZE * SKY_ROWS - restArea.height;
			add( restArea );
			
			healthMeter = new HealthMeter( this );
			add( healthMeter );
			
			//add player last for depth
			addPlayer();
		}
		
		private function addPlayer():void 
		{
			if ( FlxG.level > 0 )
			{
				player.x = 0;
				player.y = Main.TILE_SIZE * ( SKY_ROWS + PLATFORM_ROWS + MIDDLE_ROWS ) - player.height;
			}
			add( player );
		}
		
		private function createFirstMap():void 
		{
			//create sky
			for ( var i:int = 0; i < Main.NUM_COLS; i++ )
			{
				for ( var j:int = 0; j < SKY_ROWS; j++ ) {
					firstMap.push( 0 );
				}
			}
			
			//create resting platform
			for ( i = 0; i < PLATFORM_ROWS; i++ )
			{
				for ( j = 0; j < Main.NUM_COLS - PLATFORM_COLS; j++ ) {
					firstMap.push( 0 );
				}
				for ( j = 0; j < PLATFORM_COLS; j++ )
				{
					firstMap.push( 1 );
				}
			}
			
			//create gap
			for ( i = 0; i < Main.NUM_COLS; i++ )
			{
				for ( j = 0; j < MIDDLE_ROWS; j++ )
				{
					firstMap.push( 0 );
				}
			}
			
			//create bottom floor
			for ( i = 0; i < FLOOR_ROWS; i++ )
			{
				for ( j = 0; j < FLOOR_COLS; j++ )
				{
					firstMap.push( 1 );
				}
				for ( j = 0; j < Main.NUM_COLS - 2 * FLOOR_COLS; j++ )
				{
					firstMap.push( 0 );
				}
				for ( j = 0; j < FLOOR_COLS; j++ )
				{
					firstMap.push( 1 );
				}
			}
		}
		
		override public function update(): void
		{
			super.update();
			
			FlxG.collide( level, player );
			
			FlxG.overlap( fallerFactory.fallers, player, onCatch );
			
			FlxG.overlap( restArea, player, onRest );
		}
		
		private function onCatch( faller:Faller, player:Player ):void 
		{
			faller.onCaught();
		}
		
		private function onRest( restArea:RestArea, player:Player ): void
		{
			player.onRest( restArea.rate );
		}
		
		/* status text functions */
		public function updateDeadText(): void
		{
			deadText.text = DEAD_TEXT_INTRO + FlxG.scores[ Faller.SCORES_DEAD_INDEX ];
		}
		public function updateSavedText(): void
		{
			savedText.text = SAVED_TEXT_INTRO + FlxG.scores[ Faller.SCORES_SAVED_INDEX ];
		}
		
		public function endGame():void 
		{
			FlxG.switchState( new TitleState() );
		}
		
		public function nextLevel():void 
		{
			FlxG.level++;
			if ( FlxG.level >= NUM_LEVELS )
			{
				FlxG.switchState( new TitleState() );
			}
			else
			{
				FlxG.switchState( new PlayState() );
			}
		}
	}

}
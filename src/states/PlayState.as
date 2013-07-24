package states
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxTimer;
	
	/**
	 * ...
	 * @author Sam Potasznik
	 */
	public class PlayState extends FlxState 
	{	
		[Embed(source = "../../assets/leftHousesBig.png")] 
		private var LeftImage:Class;
		
		[Embed(source = "../../assets/rightHousesBig.png")] 
		private var RightImage:Class;
		
		private static const SKY_ROWS:int = 5 * 2;
		
		private static const PLATFORM_ROWS:int = 0;//1 * 2;
		private static const PLATFORM_COLS:int = 3 * 2;
		
		private static const MIDDLE_ROWS:int = 8 * 2;
		
		private static const FLOOR_ROWS:int = 5 * 2;
		public static const FLOOR_COLS:int = 3 * 2;
		
		public static const FLOOR_GAP_COLS:int = Main.NUM_COLS - FLOOR_COLS * 2;
		
		public static const LEVEL_ADVANCE_Y:int = Main.TILE_SIZE * ( SKY_ROWS + PLATFORM_ROWS );
		
		public static const GRAVITY:int = 200;
		
		static public const NUM_LEVELS:int = 3;
		
		public static const SAVED_TEXT_X:int = Main.TILE_SIZE * FLOOR_COLS + 2;
		public static const SAVED_TEXT_Y:int = Main.GAME_HEIGHT - 54;
		private static const SAVED_TEXT_INTRO:String = "SAVED: ";
		private var savedText:FlxText = new FlxText( SAVED_TEXT_X, SAVED_TEXT_Y, Main.GAME_WIDTH, 
			SAVED_TEXT_INTRO + "0" );
		
		private static const DEAD_TEXT_X:int = SAVED_TEXT_X;
		private static const DEAD_TEXT_Y:int = SAVED_TEXT_Y + 10;
		private static const DEAD_TEXT_INTRO:String = "FALLEN: ";
		private var deadText:FlxText = new FlxText( DEAD_TEXT_X, DEAD_TEXT_Y, Main.GAME_WIDTH, DEAD_TEXT_INTRO + "0" );
		
		public var level:FlxTilemap;
		
		public var player:Player;
		
		private var healthMeter:HealthMeter;
		
		private var fallerFactory:FallerFactory;
		
		private	var restArea:RestArea = new RestArea();
		
		//an array containing our level data
		private var firstMap:Array = new Array();
		
		private var currStats:LevelStats;
		
		private var _landingPads:FlxGroup = new FlxGroup();
		
		private var comboTimer:FlxTimer = new FlxTimer();
		
		override public function create(): void
		{
			FlxG.bgColor = 0xffaaaaaa;
			
			addBackground();
			
			createFirstMap();
			
			level = new FlxTilemap();
			var csv:String = FlxTilemap.arrayToCSV( firstMap, Main.NUM_COLS );
			//trace( "CSV: \n" + csv );
			level.loadMap(csv, FlxTilemap.ImgAuto, 0, 0, FlxTilemap.AUTO);
			add(level);
			
			//initialize scores
			FlxG.scores[ FlxG.level ] = new LevelStats();
			currStats = FlxG.scores[ FlxG.level ];
			/*
			if ( FlxG.level == 0 )
			{
				FlxG.scores[ Faller.SCORES_SAVED_INDEX ] = 0;
				FlxG.scores[ Faller.SCORES_DEAD_INDEX ] = 0;
			}
			*/
			
			fallerFactory = new FallerFactory( this );
			add( fallerFactory );
			
			savedText.text = SAVED_TEXT_INTRO + "0";// + currStats.numFallers;
			add( savedText );
			
			//addRestArea();
			
			healthMeter = new HealthMeter( this );
			if( FlxG.level == 0 )
				FlxG.scores[ Player.SCORES_HEALTH_INDEX ] = 1000;
			add( healthMeter );
			
			//addArrow();
			
			addLandingPads();
			
			//add player last for depth
			player = new Player();
			addPlayer();
		}
		
		private function addLandingPads():void 
		{
			var houseY:int = Main.GAME_HEIGHT - ( Main.TILE_SIZE * FLOOR_ROWS ) - 12;
			var leftHouses:FlxSprite = new FlxSprite( 0, houseY );
			leftHouses.loadGraphic( LeftImage );
			add( leftHouses );
			
			var leftPad:LandingPad = new LandingPad( true );
			leftPad.x = 0;
			var padY:int = Main.GAME_HEIGHT - ( Main.TILE_SIZE * FLOOR_ROWS ) - leftPad.height + 2;
			leftPad.y = padY;
			add( leftPad );
			
			var rightEdge:int = Main.GAME_WIDTH - ( Main.TILE_SIZE * FLOOR_COLS );
			var rightHouses:FlxSprite = new FlxSprite( Main.GAME_WIDTH - 26, houseY );
			rightHouses.loadGraphic( RightImage );
			add( rightHouses );
			
			var rightPad:LandingPad = new LandingPad( false );
			rightPad.x = rightEdge;
			rightPad.y = padY;
			add( rightPad );
			
			_landingPads.add( leftPad );
			_landingPads.add( rightPad );
		}
		
		private function addRestArea():void 
		{
			restArea.x = Main.GAME_WIDTH - ( Main.TILE_SIZE * ( PLATFORM_COLS - 1 ));
			restArea.y = Main.TILE_SIZE * SKY_ROWS - restArea.height;
			add( restArea );
		}
		
		private function addBackground():void 
		{
			add( new PlayBackground() );
		}
		
		private function addArrow():void 
		{
			var arrow:NextArrow = new NextArrow();
			
			var arrowX:int = Main.GAME_WIDTH - arrow.width - Main.TILE_SIZE;
			var arrowY:int = Main.GAME_HEIGHT - ( Main.TILE_SIZE * FLOOR_ROWS ) - arrow.height;
			
			arrow.x = arrowX;
			arrow.y = arrowY;
			add( arrow );
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
			
			FlxG.collide( player, level, onGround );
			//FlxG.collide( level, player );
			FlxG.overlap( fallerFactory.fallers, level, onFallerCollideLevel );
			
			FlxG.overlap( fallerFactory.fallers, player, onCatch );
			
			FlxG.overlap( fallerFactory.fallers, landingPads, onLanded );
			
			FlxG.overlap( fallerFactory.healths, player, onHealth );
			//for each (var faller:Faller in fallerFactory.fallers ) 
			//{
				//FlxG.overlap( faller, leftPad, onLanded );
			//}
			
			//FlxG.overlap( restArea, player, onRest );
			
			
		}
		
		private function onFallerCollideLevel( faller:Faller, level:FlxTilemap ):void 
		{
			if ( !faller.landed )
			{
				FlxObject.separate( faller, level );
			}
		}
		
		private function onHealth( packet:HealthPacket, player:Player ):void 
		{
			player.onHealth( packet.strength );
			packet.onCaught();
		}
		
		private function onLanded( faller:Faller, pad:LandingPad ):void 
		{
			if ( !faller.landed )
			{
				trace( "Faller " + faller.index + " landed." );
				//trace("Overlap!" );
				faller.onLanded();
				player.onLanded( faller );
				fallerFactory.onLanded();
				//faller.kill();
			}
		}
		
		private function onGround( player:Player, level:FlxTilemap ):void 
		{
			FlxObject.separate( player, level );
			player.angle = -90;
		}
		
		private function onCatch( faller:Faller, player:Player ):void 
		{
			if ( faller.isFalling )
			{
				trace("Caught faller " + faller.index );
				player.onCaught( faller );
				faller.onCaught();
			}	
			else
			{
				
			//trace( "NOT falling" )
			}
		}
		
		private function onRest( restArea:RestArea, player:Player ): void
		{
			player.onRest( restArea.rate );
		}
		
		/* status text functions */
		public function updateDeadText(): void
		{
			var breakDown:String = "(";
			var sum:int = 0;
			for ( var i:int = 0; i <= FlxG.level; i++ )
			{
				var deaths:int = ( LevelStats )( FlxG.scores[ i ] ).numDead;
				sum += deaths;
				
				breakDown += i > 0 ? ", " : " ";	//add separators
				breakDown += deaths;				//add number
			}
			breakDown += " )";
			
			//deadText.text = DEAD_TEXT_INTRO + sum + " " + breakDown;
			deadText.text = DEAD_TEXT_INTRO + currStats.numDead;
		}
		public function updateSavedText(): void
		{
			var breakDown:String = "(";
			var sum:int = 0;
			for ( var i:int = 0; i <= FlxG.level; i++ )
			{
				var saves:int = ( LevelStats )( FlxG.scores[ i ] ).numSaved;
				sum += saves;
				
				breakDown += i > 0 ? ", " : " ";	//add separators
				breakDown += saves;				//add number
			}
			breakDown += " )";
			
			//savedText.text = SAVED_TEXT_INTRO + sum + " " + breakDown;
			savedText.text = SAVED_TEXT_INTRO + currStats.numSaved; // + " / " + currStats.numFallers;
		}
		
		public function endGame():void 
		{
			FlxG.switchState( new GameOverState() );
		}
		
		public function nextLevel():void 
		{
			FlxG.switchState( new LevelOutro() );
		}
		
		public function get landingPads():FlxGroup 
		{
			return _landingPads;
		}
	}

}
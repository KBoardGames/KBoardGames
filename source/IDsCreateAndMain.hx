package;

/**
 * ...
 * @author kboardgames.com
 */
class IDsCreateAndMain extends FlxState
{
	/******************************
	 * is it a check or checkmate? anything related to a checkmate such as setting capturing units for the king or determining if a pawn can free the king from check, etc.
	 */
	private var __chess_check_or_checkmate:ChessCheckOrCheckmate; // instance of a class.
	
	/******************************
	 * player move piece total time.
	 */
	public static var _t:Int = 0;
	
	/******************************
	 * buy, sell, trade or pay rent. main game loop.
	 */
	public var __signature_game:SignatureGameMain;
	
	/******************************
	 * the unit is highlighted when the mouse is clicked on it.
	 */
	private var __game_image_current_unit:GameImageCurrentUnit;
	
	/******************************
	* the dice wheel, highlights each number, in turn. from 1 to 6. the number highlighted, after a mouse click, is the number used to move a piece that many times from the piece's current location.
	*/
	public var __number_wheel:NumberWheel;
	
	public var _playerPieces1:Dynamic;
	public var _playerPieces2:Dynamic;
	public var _playerPieces3:Dynamic;
	public var _playerPieces4:Dynamic;
	
	/******************************
	 * the king's unit will highlight a color when king is in danger.
	 */
	private var __chess_image_future_capturing_units:ChessImageFutureCapturingUnits;
	private var __chessImagePathToKing:ChessImagePathToKing;
	
	/******************************
	 * alternating colors of game board squares. this is the light color units.
	 * see private function SignatureGameUnitOwnership.unitOwnership() to change the signature game background color that is displayed underneath the icons.
	 */
	public var _unitgameBoardColorDark:Array<FlxColor> = [0xFFc2d93c, 0xFF9d6253, 0xFF003300, 0xFFf5f151, 0xFFbbbbbb];
	
	/******************************
	 * alternating colors of game board squares. this is the dark color units.
	 * see private function SignatureGameUnitOwnership.unitOwnership() to change the signature game background color that is displayed underneath the icons.
	 */
	public var _unitgameBoardColorLight:Array<FlxColor> = [0xFF114c2e, 0xFF562a20, 0xFF004400, 0xFFf5515a, 0xFFffffff];
	
	/******************************
	 * the numbers 1 to 8 and the letter a to h at the side of the gameboard.
	 */
	private var _gameboardBorder:FlxSprite;
	
	/******************************
	 * fill the screen with a random color.
	 */
	private var _background_scene_color:FlxSprite;
	
	/******************************
	 * display an image to full the scene.
	 */
	private var _background_scene:FlxSprite;
	
	/******************************
	 * this class determines if a game has ended naturally, such as no move units to move to, or no more pieces for that player on board, etc.
	 */
	public var __ids_win_lose_or_draw:IDsWinLoseOrDraw;
	
	/******************************
	* this refers to the chess, checker or another board currently displayed.
	*/
	public static var _gameBoard:Array<FlxSprite> = [];
	
	/******************************
	 * when players can overlap one another on a game unit (games such as snakes and ladders) then this group is used to bring the player's sprite that is moving to the front.
	 */
	public var _spriteGroup:FlxGroup;
	
	/******************************
	 * holds all player's pieces. used to ADD both player's pieces to the screen.
	 */
	private var _groupPlayerPieces:FlxSpriteGroup;
	
	/******************************
	 * a sprite group that refers to highlights any square, with an image, that the player is able to move the piece to.
	 */
	private var _groupCapturingUnit:FlxSpriteGroup;
	
	
	public var __game_house_taxi_cafe:SignatureGameReferenceImages;
		
	
	public function new(ids_win_lose_or_draw:IDsWinLoseOrDraw, chess_check_or_checkmate:ChessCheckOrCheckmate) 
	{
		super();
		
		_t = 0;
		
		RegFunctions.fontsSharpen();
		
		__ids_win_lose_or_draw = ids_win_lose_or_draw;
		__chess_check_or_checkmate = chess_check_or_checkmate;
	}
	
	
	/******************************
	 * draw the board and players pieces.
	 */
	public function gameIdSetBoardAndPieces():Void
	{
		_groupCapturingUnit = new FlxSpriteGroup();
		_groupCapturingUnit.scrollFactor.set(0, 0);
		_groupPlayerPieces = new FlxSpriteGroup();
		_groupPlayerPieces.scrollFactor.set(0, 0);
		
		Reg._groupPlayer1 = new FlxSpriteGroup();
		Reg._groupPlayer1.scrollFactor.set(0, 0);
		Reg._groupPlayer2 = new FlxSpriteGroup();
		Reg._groupPlayer2.scrollFactor.set(0, 0);
		
		switch (Reg._gameId)
		{
			// checker game.
			case 0: // 0 = empty tile. 1 = player one. 11 = plyer two. 7/17:circle, 8/18:X. circle and X are used for teaching checkers. put them on the board here then screenshot the image.	
			{
				gameIdDrawboardStuff(0); // draw the standard gameboard to screen and coordinate image and any other stuff.
				
				// this is the layout of the checkers pieces when the game first starts.
				default_layout_checkers();
								
				gameIdDrawPieces(0); // this function will draw the game pieces to the screen.
			}
			
			// chess game.
			case 1: // 0 = empty tile. 1 = player one. 11 = plyer two.		
			{
				gameIdDrawboardStuff(1); // draw the standard gameboard to screen and coordinate image and any other stuff.
			
				default_layout_chess();				
				gameIdDrawPieces(1); // this function will draw the game pieces to the screen.
			}	
			// Reversi game.
			case 2:	
			{
				//#############################
				// uncomment this when testing different piece positions other than beginning of game.
				//Reg._triggerNextStuffToDo = 4;
				//#############################
				
				gameIdDrawboardStuff(2);				
				default_layout_reversi();
				gameIdDrawPieces(2);
			}
			
			// snakes and ladders game.
			case 3:	
			{
				gameIdDrawboardStuff(3);
				default_layout_snakes_and_ladders();					
				gameIdDrawPieces(3);
			}
			
			// signature game.
			case 4:	
			{
				gameIdDrawboardStuff(4);				
				default_layout_signature_game();				
				gameIdDrawPieces(4);
			}
		}	
		

	}
	
	private function default_layout_checkers():Void
	{
		/*Reg._gamePointValueOfUnit = [
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0 , 0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0, 11,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  1,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0
		];
		
		// each piece of this board has a different value from value one and incrementing.
		Reg._gameUniqueValueOfUnit = [
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0, 11,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  4,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0
		];*/
		/*
		Reg._gamePointValueOfUnit = [
		 0, 11,  0, 11,  0, 11,  0, 11,
		 11, 0, 11,  0, 11,  0, 11,  0,
		 0, 11,  0, 11,  0, 11,  0, 11,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 1,  0,  1,  0,  1,  0,  1,  0,
		 0,  1,  0,  1,  0,  1,  0,  1,
		 1,  0,  1,  0,  1,  0,  1,  0
		];
		
		// each piece of this board has a different value from value one and incrementing.
		Reg._gameUniqueValueOfUnit = [
		 0,  1,  0,  2,  0,  3,  0,  4,
		 5,  0,  6,  0,  7,  0,  8,  0,
		 0,  9,  0, 10,  0, 11,  0, 12,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 1,  0,  2,  0,  3,  0,  4,  0,
		 0,  5,  0,  6,  0,  7,  0,  8,
		 9,  0, 10,  0, 11,  0, 12,  0
		];*/
		/* // jump test
		Reg._gamePointValueOfUnit = [
		 0, 11,  0, 11,  0, 11,  0, 11,
		11,  0,  1,  0,  11, 0, 11,  0,
		 0, 11,  0,  0,  0, 11,  0, 11,
		 0,  0,  1,  0,  1,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 1,  0,  0,  0,  0,  0,  1,  0,
		 0, 11,  0,  1,  0,  1,  0,  0,
		 0,  0,  0,  0,  1,  0,  1,  0
		];
		
		// each piece of this board has a different value from value one and incrementing.
		Reg._gameUniqueValueOfUnit = [
		 0,  1,  0,  2,  0,  3,  0,  4,
		 6,  0,  2,  0,  7,  0,  8,  0,
		 0,  9,  0,  0,  0, 11,  0, 12,
		 0,  0,  1,  0,  3,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 9,  0,  0,  0,  0,  0,  4,  0,
		 0,  5,  0,  6,  0,  7,  0,  0,
		 0,  0,  0,  0, 11,  0, 12,  0
		];*/
		/*
		Reg._gamePointValueOfUnit = [
		 0, 11,  0, 11,  0,  0,  0,  0,
		 11, 0, 11,  0,  11, 0,  1,  0,
		 0,  0,  0,  0,  0,  0, 0,  0,
		 0,  0, 11,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  1,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  1,  0,  1,  0,  1,  0,  1,
		 1,  0,  0,  0,  0,  0,  0,  0
		];
		
		// each piece of this board has a different value from value one and incrementing.
		Reg._gameUniqueValueOfUnit = [
		 0,  1,  0,  2,  0,  0,  0,  0,
		 3,  0,  4,  0,  8,  0,  1,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  7,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  9,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  5,  0,  6,  0,  7,
		 8,  0,  0,  0,  0,  0,  0,  0
		];
		*/
		
		Reg._gamePointValueOfUnit = [
		 0, 11,  0, 11,  0, 11,  0, 11,
		 11, 0, 11,  0, 11,  0, 11,  0,
		 0, 11,  0, 11,  0, 11,  0, 11,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 1,  0,  1,  0,  1,  0,  1,  0,
		 0,  1,  0,  1,  0,  1,  0,  1,
		 1,  0,  1,  0,  1,  0,  1,  0
		];
		
		// each piece of this board has a different value from value one and incrementing.
		Reg._gameUniqueValueOfUnit = [
		 0,  1,  0,  2,  0,  3,  0,  4,
		 5,  0,  6,  0,  7,  0,  8,  0,
		 0,  9,  0, 10,  0, 11,  0, 12,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 1,  0,  2,  0,  3,  0,  4,  0,
		 0,  5,  0,  6,  0,  7,  0,  8,
		 9,  0, 10,  0, 11,  0, 12,  0
		];
	}
	
	private function default_layout_chess():Void
	{
		// the first element is the top right corner of the board. element 2 or unit number 2 has a value of 12. white piece rook has a value of 4 and black piece is plus 10 that amount at 14. so, rook is 4/14, horse 3/13, bishop 2/12, queen 5/15, king 6/16 and pawn 1/11. 
				
		// these point values are not the values of a normal chess piece. a normal piece for horse and bishop has a value of 3 but in code a value of 3 is for a horse while 2 is for bishop.
		// 1/11 pawn. 2:12 bishop, 3:13 horse, 4/14 rook. 5/15 queen. 6/16 king. 7/17:circle, 8/18:X. circle and X are used for teaching chess. put them on the board here then screenshot the image.
		
		// unique values of pieces. 1-9 pawn. 10-19 bishop. 20-29 horse. 30-39 rook. 40-49 queen. 50 king.
		// pieces on set.	
		/*Reg._gamePointValueOfUnit = [
		16, 12,  0,  0,  0,  0,  0,  0,
		 0,  0, 12,  0,  0,  0,  0,  0,
		 0,  0,  0, 12,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0, 
		 0,  0,  0,  0,  0,  0,  1,  0,
		 0,  0,  0,  0,  0,  0,  0,  2,
		 6,  1,  0,  0,  1,  0,  0,  4
		];
						
		Reg._gameUniqueValueOfUnit = [
	   50,  10,  0,  0,  0,  0,  0,  0,
		0,  0,  11,  0,  0,  0,  0,  0,
		0,  0,  0, 12,  0,  0,  0,  0,
		0,  0,  0,  0,  0,  0,  0,  0,
		0,  0,  0,  0,  0,  0,  0,  0,
		0,  0,  0,  0,  0,  0,  2,  0,
		0,  1,  0,  0,  0,  0,  0,  10,
	   50,  0,  0,  0,  3,  0,  0,  40
		];*/ 
		/*
		Reg._gamePointValueOfUnit = [
		13, 0,  0,  0,  0,  0,  0,  0,
		0,  0,  0,  0,  0,  0,  0,  0,
		0,  0,  0, 16,  0,  0,  0,  0,
		0,  0, 14,  0,  0,  0, 11,  0,
		0,  0,  0, 14,  0,  0,  0,  0, 
		5,  0,  0, 13,  0,  0,  0,  0,
		5,  0,  0,  5,  0,  0,  0,  0,
		6,  0,  0,  0,  0,  0,  1,  0
		];
						
		Reg._gameUniqueValueOfUnit = [
		20, 0,  0,  0,  0,  0,  0,  0,
		0,  0,  0,  0,  0,  0,  0,  0,
		0,  0,  0, 50,  0,  0,  0,  0,
		0,  0, 31,  0,  0,  0,  1,  0,
		0,  0,  0, 30,  0,  0,  0,  0,
		40, 0,  0, 20,  0,  0,  0,  0,
		42, 0,  0, 43,  0,  0,  0,  0,
		50, 0,  0,  0,  0,  0,  1,  0
		];*/
		/*
		Reg._gamePointValueOfUnit = [
		0,  0,  0,  0,  0,  0,  0,  0,
	   11, 11,  0,  0,  0,  0,  0,  0,
		0,  0,  0,  0,  0,  0,  0,  0,
		0,  0,  0,  0,  0,  0,  1,  0,
		0, 16,  0,  0,  0,  0,  0,  0, 
		0,  0,  0, 11, 15,  0,  0,  0,
		0,  0,  0,  0,  0,  0,  0,  0,
		6,  0,  0,  0,  0,  0,  0,  0
		];
						
		Reg._gameUniqueValueOfUnit = [
		0,  0,  0,  0,  0,  0,  0,  0,
		6,  7,  0,  0,  0,  0,  0,  0,
		0,  0,  0,  0,  0,  0,  0,  0,
		0,  0,  0,  0,  0,  0,  7,  0,
		0, 50,  0,  0,  0,  0,  0,  0,
		0,  0,  0,  1, 41,  0,  0,  0,
		0,  0,  0,  0,  0,  0,  0,  0,
		50, 0,  0,  0,  0,  0,  0,  0
		];*/
		/*
		Reg._gamePointValueOfUnit = [
		0,  0,  0,  0,  0,  0,  0,  0,
		0,  0, 15,  0,  0,  0,  0,  0,
		0,  0,  0,  0, 16, 13,  0,  0,
		0,  0,  0, 14, 12,  0,  0,  0,
		0,  0,  0,  0,  0,  0,  0,  0, 
		0,  5,  0,  0,  0,  0,  0,  0,
		6,  0,  0,  0,  0,  0,  0,  0,
		0,  0,  0,  0,  0, 12,  3,  4
		];
					
		 Reg._gameUniqueValueOfUnit = [
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0, 40,  0,  0,  0,  0,  0,
		 0,  0,  0,  0, 50, 21,  0,  0,
		 0,  0,  0, 30, 11,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0, 40,  0,  0,  0,  0,  0,  0,
		 50, 0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0, 10, 21, 31			
		];*/
		/*
		Reg._gamePointValueOfUnit = [
		12,  0, 0, 15, 16, 0, 0, 0,
		13, 0,  14, 0, 11, 11, 11, 11,
		14,  0, 14,  0,  0,  0,  0,  0,
		 0,  13, 0,  0,  0, 0,  0,  0,
		 0,  0,  0,  0, 11, 0,  0,  0, 
		 0,  6,  1,  1,  0,  0,  0,  0,
		 0,  1,  1,  0,  1,  0,  1,  1,
		 0,  3,  0,  0,  0,  0,  3,  4
		];
		
		Reg._gameUniqueValueOfUnit = [
		 10, 0, 0,  40,  50,  0,  0,  0,
		 20, 0, 31,  0,  4,  6,  7,  8,
		 30, 0, 32,  0,  0,  0,  0,  0,
		 0, 21,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  5,  0,  0,  0,
		 0, 50,  1,  4,  0,  0,  0,  0,
		 0,  2,  3,  0,  5,  0,  7,  8,
		 0, 20,  0,  0,  0,  0,  21, 31
		 ];
		*/
		 /*	 
		Reg._gamePointValueOfUnit = [
		14, 13, 12, 15, 16, 12, 13, 14,
		11, 11, 11, 11, 11,  0,  0, 11,
		 0,  0,  0,  0,  0, 11,  0,  0,
		 0,  0,  0,  0,  0,  0, 11,  0,
		 0,  0,  0,  0,  0,  0,  0,  0, 
		 0,  0,  0,  0,  1,  0,  0,  0,
		 1,  1,  1,  1,  0,  1,  1,  1,
		 4,  3,  2,  5,  6,  2,  3,  4
		];
						
		Reg._gameUniqueValueOfUnit = [
		 30, 20, 10, 40, 50, 11, 21, 31,
		 1,  2,  3,  4,  5,  0,  0,  8,
		 0,  0,  0,  0,  0,  6,  0,  0,
		 0,  0,  0,  0,  0,  0,  7,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  5,  0,  0,  0,
		 1,  2,  3,  4,  0,  6,  7,  8,
		 30, 20, 10, 40, 50, 11, 21, 31
		 ];
		*//*
		Reg._gamePointValueOfUnit = [
		0, 0, 0, 0,16, 0, 0, 14,
		0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0, 
		 0,  0,  0,  0,  0,  0, 14,  0,
		 1,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  6,  5,  0,  0
		];
						
		Reg._gameUniqueValueOfUnit = [
		 0, 0, 0, 0, 50, 0, 0, 31,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  30,  0,
		 1,  0,  0,  0,  0,  0,  0,  0,
		 0, 0, 0, 0, 50, 40, 0, 0
		 ];*/
		
		 /*
		Reg._gamePointValueOfUnit = [
		14,  0, 12, 15, 16, 12, 0, 14,
		11, 11, 11, 11, 11,  0, 11, 11,
		 0,  0, 13,  0,  0, 11,  0, 13,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  2,  1,  0,  0,  0,  0, 
		 0,  0,  0,  0,  1,  0,  0,  0,
		 1,  1,  1,  0,  0,  1,  1,  1,
		 4,  3,  2,  5,  6,  0,  3,  4
		];
						
		Reg._gameUniqueValueOfUnit = [
		 30, 0, 10, 40, 50, 11, 0, 31,
		 1,  2,  3,  4,  5,  0,  7,  8,
		 0,  0, 20,  0,  0,  6,  0,  21,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0, 11,  4,  0,  0,  0,  0,
		 0,  0,  0,  0,  5,  0,  0,  0,
		 1,  2,  3,  0,  0,  6,  7,  8,
		 30, 20, 10, 40, 50, 0, 21, 31
		 ];*/
		
		 Reg._gamePointValueOfUnit = [
		14, 13, 12, 15, 16, 12, 13, 14,
		11, 11, 11, 11, 11, 11, 11, 11,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0, 
		 0,  0,  0,  0,  0,  0,  0,  0,
		 1,  1,  1,  1,  1,  1,  1,  1,
		 4,  3,  2,  5,  6,  2,  3,  4
		];
						
		Reg._gameUniqueValueOfUnit = [
		 30, 20, 10, 40, 50, 11, 21, 31,
		 1,  2,  3,  4,  5,  6,  7,  8,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 1,  2,  3,  4,  5,  6,  7,  8,
		 30, 20, 10, 40, 50, 11, 21, 31
		 ];
	}
	
	private function default_layout_reversi():Void
	{
		/*Reg._gamePointValueOfUnit = [
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  1,  1,  0,  0,  0,
		 0,  0,  0, 11,  1,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  1, 11,  1,  0,  0,  0
		];
		
		// in the Reversi game the _gameUniqueValueOfUnit var is not needed.
		Reg._gameUniqueValueOfUnit = [
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0
		];*/
		/*
		Reg._gamePointValueOfUnit = [
		 0,  0,  1, 11,  1,  1,  1, 11,
		 0,  1,  1,  1,  1,  1,  1, 11,
		11,  1,  1,  1,  1,  1,  1, 11,
		 1,  1,  1,  1,  1,  1,  1, 11,
		 1,  1,  1,  1,  1,  1,  1, 11,
		 1,  1,  1,  1,  1,  1,  1, 11,
		 1, 11,  1,  1,  1, 11, 11, 11,
		 1,  1,  1,  1,  1,  1, 11, 11
		];
		
		Reg._gameUniqueValueOfUnit = [
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0
		];
		*/	
		Reg._gamePointValueOfUnit = [
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0
		];
		
		Reg._gameUniqueValueOfUnit = [
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0
		];
		/*Reg._gamePointValueOfUnit = [
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  1, 11,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0
		];
		
		Reg._gameUniqueValueOfUnit = [
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0
		];*/
	}
	
	private function default_layout_snakes_and_ladders():Void
	{
		Reg._gamePointValueOfUnit = [
		64, 63, 62, 61, 60, 59, 58, 57,
		49, 50, 51, 52, 53, 54, 55, 56,
		48, 47, 46, 45, 44, 43, 42, 41,
		33, 34, 35, 36, 37, 38, 39, 40,
		32, 31, 30, 29, 28, 27, 26, 25,
		17, 18, 19, 20, 21, 22, 23, 24,
		16, 15, 14, 13, 12, 11, 10,  9,
		 1,  2,  3,  4,  5,  6,  7,  8
		];
		
		// not needed.
		Reg._gameUniqueValueOfUnit = [
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0
		];	
	}
	
	private function default_layout_signature_game():Void
	{
		// dice moves in this order. 0: not a playable unit
		Reg._gamePointValueOfUnit = [
		22, 21, 20, 19, 18, 17, 16, 15,
		23, 44, 43, 42, 41, 40, 39, 14,
		24, 45,  0,  0,  0,  0, 38, 13,
		25, 46,  0,  0,  0,  0, 37, 12,
		26, 47,  0,  0,  0,  0, 36, 11,
		27, 48,  0,  0,  0,  0, 35, 10,
		28, 29, 30, 31, 32, 33, 34,  9,
		 1,  2,  3,  4,  5,  6,  7,  8
		];
		
		// -1 = not used. 0 = nobody owns this unit. 1 = player 1's unit. 2:player 2's unit. 3:player 3's unit. 4:player 4's unit.
		Reg._gameUniqueValueOfUnit = [
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0, -1, -1, -1, -1,  0,  0,
		 0,  0, -1, -1, -1, -1,  0,  0,
		 0,  0, -1, -1, -1, -1,  0,  0,
		 0,  0, -1, -1, -1, -1,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0
		];
		
		// the total amount of houses, taxi cabs and cafe stores that a player has.
		Reg._gameHouseTaxiCabOrCafeStoreValueOfUnit = [
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0
		];
		
		// This is used to determine if unit is a 1:house. 2:taxi cab. 3:cafe store. this var can be used with 2 vars such as the Reg._gameYYold and Reg._gameXXold to find its value.
		Reg._gameHouseTaxiCabOrCafeStoreTypeOfUnit = [
		 0,  1,  0,  2,  3,  1,  1,  0,
		 3,  0,  0,  0,  0,  0,  0,  1,
		 2,  0,  0,  0,  0,  0,  0,  1,
		 1,  0,  0,  0,  0,  0,  0,  3,
		 1,  0,  0,  0,  0,  0,  0,  1,
		 1,  0,  0,  0,  0,  0,  0,  1,
		 1,  0,  0,  0,  0,  0,  0,  2,
		 0,  1,  1,  1,  2,  3,  0,  0
		];
			
		// building groups.
		Reg._gameUnitGroupsValueOfUnit = [
		 0,  5,  0,  0,  0,  4,  4,  0,
		 0,  0,  0,  0,  0,  0,  0,  3,
		 0,  0,  0,  0,  0,  0,  0,  3,
		 6,  0,  0,  0,  0,  0,  0,  0,
		 6,  0,  0,  0,  0,  0,  0,  2,
		 6,  0,  0,  0,  0,  0,  0,  2,
		 6,  0,  0,  0,  0,  0,  0,  0,
		 0,  1,  1,  1,  0,  0,  0,  0
		];
	}
	
	private function gameIdDrawPieces(id:Int):Void
	{
		var pp = -1;
		
		if (RegTypedef._dataTournaments._move_piece == false)
			RegTypedef._dataPlayers._moveTotal = 0;
			
		// TODO remove.
		//RegTypedef._dataMovement._history_get_all == 0
		
		if (RegTypedef._dataMovement._history_get_all == 1)
		{
			for (yy in 0...8)
			{
				for (xx in 0...8)
				{
					pp += 1;
					
					Reg._gamePointValueForPiece[yy][xx] = Reg._gamePointValueForPiece2[yy][xx];
					Reg._gameUniqueValueForPiece[yy][xx] = Reg._gameUniqueValueForPiece2[yy][xx];
					
					Reg._gamePointValueOfUnit[pp] = Reg._gamePointValueForPiece[yy][xx];
				}
			}
		}
		
		else
		{
			// important. must clear all vars so that after game over the back history button works for moves in event "Move History All Entry". The vars cannot be cleared at Reg because they are passed to the Game room class.
			Reg._moveHistoryPieceLocationOld1.splice(0, Reg._moveHistoryPieceLocationOld1.length);
			Reg._moveHistoryPieceLocationNew1.splice(0, Reg._moveHistoryPieceLocationNew1.length);
			Reg._moveHistoryPieceLocationOld2.splice(0, Reg._moveHistoryPieceLocationOld2.length); 
			Reg._moveHistoryPieceLocationNew2.splice(0, Reg._moveHistoryPieceLocationNew2.length);
			Reg._moveHistoryPieceValueOld1.splice(0, Reg._moveHistoryPieceValueOld1.length);
			Reg._moveHistoryPieceValueNew1.splice(0, Reg._moveHistoryPieceValueNew1.length);
			Reg._moveHistoryPieceValueOld2.splice(0, Reg._moveHistoryPieceValueOld2.length);
			Reg._moveHistoryPieceValueNew2.splice(0, Reg._moveHistoryPieceValueNew2.length);
			Reg._moveHistoryPieceValueOld3.splice(0, Reg._moveHistoryPieceValueOld3.length);
			Reg._step = 0;
			//------------------------------
		}
		
		switch (id)
		{
			case 0: create_checkers_game();
			case 1: create_chess_game();
			case 2: create_reversi_game();
			case 3: create_snakes_and_ladders_game();
			case 4: create_signature_game();
		}
				
		RegTypedef._dataMovement._history_get_all = 0;
		
		// unit is surrounded by a border at the location of the mouse. when the mouse moves around the grid then so does this border move.
		__game_image_current_unit = new GameImageCurrentUnit(_gameBoard[0].y, _gameBoard[0].x);
		__game_image_current_unit.scrollFactor.set(0, 0);
		add(__game_image_current_unit);
		

	}
	
	private function create_checkers_game():Void
	{
		var p = -1; // gameboard pieces.
		
		for (y in 0...8)
		{
			for (x in 0...8)
			{
				p += 1;
				
				// each piece is now stored in a XY coordinate system so that a piece can be found using a mouse.
				if (RegTypedef._dataMovement._history_get_all == 0)
				{
					Reg._gamePointValueForPiece[y][x] = Reg._gamePointValueOfUnit[p];
					Reg._gameUniqueValueForPiece[y][x] = Reg._gameUniqueValueOfUnit[p];
				}
				
				Reg._capturingUnitsForImages[0][y][x] = 0;
				Reg._capturingUnitsForImages[1][y][x] = 0;
				
				
				// highlights any square, with an image, that the player is able to move the piece to. note that the x and y values here are reverse of the class. it works. don't change them.
				var _capturingUnits = new CheckersImagesCapturingUnits(_gameBoard[0].x + (x * 75), _gameBoard[0].y + (y * 75), x, y);					
				_capturingUnits.scrollFactor.set(0, 0);
				_groupCapturingUnit.add(_capturingUnits);
				add(_groupCapturingUnit);			
				
				var _playerPieces = new CheckersMovePlayersPiece(_gameBoard[0].x + (x * 75), _gameBoard[0].y + (y * 75), Reg._gamePointValueOfUnit[p], p, __ids_win_lose_or_draw); // pieces are 75x75 pixels wide.
				_playerPieces.scrollFactor.set(0, 0);
				_groupPlayerPieces.add(_playerPieces);
				add(_groupPlayerPieces);
				
				// add the white pieces to this group.
				if (Reg._gamePointValueOfUnit[p] < 11 && Reg._gamePointValueOfUnit[p] > 0) // value 11+ is second player's gameboard pieces. 
				{
					Reg._groupPlayer1.add(_playerPieces);
					add(Reg._groupPlayer1);
				}
				
				// add the black pieces to this group.
				else if (Reg._gamePointValueOfUnit[p] >= 11) 
				{				
					Reg._groupPlayer2.add(_playerPieces);
					add(Reg._groupPlayer2);
				}
			}
		}
	}

	private function create_chess_game():Void
	{
		var p = -1; // gameboard pieces.
		
		if (RegCustom._chess_future_capturing_units_enabled == true)
		{
			for (y in 0...8)
			{
				for (x in 0...8)
				{
					// the king's unit will highlight a color when king is in danger.
					__chess_image_future_capturing_units = new ChessImageFutureCapturingUnits(_gameBoard[0].x + (x * 75), _gameBoard[0].y + (y * 75), x, y);
					__chess_image_future_capturing_units.scrollFactor.set(0, 0);
					add(__chess_image_future_capturing_units);
					
				}
			}
			
		}
		 
		// keep this outside of the above loop, so that when displaying an image of the capturing path to king at __chessImagePathToKing class, that class can set a var to hide the future capturing path to king image that might be displayed overtop of that unit that was set at __chess_image_future_capturing_units class.
		if (RegCustom._chess_path_to_king_enabled == true)
		{
			for (y in 0...8)
			{
				for (x in 0...8)
				{
					// path to king is units that can capture the king in a straight line.
					var __chessImagePathToKing = new ChessImagePathToKing(_gameBoard[0].x + (x * 75), _gameBoard[0].y + (y * 75), x, y);
					__chessImagePathToKing.scrollFactor.set(0, 0);
					add(__chessImagePathToKing);
				}
			}
		}
		
		for (y in 0...8)
		{
			for (x in 0...8)
			{
				p += 1;
				
				// each piece is now stored in a XY coordinate system so that a piece can be found using a mouse.				
				if (RegTypedef._dataMovement._history_get_all == 0)
				{
					Reg._gamePointValueForPiece[y][x] = Reg._gamePointValueOfUnit[p];
					Reg._gameUniqueValueForPiece[y][x] = Reg._gameUniqueValueOfUnit[p];
				}
				
				Reg._capturingUnitsForImages[0][y][x] = 0;
				Reg._capturingUnitsForImages[1][y][x] = 0;
				
				
				// highlights any square, with a square image, that the player is able to move the piece to. note that the x and y values here are reverse of the class. it works. don't change them.
				var _capturingUnits = new ChessImagesCapturingUnits(_gameBoard[0].x + (x * 75), _gameBoard[0].y + (y * 75), x, y);					
				_capturingUnits.scrollFactor.set(0, 0);
				_groupCapturingUnit.add(_capturingUnits);
				add(_groupCapturingUnit);
									
				var _playerPieces = new ChessMovePlayersPiece(_gameBoard[0].x + (x * 75), _gameBoard[0].y + (y * 75), Reg._gamePointValueOfUnit[p], p); // pieces are 75x75 pixels wide.
				_playerPieces.scrollFactor.set(0, 0);
				_groupPlayerPieces.add(_playerPieces);
				add(_groupPlayerPieces);
				
				// add the white pieces to this group.
				if (Reg._gamePointValueOfUnit[p] < 11 && Reg._gamePointValueOfUnit[p] > 0) // value 11+ is second player's gameboard pieces. 
				{
					Reg._groupPlayer1.add(_playerPieces);
					add(Reg._groupPlayer1);
				}
				
				// add the black pieces to this group.
				else if (Reg._gamePointValueOfUnit[p] >= 11) 
				{				
					Reg._groupPlayer2.add(_playerPieces);
					add(Reg._groupPlayer2);
				}
			}
		}
	}
	
	private function create_reversi_game():Void
	{
		var p = -1; // gameboard pieces.
		
		for (y in 0...8)
		{
			for (x in 0...8)
			{
				p += 1;
				
				// each piece is now stored in a XY coordinate system so that a piece can be found using a mouse.				
				Reg._gamePointValueForPiece[y][x] = Reg._gamePointValueOfUnit[p];
				Reg._capturingUnitsForImages[0][y][x] = 0;
				Reg._capturingUnitsForImages[1][y][x] = 0;
				Reg._gameUniqueValueForPiece[y][x] = Reg._gameUniqueValueOfUnit[p];
				
				// highlights any square, with an image, that the player is able to move the piece to. note that the x and y values here are reverse of the class. it works. don't change them.
				var _capturingUnits = new ReversiImagesCapturingUnits(_gameBoard[0].x + (x * 75), _gameBoard[0].y + (y * 75), x, y);					
				_capturingUnits.scrollFactor.set(0, 0);
				_groupCapturingUnit.add(_capturingUnits);
				add(_groupCapturingUnit);			
				
				var _playerPieces = new ReversiMovePlayersPiece(_gameBoard[0].x + (x * 75), _gameBoard[0].y + (y * 75), Reg._gamePointValueOfUnit[p], p); // pieces are 75x75 pixels wide.
				_playerPieces.scrollFactor.set(0, 0);
				_groupPlayerPieces.add(_playerPieces);
				add(_groupPlayerPieces);
				
				// add the white pieces to this group.
				if (Reg._gamePointValueOfUnit[p] < 11 && Reg._gamePointValueOfUnit[p] > 0) // value 11+ is second player's gameboard pieces. 
				{
					Reg._groupPlayer1.add(_playerPieces);
					add(Reg._groupPlayer1);
				}
				
				// add the black pieces to this group.
				else if (Reg._gamePointValueOfUnit[p] >= 11) 
				{				
					Reg._groupPlayer2.add(_playerPieces);
					add(Reg._groupPlayer2);
				}
			}
		}
		
		// the unit is highlighted when the mouse is clicked on it.
		var _currentUnitClicked = new ReversiCurrentUnitClicked(Std.int(_gameBoard[0].y), Std.int(_gameBoard[0].x), __ids_win_lose_or_draw);
		_currentUnitClicked.scrollFactor.set(0, 0);
		add(_currentUnitClicked);
		
		var _reversi_unit_total = new ReversiUnitsTotal();
		add(_reversi_unit_total);
	}
	
	private function create_snakes_and_ladders_game():Void
	{
		var p = -1; // gameboard pieces.
		
		// display the snakes and ladders. including the arrows.
		var _snakesAndLaddersImage = new SnakesAndLaddersImage(_gameBoard[0].x, _gameBoard[0].y);					
		_snakesAndLaddersImage.scrollFactor.set(0, 0);
		add(_snakesAndLaddersImage);

		for (y in 0...8)
		{
			for (x in 0...8)
			{
				// highlights any square, with a square image, that the player is able to move the piece to. note that the x and y values here are reverse of the class. it works. don't change them.
				var _capturingUnitsPlayer1a = new SnakesAndLaddersImagesCapturingUnits(_gameBoard[0].x + (x * 75), _gameBoard[0].y + (y * 75), 1, x, y);						
				_capturingUnitsPlayer1a.scrollFactor.set(0, 0);
				_groupCapturingUnit.add(_capturingUnitsPlayer1a);
				
				var _capturingUnitsPlayer1b = new SnakesAndLaddersImagesCapturingUnits(_gameBoard[0].x + (x * 75), _gameBoard[0].y + (y * 75), 2, x, y);						
				_capturingUnitsPlayer1b.scrollFactor.set(0, 0);
				_groupCapturingUnit.add(_capturingUnitsPlayer1b);
				
				var _capturingUnitsPlayer2a = new SnakesAndLaddersImagesCapturingUnits(_gameBoard[0].x + (x * 75), _gameBoard[0].y + (y * 75), 3, x, y);						
				_capturingUnitsPlayer2a.scrollFactor.set(0, 0);
				_groupCapturingUnit.add(_capturingUnitsPlayer2a);
				
				var _capturingUnitsPlayer2b = new SnakesAndLaddersImagesCapturingUnits(_gameBoard[0].x + (x * 75), _gameBoard[0].y + (y * 75), 4, x, y);						
				_capturingUnitsPlayer2b.scrollFactor.set(0, 0);
				_groupCapturingUnit.add(_capturingUnitsPlayer2b);
				
				add(_groupCapturingUnit);
			}
		}
		
					
		//##########################  PLAYER'S PIECE #############################
		// player's piece used to navigate the game board.
		_spriteGroup = new FlxGroup();
		
		_playerPieces2 = new SnakesAndLaddersMovePlayersPiece(_gameBoard[0].x - 75, _gameBoard[0].y + (7 * 75), 2, __ids_win_lose_or_draw); // pieces are 75x75 pixels wide.
		_playerPieces2.scrollFactor.set(0, 0);
		_spriteGroup.add(_playerPieces2);
		
		_playerPieces1 = new SnakesAndLaddersMovePlayersPiece(_gameBoard[0].x - 75, _gameBoard[0].y + (7 * 75), 1, __ids_win_lose_or_draw); // pieces are 75x75 pixels wide.
		_playerPieces1.scrollFactor.set(0, 0);
		_spriteGroup.add(_playerPieces1);

		add(_spriteGroup);
					
		dice(FlxG.width - 283, FlxG.height - 453);
										
		for (y in 0...8)
		{
			for (x in 0...8)
			{
				p += 1;
				
				// each piece is now stored in a XY coordinate system so that a piece can be found using a mouse.				
				Reg._gamePointValueForPiece[y][x] = Reg._gamePointValueOfUnit[p];
				Reg._gameUniqueValueForPiece[y][x] = Reg._gameUniqueValueOfUnit[p];
			}
		}
	}
	
	private function create_signature_game():Void
	{
		var p = -1; // gameboard pieces.
			
		for (y in 0...8)
		{
			for (x in 0...8)
			{
				p += 1;
				
				// each piece is now stored in a XY coordinate system so that a piece can be found using a mouse.				
				Reg._gamePointValueForPiece[y][x] = Reg._gamePointValueOfUnit[p];
				Reg._gameUniqueValueForPiece[y][x] = Reg._gameUniqueValueOfUnit[p];
				Reg._gameHouseTaxiCabOrCafeStoreForPiece[y][x] = Reg._gameHouseTaxiCabOrCafeStoreValueOfUnit[p];					
				Reg._gameHouseTaxiCabOrCafeStoreTypePiece[y][x] = Reg._gameHouseTaxiCabOrCafeStoreTypeOfUnit[p];					
				Reg._gameUnitGroupsForPiece[y][x] = Reg._gameUnitGroupsValueOfUnit[p];				
				
			}
		}
		
		// unit border.
		var _unitBorder = new FlxSprite();
		_unitBorder.loadGraphic("assets/images/signatureGameUnitsBorder.png", false);
		_unitBorder.setPosition(Reg._unitXgameBoardLocation[0], Reg._unitYgameBoardLocation[0]+5);
		add(_unitBorder);		
		
		
		var p = -1; // gameboard pieces.
		
		for (y in 0...8)
		{
			for (x in 0...8)
			{
				p += 1;
				
				// highlights any square, with an image, that the player is able to move the piece to.
				if (y > 1 && y < 6 && x > 1 && x < 6) {} // don't draw centre unit if playing the signature game.
				else
				{
					// note that the x and y values here are reverse of the class. it works. don't change them.
					var _gameDevelopedLandIcons = new 
					SignatureGameDevelopedLandImages(_gameBoard[0].x + (x * 75) + 5, _gameBoard[0].y + (y * 75) + 5, Reg._gamePointValueOfUnit[p], p); // pieces are 75x75 pixels wide.
					_gameDevelopedLandIcons.scrollFactor.set(0, 0);
					_groupPlayerPieces.add(_gameDevelopedLandIcons);
															
					__game_house_taxi_cafe = new 
					SignatureGameReferenceImages(_gameBoard[0].x + (x * 75) + 5, _gameBoard[0].y + (y * 75) + 5, Reg._gameHouseTaxiCabOrCafeStoreValueOfUnit[p], p); // pieces are 75x75 pixels wide.
					__game_house_taxi_cafe.scrollFactor.set(0, 0);
					_groupPlayerPieces.add(__game_house_taxi_cafe);
					
					add(_groupPlayerPieces);
					
				}
			}
		}			
		
		//#############################  PLAYER'S PIECE
		addSpriteGroup();
					
		__signature_game = new SignatureGameMain();
		add(__signature_game);
					
		dice(FlxG.width - 283, FlxG.height - 453);		
	
		if (Reg._gameId == 4) 
		{	
			var _informationCards = new SignatureGameInformationCards(_gameBoard[0].y, _gameBoard[0].x);
			add(_informationCards);

		}	
	}
	
	public function removeSpriteGroup():Void
	{
		if (_spriteGroup != null)
		{
			if (_spriteGroup.members != null)
			{
				if (_playerPieces1 != null)
				{
					_spriteGroup.members.remove(_playerPieces1);
					_playerPieces1.visible = false;
					_playerPieces1 = null;
				}
				
				if (_playerPieces2 != null)
				{
					_spriteGroup.members.remove(_playerPieces2);
					_playerPieces2.visible = false;
					_playerPieces2 = null;
				}
				
				if (_playerPieces3 != null)
				{
					_spriteGroup.members.remove(_playerPieces3);
					_playerPieces3.visible = false;
					_playerPieces3 = null;
				}
				
				if (_playerPieces4 != null)
				{
					_spriteGroup.members.remove(_playerPieces4);
					_playerPieces4.visible = false;
					_playerPieces4 = null;
				}
				
				_spriteGroup.members = null;
			}
			
			_spriteGroup.visible = false;		
			remove(_spriteGroup);
			
			_spriteGroup.destroy();
			_spriteGroup = null;
		}
				
		
		
	}
	
	public function addSpriteGroup():Void
	{
		// player's piece used to navigate the game board.
		_spriteGroup = new FlxGroup();		
		
		var _y = 0;
		var _x = 0;
	
		// x and y values are in correct positions. These are player's game pieces. they represent the player. player has one piece, different then the other pieces. the piece that is about to move, after a dice rotation mouse click, will be sent to the front of all other pieces.
		_y = get_piece_location_from_value_y(0);
		_x = get_piece_location_from_value_x(0);
		
		_playerPieces1 = new SignatureGameMovePlayersPiece(_gameBoard[0].x + (_x * 75), _gameBoard[0].y + (_y * 75), 1, __ids_win_lose_or_draw); // pieces are 75x75 pixels wide.
		_playerPieces1.scrollFactor.set(0, 0);
		_spriteGroup.add(_playerPieces1);
		
		// need + 1 because Reg._totalPlayersInRoom starts with 0 for the first player.
		if (Reg._totalPlayersInRoom + 1 >= 2)
		{
			_y = get_piece_location_from_value_y(1);
			_x = get_piece_location_from_value_x(1);
			
			_playerPieces2 = new SignatureGameMovePlayersPiece(_gameBoard[0].x + (_x * 75), _gameBoard[0].y + (_y * 75), 2, __ids_win_lose_or_draw); // pieces are 75x75 pixels wide.
			_playerPieces2.scrollFactor.set(0, 0);
			_spriteGroup.add(_playerPieces2);			
		}
		
		if (Reg._totalPlayersInRoom + 1 >= 3)
		{
			_y = get_piece_location_from_value_y(2);
			_x = get_piece_location_from_value_x(2);
			
			_playerPieces3 = new SignatureGameMovePlayersPiece(_gameBoard[0].x + (_x * 75), _gameBoard[0].y + (_y * 75), 3, __ids_win_lose_or_draw); // pieces are 75x75 pixels wide.
			_playerPieces3.scrollFactor.set(0, 0);
			_spriteGroup.add(_playerPieces3);
		}
		
		if (Reg._totalPlayersInRoom + 1 >= 4)
		{
			_y = get_piece_location_from_value_y(3);
			_x = get_piece_location_from_value_x(3);
			
			_playerPieces4 = new SignatureGameMovePlayersPiece(_gameBoard[0].x + (_x * 75), _gameBoard[0].y + (_y * 75), 4, __ids_win_lose_or_draw); // pieces are 75x75 pixels wide.
			_playerPieces4.scrollFactor.set(0, 0);
			_spriteGroup.add(_playerPieces4);
		}
		
		add(_spriteGroup);
		
	}
		
	// when a player leaves the game and the game continues for the other players, a new piece color is given to each player. this function is used to move the new colored piece for the player back to the location where the last player's color was at. this gets the value of the piece location. y coordinates. 
	private function get_piece_location_from_value_y(_num):Int
	{
		var _y = 0;
		
		for (yy in 0...8)
		{
			for (xx in 0...8)
			{
				if (Reg._gamePointValueForPiece[yy][xx] == (Reg._gameDiceCurrentIndex[_num] + 1))
				{
					_y = yy;
				}
				
			}
		}
	
		return _y;
	}
	
	// gets the value of the piece location. x coordinates.
	private function get_piece_location_from_value_x(_num):Int
	{
		var _x = 0;
		
		for (yy in 0...8)
		{
			for (xx in 0...8)
			{
				if (Reg._gamePointValueForPiece[yy][xx] == (Reg._gameDiceCurrentIndex[_num] + 1))
				{
					_x = xx;
				}
				
			}
		}
	
		return _x;
	}
	
	private function gameIdDrawboardStuff(id:Int):Void
	{
		//------------------------------
		RegFunctions._gameMenu = new FlxSave(); // initialize		
		RegFunctions._gameMenu.bind("ConfigurationsMenu"); // bind to the named save slot.
		
		RegFunctions.loadConfig();
		PlayState.getPlayersNamesAndAvatars();
				
		// fill the screen with a random color.
		_background_scene_color = new FlxSprite();
		_background_scene_color.makeGraphic(FlxG.width,FlxG.height - Reg._offsetScreenY + 10,FlxColor.WHITE);
		_background_scene_color.color = FlxColor.fromHSB(FlxG.random.int(1, 360), 0.8, 0.25);
		_background_scene_color.scrollFactor.set(0, 0);
		add(_background_scene_color);
		
		if (RegCustom._game_room_background_enabled == true)
		{
			_background_scene = new FlxSprite(0, -44, "assets/images/gameboardBackground" + Std.string(RegCustom._game_room_background_image_number) + ".jpg"); // 44 is half of hud height.
			_background_scene.scrollFactor.set(0, 0);
			if (RegCustom._game_room_background_alpha_enabled == true)
				_background_scene.alpha = 0.25;
			add(_background_scene);
		}
		
		if (RegCustom._gameboard_border_enabled == true)
		{
			_gameboardBorder = new FlxSprite();
			_gameboardBorder.loadGraphic("assets/images/gameboardBorder"+ RegCustom._gameboardBorder_num +".png", false);
			_gameboardBorder.setPosition(Reg._unitXgameBoardLocation[0]-30, Reg._unitYgameBoardLocation[0]-30);
			_gameboardBorder.scrollFactor.set(0, 0);
			add(_gameboardBorder);
		}
		
		// the numbers 1 to 8 and the letter a to h at the side of the gameboard.
		if (RegCustom._gameboard_coordinates_enabled == true)
		{
			var _coordinates = new FlxSprite();
			_coordinates.loadGraphic("assets/images/coordinates.png", false);
			_coordinates.setPosition(Reg._unitXgameBoardLocation[0]-30, Reg._unitYgameBoardLocation[0]-30);
			_coordinates.scrollFactor.set(0, 0);
			add(_coordinates);
		}
		
		var i = -1;
		
		for (y in 0...8)
		{
			for (x in 0...8)
			{
				i += 1;				
				
				if (Reg._gameId == 4 && y > 1 && y < 6 && x > 1 && x < 6) {} // don't draw center unit if playing the signature game.
				else
				{		
					// a standard gameboard.
					_gameBoard[i] = new FlxSprite();
					_gameBoard[i].loadGraphic("assets/images/gameboardUnit.png", false);
					_gameBoard[i].setPosition(Reg._unitXgameBoardLocation[x], Reg._unitYgameBoardLocation[y]);
					
					// draw each board unit creating the game board.
					if (y == 0 || y == 2 || y == 4 || y == 6) // every second row.
					{
						// draw colored blocks
						if (FlxMath.isOdd(i) == true) 
						{
							_gameBoard[i].color = _unitgameBoardColorLight[id]; 
							
							if (Reg._gameId == 0 || Reg._gameId == 1)
								_gameBoard[i].alpha = 0;
						}
						
						else
						{
							_gameBoard[i].color = _unitgameBoardColorDark[id];
							
							if (Reg._gameId == 0 || Reg._gameId == 1)
								_gameBoard[i].alpha = 0;
						}
					} 
					else	
					{
						// draw blocks in reverse color. even is odd and odd is even.
						if (FlxMath.isEven(i) == true)
						{
							_gameBoard[i].color = _unitgameBoardColorLight[id];
							
							if (Reg._gameId == 0 || Reg._gameId == 1)
								_gameBoard[i].alpha = 0;
							
						}
						
						else
						{
							_gameBoard[i].color = _unitgameBoardColorDark[id];
							
							if (Reg._gameId == 0 || Reg._gameId == 1)
								_gameBoard[i].alpha = 0;
						}
					}

					_gameBoard[i].scrollFactor.set(0, 0);
					add(_gameBoard[i]);
				}
				
			}
		}
	
		// display the custom game board from options menu.
		if (Reg._gameId == 0 || Reg._gameId == 1)
		{
			MenuConfigurationsGeneral._num = Reg._gameId;

			if (RegCustom._units_even_gameboard_show == true)
			{
				var _sprite_board_game_unit_even = new FlxSprite(0, 0, "assets/images/scenes/tiles/even/"+ Std.string(RegCustom._units_even_spr_num[Reg._gameId]) + ".png");
				_sprite_board_game_unit_even.scrollFactor.set();
				_sprite_board_game_unit_even.setPosition(Reg._unitXgameBoardLocation[0], Reg._unitYgameBoardLocation[0]);
				_sprite_board_game_unit_even.color = MenuConfigurationsGeneral.colorToggleUnitsEven();
				//_sprite_board_game_unit_even.alpha = 0.5;
				add(_sprite_board_game_unit_even);			
			}
			
			var _sprite_board_game_unit_odd = new FlxSprite(0, 0, "assets/images/scenes/tiles/odd/"+ Std.string(RegCustom._units_odd_spr_num[Reg._gameId]) +".png");
			_sprite_board_game_unit_odd.scrollFactor.set();
			_sprite_board_game_unit_odd.setPosition(Reg._unitXgameBoardLocation[0], Reg._unitYgameBoardLocation[0]);
			_sprite_board_game_unit_odd.color = MenuConfigurationsGeneral.colorToggleUnitsOdd();
			//_sprite_board_game_unit_odd.alpha = 0.5;
			add(_sprite_board_game_unit_odd);			
		}
		
		if (id == 0)
		{
			// the unit is highlighted when the mouse is clicked on it.
			var _currentUnitClicked = new CheckersCurrentUnitClicked(_gameBoard[0].y, _gameBoard[0].x, __ids_win_lose_or_draw);
			_currentUnitClicked.scrollFactor.set(0, 0);
			add(_currentUnitClicked);
			
		}
		
		else if (id == 1)
		{			
			// the unit is highlighted when the mouse is clicked on it.
			var _currentUnitClicked = new ChessCurrentUnitClicked(_gameBoard[0].y, _gameBoard[0].x, __ids_win_lose_or_draw);
			_currentUnitClicked.scrollFactor.set(0, 0);
			add(_currentUnitClicked);
			
		}
		
		
		if (Reg._spectator_watching_entering_game_room_message == false 
		&&  RegTypedef._dataPlayers._spectatorWatching == true)
		{
			Reg._spectator_watching_entering_game_room_message = true;
			
			Reg._gameMessage = "You are a watching spectator.";
			Reg._outputMessage = true;
			
			
			//PlayState.clientSocket.send("Move History All Entry", RegTypedef._dataMovement);
			//haxe.Timer.delay(function (){}, Reg2._event_sleep);
			
			//PlayState.clientSocket.send("Move History Next Entry", RegTypedef._dataMovement);
			//haxe.Timer.delay(function (){}, Reg2._event_sleep);
		}
	}
	
	
	
	
	public function dice(X:Float, Y:Float):Void
	{
		__number_wheel = new NumberWheel(X, Y);
		add(__number_wheel);
		
		if (Reg._gameId == 3)
		{
			var _clickMe = new SnakesAndLaddersClickMe(X, Y, __number_wheel);
			add(_clickMe);	
		}
		if (Reg._gameId == 4)
		{
			var _clickMe = new SignatureGameClickMe(X, Y, __number_wheel, __ids_win_lose_or_draw, _playerPieces1, _playerPieces2, _playerPieces3, _playerPieces4);
			add(_clickMe);	
		}
			
	}
	
	
	public static function timeGivenForEachGame(_num:Int = -1):Void
	{
		if (_num == -1) _num = Reg._gameId;
		
		// set to 10 minutes for a move if playing a tournament game.
		if (RegTypedef._dataTournaments._move_piece == false)
		{
			// time is set at the MenuConfigurationsGames.hx file. we times it by 60 to create the seconds allowed for the game.
			_t = RegCustom._move_time_remaining_current[_num] * 60;
		}
		
		RegTypedef._dataPlayers._timeTotal = _t;
		RegTypedef._dataStatistics._timeTotal = _t;
	}
	
	
	/******************************
	 * when a player move is completed then this function sends all the important data to the server when the Reg._pieceMovedUpdateServer is set to true.
	 * @param	i	the game being played. 0:checkers, 1:chess,
	 */
	public function gameIdSendDataToServer():Void
	{
		//################ PLAYER MOVEMENT ####################					
		if (Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false)
		{
			RegTypedef._dataPlayers._moveTotal += 1;
			
			if (Reg._gameId == 0)
			{
				// these are the vars needed to move a piece.
				RegTypedef._dataGame0._gameUnitNumberNew = Reg._gameUnitNumberNew;
				RegTypedef._dataGame0._gameUnitNumberOld = Reg._gameUnitNumberOld;
				RegTypedef._dataGame0._gameXXnew = Reg._gameXXnew;
				RegTypedef._dataGame0._gameYYnew = Reg._gameYYnew;
				RegTypedef._dataGame0._gameXXold = Reg._gameXXold;
				RegTypedef._dataGame0._gameYYold = Reg._gameYYold;
				RegTypedef._dataGame0._gameXXold2 = Reg._gameXXold2;
				RegTypedef._dataGame0._gameYYold2 = Reg._gameYYold2;
				RegTypedef._dataGame0._triggerNextStuffToDo = Reg._triggerNextStuffToDo;
				RegTypedef._dataGame0._isThisPieceAtBackdoor = Reg._checkersFoundPieceToJumpOver;

			}	
			
			if (Reg._gameId == 1)
			{
				// these are the vars needed to move a piece.
				RegTypedef._dataGame1._pieceValue = Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew];
				RegTypedef._dataGame1._uniqueValue = Reg._gameUniqueValueForPiece[Reg._gameYYnew][Reg._gameXXnew];
				RegTypedef._dataGame1._gameUnitNumberNew = Reg._gameUnitNumberNew;
				RegTypedef._dataGame1._gameUnitNumberOld = Reg._gameUnitNumberOld;
				RegTypedef._dataGame1._gameUnitNumberNew2 = Reg._gameUnitNumberNew2;
				RegTypedef._dataGame1._gameUnitNumberOld2 = Reg._gameUnitNumberOld2;
				RegTypedef._dataGame1._piece_capturing_image_value = Reg._imageValueOfUnitOld3;
				RegTypedef._dataGame1._gameXXnew = Reg._gameXXnew;
				RegTypedef._dataGame1._gameYYnew = Reg._gameYYnew;
				RegTypedef._dataGame1._gameXXold = Reg._gameXXold;
				RegTypedef._dataGame1._gameYYold = Reg._gameYYold;
				RegTypedef._dataGame1._gameXXnew2 = Reg._gameXXnew2;
				RegTypedef._dataGame1._gameYYnew2 = Reg._gameYYnew2;
				RegTypedef._dataGame1._gameXXold2 = Reg._gameXXold2;
				RegTypedef._dataGame1._gameYYold2 = Reg._gameYYold2;
				RegTypedef._dataGame1._isEnPassant = Reg._isEnPassant;
				RegTypedef._dataGame1._isEnPassantPawnNumber = Reg._chessEnPassantPawnNumber;
				RegTypedef._dataGame1._triggerNextStuffToDo = Reg._triggerNextStuffToDo;
				RegTypedef._dataGame1._pointValue2 = Reg._pointValue2;
				RegTypedef._dataGame1._uniqueValue2 = Reg._uniqueValue2;
				RegTypedef._dataGame1._promotePieceLetter = Reg._promotePieceLetter;
				RegTypedef._dataGame1._doneEnPassant = Reg._doneEnPassant;
				
			}				
			
			if (Reg._gameId == 2)
			{
				// these are the vars needed to move a piece.
				//RegTypedef._dataGame2._gameUnitNumberNew = Reg._gameUnitNumberNew;
				//RegTypedef._dataGame2._gameUnitNumberOld = Reg._gameUnitNumberOld;
				//RegTypedef._dataGame2._gameUnitNumberNew2 = Reg._gameUnitNumberNew2;
				//RegTypedef._dataGame2._gameUnitNumberOld2 = Reg._gameUnitNumberOld2;
				RegTypedef._dataGame2._gameXXold = Reg._gameXXold;
				RegTypedef._dataGame2._gameYYold = Reg._gameYYold;
				//RegTypedef._dataGame2._pieceValue = Reg._gamePointValueForPiece[Reg._gameYYold][Reg._gameXXold];
				RegTypedef._dataGame2._pointValue2 = Reg._pieceNumber + 1;
				RegTypedef._dataGame2._triggerNextStuffToDo = Reg._triggerNextStuffToDo; // Reversi. used to place the four piece on the board.
			
			}	
			
			if (Reg._gameId == 3)
			{	
				// these are the vars needed to move a piece.
				
				// if true then other player was at the head of the snake. set this player at the head of the snake so that player's piece can move down.
				if (SnakesAndLaddersMovePlayersPiece._snakeMovePiece == true)
				{
					if (Reg._gameDiceMaximumIndex[Reg._playerMoving] == 5)
						Reg._gameDiceMaximumIndex[Reg._playerMoving] = 15;
						
					if (Reg._gameDiceMaximumIndex[Reg._playerMoving] == 7)
						Reg._gameDiceMaximumIndex[Reg._playerMoving] = 35;
					
					if (Reg._gameDiceMaximumIndex[Reg._playerMoving] == 31)
						Reg._gameDiceMaximumIndex[Reg._playerMoving] = 59;
						
					if (Reg._gameDiceMaximumIndex[Reg._playerMoving] == 23)
						Reg._gameDiceMaximumIndex[Reg._playerMoving] = 42;
				}
					
					
				//RegTypedef._dataGame3._gameUnitNumberNew = Reg._gameDiceMaximumIndex[Reg._playerMoving];
				//RegTypedef._dataGame3._gameUnitNumberNew = Reg._backdoorMoveValue;
				
				// since move piece was sent to the server, current and maximum index are the same, so since _gameDiceMaximumIndex might have been changed at the above code, "if (SnakesAndLaddersMovePlayersPiece._snakeMovePiece == true)", change the var back to the correct value.
				Reg._gameDiceMaximumIndex[Reg._playerMoving] = Reg._gameDiceCurrentIndex[Reg._playerMoving];
				
				
				RegTypedef._dataGame3._triggerNextStuffToDo = Reg._triggerNextStuffToDo; // used in snakes and ladders. if 6 is rolled then roll again.
				RegTypedef._dataGame3._rolledA6 = Reg._rolledA6;
				RegTypedef._dataGame3._triggerEventForAllPlayers = RegTriggers._eventForAllPlayers; // if true then both players piece will move at the same time.
		
			}	
					
			if (Reg._gameId == 4)
			{
				// these are the vars needed to move a piece.
				RegTypedef._dataGame4._gameXXold = Reg._gameXXold;
				RegTypedef._dataGame4._gameYYold = Reg._gameYYold;
				
				// this var is being used.
				RegTypedef._dataGame4._gameXXnew = Reg._gameXXnew;
				RegTypedef._dataGame4._gameYYnew = Reg._gameYYnew;
				
				
				RegTypedef._dataGame4._gameXXold2 = Reg._gameXXold2; // other piece. the unit of the player you would like to trade with.
				RegTypedef._dataGame4._gameYYold2 = Reg._gameYYold2; // other piece.
				RegTypedef._dataGame4._gameXXnew2 = Reg._gameXXnew2; // trading your piece.
				RegTypedef._dataGame4._gameYYnew2 = Reg._gameYYnew2; // trading your piece.
				RegTypedef._dataGame4._gameUniqueValueForPiece = Reg._gameUniqueValueForPiece;
				RegTypedef._dataGame4._unitNumberTrade = Reg._signatureGameUnitNumberTrade;
				RegTypedef._dataGame4._gameUniqueValueForPiece = Reg._gameUniqueValueForPiece;
				RegTypedef._dataGame4._gameHouseTaxiCabOrCafeStoreForPiece = Reg._gameHouseTaxiCabOrCafeStoreForPiece;
				
			}	
		}
		
		//events
		if (Reg._game_offline_vs_cpu == false 
		&&  Reg._game_offline_vs_player == false
		&&  RegTypedef._dataTournaments._move_piece == false) 
		{
			NetworkEventsIds.gotoMovePlayerEvent();
		}
		else
		{										
			if (Reg._game_offline_vs_cpu == true 
			||  Reg._game_offline_vs_player == true
			||  RegTypedef._dataTournaments._move_piece == true)
			{
				if (Reg._playerMoving == 1) 
					Reg._chessUnitsInCheckTotal[1] = 0; 
				else if (RegTypedef._dataTournaments._move_piece == false)
					RegTypedef._dataPlayers._moveTotal += 1;
				
				// by default all board games use this class.
				GameClearVars.clearVarsOnMoveUpdate();
				
				if (Reg._gameId == 0)
				{
					if (Reg._gameNotationOddEven == 0) Reg._gameNotationOddEven = 1;
					
					Reg._checkersFoundPieceToJumpOver = false;

					if (Reg._gameYYnew != -1 && Reg._gameXXnew != -1)
					CheckersCapturingUnits.jumpCapturingUnitsForPiece(Reg._gameYYnew, Reg._gameXXnew, Reg._playerMoving);
					
					if (Reg._checkersFoundPieceToJumpOver == true)
						Reg._checkersIsThisFirstMove = false;
				}
				
				if (Reg._gameId == 1)						
				{
					GameClearVars.clearCheckAndCheckmateVars();						
					ChessCapturingUnits.capturingUnits();						
					
					if (Reg._chessCheckBypass == false)
					{							
						if (Reg._chessCheckmateBypass == false) 
							__chess_check_or_checkmate.isThisCheckOrCheckmate();
					}
					
					GameClearVars.clearVarsOnMoveUpdate();
					GameClearVars.clearCheckAndCheckmateVars();
					
					//ChessMoveCPUsPiece._checkmate_loop = 0;
					
					if (Reg._gameNotationOddEven == 0) Reg._gameNotationOddEven = 1;
					
					__ids_win_lose_or_draw.canPlayerMove1();
				}
					
			}
				
			
		}		
	}

	/******************************
	 * client is sending a move request to the other clients
	 */
	public static function setMovement():Void
	{
		if (Reg._gameId == 4)
		{
			//RegTypedef._dataMovement._triggerNextStuffToDo = Reg._triggerNextStuffToDo;
			RegTypedef._dataMovement._gameDiceMaximumIndex = Reg._backdoorMoveValue;
		}
		
		PlayState.clientSocket.send("Movement", RegTypedef._dataMovement);
		// send event here.
		haxe.Timer.delay(function (){}, Reg2._event_sleep);
	}
	
}
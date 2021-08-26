package;

/**
 * ...
 * @author kboardgames.com
 */
class SignatureGameDevelopedLandImages extends FlxSprite
{
	/******************************
	 * this var refers to a unique piece on the grid. each piece on the grid has a different number. an ID can be called anything. it just refers to an instance of a class. it does not share data from other instances, it may not have the same values but holds the same variables. this var is used to move pieces from one unit to another. 
	 */
	private var _id:Int = 0; 
	
	private var _ticks:Float = 0;
	private var _pieceValue:Int = 0;
	
	
	/**
	 * @param	x				image coordinate
	 * @param	y				image coordinate
	 * @param	pieceValue		used to load an image of a gameboard piece.
	 * @param	str				the game board name and the folder to access. 
	 * @param	id				an instance of this class. each time of a "new" an id increments in value.
	 */
	public function new (x:Float, y:Float, pieceValue:Int, id:Int)
	{
		super(x, y+5);		
		//Reg._gameUndevelopedValueOfUnit[58]=0;
		ID = _id = id;
		
		_pieceValue = pieceValue -= 1;
		loadGraphic("assets/images/signatureGame/"+pieceValue+".png", false, 65, 65, true);
		
		// TODO not used. remove this undeveloped named var.
		//if (Reg._gameUndevelopedValueOfUnit[_id] > 0) visible = false; // stop two images displaying at start-up. 1:undeveloped and 0:developed.
	}

	override public function update (elapsed:Float)
	{
		if (Reg._gameId == 4 && Reg._gameOverForPlayer == false
		||  Reg._gameId == 4 && RegTypedef._dataPlayers._spectatorPlaying == true)
		{
			// delay updating data.
			_ticks = RegFunctions.incrementTicks(_ticks, 60 / Reg._framerate);
			
			if (_ticks >= 40) 
			{
				_ticks = 0;
			
				for (yy in 0...8)
				{
					for (xx in 0...8)
					{
						if (_id == ID // untint.
						&& (_pieceValue + 1) == Reg._gamePointValueForPiece[yy][xx]
						&& Reg._gameUniqueValueForPiece[yy][xx] == 0) color = 0x00ffffff;	// this untints the color.
						
						if (_id == ID // red.
						&& (_pieceValue + 1) == Reg._gamePointValueForPiece[yy][xx]
						&& Reg._gameUniqueValueForPiece[yy][xx] == 1) color = Reg._game_piece_color2[0];
						
						if (_id == ID // blue.
						&& (_pieceValue + 1) == Reg._gamePointValueForPiece[yy][xx]
						&& Reg._gameUniqueValueForPiece[yy][xx] == 2) color = Reg._game_piece_color2[1];
						
						if (_id == ID // green.
						&& (_pieceValue + 1) == Reg._gamePointValueForPiece[yy][xx]
						&& Reg._gameUniqueValueForPiece[yy][xx] == 3) color = Reg._game_piece_color2[2];
						
						if (_id == ID // yellow.
						&& (_pieceValue + 1) == Reg._gamePointValueForPiece[yy][xx]
						&& Reg._gameUniqueValueForPiece[yy][xx] == 4) color = Reg._game_piece_color2[3];
						
					}
				}
								
				// is there a mortgage at this unit. this code look wrong but it works. if the current mortgage matches the value of the land, not house, then enter code. this code happens when there is a change at unit of the houses/services.
				if (SignatureGameMain._houseTaxiCafeAmountY[0] == SignatureGameMain._mortgageLandPriceCurrentUnitY && SignatureGameMain._houseTaxiCafeAmountY[0] > 0
				&&  SignatureGameMain._houseTaxiCafeAmountX[0] == SignatureGameMain._mortgageLandPriceCurrentUnitX && SignatureGameMain._houseTaxiCafeAmountX[0] > 0)
				{
					var _p = RegFunctions.getP(SignatureGameMain._mortgageLandPriceCurrentUnitY, SignatureGameMain._mortgageLandPriceCurrentUnitX);
					
					// for this instance only. is there mortgage at current unit.
					if (ID == _p && SignatureGameMain._mortgageLandPriceCurrentUnitY > -1 && SignatureGameMain._mortgageLandPriceCurrentUnitX > -1)
					{
						// unit is owned by nobody.
						SignatureGameMain._mortgageLandPriceCurrentUnitY = -1;
						SignatureGameMain._mortgageLandPriceCurrentUnitX = -1;
					}
				}
				
				
			}
			
			super.update(elapsed);
		}
		
		
	}
	

}

package;

/**
 * ... a circle on a land refers to a houses, taxi or cafe. max 4 houses.
 * @author kboardgames.com
 */
class SignatureGameReferenceImages extends FlxSprite {

	/******************************
	 * this var refers to a unique piece on the grid. each piece on the grid has a different number. an ID can be called anything. it just refers to an instance of a class. it does not share data from other instances, it may not have the same values but holds the same variables. this var is used to move pieces from one unit to another. 
	 */
	private var _id:Int = 0; 
	
	/******************************
	 * // unit number that starts from the top-left corner (0) and ends at the bottom-right corner (63).
	 */
	private var p:Int = -1;
	
	public var _pieceValue:Int = 0;
	private var _ticks:Float = 0;
	
	/**
	 * @param	x				image coordinate
	 * @param	y				image coordinate
	 * @param	pieceValue			used to load an image of a gameboard piece.
	 * @param	str				the game board name and the folder to access. 
	 * @param	id				an instance of this class. each time of a "new" an id increments in value.
	 */
	public function new (x:Float, y:Float, pieceValue:Int, _p:Int)
	{
		super(x, y-4);		
		
		ID = _id = _p;
		_pieceValue = pieceValue;
		
		loadGraphic("assets/images/signatureGame/houseTaxiCafe/reference.png", true, 65, 12);
		
		houseTaxiCafeOwnership(_pieceValue);
		
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
						var _p = RegFunctions.getP(yy, xx);
						
						if (ID == _p)
						{					
							// for this instance only.
							{	
								// update how many houses are on a unit highlight.
								houseTaxiCafeOwnership(Reg._gameHouseTaxiCabOrCafeStoreForPiece[yy][xx]);
							}
						}
					}
				}
			}
					
		}
		
		for (i in 0...28)
		{
			SignatureGameMain._houseTaxiCafeAmountY[i] = -1;
			SignatureGameMain._houseTaxiCafeAmountX[i] = -1;
		}
		
		super.update(elapsed);
	}
	
	public function houseTaxiCafeOwnership(_pValue:Int):Void
	{
		Reg._gameHouseTaxiCabOrCafeStoreValueOfUnit[Reg._gameDiceMaximumIndex[Reg._move_number_next]] = 0;
		//if (Reg._gameYYnew2 > -1 && SignatureGameSelect._tradeAnsweredAs == false) RegTypedef._dataGame4._gameHouseTaxiCabOrCafeStoreForPiece[Reg._gameYYnew2][Reg._gameXXnew2] = _pValue;
						
		if (_pValue == 0) 
		{
			animation.add("houseTaxiCafe", [0], 30, true);
			animation.play("houseTaxiCafe");
		}
		
		if (_pValue == 1) 
		{
			animation.add("houseTaxiCafe1", [1], 30, true);
			animation.play("houseTaxiCafe1");
		}
		
		if (_pValue == 2) 
		{
			animation.add("houseTaxiCafe2", [2], 30, true);
			animation.play("houseTaxiCafe2");
		}
		
		if (_pValue == 3) 
		{
			animation.add("houseTaxiCafe3", [3], 30, true);
			animation.play("houseTaxiCafe3");
		}
		
		if (_pValue == 4) 
		{
			animation.add("houseTaxiCafe4", [4], 30, true);
			animation.play("houseTaxiCafe4");
		}
		
	
	}

}

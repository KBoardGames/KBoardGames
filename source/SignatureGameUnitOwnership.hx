package;

/**
 * @author kboardgames.com
 */

class SignatureGameUnitOwnership extends FlxSprite
{
	private var _xID:Int = 0;
	private var _yID:Int = 0;
	
	private var _pieceValue:Int = 0;
	private var _ticks:Float = 0;
	private var _ticks2:Float = 0;
	
	/******************************
	 * the location of this, a players piece image, is determined when this instance is created.
	 * @param	if		instant number.
	 * @param	xx		image coordinate.
	 * @param	yy		image coordinate.
	 * @param	xID		unit coordinate (0-7)
	 * @param	yID		unit coordinate (0-7)
	 */
	public function new (yy:Float, xx:Float, yID:Int, xID:Int, _id, pieceValue:Int = 0)
	{
		super(yy, xx);		
		
		_xID = xID;
		_yID = yID;
		ID = _id;
		_pieceValue = pieceValue;
	
		loadGraphic("assets/images/signatureGame/player/playersPieceColor.png", false, 75);
		visible = false;
	}
		
	override public function update(elapsed:Float):Void 
	{
		if (Reg._gameId == 4 && Reg._gameOverForPlayer == false
		||  Reg._gameId == 4 && RegTypedef._dataPlayers._spectatorPlaying == true)
		{
			// delay updating data.
			_ticks = RegFunctions.incrementTicks(_ticks, 60 / Reg._framerate);
			_ticks2 = RegFunctions.incrementTicks(_ticks, 60 / Reg._framerate);
			
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
								// go to the function that adds or removes unit highlight.
								visible = true;
							}
						}
					}
				}
			}
		
			if (_ticks2 >= 40) 
			{
				_ticks2 = 0;
			
				// is there a mortgage at this unit. this code look wrong but it works. if the current mortgage matches the value of the land, not house, then enter code. this code happens when there is a change at unit of the houses/services.
				if (SignatureGameMain._houseTaxiCafeAmountY[0] == SignatureGameMain._mortgageLandPriceCurrentUnitY && SignatureGameMain._houseTaxiCafeAmountY[0] > 0
				&&  SignatureGameMain._houseTaxiCafeAmountX[0] == SignatureGameMain._mortgageLandPriceCurrentUnitX && SignatureGameMain._houseTaxiCafeAmountX[0] > 0)
				{
					var _p = RegFunctions.getP(SignatureGameMain._mortgageLandPriceCurrentUnitY, SignatureGameMain._mortgageLandPriceCurrentUnitX);
					
					// for this instance only. is there mortgage at current unit.
					if (ID == _p && SignatureGameMain._mortgageLandPriceCurrentUnitY > -1 && SignatureGameMain._mortgageLandPriceCurrentUnitX > -1)
					{
						// unit is owned by nobody.
						visible = false;
						
						SignatureGameMain._mortgageLandPriceCurrentUnitY = -1;
						SignatureGameMain._mortgageLandPriceCurrentUnitX = -1;
					}
				}
			}
			
			super.update(elapsed);
		}
	}
	
}
package;

/**
 * images of the player pieces and the highlighted units where the pieces use to be located.
 * @author kboardgames.com
 */
class SnakesAndLaddersImagesCapturingUnits extends FlxSprite 
{
	private var _xID:Int = 0;
	private var _yID:Int = 0;
	private var _id:Int = 0;

	
	/******************************
	 * the location of this, a unit image, is determined when this instance is created.
	 * @param	x			image coordinate.
	 * @param	y			image coordinate.
	 * @param	id			id of the player.
	 * @param	xID			unit coordinate (0-7)
	 * @param	yID			unit coordinate (0-7)
	 */
	public function new (xx:Float, yy:Float, id, xID:Int, yID:Int)
	{
		super(xx, yy);		
		
		_xID = xID;
		_yID = yID;

		ID = _id = id;
		
		x = xx;
		y = yy;		
				
		// player 2 in an player vs player online game needs to swap pieces or else player 2 will be using the wrong pieces.
		if (Reg._gameHost == true
		&&  Reg._game_offline_vs_cpu == false
		&&  Reg._game_offline_vs_player == false)
		{
			if (_id == 1) loadGraphic("assets/images/capturingUnitsNoTransparency2.png", false);
			if (_id == 2) loadGraphic("assets/images/capturingUnitsNoTransparency1.png", false);
			if (_id == 3) loadGraphic("assets/images/snakesLadders/player/19.png", false);
			if (_id == 4) loadGraphic("assets/images/snakesLadders/player/14.png", false);
		}
		else
		{
			if (_id == 1) loadGraphic("assets/images/capturingUnitsNoTransparency1.png", false);
			if (_id == 2) loadGraphic("assets/images/capturingUnitsNoTransparency2.png", false);
			if (_id == 3) loadGraphic("assets/images/snakesLadders/player/14.png", false);
			if (_id == 4) loadGraphic("assets/images/snakesLadders/player/19.png", false);
		}
			
	}

	override public function update (elapsed:Float)
	{
		if (Reg._gameId == 3)
		{			
			var _found:Bool = false;
			
			// this updates the other client so that when the game is over, that piece is correctly displayed at the last board unit.
			if (Reg._game_offline_vs_player == false 
			&&  Reg._game_offline_vs_cpu == false 
			&&  Reg._game_online_vs_cpu == false
			&&  Reg._isThisPieceAtBackdoor == true) // if player online.
			{
				if (Reg._gameDiceMaximumIndex[0] >= 64)
				{
					 Reg._gameYYnewB = 0; // update the piece that did not move.
					 Reg._gameXXnewB = 0;
				}
							
				if (Reg._gameDiceMaximumIndex[1] >= 64)
				{
					 Reg._gameYYnewA = 0;
					 Reg._gameXXnewA = 0;
				}
			}
			
			
			// this code highlights where the piece moved from.
			if (ID == _id && ID == 1
			&&  _yID == Reg._gameYYoldA && _xID == Reg._gameXXoldA)
			{
				visible = true;
				_found = true;
			}
			
			if (ID == _id && ID == 2
			&&  _yID == Reg._gameYYoldB && _xID == Reg._gameXXoldB)
			{
				visible = true;
				_found = true;
			}
					
			// this code highlights where the unit moved to.
			if (ID == _id && ID == 3
			&&  _yID == Reg._gameYYnewA && _xID == Reg._gameXXnewA)
			{
				visible = true;
				_found = true;		
			}

			else if (ID == _id && ID == 4
			&&  _yID == Reg._gameYYnewB && _xID == Reg._gameXXnewB)
			{
				visible = true;
				_found = true;
			}	
				
			if (_found == false) visible = false;
			
			super.update(elapsed);
		}
	}

}

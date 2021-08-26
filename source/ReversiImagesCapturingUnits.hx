package;

/**
 * ...
 * @author kboardgames.com
 */
class ReversiImagesCapturingUnits extends FlxSprite {

	private var _xID:Int = 0;
	private var _yID:Int = 0;
	
	/**
	 * the location of this, a unit image, is determined when this instance is created.
	 * @param	x		image coordinate.
	 * @param	y		image coordinate.
	 * @param	xID		unit coordinate (0-7)
	 * @param	yID		unit coordinate (0-7)
	 */
	public function new (yy:Float, xx:Float, xID:Int, yID:Int)
	{
		super(yy, xx);		
		
		_xID = xID;
		_yID = yID;
		
		loadGraphic("assets/images/reversi/capturingUnit.png", false);

		Reg._capturingUnitsForImages[0][_yID][_xID] = 0;
		Reg._capturingUnitsForImages[1][_yID][_xID] = 0;
		visible = false;
	}

	override public function update (elapsed:Float)
	{
		if (Reg._gameId == 2)
		{
			if (Reg._playerCanMovePiece == true)
			{
				RegFunctions.is_player_attacker(false); // a value of false then the player hosts a game known as the defender. true, if being hosted. eg, array[Reg._playerMoving][value][yy][xx]. playerAttacker is the opposite of the defender. so if Reg._playerMoving = 0 then its the player hosting the game while Reg._playerNotMoving which has a value of 1 had accepted the game at the chatroom.	
							
				if (Reg._capturingUnitsForPieces[Reg._playerMoving][_yID][_xID] > 0 && Reg._gamePointValueForPiece[_yID][_xID] == 0)
				visible = true; // highlight the capturing units.
				else visible = false;
			} else visible = false;
		}
		
		super.update(elapsed);
	}

}

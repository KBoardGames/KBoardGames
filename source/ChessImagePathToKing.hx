package;

/**
 * ...this class displays the current selected unit of the path to king.
 * @author kboardgames.com
 */
class ChessImagePathToKing extends FlxSprite
{
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
		
		loadGraphic("assets/images/pathToKing.png", false);

		color = RegFunctions.color_path_to_king();
		visible = false;
	}

	override public function update (elapsed:Float)
	{
		if (Reg._checkmate == false)
		{
			RegFunctions.is_player_attacker(false); // a value of false then the player hosts a game known as the defender. true, if being hosted. eg, array[Reg._playerMoving][value][yy][xx]. playerAttacker is the opposite of the defender. so if Reg._playerMoving = 0 then its the player hosting the game while Reg._playerNotMoving which has a value of 1 had accepted the game at the chatroom.	
		
			visible = false;
			
			for (d in 0...8)
			{
				// d is plus 1 because the var starts at 1. this is used so that the capturing path to king is removed when there is a second defender piece at that path. no need to show the path when the king is not in jeopardy from that direction.
				if (Reg._chessTotalDefendersOnPath[(d + 1)] > 0
				&&  Reg._chessTotalDefendersOnPath[(d + 1)] < 3
				&&  Reg._chessCapturingPathToKing[Reg._playerNotMoving][_yID][_xID] >= 1)
				{
					Reg._chessFuturePathToKing[Reg._playerNotMoving][_yID][_xID] = 0;
					visible = true;
				}
			}
						 
		} 
		
		// if here then its checkmate.
		else 
		{
			if (visible == true) visible = false;
			
			for (y in 0...8)
			{
				for (x in 0...8)
				{
					Reg._chessCapturingPathToKing[Reg._playerMoving][y][x] = 0;
					Reg._chessCapturingPathToKing[Reg._playerNotMoving][y][x] = 0;
				}
			}			
		}
		 
		super.update(elapsed);
	}

}
//
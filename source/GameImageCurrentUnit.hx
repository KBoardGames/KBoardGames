package;

/**
 * ...this class displays the current selected unit. a none solid box that parameters a unit where the mouse is located at.
 * @author kboardgames.com
 */
class GameImageCurrentUnit extends FlxSprite
{
	/******************************
	 * When this class is first created this var will hold the X value of this class. If this class needs to be reset back to its start map location then X needs to equal this var. 
	 */
	private var _startX:Float = 0;
	
	/******************************
	 * When this class is first created this var will hold the Y value of this class. If this class needs to be reset back to its start map location then Y needs to equal this var. 
	 */
	private var _startY:Float = 0;
	
	/******************************
	 * display a square box around the current unit where the mouse cursor is at.
	 * @param	x 	top-left X corner of this current square shaped image.
	 * @param	y	top-left Y corner of this current square shaped image.
	 */
	public function new (y:Float, x:Float)
	{
		super(y, x);
		
		_startX = x; // top-left corner...
		_startY = y; // of gameboard.
		
		loadGraphic("assets/images/currentUnit.png", false);

		visible = false;
	}

	override public function update (elapsed:Float)
	{
		if (RegTypedef._dataMisc._spectatorWatching == false
		||  RegTypedef._dataTournaments._move_piece == true)
		{
			if (Reg._checkmate == false && Reg._gameOverForPlayer == false)
			{
				RegFunctions.is_player_attacker(false); // a value of false then the player hosts a game known as the defender. true, if being hosted. eg, array[Reg._playerMoving][value][yy][xx]. playerAttacker is the opposite of the defender. so if Reg._playerMoving = 0 then its the player hosting the game while Reg._playerNotMoving which has a value of 1 had accepted the game at the chatroom.
				if (Reg._at_input_keyboard == false)
				{
					if (Reg._playerCanMovePiece == true || RegTriggers._tradeProposalOffer == true || Reg._gameId == 4)
					 {		 
						// playing against the computer and its the computers turn...
						if (Reg._gameId != 4 && Reg._playerMoving == 1 && Reg._game_offline_vs_cpu == true && Reg._gameId != 0
						)
						{
							// the XY coordinate equals the start of the board plus the unit coordinate times the width/height of this image.
							 var xx:Int = 1;						
							 var yy:Int = 1;
							 
							 visible = false;			
						}
						
						else
						{
							// highlight units when at your piece.
							if (Reg._gameId == 0) highlightCheckers();
							if (Reg._gameId == 1) highlightChess();
							if (Reg._gameId == 2) highlightReversi();
							if (Reg._gameId == 4) highlightSignatureGame();
							
						}
						
						
					} else if (visible == true) visible = false;
				}
				 
				if (Reg._gameId == 4 && RegTriggers._signatureGameUnitImage == false || Reg._gameId == 4 && Reg._buttonCodeValues != "")
				visible = false;
				
			} else if (visible == true) visible = false;
				
			// if mouse is not at the game board.
			if (ActionInput.coordinateX() < _startX || ActionInput.coordinateX() > _startX + (7 * 75) + 75)
			visible = false;
			
			super.update(elapsed);
		}
	}

	private function highlightCheckers():Void
	{
		// checkers and chess
		if (Reg._gameId == 0)
		{
			for (yy in 0...8)
			{
				for (xx in 0...8)
				{
					// determine if mouse is within a region of a grid unit.
					if (ActionInput.coordinateX() > _startX + (xx * 75) 
					&& ActionInput.coordinateX() < _startX + 75 + (xx * 75) 
					&& ActionInput.coordinateY() > _startY + (yy * 75)
					&& ActionInput.coordinateY() < _startY + 75 + (yy * 75)
					)
					{
						// if mouse is clicked and is at that player's piece then use an image to highlight that unit. 
						if (Reg._gameHost == true && ActionInput.overlaps(Reg._groupPlayer1) 
						||  Reg._gameHost == false && ActionInput.overlaps(Reg._groupPlayer2)
						)
						{			
							if (visible == false) visible = true;												
							 x = _startX + xx * 75;				
							 y = _startY + yy * 75;
							
							var _p:Int = 0;
							
							break;
						
						}			
						
						else  if (visible == true) visible = false;			
					}	 	
				}
			}
		}
	}
	
	private function highlightChess():Void
	{
		for (yy in 0...8)
		{
			for (xx in 0...8)
			{
				// determine if mouse is within a region of a grid unit.
				if (ActionInput.coordinateX() > _startX + (xx * 75) 
				&& ActionInput.coordinateX() < _startX + 75 + (xx * 75) 
				&& ActionInput.coordinateY() > _startY + (yy * 75)
				&& ActionInput.coordinateY() < _startY + 75 + (yy * 75)
				)
				{
					// if mouse is clicked and is at that player's piece then use an image to highlight that unit. 
					if (Reg._gameHost == true && ActionInput.overlaps(Reg._groupPlayer1) 
					||  Reg._gameHost == false && ActionInput.overlaps(Reg._groupPlayer2)
					||  Reg._capturingUnitsForImages[Reg._playerMoving][yy][xx] > 0
					)
					{			
						if (visible == false) visible = true;												
						 x = _startX + xx * 75;				
						 y = _startY + yy * 75;
						
						var _p:Int = 0;
						
						break;
					
					}			
					
					else  if (visible == true) visible = false;			
				}	 	
			}
		}
	}
	
	private function highlightReversi():Void
	{
		// these yy and xx vars are the vertical and horizonal coordinates of the units that make up the grid of the gameboard. each unit is 75 x 75 pixels. 		
		for (yy in 0...8)
		{
			for (xx in 0...8)
			{
				// determine if mouse is within a region of a grid unit.
				if (ActionInput.coordinateX() > _startX + (xx * 75) 
				&& ActionInput.coordinateX() < _startX + 75 + (xx * 75) 
				&& ActionInput.coordinateY() > _startY + (yy * 75)
				&& ActionInput.coordinateY() < _startY + 75 + (yy * 75)
				&& Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] > 0 
				&& Reg._gamePointValueForPiece[yy][xx] == 0
				)
				{			
					if (visible == false) visible = true;
					
					// the XY coordinate equals the start of the board plus the unit coordinate times the width/height of this image.
					 x = _startX + xx * 75;						
					 y = _startY + yy * 75;	
				}	
			}
		}
	}
	
	private function highlightSignatureGame():Void
	{
		// signature game.
		// these yy and xx vars are the vertical and horizonal coordinates of the units that make up the grid of the gameboard. each unit is 75 x 75 pixels. 		
		for (yy in 0...8)
		{
			for (xx in 0...8)
			{
				// highlights any square, with an image, that the player is able to move the piece to.
				if (RegTriggers._highlightOnlyOuterUnits == false && yy > 1 && yy < 6 && xx > 1 && xx < 6) {} // don't draw centre unit if playing the signature game.
				else if (RegTriggers._highlightOnlyOuterUnits == true && yy > 0 && yy < 7 && xx > 0 && xx < 7) {}
				else
				{	
					// determine if mouse is within a region of a grid unit.
					
					// SignatureGameSelect.background != null is needed to stop a bug where clicking the units directly after the number wheel is clicked will result in a client freeze.
					if (ActionInput.coordinateX() > _startX + (xx * 75) 
					&& ActionInput.coordinateX() < _startX + 75 + (xx * 75) 
					&& ActionInput.coordinateY() > _startY + (yy * 75)
					&& ActionInput.coordinateY() < _startY + 75 + (yy * 75)
					)
					{
						if (visible == false) visible = true;
						
						// the XY coordinate equals the start of the board plus the unit coordinate times the width/height of this image.
						 x = _startX + xx * 75;						
						 y = _startY + yy * 75;
						
						Reg._gameYYold = yy;
						Reg._gameXXold = xx;
						
						var _p:Int = 0;
						
						if (RegTriggers._highlightOnlyOuterUnits == true && ActionInput.justPressed() == true && Reg._messageId == 0 && RegTriggers._tradeWasAnswered == false && Reg._yesNoKeyPressValueAtTrade == 0
						|| RegTriggers._highlightOnlyOuterUnits == true && Reg._move_number_current > 0 && Reg._game_offline_vs_cpu == true && Reg._messageId == 0 && RegTriggers._tradeWasAnswered == false && Reg._yesNoKeyPressValueAtTrade == 0) 
						{
							
								
							// your unit that you would like to trade.
							if (Reg._move_number_next + 1 == Reg._gameUniqueValueForPiece[yy][xx] && SignatureGameMain._unitYoursButton.toggled == true)
							{
								// do not set player's data if other player is moving.
				
								if (RegTriggers._tradeProposalOffer == false)
								{
									SignatureGameMain._unitYoursButton.label.text = ""; // remove "yours" text.
									_p = Reg._gamePointValueForPiece[yy][xx] - 1;
									Reg._signatureGameUnitNumberTrade[0] = _p;
									SignatureGameMain._unitYoursText.text = "Unit #" + _p;
									// save this in a var so we know which unit was clicked when trading units. this vars are used for the signature game when training. these vars are for the player that selected trade from the options menu.
									Reg._gameYYnew2 = yy;
									Reg._gameXXnew2 = xx;
									
								}
								
								if (_p > 0) SignatureGameMain._unitYoursImage.loadGraphic("assets/images/signatureGame/"+ _p +".png", false);
								
							}
						}
					}
				}
			}
		}
	

	}
}

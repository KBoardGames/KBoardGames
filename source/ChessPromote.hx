/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published
    by the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

/**
 * ...
 * @author kboardgames.com
 */
class ChessPromote extends FlxSubState
{	
	/******************************
	 * on the gameboard this box surrounds the selected piece.
	 */
	private var _currentUnit:FlxSprite;
	
	/******************************
	 * used to display the white or black promoted piece.
	 */
	private var _num:Int = 0;
	
	public function new():Void
	{
		super();	
		
		var background = new FlxSprite(0, 0);
		background.makeGraphic(FlxG.width, FlxG.height, 0xCC000000);
		background.scrollFactor.set(0, 0);	
		add(background);
		
		var background2 = new FlxSprite(0, 0);
		background2.makeGraphic(650, 275, 0xFF000066);
		background2.scrollFactor.set(0, 0);	
		background2.screenCenter(XY);
		add(background2);	
		
		
		if (Reg._gameYYnew == 7) _num = 10;
			
		if (Reg._chessPawnPromotedMessage == false)
		{
			var _text:FlxText = new FlxText(0, FlxG.height / 2 -75, 0, "Promote pawn to which piece.");
			_text.setFormat(null, 25, FlxColor.WHITE, LEFT);
			_text.font = Reg._fontDefault;
			_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 1);
			_text.scrollFactor.set(0, 0);
			_text.screenCenter(X);
			add(_text);
			
			var _bishop = new FlxSprite(FlxG.width / 2 - 150, FlxG.height / 2);
			_bishop.loadGraphic("assets/images/chess/" + (2 + _num) + ".png", false);
			_bishop.scrollFactor.set(0, 0);
			add(_bishop);
			
			var _horse = new FlxSprite(FlxG.width / 2 - 75, FlxG.height / 2);
			_horse.loadGraphic("assets/images/chess/" + (3 + _num) + ".png", false);
			_horse.scrollFactor.set(0, 0);
			add(_horse);
			
			var _rook = new FlxSprite(FlxG.width / 2, FlxG.height / 2);
			_rook.loadGraphic("assets/images/chess/" + (4 + _num) + ".png", false);
			_rook.scrollFactor.set(0, 0);
			add(_rook);
			
			var _queen = new FlxSprite(FlxG.width / 2 + 75, FlxG.height / 2);
			_queen.loadGraphic("assets/images/chess/" + (5 + _num) + ".png", false);
			_queen.scrollFactor.set(0, 0);
			add(_queen);
			
			// on the gameboard this box surrounds the selected piece.
			_currentUnit = new FlxSprite(FlxG.width / 2 + 75, FlxG.height / 2);
			_currentUnit.loadGraphic("assets/images/currentUnit.png", false);
			_currentUnit.scrollFactor.set(0, 0);
			add(_currentUnit);
			
			Reg._chessPawnPromotedMessage = true;
		
		}
		
		else 
		{
			var _text:FlxText = new FlxText(0, 0, 0, "");
			_text.setFormat(null, 25, FlxColor.WHITE, LEFT);
			
			if (Reg._gameYYold == 7) _num = 10; // used to display the white or black promoted piece.
			else _num = 0;
			
			if (_num == 0) _text.text = "White ";
			else _text.text = "Black ";
			
			_text.text += "Pawn promoted to ";
			
			if (Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew] == (5 + _num)) _text.text += "queen.";
			if (Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew] == (4 + _num)) _text.text += "rook.";
			if (Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew] == (3 + _num)) _text.text += "horse.";
			if (Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew] == (2 + _num)) _text.text += "bishop.";
			
			_text.font = Reg._fontDefault;
			_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 1);
			_text.scrollFactor.set(0, 0);
			_text.screenCenter(XY);
			add(_text);
			
			Reg._gameMessage = _text.text;			
		}
	}
	
	override public function update(elapsed:Float):Void 
	{		
		if (Reg._chessPawnPromotedMessage == true)
		{
			// computer's turn to move? then select queen.
			if (Reg._playerMoving == 0 && Reg._game_offline_vs_cpu == true)
			{
				Reg._chessPawnIsPromoted = true;
				Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew] = (_num + 5);
				
				var _found:Bool = false;

				// search the board for a queen instance of unique value that does not exist.
				for (i in 0...10)
				{
					for (yy in 0...8)
					{
						for (xx in 0...8)
						{
							if (Reg._gameUniqueValueForPiece[yy][xx] == 40 + i)
							{
								_found = true; // piece exists, so try again.
							}
						}
					}
					
					if (_found == false)
					{
						// piece not found, so create the queen.
						Reg._gameUniqueValueForPiece[Reg._gameYYnew][Reg._gameXXnew] = 40 + i;
						//ChessCapturingUnits.populateCaptures(1);
						//ChessCapturingUnits.populateCaptures(0);
						break;						
					}
					
					_found = false;
				}
				
				Reg._promotePieceLetter = "(Q)";
			
				new FlxTimer().start(1, closeMessage, 1);
				
			}
					
			else
			{
				for (xx in 0...4)
				{
					// determine if mouse is within a region of a grid unit.
					if (ActionInput.coordinateX() > (FlxG.width / 2 - 150) + (xx * 75) && ActionInput.coordinateX() < (FlxG.width / 2 - 150) + 75 + (xx * 75) && ActionInput.coordinateY() > (FlxG.height / 2) && ActionInput.coordinateY() < (FlxG.height / 2) + 75)
					 {
						 _currentUnit.x = (FlxG.width / 2 - 150) + xx * 75;						
						 _currentUnit.y = (FlxG.height / 2);
						 
						
						 
						 if (ActionInput.justPressed() == true) 
						 {					 
							Reg._chessPawnIsPromoted = true;
														
							switch(xx)
							{								
								case 0:
									{										
										var _found:Bool = false;
										
										for (i in 0...10)
										{
											for (yy in 0...8)
											{
												for (xx in 0...8)
												{
													if (Reg._gameUniqueValueForPiece[yy][xx] == 10 + i)
													{
														_found = true;
													}; 
												}
											}
											
											if (_found == false)
											{
												Reg._gameUniqueValueForPiece[Reg._gameYYnew][Reg._gameXXnew] = 10 + i; 
												break;
											}
											
											_found = false;
										}
										
										
										Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew] = 2;
										Reg._promotePieceLetter = "(B)";
									}
								case 1:
									{										
										var _found:Bool = false;
										
										for (i in 0...10)
										{
											for (yy in 0...8)
											{
												for (xx in 0...8)
												{
													// a value of 20-29 is a horse. if this value remains false then no horse is found for that unique value.
													if (Reg._gameUniqueValueForPiece[yy][xx] == 20 + i)
													{
														_found = true;
													}; 
												}
											}
											
											// at this unit, create a horse with the unique Value of 20 + i.
 											if (_found == false)
											{
												Reg._gameUniqueValueForPiece[Reg._gameYYnew][Reg._gameXXnew] = 20 + i; 
												break;
											}
											
											_found = false;
										}
										
										
										Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew] = 3;
										Reg._promotePieceLetter = "(N)"; // notation knight (horse).
									}
								case 2: 
									{										
										var _found:Bool = false;
										
										for (i in 0...10)
										{
											for (yy in 0...8)
											{
												for (xx in 0...8)
												{
													if (Reg._gameUniqueValueForPiece[yy][xx] == 30 + i)
													{
														_found = true;
													}; 
												}
											}
											
											if (_found == false)
											{
												Reg._gameUniqueValueForPiece[Reg._gameYYnew][Reg._gameXXnew] = 30 + i; 
												break;
											}
											
											_found = false;
										}
										
										
										Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew] = 4;
										Reg._promotePieceLetter = "(R)";
									}
								case 3:
									{										
										var _found:Bool = false;
										
										for (i in 0...10)
										{
											for (yy in 0...8)
											{
												for (xx in 0...8)
												{
													if (Reg._gameUniqueValueForPiece[yy][xx] == 40 + i)
													{
														_found = true;
													}; 
												}
											}
											
											if (_found == false)
											{
												Reg._gameUniqueValueForPiece[Reg._gameYYnew][Reg._gameXXnew] = 40 + i; 
												break;
											}
											
											_found = false;
										}
										
										
										Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew] = 5;
										Reg._promotePieceLetter = "(Q)";
									}
							}
														
							new FlxTimer().start(1, closeMessage, 1);
						}

					}
				}
			}
		}
				
		super.update(elapsed);
	}	
	
	private function closeMessage(i:FlxTimer):Void
	{
		Reg._chessPawnPromotedMessage = false;
		Reg._gameMessage = "";
		close();
	}
}
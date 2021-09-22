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
class GameHistoryAndNotations extends FlxGroup
{
	/******************************
	 * text to be displayed at the scroller.
	 */
	public static var _messageForBoxScroller:FlxText;
	
	/******************************
	 * the boxScroller would not work without at least one sprite added to the boxScrollerGroup.
	 */
	public static var _box:FlxSprite;
	
	/******************************
	 * add any object to this group. those objects added will be displayed at the boxScroller.
	 */
	public static var _boxScrollerGroup:FlxSpriteGroup;
	
	/******************************
	 * pointer to the scroller.
	 */
	public static var __boxscroller:FlxScrollableArea;
	
	/******************************
	 * an image used as a border that surrounds the scrollableArea.
	 */
	public static var _notationDisplayBorder:FlxSprite;
	
	/******************************
	 * used to darken the scrollableArea region.
	 */
	public static var _notation:FlxSprite;
	
	/******************************
	 * this is the scroller text. this is a pointer to ScrollingText. not to be confused with scrollableArea. Dynamic is used to avoid a strange error. this var is for player 1.
	 */
	public static var _scrollingTextP1:Dynamic;	
	
	/******************************
	 * this is the scroller text. this is a pointer to ScrollingText. not to be confused with scrollableArea. Dynamic is used to avoid a strange error. this var is for player 2 or player computer.
	 */
	public static var _scrollingTextP2:Dynamic;
   
	public function new():Void
	{
		super();
				
		RegFunctions.fontsSharpen();
		
		// add any object to this group. those objects added will be displayed at the boxScroller.
		_boxScrollerGroup = cast add(new FlxSpriteGroup());

		// the boxScroller would not work without at least one sprite added to the boxScrollerGroup.
		_box = new FlxSprite();
		_box.makeGraphic(1, 1, FlxColor.BLACK);
		_box.setPosition(0, 0);
		add(_box);
		_boxScrollerGroup.add(_box);

		// this text is needed to fix a bug. it shows a scroll bar by feeding new lines to the FlxScrollableArea. this scrollbar move up until its bottom edge reaches the bottom of the FlxScrollableArea.
		var _text = new FlxText(40, FlxG.height - Reg._offsetScreenY + 13, 0, "");
		_text.setFormat(null, 17, FlxColor.WHITE, LEFT);
		_text.offset.set(0, 10);
		_text.font = Reg._fontDefault;
		_text.text = "this will fix\n a display\n bug. \n by making new lines. \n";
		_text.visible = false; // the bug will still be fixed.
		add(_text);
		_boxScrollerGroup.add(_text);
		
		// used to darken the scrollableArea region.
		if (RegCustom._notation_panel_enabled[Reg._tn] == true)
		{
			_notation = new FlxSprite(0, 0);
			_notation.makeGraphic(337, FlxG.height - Reg._offsetScreenY + 13, FlxColor.BLACK);
			if (RegCustom._notation_panel_10_percent_alpha_enabled[Reg._tn] == true)
				_notation.alpha = 0.60;
			_notation.scrollFactor.set(0, 0);
			add(_notation);
		}
		
		// text to be displayed at the boxScroller.
		_messageForBoxScroller = new FlxText(30, FlxG.height, 0, "");
		_messageForBoxScroller.setFormat(null, Reg._font_size, FlxColor.WHITE, LEFT);
		//_messageForBoxScroller.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 1);
		_messageForBoxScroller.offset.set(0, 10);
		_messageForBoxScroller.font = Reg._fontDefault;
		_messageForBoxScroller.text = "Notations:\r\r";
		add(_messageForBoxScroller);
		_boxScrollerGroup.add(_messageForBoxScroller);
		
		//----------
		if (__boxscroller != null)
		{
			FlxG.cameras.remove(__boxscroller);
			__boxscroller.destroy();
			__boxscroller = null;
		}
		
		// make a scrollbar-enabled camera for it (a FlxScrollableArea).
		if (__boxscroller != null) FlxG.cameras.remove(__boxscroller);
		__boxscroller = new FlxScrollableArea( new FlxRect( 0, 0, 357, FlxG.height - 90), _boxScrollerGroup.getHitbox(), ResizeMode.NONE, 0, 100, -1, FlxColor.LIME, null, 0, false, false);
		
		FlxG.cameras.add(__boxscroller);
		__boxscroller.antialiasing = true;
		__boxscroller.pixelPerfectRender = true;
	}

	public static function notationShare():Void
	{
		// make a scrollbar-enabled camera for it (a FlxScrollableArea).
		if (__boxscroller != null) FlxG.cameras.remove(__boxscroller);
		__boxscroller = new FlxScrollableArea( new FlxRect( 0, 0, 357, FlxG.height - 90), _boxScrollerGroup.getHitbox(), ResizeMode.NONE, 0, 100, -1, FlxColor.LIME, null, 0, false, true);
		
		FlxG.cameras.add(__boxscroller);
		__boxscroller.antialiasing = true;
		__boxscroller.pixelPerfectRender = true;
		
	}
	
	/******************************
	 * removes the notation camera and boxScroller when text changes so that creating the boxScroller will not be needed which will only decrease the framerate after awhile.
	 */
	public static function notationReset():Void
	{
		//Reg._chessStrippedNotation = ""; // do not uncomment.
		Reg._chessStrippedNotationTemp = "";
		
		
		if (__boxscroller != null)
		{
			FlxG.cameras.remove(__boxscroller);
			__boxscroller.destroy();
			__boxscroller = null;
		}
		
		notationShare();

	}
	
	/******************************
	 * store the move history not in notation format but in _p value. the top-left corner of the board, the first unit, has a value of 1, then the next unit to its right has a value of 2. continue until you reach the 8th unit then the 9th unit is underneath the first unit that has a value of 1.
	 */
	public static function historyBasic():Void
	{
		Reg._step += 1;
		
		// the order of player's notations. this array elements will later be looped for start to end. an element of 0 refers to a history of player 1's moves.
		Reg._moveNumberAllNotations[Reg._moveNumberAllNotations.length] = Reg._moveNumberCurrentForNotation;
		Reg._moveNumberAllNotations.push(0);

		// ############# Move piece. ############################
		if (RegTypedef._dataPlayers._spectatorWatching == false
		||  RegTypedef._dataTournaments._move_piece == true
		)
		{
			// this is the normal piece that moved. for the GameIDsHistoryButtons.hx.
			Reg._moveHistoryPieceLocationOld1[Reg._moveHistoryPieceLocationOld1.length] = RegFunctions.getP(Reg._gameYYold, Reg._gameXXold) + 1;	
			
			Reg._moveHistoryPieceLocationNew1[Reg._moveHistoryPieceLocationNew1.length] = RegFunctions.getP(Reg._gameYYnew, Reg._gameXXnew) + 1;	
		
			// the jumped over piece or the second piece (castling) that moves in one move.
			Reg._moveHistoryPieceLocationOld2[Reg._moveHistoryPieceLocationOld2.length] = RegFunctions.getP(Reg._gameYYold2, Reg._gameXXold2) + 1;	

			Reg._moveHistoryPieceLocationNew2[Reg._moveHistoryPieceLocationNew2.length] = RegFunctions.getP(Reg._gameYYnew2, Reg._gameXXnew2) + 1;	
		
			// ############ image value of piece #######################################
			// see CheckersMovePlayersPiece.hx for how Reg._imageValueOfUnitOld1 is used.
			Reg._moveHistoryPieceValueOld1[Reg._moveHistoryPieceValueOld1.length] = Reg._imageValueOfUnitOld1;

			Reg._moveHistoryPieceValueNew1[Reg._moveHistoryPieceValueNew1.length] = Reg._imageValueOfUnitNew1;
			
			Reg._moveHistoryPieceValueOld2[Reg._moveHistoryPieceValueOld2.length] = Reg._imageValueOfUnitOld2;

			Reg._moveHistoryPieceValueNew2[Reg._moveHistoryPieceValueNew2.length] = Reg._imageValueOfUnitNew2;
			
			Reg._moveHistoryPieceValueOld3[Reg._moveHistoryPieceValueOld3.length] = Reg._imageValueOfUnitOld3;
			
			
			Reg._historyImageChessPromotion[Reg._historyImageChessPromotion.length] = 0;
		
		/*	
		trace("1old"+Reg._moveHistoryPieceLocationOld1);
		trace("1new"+Reg._moveHistoryPieceLocationNew1);
		trace("2old"+Reg._moveHistoryPieceLocationOld2);
		trace("2new"+Reg._moveHistoryPieceLocationNew2);
		trace("image 1old"+Reg._moveHistoryPieceValueOld1);
		trace("image 1new"+Reg._moveHistoryPieceValueNew1);
		trace("image 2old"+Reg._moveHistoryPieceValueOld2);
		trace("image 2new"+Reg._moveHistoryPieceValueNew2);
		trace("image 3old"+Reg._moveHistoryPieceValueOld3);
		*/
		
			RegTypedef._dataMovement._moveHistoryPieceLocationOld1 = Std.string(Reg._moveHistoryPieceLocationOld1[Reg._moveHistoryPieceLocationOld1.length-1]);
			
			RegTypedef._dataMovement._moveHistoryPieceLocationNew1 = Std.string(Reg._moveHistoryPieceLocationNew1[Reg._moveHistoryPieceLocationNew1.length-1]);
			
			RegTypedef._dataMovement._moveHistoryPieceLocationOld2 = Std.string(Reg._moveHistoryPieceLocationOld2[Reg._moveHistoryPieceLocationOld2.length-1]);
			
			RegTypedef._dataMovement._moveHistoryPieceLocationNew2 = Std.string(Reg._moveHistoryPieceLocationNew2[Reg._moveHistoryPieceLocationNew2.length-1]);
			
			RegTypedef._dataMovement._moveHistoryPieceValueOld1 = Std.string(Reg._moveHistoryPieceValueOld1[Reg._moveHistoryPieceValueOld1.length-1]);
			
			RegTypedef._dataMovement._moveHistoryPieceValueNew1 = Std.string(Reg._moveHistoryPieceValueNew1[Reg._moveHistoryPieceValueNew1.length-1]);
			
			RegTypedef._dataMovement._moveHistoryPieceValueOld2 = Std.string(Reg._moveHistoryPieceValueOld2[Reg._moveHistoryPieceValueOld2.length-1]);
			
			RegTypedef._dataMovement._moveHistoryPieceValueNew2 = Std.string(Reg._moveHistoryPieceValueNew2[Reg._moveHistoryPieceValueNew2.length - 1]);
			
			RegTypedef._dataMovement._moveHistoryPieceValueOld3 = Std.string(Reg._moveHistoryPieceValueOld3[Reg._moveHistoryPieceValueOld3.length-1]);
		}

		// only send move history to MySQL using the host of the game that is not spectator because we do not need more than one entry per move.
		if (Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false
		&&  RegTypedef._dataPlayers._spectatorWatching == false
		&&  Reg._gameHost == true
		||  RegTypedef._dataTournaments._move_piece == true
		)
		{
			RegTypedef._dataMovement._username_room_host = RegTypedef._dataMisc._roomHostUsername[RegTypedef._dataMisc._room];
			
			RegTypedef._dataMovement._point_value = "";
			RegTypedef._dataMovement._unique_value = "";
			
			for (yy in 0...8)
			{
				for (xx in 0...8)
				{
					RegTypedef._dataMovement._point_value += Reg._gamePointValueForPiece[yy][xx] + ",";
					RegTypedef._dataMovement._unique_value += Reg._gameUniqueValueForPiece[yy][xx] + ",";
				}
			}
			
			// players enter this event in the order that this event was first called.
			PlayState.clientSocket.send("Move History Next Entry", RegTypedef._dataMovement);
			haxe.Timer.delay(function (){}, Reg2._event_sleep);
			
			//RegTypedef._dataMovement._username = _tempUsername;
			
		}
	}
	
	public function notationPrint():Void 
	{
		// should the notation panel be displayed?
		if (RegCustom._notation_panel_enabled[Reg._tn] == false) return;
		
		var _textTemp:String = ""; // used to store pieces of text. when finished the this var will be copied to _messageForBoxScroller.text.	
		var _letter:String = "";
		
		if (Tournaments._piece_move_completed == false) historyBasic();
		
		// not in tournament or have not yet moved game piece in tournament play.
		if (RegTypedef._dataTournaments._move_piece == true)
			Tournaments._piece_move_completed = true;
		
		// current notation print is not a feature for the spectator watching nor for tournament play.
		if (RegTypedef._dataPlayers._spectatorWatching == true) return;
		
		// value set after promoting a piece. that value will be a first letter in brackets referring to a pawn promoted to that piece.
		if (Reg._promotePieceLetter == "" && Reg._gameYYold > -1)
		{
			// not promoting a piece. therefore, in notation, this first letter of a chess piece is used to refer to that piece, N = knight (horse) because K is used by king. 
			
			if (Reg._gameId == 1)
			{
				// pawns.
				if (Reg._gameUniqueValueForPiece[Reg._gameYYnew][Reg._gameXXnew] > 0 && Reg._gameUniqueValueForPiece[Reg._gameYYnew][Reg._gameXXnew] < 9)
				_letter = "";
				// bishop.
				if (Reg._gameUniqueValueForPiece[Reg._gameYYnew][Reg._gameXXnew] > 9 && Reg._gameUniqueValueForPiece[Reg._gameYYnew][Reg._gameXXnew] < 20)
				_letter += "B";
				// horse.
				if (Reg._gameUniqueValueForPiece[Reg._gameYYnew][Reg._gameXXnew] > 19 && Reg._gameUniqueValueForPiece[Reg._gameYYnew][Reg._gameXXnew] < 30)
				_letter += "N";
				// rook.
				if (Reg._gameUniqueValueForPiece[Reg._gameYYnew][Reg._gameXXnew] > 29 && Reg._gameUniqueValueForPiece[Reg._gameYYnew][Reg._gameXXnew] < 40)
				_letter += "R";
				// queen.
				if (Reg._gameUniqueValueForPiece[Reg._gameYYnew][Reg._gameXXnew] > 39 && Reg._gameUniqueValueForPiece[Reg._gameYYnew][Reg._gameXXnew] < 50)
				_letter += "Q";
				// king.
				if (Reg._gameUniqueValueForPiece[Reg._gameYYnew][Reg._gameXXnew] == 60)
				_letter += "K";	
			} else _letter = "";
		}
		
		// pawn promotion. show the notation as pawn for the first notation and the selected piece for the second promotion.
		if (Reg._promotePieceLetter != "") _textTemp = unitToXletterOld() + unitToYnumberOld() + "-" + unitToXletterNew() + unitToYnumberNew();		
		else _textTemp = _letter + unitToXletterOld() + unitToYnumberOld() + "-" + unitToXletterNew() + unitToYnumberNew();
		
		// stripped version of notation. used to compare at server.
		if (Reg._chessStrippedNotation == "")
		{
			Reg._chessStrippedNotation = "1.";
			Reg._chessStrippedNotation += unitToXletterOld() + unitToYnumberOld() + unitToXletterNew() + unitToYnumberNew();
		}
		else 
		{
			if (Reg._chessStrippedNotation.substr(Reg._chessStrippedNotation.length - 4, 4) != unitToXletterOld() + unitToYnumberOld() + unitToXletterNew() + unitToYnumberNew()) 
			{
				Reg._chessStrippedNotation = Reg._chessStrippedNotation + " " + unitToXletterOld() + unitToYnumberOld() + unitToXletterNew() + unitToYnumberNew();
			}
		} 
		
		Reg._chessStrippedNotationTemp = Reg._chessStrippedNotation;
		
		if (_textTemp != "")
		{
			if (Reg._gameId == 1)
			{
				if (Reg._promotePieceLetter != "") _textTemp = _textTemp + Reg._promotePieceLetter; // (Q) for queen at the end of a notation.
				if (Reg._doneEnPassant == true) _textTemp = _textTemp + "(ep)"; // En passant.
				if (Reg._gameMessage == "Check" && Reg._chessUnitsInCheckTotal[Reg._playerMoving] != 0) _textTemp = _textTemp + "+"; // refers to check.  
				if (Reg._gameMessage == "Checkmate" 
				||  Reg._gameMessage == "Black piece wins." && Reg._gameId == 1
				||  Reg._gameMessage == "While piece wins." && Reg._gameId == 1)
				_textTemp = _textTemp + "++"; // refers to checkmate.
						
				if (Reg._gameYYnew2 > -1 )
				{
					if (Reg._gameXXnew2 >= 5)
					{
						Reg._gameMessage = "Castling"; 
						Reg._outputMessage = true;
						_textTemp = _textTemp + "(0-0)"; // castling kingside.
					}
					else 
					{
						Reg._gameMessage = "Castling";
						Reg._outputMessage = true;
						_textTemp = _textTemp + "(0-0-0)"; // castle queenside. 
					}
				}
			}
			
			// when text is printed to screen, player 1 and the other player both share the same notation print line. _gameNotationMoveNumber increments after the other player moves. _gameNotationOddEven is used to toggle between player 1 and other player so that they can both be printed to the same line.
			if (Reg._gameNotationOddEven > 0)
			{
				if (Reg._gameNotationOddEven == 1)	_messageForBoxScroller.text += Std.string(Reg._gameNotationMoveNumber + 1) + ". " + _textTemp;
				
				if (Reg._gameNotationOddEven == 2)	_messageForBoxScroller.text += " " + _textTemp + "\n";
			}
			
			Reg._gameNotationOddEven += 1;
			
			if (Reg._gameNotationOddEven == 3) Reg._gameNotationOddEven = 1;
			if (Reg._gameNotationOddEven == 2)	Reg._gameNotationMoveNumber += 1;		
			 
			
		}	
			
		isThisNotationAnECOopening();
		notationReset();
				
		_textTemp = "";
		Reg._gameMessage = "";
		RegTypedef._dataGameMessage._gameMessage = "";
	}
	
	/******************************
	 * start of a move when the mouse clicks the piece. as _gameXXold value increases it refers to a unit that runs from left to right.
	 */
	public static function unitToXletterOld():String
	{
		var _textTemp:String = "";
		
		if (Reg._gameXXold == 0) _textTemp += "a";
		if (Reg._gameXXold == 1) _textTemp += "b";
		if (Reg._gameXXold == 2) _textTemp += "c";
		if (Reg._gameXXold == 3) _textTemp += "d";
		if (Reg._gameXXold == 4) _textTemp += "e";
		if (Reg._gameXXold == 5) _textTemp += "f";
		if (Reg._gameXXold == 6) _textTemp += "g";
		if (Reg._gameXXold == 7) _textTemp += "h";
		
		return _textTemp;
	}
	
	/******************************
	 * start of a move when the mouse clicks the piece. as _gameYYold increases in value to refers to a unit that runs from up to down.
	 */
	public static function unitToYnumberOld():String
	{
		var _textTemp:String = "";
		
		if (Reg._gameYYold == 0) _textTemp = "8";
		if (Reg._gameYYold == 1) _textTemp = "7";
		if (Reg._gameYYold == 2) _textTemp = "6";
		if (Reg._gameYYold == 3) _textTemp = "5";
		if (Reg._gameYYold == 4) _textTemp = "4";
		if (Reg._gameYYold == 5) _textTemp = "3";
		if (Reg._gameYYold == 6) _textTemp = "2";
		if (Reg._gameYYold == 7) _textTemp = "1";
	
		return _textTemp;
	}
	
	/******************************
	 * end of a move when the mouse clicks an empty unit to move to. as _gameXXNew increases in value it refers to a unit that runs from left to right.
	 */
	public static function unitToXletterNew():String
	{
		var _textTemp:String = "";
		
		if (Reg._gameYYnew2 > -1 && Reg._gameId == 1) return _textTemp; 
		
		if (Reg._gameNotationX == true) _textTemp = "x";
		Reg._gameNotationX = false;
		
		if (Reg._gameXXnew == 0) _textTemp += "a";
		if (Reg._gameXXnew == 1) _textTemp += "b";
		if (Reg._gameXXnew == 2) _textTemp += "c";
		if (Reg._gameXXnew == 3) _textTemp += "d";
		if (Reg._gameXXnew == 4) _textTemp += "e";
		if (Reg._gameXXnew == 5) _textTemp += "f";
		if (Reg._gameXXnew == 6) _textTemp += "g";
		if (Reg._gameXXnew == 7) _textTemp += "h";
		
		return _textTemp;
	}
	
	/******************************
	 * end of a move when the mouse clicks an empty unit to move to. as _gameYYNew increases in value it refers to a unit that runs from up to down.
	 */
	public static function unitToYnumberNew():String
	{
		var _textTemp:String = "";
		
		if (Reg._gameYYnew2 > -1 && Reg._gameId == 1) return _textTemp; 
		
		if (Reg._gameYYnew == 0) _textTemp = "8";
		if (Reg._gameYYnew == 1) _textTemp = "7";
		if (Reg._gameYYnew == 2) _textTemp = "6";
		if (Reg._gameYYnew == 3) _textTemp = "5";
		if (Reg._gameYYnew == 4) _textTemp = "4";
		if (Reg._gameYYnew == 5) _textTemp = "3";
		if (Reg._gameYYnew == 6) _textTemp = "2";
		if (Reg._gameYYnew == 7) _textTemp = "1";
	
		return _textTemp;
	}
	
	/******************************
	 * this "X" in notation refers to a piece that was captured.
	 */
	public static function notationX():Void
	{
		if (Reg._gameUniqueValueForPiece[Reg._gameYYnew][Reg._gameXXnew] > 0) 
		Reg._gameNotationX = true;
	}

	/******************************
	* none computer player.
	*/
	public static function isThisNotationAnECOopening():Void
	{
		if (Reg._enableGameNotations == true)
		{
			for (i in 0...Reg._ecoOpeningsNotations.length)
			{
				// if game notation of piece moved matches eco notation.
				if (Reg._chessStrippedNotation == Reg._ecoOpeningsNotations[i].substr(0, Reg._chessStrippedNotation.length))
				{
					// at PlayState, this text is checked to see if it does not equal empty. if true then output its text at ScrollingText.hx. which is a scroller on the screen.
					Reg._ecoOpeningsNotationsOutput = Reg._ecoOpeningsNames[i];
					break;
				}			
			}
		}
	}
	
	/******************************
	 * computer is moving.
	 */
	public static function CPUgetNotationForNextMove():Void
	{
		//if (Reg._chessStrippedNotation != Reg._chessStrippedNotationTemp) return;
		
		var _stop:Bool = false;
		
		// since the computer has not moved yet, the eco notation in the array needs to be exactly five characters greater then the current Reg._chessStrippedNotation.
		var strLan:Int = Reg._chessStrippedNotation.length + 5;
		var ra:Int = 0;		
		
		Reg._foundNotation = false;
		
		// can this be checkmate in 3? did player move one of these pieces to these units.
		if ( Reg._chessStrippedNotation == "1.f2f3"	
		  || Reg._chessStrippedNotation == "1.f2f4"
		  || Reg._chessStrippedNotation == "1.g2g4"
		  )
		{
			// make the computer prepare to move the queen for a checkmate in 3 opening play.
			Reg._gameXXold = 4;
			Reg._gameYYold = 1;
			Reg._gameXXnew = 4;
			Reg._gameYYnew = 3;
			
			Reg._foundNotation = true;
		}
		
		else
		{
			// after each player move, this var is populated with notations that the computer can select from.
			var _eco_notations_can_select:Array<String> = [];
			_eco_notations_can_select.splice(0, _eco_notations_can_select.length);
			
			// find the notations that the computer can move to.
			for ( i in 0... Reg._ecoOpeningsNotations.length)
			{
				// Reg._chessStrippedNotation is still minus five characters smaller then Reg._ecoOpeningsNotations[ra].length but a notation is found that is that much characters bigger. so we can use length here to enter the loop.
				if (Reg._chessStrippedNotation == Reg._ecoOpeningsNotations[i].substr(0, Reg._chessStrippedNotation.length))
				{	
					// if these match then the next notation for the Reg._chessStrippedNotation has been found. 
					if (strLan <= Reg._ecoOpeningsNotations[i].length)
					{
						_eco_notations_can_select.push(Reg._ecoOpeningsNotations[i].substr(0, strLan));
					}
				}
			}
			
			// select the notation for the computer.
			if (_eco_notations_can_select.length > 0)
			{
				// randomly select one of the eco notations.
				ra = FlxG.random.int(0, _eco_notations_can_select.length-1);
					
				// Reg._chessStrippedNotation is now five characters bigger so the move can be made by the computer.
				Reg._chessStrippedNotation = _eco_notations_can_select[ra];
				
				Reg._foundNotation = true;
									
			}
			
			// get the last four characters from the string. those characters are the movement coordinates for the computer.
			var _str = Reg._chessStrippedNotation.substr(Reg._chessStrippedNotation.length - 4, 4);
			
			if (_str.length == 4 && Reg._foundNotation == true)
			{
				var _temp1:String;
				var _temp2:String;
				var _temp3:String;
				var _temp4:String;
				
				// _str contains the movements coordinate for example, b2b4 which is b2=b2. b2 is the piece location and b4 is where the piece is moved to. _temp1 is b in b2 while temp2 is 2 in b2. go to the functions to convert letters and number into coordinates that this game understands. this game is written to understand that 62 is y 6 and x 2, but the eco notation does things differently. somethings we need numbers while other times number and letters are used. there is no correct way to do things.
				_temp1 = letterToNumber(_str.substr(0, 1));
				_temp2 = numberToReverse(_str.substr(1, 1));
				_temp3 = letterToNumber(_str.substr(2, 1));
				_temp4 = numberToReverse(_str.substr(3, 1));
				
				// set the values to the reg._game int. at next framerate update the computer will move a piece.
				Reg._gameXXold = Std.parseInt(_temp1);
				Reg._gameYYold = Std.parseInt(_temp2);
				Reg._gameXXnew = Std.parseInt(_temp3);
				Reg._gameYYnew = Std.parseInt(_temp4);
				
			}
		}
		
	}
	
	
	public static function letterToNumber(_textTemp:Dynamic):Dynamic
	{
		if (_textTemp == "a") _textTemp = 0;
		if (_textTemp == "b") _textTemp = 1;
		if (_textTemp == "c") _textTemp = 2;
		if (_textTemp == "d") _textTemp = 3;
		if (_textTemp == "e") _textTemp = 4;
		if (_textTemp == "f") _textTemp = 5;
		if (_textTemp == "g") _textTemp = 6;
		if (_textTemp == "h") _textTemp = 7;
		
		return _textTemp;
	}
	
	public static function numberToReverse(_textTemp:Dynamic):Dynamic
	{
		var _text:Dynamic = 0;
		
		if (_textTemp == "8") _text = 0;
		if (_textTemp == "7") _text = 1;
		if (_textTemp == "6") _text = 2;
		if (_textTemp == "5") _text = 3;
		if (_textTemp == "4") _text = 4;
		if (_textTemp == "3") _text = 5;
		if (_textTemp == "2") _text = 6;
		if (_textTemp == "1") _text = 7;
		
		return _text;
	}
	
	
	public function gameNotationScrollerText():Void
	{
		if (Reg._disconnectNow == true) return;
		
		// this is the game notation text for the scroller text.
		if (Reg._ecoOpeningsNotationsOutput != "")
		{
			// player 1.
			if (Reg._gameNotationOddEven == 2)
			{				
				// if scroller text is active then delete it so that another scroll text can be displayed.
				if (_scrollingTextP1 != null) _scrollingTextP1.destroy();
				_scrollingTextP1 = add(new ScrollingText(IDsCreateAndMain._gameBoard[0].x + 20, IDsCreateAndMain._gameBoard[0].y - 24, 260, 24, Reg._ecoOpeningsNotationsOutput, 18, 18)); // this is the scroller text.
			}
			
			if (Reg._gameNotationOddEven == 1)
			{
				if (_scrollingTextP2 != null) _scrollingTextP2.destroy();
				_scrollingTextP2 = add(new ScrollingText(IDsCreateAndMain._gameBoard[0].x + 300 + 20, IDsCreateAndMain._gameBoard[0].y - 24, 260, 24, Reg._ecoOpeningsNotationsOutput, 18, 18));
			}


			
			Reg._ecoOpeningsNotationsOutput = "";			
		}
	}	
	
	override public function destroy()
	{
		if (_box != null)
		{
			remove(_box);
			_box.destroy();
		}
		
		if (_messageForBoxScroller != null)
		{
			remove(_messageForBoxScroller);
			_messageForBoxScroller.destroy();
			_messageForBoxScroller = null;
		}
		
		if (__boxscroller != null)
		{
			cameras.remove(__boxscroller);
			__boxscroller.destroy();
			__boxscroller = null;
		}
		
		if (_boxScrollerGroup != null)
		{
			remove(_boxScrollerGroup);
			_boxScrollerGroup.destroy();
			_boxScrollerGroup = null;
		}
		
		if (_notation != null)
		{
			remove(_notation);
			_notation.destroy();
			_notation = null;
		}
		
		
		if (_scrollingTextP1 != null) 
		{
			remove(_scrollingTextP1);
			_scrollingTextP1.destroy();
			_scrollingTextP1 = null;
		}
		
		if (_scrollingTextP2 != null) 
		{
			remove(_scrollingTextP2);
			_scrollingTextP2.destroy();
			_scrollingTextP2 = null;
		}
		
		
		super.destroy();
	}

}
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
 * highlights which players turn it is to move. also updates the player's move total.
 * @author kboardgames.com
 */
class PlayerWhosTurnToMove extends FlxState
{	 	
	private var _rectangleBox:FlxSprite;
	private var _move_total:FlxText;
	
	public function new() 
	{
		super();
		
		// when its the player's turn to move, this _rectangleBox will be displayed behind that player's text.
		_rectangleBox = new FlxSprite(FlxG.width - 360, Reg._unitYgameBoardLocation[0] + 50);
		_rectangleBox.makeGraphic(51, 40, 0xFFFFFFFF);
		_rectangleBox.scrollFactor.set(0, 0);
		_rectangleBox.visible = false;
		add(_rectangleBox);
		
		var _textPlayer1 = new FlxText(FlxG.width - 352, Reg._unitYgameBoardLocation[0] + 55, 0, "", 20);
		_textPlayer1.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.CYAN);
		_textPlayer1.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 2);
		_textPlayer1.text = "P1";		
		_textPlayer1.scrollFactor.set(0, 0);
		add(_textPlayer1);
		
		var _textPlayer2 = new FlxText(FlxG.width - 267, Reg._unitYgameBoardLocation[0] + 55, 0, "", 20);
		_textPlayer2.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.CYAN);
		_textPlayer2.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 2);
		_textPlayer2.text = "P2";		
		_textPlayer2.scrollFactor.set(0, 0);
		add(_textPlayer2);
				
		if (Reg._roomPlayerLimit - Reg._playerOffset > 2)
		{		
			var _textPlayer3 = new FlxText(FlxG.width - 183, Reg._unitYgameBoardLocation[0] + 55, 0, "", 20);
			_textPlayer3.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.CYAN);
			_textPlayer3.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 2);
			_textPlayer3.text = "P3";		
			_textPlayer3.scrollFactor.set(0, 0);
			add(_textPlayer3);
		}
		
		if (Reg._roomPlayerLimit - Reg._playerOffset > 3)
		{
			var _textPlayer4 = new FlxText(FlxG.width - 98, Reg._unitYgameBoardLocation[0] + 55, 0, "", 20);
			_textPlayer4.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.CYAN);
			_textPlayer4.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 2);
			_textPlayer4.text = "P4";		
			_textPlayer4.scrollFactor.set(0, 0);
			add(_textPlayer4);
		}
	
		// display move total only for checkers, chess and Reversi. do this condition also for the function updateMove().
		if (Reg._gameId < 3 && RegCustom._move_total_enable == true)
		{
			_move_total = new FlxText(FlxG.width - 352, FlxG.height - 357, 0, "Total Move:" + RegTypedef._dataPlayers._moveTotal);
			_move_total.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.PINK);
			_move_total.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 2);
			_move_total.scrollFactor.set();
			add(_move_total);
		}
		
		updateMove();
	}

	override public function destroy()
	{
		
		super.destroy();
	}
	
	public function updateMove():Void 
	{
		_rectangleBox.visible = true;
		
		if (RegCustom._move_total_enable == true)
		{
			if (Reg._gameId < 3) _move_total.text = "Move Total: " + RegTypedef._dataPlayers._moveTotal;
		}
		
		// when it is the other players turn to move, this var is changed and the white box underneath the P1, P2, P3 or P4 moves, the second condition is, if player has a trade request and that player is the same as the requested player then highlight that player unit the request timer is finished or the player has clicked a request message box button.
		if (Reg._move_number_next == 0 && RegTriggers._tradeProposalOffer == false 
		|| RegTypedef._dataGameMessage._userTo != "" 
		&& RegTypedef._dataGameMessage._userTo == RegTypedef._dataPlayers._usernamesDynamic[0] 
		&& RegTriggers._tradeProposalOffer == true) 
		{
			if (_rectangleBox.x != FlxG.width - 360
			&& RegTypedef._dataPlayers._spectatorWatching == false)
			{
				RegTypedef._dataPlayers._spectatorWatchingGetMoveNumber = 0;
				
				if (RegTypedef._dataPlayers._username == RegTypedef._dataPlayers._usernamesDynamic[0] && Reg._playerCanMovePiece == true
				&& Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false) 
				{
					PlayState.clientSocket.send("Spectator Watching Get Move Number", RegTypedef._dataPlayers);
					haxe.Timer.delay(function (){}, Reg2._event_sleep);
				}
			}
			
			_rectangleBox.x = FlxG.width - 360;
		}
		
		
		if (Reg._move_number_next == 1 && RegTriggers._tradeProposalOffer == false 
		|| RegTypedef._dataGameMessage._userTo != "" 
		&& RegTypedef._dataGameMessage._userTo == RegTypedef._dataPlayers._usernamesDynamic[1] 
		&& RegTriggers._tradeProposalOffer == true)
		{
			if (_rectangleBox.x != FlxG.width - 275
			&& RegTypedef._dataPlayers._spectatorWatching == false)
			{
				RegTypedef._dataPlayers._spectatorWatchingGetMoveNumber = 1;
				if (RegTypedef._dataPlayers._username == RegTypedef._dataPlayers._usernamesDynamic[1] && Reg._playerCanMovePiece == true
				&& Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false) 
				{
					PlayState.clientSocket.send("Spectator Watching Get Move Number", RegTypedef._dataPlayers);
					haxe.Timer.delay(function (){}, Reg2._event_sleep);
				}
			}
			
			_rectangleBox.x = FlxG.width - 275;
		}
		
		if (Reg._move_number_next == 2 && RegTriggers._tradeProposalOffer == false 
		|| RegTypedef._dataGameMessage._userTo != "" 
		&& RegTypedef._dataGameMessage._userTo == RegTypedef._dataPlayers._usernamesDynamic[2] 
		&& RegTriggers._tradeProposalOffer == true)
		{
			if (_rectangleBox.x != FlxG.width - 190
			&& RegTypedef._dataPlayers._spectatorWatching == false)
			{
				RegTypedef._dataPlayers._spectatorWatchingGetMoveNumber = 2;
				if (RegTypedef._dataPlayers._username == RegTypedef._dataPlayers._usernamesDynamic[2] && Reg._playerCanMovePiece == true
				&& Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false) 
				{
					PlayState.clientSocket.send("Spectator Watching Get Move Number", RegTypedef._dataPlayers);
					haxe.Timer.delay(function (){}, Reg2._event_sleep);
				}
			}
				
			_rectangleBox.x = FlxG.width - 190;
		}
		
		if (Reg._move_number_next == 3 && RegTriggers._tradeProposalOffer == false 
		|| RegTypedef._dataGameMessage._userTo != "" 
		&& RegTypedef._dataGameMessage._userTo == RegTypedef._dataPlayers._usernamesDynamic[3] 
		&& RegTriggers._tradeProposalOffer == true)
		{
			if (_rectangleBox.x != FlxG.width - 105
			&& RegTypedef._dataPlayers._spectatorWatching == false)
			{
				RegTypedef._dataPlayers._spectatorWatchingGetMoveNumber = 3;
				if (RegTypedef._dataPlayers._username == RegTypedef._dataPlayers._usernamesDynamic[3] && Reg._playerCanMovePiece == true
				&& Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false)
				{
					PlayState.clientSocket.send("Spectator Watching Get Move Number", RegTypedef._dataPlayers);
					haxe.Timer.delay(function (){}, Reg2._event_sleep);
				}
			}
			
			_rectangleBox.x = FlxG.width - 105;
		}
	
	
	}
	
}
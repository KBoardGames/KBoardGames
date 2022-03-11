/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

/**
 * highlights which players turn it is to move. also updates the player's move total.
 * @author kboardgames.com
 */
class PlayerWhosTurnToMove extends FlxState
{
	/******************************
	 * when its the player's turn to move, this _background will be displayed behind either the p1, p2, p3 or p4 text.
	 */
	private var _background:FlxSprite;
	
	/******************************
	 * player's p1, p2, p3 or p4 text.
	 */
	private var _text:Array<FlxText> = [];
	
	/******************************
	 * display move total for games that use this feature.
	 */
	private var _move_total:FlxText;
	
	public function new() 
	{
		super();
		
		// when its the player's turn to move, this _background will be displayed behind that player's text.
		_background = new FlxSprite(FlxG.width - 360, Reg._unitYgameBoardLocation[0] + 50);
		_background.makeGraphic(51, 40, 0xFFFFFFFF);
		_background.scrollFactor.set(0, 0);
		_background.visible = false;
		add(_background);
		
		// player's p1, p2, p3 or p4 text.
		_text[0] = new FlxText(FlxG.width - 352, Reg._unitYgameBoardLocation[0] + 55, 0, "", 20);
		_text[0].setFormat(Reg._fontDefault, Reg._font_size, FlxColor.CYAN);
		_text[0].setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		_text[0].text = "P1";		
		_text[0].scrollFactor.set(0, 0);
		add(_text[0]);
		
		_text[1] = new FlxText(FlxG.width - 267, Reg._unitYgameBoardLocation[0] + 55, 0, "", 20);
		_text[1].setFormat(Reg._fontDefault, Reg._font_size, FlxColor.CYAN);
		_text[1].setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		_text[1].text = "P2";		
		_text[1].scrollFactor.set(0, 0);
		add(_text[1]);
				
		if (Reg._roomPlayerLimit - Reg._playerOffset > 2)
		{		
			_text[2] = new FlxText(FlxG.width - 183, Reg._unitYgameBoardLocation[0] + 55, 0, "", 20);
			_text[2].setFormat(Reg._fontDefault, Reg._font_size, FlxColor.CYAN);
			_text[2].setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
			_text[2].text = "P3";		
			_text[2].scrollFactor.set(0, 0);
			add(_text[2]);
		}
		
		if (Reg._roomPlayerLimit - Reg._playerOffset > 3)
		{
			_text[3] = new FlxText(FlxG.width - 98, Reg._unitYgameBoardLocation[0] + 55, 0, "", 20);
			_text[3].setFormat(Reg._fontDefault, Reg._font_size, FlxColor.CYAN);
			_text[3].setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
			_text[3].text = "P4";		
			_text[3].scrollFactor.set(0, 0);
			add(_text[3]);
		}
	
		// display move total for games that use this feature. do this condition also for the function updateMove().
		if (Reg._gameId < 3 && RegCustom._move_total_enabled[Reg._tn] == true)
		{
			_move_total = new FlxText(FlxG.width - 352, FlxG.height - 357, 0, "Total Move:" + RegTypedef._dataPlayers._moveTotal);
			_move_total.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
			_move_total.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
			_move_total.scrollFactor.set();
			add(_move_total);
		}
		
		updateMove();
	}

	public function updateMove():Void 
	{
		_background.visible = true;
		
		if (RegCustom._move_total_enabled[Reg._tn] == true)
		{
			if (Reg._gameId < 3) _move_total.text = "Total Moves: " + RegTypedef._dataPlayers._moveTotal;
		}
		
		// when it is the other players turn to move, this var is changed and the white box underneath the P1, P2, P3 or P4 moves, the second condition is, if player has a trade request and that player is the same as the requested player then highlight that player unit the request timer is finished or the player has clicked a request message box button.
		if (Reg._move_number_next == 0 && RegTriggers._tradeProposalOffer == false 
		|| RegTypedef._dataGameMessage._userTo != "" 
		&& RegTypedef._dataGameMessage._userTo == RegTypedef._dataPlayers._usernamesDynamic[0] 
		&& RegTriggers._tradeProposalOffer == true) 
		{
			if (_background.x != FlxG.width - 360
			&& RegTypedef._dataPlayers._spectatorWatching == false)
			{
				RegTypedef._dataPlayers._spectatorWatchingGetMoveNumber = 0;
				
				if (RegTypedef._dataPlayers._username == RegTypedef._dataPlayers._usernamesDynamic[0] && Reg._playerCanMovePiece == true
				&& Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false) 
				{
					PlayState.send("Spectator Watching Get Move Number", RegTypedef._dataPlayers);		
				}
			}
			
			_background.x = FlxG.width - 360;
		}
		
		
		if (Reg._move_number_next == 1 && RegTriggers._tradeProposalOffer == false 
		|| RegTypedef._dataGameMessage._userTo != "" 
		&& RegTypedef._dataGameMessage._userTo == RegTypedef._dataPlayers._usernamesDynamic[1] 
		&& RegTriggers._tradeProposalOffer == true)
		{
			if (_background.x != FlxG.width - 275
			&& RegTypedef._dataPlayers._spectatorWatching == false)
			{
				RegTypedef._dataPlayers._spectatorWatchingGetMoveNumber = 1;
				if (RegTypedef._dataPlayers._username == RegTypedef._dataPlayers._usernamesDynamic[1] && Reg._playerCanMovePiece == true
				&& Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false) 
				{
					PlayState.send("Spectator Watching Get Move Number", RegTypedef._dataPlayers);		
				}
			}
			
			_background.x = FlxG.width - 275;
		}
		
		if (Reg._move_number_next == 2 && RegTriggers._tradeProposalOffer == false 
		|| RegTypedef._dataGameMessage._userTo != "" 
		&& RegTypedef._dataGameMessage._userTo == RegTypedef._dataPlayers._usernamesDynamic[2] 
		&& RegTriggers._tradeProposalOffer == true)
		{
			if (_background.x != FlxG.width - 190
			&& RegTypedef._dataPlayers._spectatorWatching == false)
			{
				RegTypedef._dataPlayers._spectatorWatchingGetMoveNumber = 2;
				if (RegTypedef._dataPlayers._username == RegTypedef._dataPlayers._usernamesDynamic[2] && Reg._playerCanMovePiece == true
				&& Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false) 
				{
					PlayState.send("Spectator Watching Get Move Number", RegTypedef._dataPlayers);		
				}
			}
				
			_background.x = FlxG.width - 190;
		}
		
		if (Reg._move_number_next == 3 && RegTriggers._tradeProposalOffer == false 
		|| RegTypedef._dataGameMessage._userTo != "" 
		&& RegTypedef._dataGameMessage._userTo == RegTypedef._dataPlayers._usernamesDynamic[3] 
		&& RegTriggers._tradeProposalOffer == true)
		{
			if (_background.x != FlxG.width - 105
			&& RegTypedef._dataPlayers._spectatorWatching == false)
			{
				RegTypedef._dataPlayers._spectatorWatchingGetMoveNumber = 3;
				if (RegTypedef._dataPlayers._username == RegTypedef._dataPlayers._usernamesDynamic[3] && Reg._playerCanMovePiece == true
				&& Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false)
				{
					PlayState.send("Spectator Watching Get Move Number", RegTypedef._dataPlayers);		
				}
			}
			
			_background.x = FlxG.width - 105;
		}
		
	}
		
	override public function destroy()
	{
		if (_background != null)
		{
			remove(_background);
			_background.destroy();
			_background = null;
		}
		
		for (i in 0... 4)
		{
			if (_text[i] != null)
			{
				remove(_text[i]);
				_text[i].destroy();
				_text[i] = null;
			}
		}
		
		if (_move_total != null)
		{
			remove(_move_total);
			_move_total.destroy();
			_move_total = null;
		}
	
		super.destroy();
	}
	
	override public function update(elapsed:Float):Void 
	{
		updateMove();
		super.update(elapsed);	
	}
}
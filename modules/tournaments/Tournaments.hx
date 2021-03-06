/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package modules.tournaments;

import flixel.group.FlxGroup;
import flixel.FlxG;
import flixel.text.FlxText;

/**
 * all option and statistic buttons. Help checkers, instruction and exit buttons.
 * @author kboardgames.com
 */
class Tournaments extends FlxGroup
{
	public static var __title_bar:TitleBar;
	public static var __menu_bar:MenuBar; 
	
	private var _title_sub:FlxText;
	private var _tourny1:FlxText;
		
	/******************************
	 * true if the player moved a piece on the board in tournament play.
	 */
	public static var _piece_move_completed:Bool = false;
	
	/******************************
	 * go to game room
	 */
	public var _button_move_piece:ButtonGeneralNetworkYes;
	
	public function new():Void
	{
		super();	
		
		FlxG.autoPause = false;
		
		if (__title_bar != null)
		{
			remove(__title_bar);
			__title_bar.destroy();
		}
		
		__title_bar = new TitleBar("Tournaments");
		add(__title_bar);
		
		if (__menu_bar != null)
		{
			remove(__menu_bar);
			__menu_bar.destroy();
		}
		
		__menu_bar = new MenuBar();
		add(__menu_bar);
		
	}
	
	public function _tournament_standard_8():Void
	{
		if (_title_sub != null)
		{
			_title_sub.visible = false;
			remove(_title_sub);
			_title_sub.destroy();
		}
		
		_title_sub = new FlxText(15, 180, FlxG.width - 15, "Tournament Chess Standard (" + Std.string(RegTypedef._dataTournaments._player_current) + "/" + Std.string(RegTypedef._dataTournaments._player_maximum) + ")");
		_title_sub.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_topic_title_text_color());
		_title_sub.scrollFactor.set();
		add(_title_sub);
		
		if (_tourny1 != null)
		{
			_tourny1.visible = false;
			remove(_tourny1);
			_tourny1.destroy();
		}
		
		_tourny1 = new FlxText(15, _title_sub.y + 50, FlxG.width - 15, "");
		_tourny1.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		_tourny1.scrollFactor.set();
		add(_tourny1);
		
		if (RegTypedef._dataTournaments._player1 == "")
		{
			_tourny1.text = "You are not participating in this tournament.";
		}
		
		else if (RegTypedef._dataTournaments._move_piece == false
		&& 		 RegTypedef._dataTournaments._game_over == 0)
		{
			_tourny1.text = "Waiting for " + RegTypedef._dataTournaments._player2 + " to move gameboard piece. Come back later.";
		}
		
		else if (RegTypedef._dataTournaments._game_over == 0)
		
		{
			_tourny1.text = "Please move your gameboard piece.";
			
			_button_move_piece = new ButtonGeneralNetworkYes(_tourny1.x + _tourny1.textField.textWidth + 15, _tourny1.y, "Move Piece", 215, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, move_piece.bind(1), RegCustom._button_color[Reg._tn], false);		
			_button_move_piece.label.font = Reg._fontDefault;
			_button_move_piece.scrollFactor.set(0, 0);
			add(_button_move_piece);
		}
		
		else if (RegTypedef._dataTournaments._won_game == 1
		&&		 RegTypedef._dataTournaments._round_current <
				 RegTypedef._dataTournaments._rounds_total)
		{
			RegTypedef._dataTournaments._move_piece = false;
			
			_tourny1.text = "You have advanced to the next tournament round. However, users are still playing in the current tournament round. Therefore, You are waiting for an opponent. Come back later.";
			
		}
		
		else if (RegTypedef._dataTournaments._tournament_started == false)
		{
			_tourny1.text = "Tournament has not started yet because we still need more players to join. Come back later.";
		}
		
		else
		{
			RegTypedef._dataTournaments._move_piece = false;
			
			_tourny1.text = "You have been eliminated from this tournament.";
			
			if (_button_move_piece != null)
			{
				_button_move_piece.visible = false;
				remove(_button_move_piece);
				_button_move_piece.destroy();
			}
			
			_button_move_piece = new ButtonGeneralNetworkYes(_tourny1.x + _tourny1.textField.textWidth + 15, _tourny1.y, "Preview", 215, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, preview.bind(1), RegCustom._button_color[Reg._tn], false);		
			_button_move_piece.label.font = Reg._fontDefault;
			_button_move_piece.scrollFactor.set(0, 0);
			add(_button_move_piece);
		}
		
	}
	
	/******************************
	 * this code in this function setup everything needed to move a piece in tournament play.
	 */
	public function move_piece(_num:Int):Void
	{
		_piece_move_completed = false;
				
		__menu_bar._scene_tournaments_exit.active = false;
		__menu_bar.active = false;
		
		_button_move_piece.active = false;
		
		visible = false;
		
		RegTypedef._dataMisc._spectatorWatching = true;
		RegTypedef._dataPlayers._spectatorPlaying = true;
		RegTypedef._dataPlayers._spectatorWatching = true;
		
		if (_num == 1)
		{
			Reg._gameId = 1;
			RegTypedef._dataMisc._room = SceneLobby._room_total;
			PlayState.allTypedefRoomUpdate(SceneLobby._room_total);
		}
		
		RegTypedef._dataPlayers._moveNumberDynamic[0] = 0;
		RegTypedef._dataMisc._roomState[0] = 8;
		RegTypedef._dataMisc._userLocation = 3;
		
		RegTypedef._dataMovement._gid = RegTypedef._dataTournaments._gid;
		
		Reg._gameOverForPlayer = false;
		Reg._gameOverForAllPlayers = false;
		Reg._playerCanMovePiece = true;
		
		PlayState.send("Greater RoomState Value", RegTypedef._dataMisc); 		
	}
	
	/******************************
	 * preview the game then ending.
	 */
	public function preview(_num:Int):Void
	{
		_piece_move_completed = true;
				
		__menu_bar._scene_tournaments_exit.active = false;
		__menu_bar.active = false;
		
		_button_move_piece.active = false;
		
		visible = false;
		
		RegTypedef._dataMisc._spectatorWatching = true;
		RegTypedef._dataPlayers._spectatorPlaying = false;
		RegTypedef._dataPlayers._spectatorWatching = true;
		
		if (_num == 1)
		{			
			RegTypedef._dataMisc._room = SceneLobby._room_total;
			Reg._gameId = RegTypedef._dataMisc._roomGameIds[RegTypedef._dataMisc._room] = 1;
			PlayState.allTypedefRoomUpdate(SceneLobby._room_total);
		}
		
		RegTypedef._dataPlayers._moveNumberDynamic[0] = 0;
		RegTypedef._dataMisc._roomState[0] = 8;
		RegTypedef._dataMisc._userLocation = 3;
		
		RegTypedef._dataMovement._gid = RegTypedef._dataTournaments._gid;
		
		Reg._gameOverForPlayer = true;
		Reg._gameOverForAllPlayers = true;
		Reg._playerCanMovePiece = false;
		
		PlayState.send("Greater RoomState Value", RegTypedef._dataMisc); 		
	}
		
	override public function destroy()
	{
		super.destroy();
	}
	
	override public function update(elapsed:Float):Void
	{
		if (Reg._at_tournaments == false) return;
		
		if (RegTriggers._tournament_standard_chess_8 == true)
		{
			RegTriggers._tournament_standard_chess_8 = false;
			_tournament_standard_8();
		}
		
		super.update(elapsed);
	}	

}
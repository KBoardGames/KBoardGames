/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

/**
 * ...
 * @author kboardgames.com
 */
class MenuStateOfflinePlayers extends MenuState
{
	public static var __title_bar:TitleBar;
	public static var __menu_bar:MenuBar;
	
	override public function create():Void
	{
		Reg._at_game_room = false;
		Reg._alreadyOnlineHost = false;
		Reg._alreadyOnlineUser = false;
		RegTypedef.resetTypedefData();
		Reg.resetRegVars(); 
		Reg2.resetRegVars();
		RegCustom.resetRegVars();
		Reg._at_menu_state_offline = true;
		_ticks_startup = 1000;

		RegTriggers.resetTriggers();		
	
		#if desktop
			FlxG.mouse.useSystemCursor = true;				
		#end
				
		RegFunctions.fontsSharpen();		
		startupFunctions();
		
		if (__title_bar != null) 
		{
			remove(__title_bar);
			__title_bar.destroy();
		}
		
		__title_bar = new TitleBar("Player 1 vs Player 2", true);
		add(__title_bar);
		
		if (Reg._total_games_in_release > 0)
		{
			RegFunctions.gameIds_create(true);
			RegFunctions.gameIds_draw_sprite(this);
		}
		
		else RegFunctions.no_game_modules_installed_notice(this);
		
		if (Reg._clientReadyForPublicRelease == false)
		{
			if (__action_commands != null)
			{
				remove(__action_commands);
				__action_commands.destroy();
			}
			
			__action_commands = new ActionCommands(); 
			add(__action_commands);
		} 
		
		Reg._gameJumpTo = 0;
		Reg2._scrollable_area_is_scrolling = false;
	}
	
				
	public function playCheckers():Void
	{
		Reg._alreadyOnlineHost = false;
		Reg._alreadyOnlineUser = false;
		RegTypedef.resetTypedefData();
		Reg.resetRegVars(); 
		Reg2.resetRegVars();
		RegCustom.resetRegVars();
		RegTriggers.resetTriggers();
		
		// these two vars are true only here for single mode because in 2 player mode the first player to enter lobby will set these vars to true.
		Reg._playerCanMovePiece = true; 
		Reg._gameHost = true;
		
		Reg._gameId = 0; //checkers.
		Reg._game_offline_vs_player = true;
		Reg._game_offline_vs_cpu = false; 
		Reg._move_number_current = 0;
		Reg._move_number_next = 0;		 
		Reg._gameJumpTo = 0;		
		Reg._gameNotationOddEven = 0;
		Reg._at_menu_state_offline = false;
		
		FlxG.switchState(new PlayState());
	}
	
	public function playChess():Void
	{
		Reg._alreadyOnlineHost = false;
		Reg._alreadyOnlineUser = false;
		RegTypedef.resetTypedefData();
		Reg.resetRegVars(); 
		Reg2.resetRegVars();
		RegCustom.resetRegVars();
		RegTriggers.resetTriggers();
		
		// these two vars are true only here for single mode because in 2 player mode the first player to enter lobby will set these vars to true.
		Reg._playerCanMovePiece = true; 
		Reg._gameHost = true;
		
		Reg._gameId = 1; //checkers.
		Reg._game_offline_vs_player = true;
		Reg._game_offline_vs_cpu = false; 
		Reg._move_number_current = 0;
		Reg._move_number_next = 0;		 
		Reg._gameJumpTo = 0;		
		Reg._gameNotationOddEven = 0;
		Reg._at_menu_state_offline = false;
		
		FlxG.switchState(new PlayState());
	}
	
	public function playReversi():Void
	{
		// these two vars are true only here for single mode because in 2 player mode the first player to enter lobby will set these vars to true.
		Reg._playerCanMovePiece = true; 
		Reg._gameHost = true;
		
		Reg._gameId = 2; // Reversi.
		Reg._game_offline_vs_player = true;
		Reg._game_offline_vs_cpu = false; 
		Reg._move_number_current = 0;
		Reg._move_number_next = 0;
		Reg._gameJumpTo = 0; 
		Reg._gameNotationOddEven = 0;
		Reg._at_menu_state_offline = false;
		
		FlxG.switchState(new PlayState());
	}
	
	public function playSnakesAndLadders():Void
	{
		// these two vars are true only here for single mode because in 2 player mode the first player to enter lobby will set these vars to true.
		Reg._playerCanMovePiece = true; 
		Reg._gameHost = true;
		
		Reg._gameId = 3; // snakes and ladders.
		Reg._game_offline_vs_player = true;
		Reg._game_offline_vs_cpu = false;
		Reg._move_number_current = 0;
		Reg._move_number_next = 0;
		Reg._gameJumpTo = 0;		
		Reg._at_menu_state_offline = false;
		
		FlxG.switchState(new PlayState());
	}
	
	override public function update(elapsed:Float):Void 
	{
		for (i in 0... Reg._total_games_in_release - Reg._total_games_excluded_from_list)
		{
			if (Reg2._gameId_sprite[i] != null)
			{
				if (ActionInput.overlaps(Reg2._gameId_sprite[i]) == true
				)
				{
					Reg2._gameId_sprite_highlight.setPosition(75 + ( i * 255), 120);
				}
				
				if (ActionInput.overlaps(Reg2._gameId_sprite[i]) == true)
				{
					if (ActionInput.justPressed() == true)
					{					
						if (RegCustom._sound_enabled[Reg._tn] == true
					&&  Reg2._scrollable_area_is_scrolling == false)
							FlxG.sound.play("click", 1, false);		
					}
					
					if (ActionInput.justReleased() == true)
					{
						switch(Reg2._gameIds_that_can_be_selected[i])
						{
							case 0: playCheckers();
							case 1: playChess();
							case 2: playReversi();
							case 3: playSnakesAndLadders();
						}
					}
				}
			}
		}
		
		super.update(elapsed);
	}
}


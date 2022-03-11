/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

/**
 * author: kboardgames.com.
 */

class MenuStateOfflineCPU extends MenuState
{
	private var _playChessVsCPU:ButtonGeneral;
		
	override public function create():Void
	{
		Reg._alreadyOnlineHost = false;
		Reg._alreadyOnlineUser = false;
		RegTypedef.resetTypedefData(); 
		Reg.resetRegVars(); 
		Reg2.resetRegVars();
		RegCustom.resetRegVars();
		
		_ticks_startup = 1000;
		
		RegTriggers.resetTriggers();
		RegFunctions.fontsSharpen();		
		
		startupFunctions();
		
		// the title of the game.
		var title = new FlxText(0, 0, 0, "Player vs Computer");
		title.setFormat(Reg._fontTitle, 69, FlxColor.YELLOW);
		title.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 3);
		title.scrollFactor.set();
		title.screenCenter(X);
		add(title);
		
		// TODO Chess game is broken when playing against the computer. pawn piece moves and does not block king when king is in check. currently computer checks 3 moves in advanced for a checkmate. make it 1 to 50 in a loop.
		 _playChessVsCPU = new ButtonGeneral(((FlxG.width / 4) * 3) - 175 + _offsetX, (FlxG.height - 340) / 2 + 170, "Chess", 350 + 15, 35, Reg._font_size, 0xFFCCFF33, 0, playChessVsCPU, 0xFF000044, false);
		_playChessVsCPU.label.font = Reg._fontDefault;
		add(_playChessVsCPU);
		
		
		var _signatureGame = new ButtonGeneral(((FlxG.width / 4) * 3) - 175 + _offsetX, (FlxG.height - 340) / 2 + 220, "Signature Game", 350 + 15, 35, Reg._font_size, 0xFFCCFF33, 0, playSignatureGame, 0xFF000044, false);
		_signatureGame.label.font = Reg._fontDefault;
		add(_signatureGame);
		
		var _back = new ButtonGeneral(((FlxG.width / 4) * 3) - 175 + _offsetX, (FlxG.height - 340) / 2 + 320, "To Title", 170 + 15, 35, Reg._font_size, 0xFFCCFF33, 0, backToTitle, 0xFF000044, false);
		_back.label.font = Reg._fontDefault;
		add(_back);
		
		Reg._gameJumpTo = 0;
	}
		
	private function playChessVsCPU():Void
	{		
		Reg.playChessVsCPU();
		Reg._gameOverForAllPlayers = false;
		Reg._gameOverForPlayer = false;
		
		FlxG.switchState(new PlayState());
	}
	
	private function playSignatureGame():Void
	{
		Reg.playSignatureGame();
		Reg._gameOverForAllPlayers = false;
		Reg._gameOverForPlayer = false;
		
		FlxG.switchState(new PlayState());
	}
	
	public function backToTitle():Void
	{
		Reg._gameJumpTo = 0;
		FlxG.switchState(new MenuState());
	}
			
	
}


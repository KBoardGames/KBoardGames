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
 * score, stats text output and background (background). 
 * @author kboardgames.com
 */
class HUD extends FlxState
{		
	private var _bg:FlxSprite;
	
	/******************************
	 * this is the image of the avatar for profile.
	 */
	public static var _image_profile_avatar_p1:FlxSprite;
	public static var _image_profile_avatar_p2:FlxSprite;
	public static var _image_profile_avatar_p3:FlxSprite;
	public static var _image_profile_avatar_p4:FlxSprite;
	
	/******************************
	 * the names of the rows such as name, wins and turns.
	 */
	private var _row_username:FlxText;
	private var _row_win_total:FlxText;
	private var _row_other:FlxText;
		
	/******************************
	 * the name of the player.
	 */
	public static var _row_username_p1:FlxText;
	public static var _row_username_p2:FlxText;
	public static var _row_username_p3:FlxText;
	public static var _row_username_p4:FlxText;
	
	/******************************
	 * player win total.
	 */
	public static var _row_total_wins_p1:FlxText;
	public static var _row_total_wins_p2:FlxText;
	public static var _row_total_wins_p3:FlxText;
	public static var _row_total_wins_p4:FlxText;
	
	/******************************
	 * player total cash if playing signature game, or this can be the total turns remaining, or whatever.
	 */
	public static var _row_total_other_p1:FlxText;
	public static var _row_total_other_p2:FlxText;
	public static var _row_total_other_p3:FlxText;
	public static var _row_total_other_p4:FlxText;
	
	/******************************
	 * the background behind the row.
	 */
	private var _row_bg_username:FlxSprite;
	private var _row_bg_win_total:FlxSprite;
	private var _row_bg_other:FlxSprite; // used for turns or cash.
	
	/******************************
	 * the header of the row.
	 */
	private var _row_bg_header_username:FlxSprite;
	private var _row_bg_header_win_total:FlxSprite;
	private var _row_bg_header_other:FlxSprite;
		
	public static var textGameTurnsP1:FlxText;
	public static var textGameTurnsP2:FlxText;
	public static var textGameTurnsP3:FlxText;
	public static var textGameTurnsP4:FlxText;
	
	override public function new() 
	{
		super();
		
		_bg = new FlxSprite(0, 0);
		_bg.makeGraphic(FlxG.width, Reg._offsetScreenY, 0xFF000000);
		_bg.scrollFactor.set();
		_bg.setPosition(0, FlxG.height - Reg._offsetScreenY + 10);
		add(_bg);
				
		//---------------------------
		_row_bg_username = new FlxSprite(0, FlxG.height - 87);
		_row_bg_username.makeGraphic(FlxG.width, 23, 0xFF080027);
		_row_bg_username.scrollFactor.set();	
		add(_row_bg_username);
		
		_row_bg_win_total = new FlxSprite(0, FlxG.height - 57);
		_row_bg_win_total.makeGraphic(FlxG.width, 23, 0xFF001427);
		_row_bg_win_total.scrollFactor.set();	
		add(_row_bg_win_total);
		
		_row_bg_other = new FlxSprite(0, FlxG.height - 27);
		_row_bg_other.makeGraphic(FlxG.width, 23, 0xFF002027);
		_row_bg_other.scrollFactor.set();	
		add(_row_bg_other);
		
		//---------------------------
		_row_bg_header_username = new FlxSprite(25, FlxG.height - 87);
		_row_bg_header_username.makeGraphic(120, 23, 0x77000000);
		_row_bg_header_username.scrollFactor.set();	
		add(_row_bg_header_username);
		
		_row_bg_header_win_total = new FlxSprite(25, FlxG.height - 57);
		_row_bg_header_win_total.makeGraphic(120, 23, 0x77000000);
		_row_bg_header_win_total.scrollFactor.set();	
		add(_row_bg_header_win_total);
		
		_row_bg_header_other = new FlxSprite(25, FlxG.height - 27);
		_row_bg_header_other.makeGraphic(120, 23, 0x77000000);
		_row_bg_header_other.scrollFactor.set();	
		add(_row_bg_header_other);
		//---------------------------
		
		_row_username = new FlxText(35, FlxG.height - 91, 0, "Name", 0);
		_row_username.scrollFactor.set();
		_row_username.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.YELLOW);
		_row_username.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 2);
		add(_row_username);
		
		if (Reg._game_online_vs_cpu == false 
		&&  Reg._game_offline_vs_player == false
		&&  Reg._game_offline_vs_cpu == false)
		{
			_row_win_total = new FlxText(35, FlxG.height - 61, 0, "Wins", 0);
			_row_win_total.scrollFactor.set();
			_row_win_total.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.YELLOW);
			_row_win_total.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 2);
			add(_row_win_total);
		}
		
		_row_other = new FlxText(35, FlxG.height - 31, 0, "", 0);
		_row_other.scrollFactor.set();
		_row_other.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.YELLOW);
		_row_other.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 2);
		add(_row_other);
		if (Reg._gameId <= 1) _row_other.text = "Turns";
		else if (Reg._gameId == 4) _row_other.text = "Cash";
		else _row_other.text = "";
		//--------------------------
		
		_image_profile_avatar_p1 = new FlxSprite(150 + 6, 0);
		if (Reg._game_offline_vs_player == true || Reg._game_offline_vs_cpu == true || Reg._game_online_vs_cpu == true)
			_image_profile_avatar_p1.loadGraphic("vendor/multiavatar/" + RegCustom._profile_avatar_number1[Reg._tn]);
		else _image_profile_avatar_p1.loadGraphic("vendor/multiavatar/" + RegTypedef._dataPlayers._avatarNumber[0]);		
		_image_profile_avatar_p1.y = FlxG.height - (Reg._offsetScreenY + _image_profile_avatar_p1.height - 10) / 2; // this centers avatar to the HUD background.
		_image_profile_avatar_p1.scrollFactor.set();	
		add(_image_profile_avatar_p1);	
		
		_image_profile_avatar_p2 = new FlxSprite(450 + 12, 0);
		if (Reg._game_offline_vs_player == true)
		{
			_image_profile_avatar_p2.loadGraphic("vendor/multiavatar/" + RegCustom._profile_avatar_number2[Reg._tn]);
		}
			
		else if (Reg._game_offline_vs_cpu == true
		&& 		 Reg._game_online_vs_cpu == false)
		{
			var _num = getBOTvalue();
			_image_profile_avatar_p2.loadGraphic("vendor/multiavatar/" + Reg2._offline_cpu_avatar_number[_num]);	
		}
		
		// display the correct profile images for the computer when player started a computer game.
		else if (Reg._game_online_vs_cpu == true)
		{
			if (Reg._gameId == 1)
			{
				for (i in 0...5)
				{
					if (Reg2._offline_cpu_host_names[i] == RegTypedef._dataMisc._roomHostUsername[2])
					{
						_image_profile_avatar_p2.loadGraphic("vendor/multiavatar/" + Reg2._offline_cpu_avatar_number[i]);	
					}
				
				}
					
			}
			
			if (Reg._gameId == 4)
			{
				for (i in 0...5)
				{
					if (Reg2._offline_cpu_host_names[i] == RegTypedef._dataMisc._roomHostUsername[1])
					{
						_image_profile_avatar_p2.loadGraphic("vendor/multiavatar/" + Reg2._offline_cpu_avatar_number[i]);	
					}
				}
					
			}
		}
		else _image_profile_avatar_p2.loadGraphic("vendor/multiavatar/" + RegTypedef._dataPlayers._avatarNumber[1]);	
		_image_profile_avatar_p2.y = FlxG.height - (Reg._offsetScreenY + _image_profile_avatar_p2.height - 10) / 2;	
		_image_profile_avatar_p2.scrollFactor.set();	
		add(_image_profile_avatar_p2);
		
		_image_profile_avatar_p3 = new FlxSprite(750 + 18, 0);
		if (Reg._game_offline_vs_player == true)
			_image_profile_avatar_p3.loadGraphic("vendor/multiavatar/" + RegCustom._profile_avatar_number3[Reg._tn]);
		else _image_profile_avatar_p3.loadGraphic("vendor/multiavatar/" + RegTypedef._dataPlayers._avatarNumber[2]);			
		_image_profile_avatar_p3.y = FlxG.height - (Reg._offsetScreenY + _image_profile_avatar_p3.height - 10) / 2;	
		_image_profile_avatar_p3.scrollFactor.set();	
		add(_image_profile_avatar_p3);
		
		_image_profile_avatar_p4 = new FlxSprite(1050 + 24, 0);
		if (Reg._game_offline_vs_player == true)
			_image_profile_avatar_p4.loadGraphic("vendor/multiavatar/" + RegCustom._profile_avatar_number4[Reg._tn]);
		else _image_profile_avatar_p4.loadGraphic("vendor/multiavatar/" + RegTypedef._dataPlayers._avatarNumber[3]);			
		_image_profile_avatar_p4.y = FlxG.height - (Reg._offsetScreenY + _image_profile_avatar_p4.height - 10) / 2;	
		_image_profile_avatar_p4.scrollFactor.set();	
		add(_image_profile_avatar_p4);
		//---------------------------
		
		_row_username_p1 = new FlxText(_image_profile_avatar_p1.x + 85, FlxG.height - 91, 0, "", 20);
		_row_username_p1.scrollFactor.set();
		_row_username_p1.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.LIME);
		_row_username_p1.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 2);
		add(_row_username_p1);
		
		_row_username_p2 = new FlxText(_image_profile_avatar_p2.x + 85, FlxG.height - 91, 0, "", 20);
		_row_username_p2.scrollFactor.set();
		_row_username_p2.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.LIME);
		_row_username_p2.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 2);
		add(_row_username_p2);
		
		_row_username_p3 = new FlxText(_image_profile_avatar_p3.x + 85, FlxG.height - 91, 0, "", 20);
		_row_username_p3.scrollFactor.set();
		_row_username_p3.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.LIME);
		_row_username_p3.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 2);
		add(_row_username_p3);
		
		_row_username_p4 = new FlxText(_image_profile_avatar_p4.x + 85, FlxG.height - 91, 0, "", 20);
		_row_username_p4.scrollFactor.set();
		_row_username_p4.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.LIME);
		_row_username_p4.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 2);
		add(_row_username_p4);
		
		//--------------------------
		if (Reg._game_online_vs_cpu == false 
		&&  Reg._game_offline_vs_player == false
		&&  Reg._game_offline_vs_cpu == false)
		{
			_row_total_wins_p1 = new FlxText(_image_profile_avatar_p1.x + 85, FlxG.height - 61, 0, "", 20);
			_row_total_wins_p1.scrollFactor.set();
			_row_total_wins_p1.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.LIME);
			_row_total_wins_p1.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 2);
			add(_row_total_wins_p1);
					
			_row_total_wins_p2 = new FlxText(_image_profile_avatar_p2.x + 85, FlxG.height - 61, 0, "", 20);
			_row_total_wins_p2.scrollFactor.set();
			_row_total_wins_p2.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.LIME);
			_row_total_wins_p2.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 2);
			add(_row_total_wins_p2);
			
			_row_total_wins_p3 = new FlxText(_image_profile_avatar_p3.x + 85, FlxG.height - 61, 0, "", 20);
			_row_total_wins_p3.scrollFactor.set();
			_row_total_wins_p3.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.LIME);
			_row_total_wins_p3.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 2);
			add(_row_total_wins_p3);
			
			_row_total_wins_p4 = new FlxText(_image_profile_avatar_p4.x + 85, FlxG.height - 61, 0, "", 20);
			_row_total_wins_p4.scrollFactor.set();
			_row_total_wins_p4.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.LIME);
			_row_total_wins_p4.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 2);
			add(_row_total_wins_p4);
		}
		//--------------------------
			
		_row_total_other_p1 = new FlxText(_image_profile_avatar_p1.x + 85, FlxG.height - 31, 0, "", 20);
		_row_total_other_p1.scrollFactor.set();
		_row_total_other_p1.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.LIME);
		_row_total_other_p1.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 2);
		add(_row_total_other_p1);
		
		_row_total_other_p2 = new FlxText(_image_profile_avatar_p2.x + 85, FlxG.height - 31, 0, "", 20);
		_row_total_other_p2.scrollFactor.set();
		_row_total_other_p2.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.LIME);
		_row_total_other_p2.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 2);
		add(_row_total_other_p2);
		
		_row_total_other_p3 = new FlxText(_image_profile_avatar_p3.x + 85, FlxG.height - 31, 0, "", 20);
		_row_total_other_p3.scrollFactor.set();
		_row_total_other_p3.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.LIME);
		_row_total_other_p3.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 2);
		add(_row_total_other_p3);
		
		_row_total_other_p4 = new FlxText(_image_profile_avatar_p4.x + 85, FlxG.height - 31, 0, "", 20);
		_row_total_other_p4.scrollFactor.set();
		_row_total_other_p4.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.LIME);
		_row_total_other_p4.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 2);
		add(_row_total_other_p4);		
		//--------------------------
		
		textGameTurnsP1 = new FlxText(-1000, -1000, 0, "50", 20);
		textGameTurnsP1.scrollFactor.set();
		textGameTurnsP1.font = Reg._fontDefault;
		textGameTurnsP1.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 1);
		add(textGameTurnsP1);
		
		textGameTurnsP2 = new FlxText(-1000, -1000, 0, "50", 20);
		textGameTurnsP2.scrollFactor.set();
		textGameTurnsP2.font = Reg._fontDefault;
		textGameTurnsP2.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 1);
		add(textGameTurnsP2);
		
		textGameTurnsP3 = new FlxText(-1000, -1000, 0, "50", 20);
		textGameTurnsP3.scrollFactor.set();
		textGameTurnsP3.font = Reg._fontDefault;
		textGameTurnsP3.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 1);
		add(textGameTurnsP3);
		
		textGameTurnsP4 = new FlxText(-1000, -1000, 0, "50", 20);
		textGameTurnsP4.scrollFactor.set();
		textGameTurnsP4.font = Reg._fontDefault;
		textGameTurnsP4.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 1);
		add(textGameTurnsP4);
		
			
	}

	override public function destroy()
	{
		
		super.destroy();
	}
	
	override public function update(elapsed:Float):Void 
	{	
		if (Reg._gameOverForPlayer == false)
		{
			if (Reg._gameId < 2) // only checkers and chess do game turns.
			{
				// update the game turn for all players.
				if (Reg._playerCanMovePiece == true) // the player moving...
				{
					if (textGameTurnsP1 != null)
					textGameTurnsP1.text = Std.string(Reg._gameTurnsP1);
				}
				// ... and also that piece at the other player's board.
				else if (Reg._otherPlayer == false && Reg._gameDidFirstMove == false)
				{
					if (textGameTurnsP2 != null)
					textGameTurnsP2.text = Std.string(Reg._gameTurnsOther);
				}
			}
			
			if (Reg._gameTurnsP1 == 0 || Reg._gameTurnsOther == 0)
			{
				if (Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false)
				{				
					RegTypedef._dataGameMessage._gameMessage = "Draw: Fifty-move rule.";
					PlayState.clientSocket.send("Game Message Not Sender", RegTypedef._dataGameMessage);
					haxe.Timer.delay(function (){}, Reg2._event_sleep);
					
					RegTypedef._dataPlayers._gameMessage = "Game ended in a draw.";
					PlayState.clientSocket.send("Game Draw", RegTypedef._dataPlayers);
					haxe.Timer.delay(function (){}, Reg2._event_sleep);
				}
				
				else
				{
					RegTriggers._messageDraw = "Game ended in a draw.";
					RegTriggers._draw = true;
					
					Reg._gameOverForPlayer = true;
					RegFunctions.playerAllStop();
					
				}
				
				Reg._gameMessage = "Draw: Fifty-move rule.";				
				Reg._outputMessage = true;
				
			}
		}	
		
		RegTypedef.mathRoundCash();
		stats();
				
		super.update(elapsed);		
	}
	
	public static function stats():Void
	{
		_row_username_p1.text = RegTypedef._dataPlayers._usernamesDynamic[0];
		
		if (_row_total_wins_p1 != null) _row_total_wins_p1.text = Std.string(RegTypedef._dataPlayers._gamesAllTotalWins[0]);		
		
		
		if (Reg._gameId <= 1) _row_total_other_p1.text = Std.string(Reg._gameTurnsP1);
		if (Reg._gameId == 4) _row_total_other_p1.text = Std.string(RegTypedef._dataPlayers._cash[0]);
		
		if (Reg._game_online_vs_cpu == true)
		{			
			if (Reg._gameId == 1)
			{
				for (i in 0...5)
				{
					if (Reg2._offline_cpu_host_names[i] == RegTypedef._dataMisc._roomHostUsername[2])
					{
						_row_username_p2.text =	Reg2._offline_cpu_host_names[i];
					}
				
				}
					
			}
			
			if (Reg._gameId == 4)
			{
				for (i in 0...5)
				{
					if (Reg2._offline_cpu_host_names[i] == RegTypedef._dataMisc._roomHostUsername[1])
					{
						_row_username_p2.text =	Reg2._offline_cpu_host_names[i];
					}
				}
			}
		}
		else 
			_row_username_p2.text = RegTypedef._dataPlayers._usernamesDynamic[1];
		
		if (_row_total_wins_p2 != null) _row_total_wins_p2.text = Std.string(RegTypedef._dataPlayers._gamesAllTotalWins[1]);
		
		
		if (Reg._gameId <= 1) _row_total_other_p2.text = Std.string(Reg._gameTurnsOther);
		if (Reg._gameId == 4) _row_total_other_p2.text = Std.string(RegTypedef._dataPlayers._cash[1]);
		
		if (RegTypedef._dataMisc._roomPlayerLimit[RegTypedef._dataMisc._room] > 2)
		{
			_row_username_p3.text = RegTypedef._dataPlayers._usernamesDynamic[2];
			
			if (_row_total_wins_p3 != null) _row_total_wins_p3.text = Std.string(RegTypedef._dataPlayers._gamesAllTotalWins[2]);
			
			if (Reg._gameId == 4) _row_total_other_p3.text = Std.string(RegTypedef._dataPlayers._cash[2]);
						
			_image_profile_avatar_p3.visible = true;
		} else _image_profile_avatar_p3.visible = false;
		
		if (RegTypedef._dataMisc._roomPlayerLimit[RegTypedef._dataMisc._room] > 3)
		{
			_row_username_p4.text = RegTypedef._dataPlayers._usernamesDynamic[3];
			
			if (_row_total_wins_p4 != null) _row_total_wins_p4.text = Std.string(RegTypedef._dataPlayers._gamesAllTotalWins[3]);
						
			if (Reg._gameId == 4) _row_total_other_p4.text = Std.string(RegTypedef._dataPlayers._cash[3]);
			_image_profile_avatar_p4.visible = true;
		} else _image_profile_avatar_p4.visible = false;
	}
	
	/******************************
	 * every single player move on the game board is called a turn.
	 * @param	yy	y game board location the player is moving to.
	 * @param	xx	x game board location the player is moving to.
	 */
	public static function gameTurns(yy:Int, xx:Int):Void
	{
		// multiplayer game/
		if (Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false)
		{
			// the player hosting the game.
			if (Reg._gameHost == true)
			{
				// first player can move piece.
				if (Reg._playerCanMovePiece == true)
				{
					// if not capturing a piece then increase turn else set turn var to default. when turn equals 0 then the game is over. the game is regarded a draw.
					if (Reg._jumpingWhatDirection == -1 && Reg._checkersKingThePiece == false && Reg._gameId == 0 
					 || Reg._gamePointValueForPiece[yy][xx] == 0 && Reg._gameId == 1) Reg._gameTurnsP1 -= 1;
					else Reg._gameTurnsP1 = 50;
				}
				// the player hosting the game, that players piece needs to be updated at that other player's game board. if the Reg._gameDidFirstMove is false then the player is not moving which is what we want.
				else if (Reg._otherPlayer == false && Reg._gameDidFirstMove == false)
				{
					if (Reg._jumpingWhatDirection == -1 && Reg._checkersKingThePiece == false && Reg._gameId == 0 
					 || Reg._gamePointValueForPiece[yy][xx] == 0 && Reg._gameId == 1) Reg._gameTurnsOther -= 1;
					else Reg._gameTurnsOther = 50;
				}
	
				// this code is needed so that the game turn text displayed underneath chatter for both players will update.
				if (Reg._playerCanMovePiece == true) // the player moving...
				{
					if (HUD.textGameTurnsP1 != null)
					HUD.textGameTurnsP1.text = Std.string(Reg._gameTurnsP1);
				}
				// ... and also that piece at the other player's board.
				else if (Reg._otherPlayer == false && Reg._gameDidFirstMove == false)
				{
					if (HUD.textGameTurnsP2 != null)
					HUD.textGameTurnsP2.text = Std.string(Reg._gameTurnsOther);
				}
			}
			
			else if (Reg._gameHost == false)
			{
				if (Reg._playerCanMovePiece == true)
				{
					if (Reg._jumpingWhatDirection == -1 && Reg._checkersKingThePiece == false && Reg._gameId == 0 
					 || Reg._gamePointValueForPiece[yy][xx] == 0 && Reg._gameId == 1) Reg._gameTurnsOther -= 1;
					else Reg._gameTurnsOther = 50;
				}
				else if (Reg._otherPlayer == false && Reg._gameDidFirstMove == false)
				{
					if (Reg._jumpingWhatDirection == -1 && Reg._checkersKingThePiece == false && Reg._gameId == 0 
					 || Reg._gamePointValueForPiece[yy][xx] == 0 && Reg._gameId == 1) Reg._gameTurnsP1 -= 1;
					else Reg._gameTurnsP1 = 50;
				}
				
				if (Reg._playerCanMovePiece == true)
				{
					if (HUD.textGameTurnsP2 != null)
					HUD.textGameTurnsP2.text = Std.string(Reg._gameTurnsOther);
				}
				else if (Reg._otherPlayer == false && Reg._gameDidFirstMove == false)
				{
					if (HUD.textGameTurnsP1 != null)
					HUD.textGameTurnsP1.text = Std.string(Reg._gameTurnsP1);
				}
			}
		}
		
		// update turn when player with the computer or p1 vs p2 offline.
		else if (Reg._game_offline_vs_cpu == true || Reg._game_offline_vs_player == true)
		{
			if (Reg._playerMoving == 0) // first player moving.
			{
				if (Reg._jumpingWhatDirection == -1 && Reg._checkersKingThePiece == false && Reg._gameId == 0  
				 || Reg._gamePointValueForPiece[yy][xx] == 0 && Reg._gameId == 1) Reg._gameTurnsP1 -= 1;
				else Reg._gameTurnsP1 = 50;
				
				// update turn text.
				if (HUD.textGameTurnsP1 != null)
				HUD.textGameTurnsP1.text = Std.string(Reg._gameTurnsP1);		
			}
			
			else if (Reg._playerMoving == 1)
			{
				if (Reg._jumpingWhatDirection == -1 && Reg._checkersKingThePiece == false && Reg._gameId == 0 
				 || Reg._gamePointValueForPiece[yy][xx] == 0 && Reg._gameId == 1) Reg._gameTurnsOther -= 1;
				else Reg._gameTurnsOther = 50;
				
				if (HUD.textGameTurnsP2 != null)
				HUD.textGameTurnsP2.text = Std.string(Reg._gameTurnsOther);		
			}
		}
		
		//Reg._gameTurnsOther = 0;
		//Reg._gameTurnsP1 = 0;
		
		Reg._checkersKingThePiece = false;
		
		
	}
	
	// this is used to display the computer avatar when playing a game with the computer. this is for the first computer only, if adding a second computer to the game then you will need a different function. this function is called at the constructor of this class.
	private function getBOTvalue():Int
	{
		var _num = 0;
		
		for (i in 0...4)
		{
			if (Reg2._offline_cpu_host_names[i] == RegTypedef._dataPlayers._usernamesDynamic[1])
				_num = i;
		}
		
		return _num;
	}
}
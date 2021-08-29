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
 * When a event text is mouse clicked at the event schedule, this sub state is displayed. this class shows the event name and the event description with a close button that once clicked will return the user back to the event schedule scene.
 * @author kboardgames.com
 */
class MiscellaneousMenuOutput extends FlxState
{	
	/******************************
	* anything added to this group will be placed inside of the boxScroller field. 
	*/
	public static var group:FlxSpriteGroup;	
	public var __boxscroller:FlxScrollableArea;	
	private var _title:FlxText;
	private var _height:Float; // used to display the next button or next text data underneath the previous button or text. without this var, the texts, images and buttons would all be displayed at the same line.
	
	public var __menu_bar:MenuBar;
	private var _offset_x:Int = 440;
	
	private var _close:ButtonGeneralNetworkYes;
	
	public function new(_int:Int):Void
	{
		super();	
		
		FlxG.mouse.reset();
		FlxG.mouse.enabled = true;
		
		FlxG.autoPause = false;	// this application will pause when not in focus.
		Reg.at_scene_menu = false;
		
		RegTriggers._makeMiscellaneousMenuClassNotActive = true;
		
		var background = new FlxSprite();
		background.makeGraphic(FlxG.width-20,FlxG.height-50,FlxColor.WHITE);
		background.color = FlxColor.BLACK;
		background.scrollFactor.set(0, 0);
		add(background);
				
		group = cast add(new FlxSpriteGroup());
		
		// put the group off-screen
		group.setPosition(5000, 0);		
		
		// the boxScroller would not work without at least one sprite added to the boxScrollerGroup.
		var _box = new FlxSprite();
		_box.makeGraphic(1, 1, FlxColor.BLACK);
		_box.setPosition(0, 0);
		add(_box);
		group.add(_box);		
		
		// if this value if different than 30 then we can call some other function.
		if (_int == 30)
		{
			statisticsAll();
			eventsAll();
		}
				
			
		// make a scrollbar-enabled camera for it (a FlxScrollableArea)	
		if (__boxscroller != null) FlxG.cameras.remove(__boxscroller);
		__boxscroller = new FlxScrollableArea( new FlxRect( 0, 0, FlxG.width, FlxG.height-55), group.getHitbox(), ResizeMode.NONE, 0, 100, -1, FlxColor.LIME, null, 0, true);
		add(__boxscroller);
		FlxG.cameras.add( __boxscroller );
		__boxscroller.antialiasing = true;
		__boxscroller.pixelPerfectRender = true;
				
		__menu_bar = new MenuBar();
		add(__menu_bar);
		
		var _title_background = new FlxSprite(0, 0);
		_title_background.makeGraphic(FlxG.width - 40, 100, 0xFF000000); 
		_title_background.scrollFactor.set(0, 0);
		add(_title_background);
		
		if (_int == 30) _title = new FlxText(0, 0, 0, "Game Statistics");
		else _title = new FlxText(0, 0, 0, "Game Instructions");
		
		_title.setFormat(Reg._fontDefault, 50, FlxColor.YELLOW);
		_title.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 3);
		_title.scrollFactor.set();
		_title.setPosition(0, 20);
		_title.visible = true;
		_title.screenCenter(X);
		_title.x -= 20; // minus the width of the boxScroller track.
		add(_title);
		
		_close = new ButtonGeneralNetworkYes(0, FlxG.height-40, "Exit", 150 + 15, 35, Reg._font_size, 0xFFCCFF33, 0, closeState, 0xFF000044, false);
		_close.active = true;
		_close.label.font = Reg._fontDefault;
		_close.screenCenter(X);
		_close.x += 400;		
		add(_close);
	}
	
	private function statisticsAll():Void
	{
		_height = 135;
		
		// total wins --------------------------------------------------------
		var _text = new FlxText(0, 0, 0, "Total Wins.");
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.WHITE, 1);
		_text.setFormat(Reg._fontDefault, 24);
		_text.setPosition(20, _height);
		group.add(_text);
		
		var _text = new FlxText(0, 0, 0, Std.string(RegTypedef._dataStatistics._gamesAllTotalWins));
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.WHITE, 1);
		_text.setFormat(Reg._fontDefault, 24);
		_text.setPosition(_offset_x, _height);
		group.add(_text);
		
		_height = _height + _text.height + 15;
		
		// total losses  ----------------------------------------------------
		var _text = new FlxText(0, 0, 0, "Total Losses.");
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.WHITE, 1);
		_text.setFormat(Reg._fontDefault, 24);
		_text.setPosition(20, _height);
		group.add(_text);
		
		var _text = new FlxText(0, 0, 0, Std.string(RegTypedef._dataStatistics._gamesAllTotalLosses));
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.WHITE, 1);
		_text.setFormat(Reg._fontDefault, 24);
		_text.setPosition(_offset_x, _height);
		group.add(_text);
		
		_height = _height + _text.height + 15;
		
		// total draws  ----------------------------------------------------
		var _text = new FlxText(0, 0, 0, "Total Draws.");
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.WHITE, 1);
		_text.setFormat(Reg._fontDefault, 24);
		_text.setPosition(20, _height);
		group.add(_text);
		
		var _text = new FlxText(0, 0, 0, Std.string(RegTypedef._dataStatistics._gamesAllTotalDraws));
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.WHITE, 1);
		_text.setFormat(Reg._fontDefault, 24);
		_text.setPosition(_offset_x, _height);
		group.add(_text);
		
		_height = _height + _text.height + 15;
		
		// checkers wins  ----------------------------------------------------
		var _text = new FlxText(0, 0, 0, "Checkers Wins.");
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.WHITE, 1);
		_text.setFormat(Reg._fontDefault, 24);
		_text.setPosition(20, _height);
		group.add(_text);
		
		var _text = new FlxText(0, 0, 0, Std.string(RegTypedef._dataStatistics._checkersWins));
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.WHITE, 1);
		_text.setFormat(Reg._fontDefault, 24);
		_text.setPosition(_offset_x, _height);
		group.add(_text);
		
		_height = _height + _text.height + 15;
		
		// checkers losses  ----------------------------------------------------
		var _text = new FlxText(0, 0, 0, "Checkers Losses.");
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.WHITE, 1);
		_text.setFormat(Reg._fontDefault, 24);
		_text.setPosition(20, _height);
		group.add(_text);
		
		var _text = new FlxText(0, 0, 0, Std.string(RegTypedef._dataStatistics._checkersLosses));
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.WHITE, 1);
		_text.setFormat(Reg._fontDefault, 24);
		_text.setPosition(_offset_x, _height);
		group.add(_text);
		
		_height = _height + _text.height + 15;
		
		// checkers Draws  ----------------------------------------------------
		var _text = new FlxText(0, 0, 0, "Checkers Draws.");
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.WHITE, 1);
		_text.setFormat(Reg._fontDefault, 24);
		_text.setPosition(20, _height);
		group.add(_text);
		
		var _text = new FlxText(0, 0, 0, Std.string(RegTypedef._dataStatistics._checkersDraws));
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.WHITE, 1);
		_text.setFormat(Reg._fontDefault, 24);
		_text.setPosition(_offset_x, _height);
		group.add(_text);
		
		_height = _height + _text.height + 15;
		
		// chess wins  ----------------------------------------------------
		var _text = new FlxText(0, 0, 0, "Chess Wins.");
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.WHITE, 1);
		_text.setFormat(Reg._fontDefault, 24);
		_text.setPosition(20, _height);
		group.add(_text);
		
		var _text = new FlxText(0, 0, 0, Std.string(RegTypedef._dataStatistics._chessWins));
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.WHITE, 1);
		_text.setFormat(Reg._fontDefault, 24);
		_text.setPosition(_offset_x, _height);
		group.add(_text);
		
		_height = _height + _text.height + 15;
		
		// chess losses  ----------------------------------------------------
		var _text = new FlxText(0, 0, 0, "Chess Losses.");
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.WHITE, 1);
		_text.setFormat(Reg._fontDefault, 24);
		_text.setPosition(20, _height);
		group.add(_text);
		
		var _text = new FlxText(0, 0, 0, Std.string(RegTypedef._dataStatistics._chessLosses));
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.WHITE, 1);
		_text.setFormat(Reg._fontDefault, 24);
		_text.setPosition(_offset_x, _height);
		group.add(_text);
		
		_height = _height + _text.height + 15;
		
		// chess Draws  ----------------------------------------------------
		var _text = new FlxText(0, 0, 0, "Chess Draws.");
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.WHITE, 1);
		_text.setFormat(Reg._fontDefault, 24);
		_text.setPosition(20, _height);
		group.add(_text);
		
		var _text = new FlxText(0, 0, 0, Std.string(RegTypedef._dataStatistics._chessDraws));
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.WHITE, 1);
		_text.setFormat(Reg._fontDefault, 24);
		_text.setPosition(_offset_x, _height);
		group.add(_text);
		
		_height = _height + _text.height + 15;
		
		
		// Reversi wins  ----------------------------------------------------
		var _text = new FlxText(0, 0, 0, "Reversi Wins.");
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.WHITE, 1);
		_text.setFormat(Reg._fontDefault, 24);
		_text.setPosition(20, _height);
		group.add(_text);
		
		var _text = new FlxText(0, 0, 0, Std.string(RegTypedef._dataStatistics._reversiWins));
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.WHITE, 1);
		_text.setFormat(Reg._fontDefault, 24);
		_text.setPosition(_offset_x, _height);
		group.add(_text);
		
		_height = _height + _text.height + 15;
		
		// Reversi losses  ----------------------------------------------------
		var _text = new FlxText(0, 0, 0, "Reversi Losses.");
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.WHITE, 1);
		_text.setFormat(Reg._fontDefault, 24);
		_text.setPosition(20, _height);
		group.add(_text);
		
		var _text = new FlxText(0, 0, 0, Std.string(RegTypedef._dataStatistics._reversiLosses));
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.WHITE, 1);
		_text.setFormat(Reg._fontDefault, 24);
		_text.setPosition(_offset_x, _height);
		group.add(_text);
		
		_height = _height + _text.height + 15;
		
		// Reversi Draws  ----------------------------------------------------
		var _text = new FlxText(0, 0, 0, "Reversi Draws.");
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.WHITE, 1);
		_text.setFormat(Reg._fontDefault, 24);
		_text.setPosition(20, _height);
		group.add(_text);
		
		var _text = new FlxText(0, 0, 0, Std.string(RegTypedef._dataStatistics._reversiDraws));
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.WHITE, 1);
		_text.setFormat(Reg._fontDefault, 24);
		_text.setPosition(_offset_x, _height);
		group.add(_text);
		
		_height = _height + _text.height + 15;
		
		
		// snakes and ladders wins  -------------------------------------------
		var _text = new FlxText(0, 0, 0, "Snakes and Ladders Wins.");
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.WHITE, 1);
		_text.setFormat(Reg._fontDefault, 24);
		_text.setPosition(20, _height);
		group.add(_text);
		
		var _text = new FlxText(0, 0, 0, Std.string(RegTypedef._dataStatistics._snakesAndLaddersWins));
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.WHITE, 1);
		_text.setFormat(Reg._fontDefault, 24);
		_text.setPosition(_offset_x, _height);
		group.add(_text);
		
		_height = _height + _text.height + 15;
		
		// Snakes and ladders losses -----------------------------------------
		var _text = new FlxText(0, 0, 0, "Snakes and Ladders Losses.");
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.WHITE, 1);
		_text.setFormat(Reg._fontDefault, 24);
		_text.setPosition(20, _height);
		group.add(_text);
		
		var _text = new FlxText(0, 0, 0, Std.string(RegTypedef._dataStatistics._snakesAndLaddersLosses));
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.WHITE, 1);
		_text.setFormat(Reg._fontDefault, 24);
		_text.setPosition(_offset_x, _height);
		group.add(_text);
		
		_height = _height + _text.height + 15;
		
		// Snakes and ladders Draws -------------------------------------------
		var _text = new FlxText(0, 0, 0, "Snakes and Ladders Draws.");
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.WHITE, 1);
		_text.setFormat(Reg._fontDefault, 24);
		_text.setPosition(20, _height);
		group.add(_text);
		
		var _text = new FlxText(0, 0, 0, Std.string(RegTypedef._dataStatistics._snakesAndLaddersDraws));
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.WHITE, 1);
		_text.setFormat(Reg._fontDefault, 24);
		_text.setPosition(_offset_x, _height);
		group.add(_text);
		
		_height = _height + _text.height + 15;
		
		// Signature Game wins ------------------------------------------------
		var _text = new FlxText(0, 0, 0, "Signature Game Wins.");
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.WHITE, 1);
		_text.setFormat(Reg._fontDefault, 24);
		_text.setPosition(20, _height);
		group.add(_text);
		
		var _text = new FlxText(0, 0, 0, Std.string(RegTypedef._dataStatistics._signatureGameWins));
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.WHITE, 1);
		_text.setFormat(Reg._fontDefault, 24);
		_text.setPosition(_offset_x, _height);
		group.add(_text);
		
		_height = _height + _text.height + 15;
		
		// Signature Game losses  --------------------------------------------
		var _text = new FlxText(0, 0, 0, "Signature Game Losses.");
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.WHITE, 1);
		_text.setFormat(Reg._fontDefault, 24);
		_text.setPosition(20, _height);
		group.add(_text);
		
		var _text = new FlxText(0, 0, 0, Std.string(RegTypedef._dataStatistics._signatureGameLosses));
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.WHITE, 1);
		_text.setFormat(Reg._fontDefault, 24);
		_text.setPosition(_offset_x, _height);
		group.add(_text);
		
		_height = _height + _text.height + 15;
		
		// Signature Game Draws ----------------------------------------------
		var _text = new FlxText(0, 0, 0, "Signature Game Draws.");
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.WHITE, 1);
		_text.setFormat(Reg._fontDefault, 24);
		_text.setPosition(20, _height);
		group.add(_text);
		
		var _text = new FlxText(0, 0, 0, Std.string(RegTypedef._dataStatistics._signatureGameDraws));
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.WHITE, 1);
		_text.setFormat(Reg._fontDefault, 24);
		_text.setPosition(_offset_x, _height);
		group.add(_text);
		
		_height = _height + _text.height + 15;
		
		
		// this is to move the "go back" button down a bit so that it does not display overtop of the _text above.
		_height = _height + _text.height + 15;
			
	}
	
	
	private function eventsAll():Void
	{
		_height = 135;
	
		// total credits  --------------------------------------------------
		var _text = new FlxText(0, 0, 0, "Total Credits.");
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.WHITE, 1);
		_text.setFormat(Reg._fontDefault, 24);
		_text.setPosition(700, _height);
		group.add(_text);
		
		var _text = new FlxText(0, 0, 0, Std.string(RegTypedef._dataStatistics._creditsTotal));
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.WHITE, 1);
		_text.setFormat(Reg._fontDefault, 24);
		_text.setPosition(1040, _height);
		group.add(_text);
		
		_height = _height + _text.height + 15;
		
		// Experience points --------------------------------------------------
		var _text = new FlxText(0, 0, 0, "Experence Points.");
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.WHITE, 1);
		_text.setFormat(Reg._fontDefault, 24);
		_text.setPosition(700, _height);
		group.add(_text);
		
		var _text = new FlxText(0, 0, 0, Std.string(RegTypedef._dataStatistics._experiencePoints));
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.WHITE, 1);
		_text.setFormat(Reg._fontDefault, 24);
		_text.setPosition(1040, _height);
		group.add(_text);
		
		_height = _height + _text.height + 15;
		
		// House coins --------------------------------------------------
		var _text = new FlxText(0, 0, 0, "House Coins.");
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.WHITE, 1);
		_text.setFormat(Reg._fontDefault, 24);
		_text.setPosition(700, _height);
		group.add(_text);
		
		var _text = new FlxText(0, 0, 0, Std.string(RegTypedef._dataStatistics._houseCoins));
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.WHITE, 1);
		_text.setFormat(Reg._fontDefault, 24);
		_text.setPosition(1040, _height);
		group.add(_text);
		
		_height = _height + _text.height + 15;
		
		
		
		// this is to move the "go back" button down a bit so that it does not display overtop of the _text above.
		_height = _height + _text.height + 15;
	}
	
	private function closeState():Void
	{
		_close.active = false;
		
		FlxG.mouse.reset();
		
		RegTriggers._makeMiscellaneousMenuClassActive = true;
		
		__boxscroller.visible = false;
		Reg.at_scene_menu = true;
		
		visible = false;
		active = false;

	}
	
	override public function destroy()
	{
		if (__boxscroller != null)
		{			
			cameras.remove(__boxscroller);
			__boxscroller.destroy();
			__boxscroller = null;
		}
		
		
		super.destroy();
		
	}
}//
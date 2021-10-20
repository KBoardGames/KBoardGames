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
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

/**
 * at the configuration menu, any feature that changes in color, such as a background or a header, will use one of these functions.
 * @author kboardgames.com
 */
class RegCustomColors 
{
public static function color_future_capturing_units():FlxColor
	{
		
		var _color:FlxColor = 0xFFded943;
		
		if (RegCustom._chess_future_capturing_units_number[Reg._tn] == 1) _color = FlxColor.BLUE;
		if (RegCustom._chess_future_capturing_units_number[Reg._tn] == 2) _color = FlxColor.BROWN;
		if (RegCustom._chess_future_capturing_units_number[Reg._tn] == 3) _color = FlxColor.CYAN;
		if (RegCustom._chess_future_capturing_units_number[Reg._tn] == 4) _color = FlxColor.GRAY;
		if (RegCustom._chess_future_capturing_units_number[Reg._tn] == 5) _color = FlxColor.GREEN;
		if (RegCustom._chess_future_capturing_units_number[Reg._tn] == 6) _color = FlxColor.LIME;
		if (RegCustom._chess_future_capturing_units_number[Reg._tn] == 7) _color = FlxColor.MAGENTA;
		if (RegCustom._chess_future_capturing_units_number[Reg._tn] == 8) _color = FlxColor.ORANGE;
		if (RegCustom._chess_future_capturing_units_number[Reg._tn] == 9) _color = FlxColor.PINK;	 
		if (RegCustom._chess_future_capturing_units_number[Reg._tn] == 10) _color = FlxColor.PURPLE;
		if (RegCustom._chess_future_capturing_units_number[Reg._tn] == 11) _color = FlxColor.RED;
		if (RegCustom._chess_future_capturing_units_number[Reg._tn] == 12) _color = FlxColor.YELLOW;
		if (RegCustom._chess_future_capturing_units_number[Reg._tn] == 13) _color = FlxColor.WHITE;
		return _color;
	}
	
	public static function color_path_to_king():FlxColor
	{
		
		var _color:FlxColor = 0xFFded943;
		
		if (RegCustom._chess_path_to_king_number[Reg._tn] == 1) _color = FlxColor.BLUE;
		if (RegCustom._chess_path_to_king_number[Reg._tn] == 2) _color = FlxColor.BROWN;
		if (RegCustom._chess_path_to_king_number[Reg._tn] == 3) _color = FlxColor.CYAN;
		if (RegCustom._chess_path_to_king_number[Reg._tn] == 4) _color = FlxColor.GRAY;
		if (RegCustom._chess_path_to_king_number[Reg._tn] == 5) _color = FlxColor.GREEN;
		if (RegCustom._chess_path_to_king_number[Reg._tn] == 6) _color = FlxColor.LIME;
		if (RegCustom._chess_path_to_king_number[Reg._tn] == 7) _color = FlxColor.MAGENTA;
		if (RegCustom._chess_path_to_king_number[Reg._tn] == 8) _color = FlxColor.ORANGE;
		if (RegCustom._chess_path_to_king_number[Reg._tn] == 9) _color = FlxColor.PINK;	 
		if (RegCustom._chess_path_to_king_number[Reg._tn] == 10) _color = FlxColor.PURPLE;
		if (RegCustom._chess_path_to_king_number[Reg._tn] == 11) _color = FlxColor.RED;
		if (RegCustom._chess_path_to_king_number[Reg._tn] == 12) _color = FlxColor.YELLOW;
		if (RegCustom._chess_path_to_king_number[Reg._tn] == 13) _color = FlxColor.WHITE;
		return _color;
	}
	
	/******************************
	 * regular units that the piece can capture.
	 */
	public static function color_capturing_units():FlxColor
	{
		
		var _color:FlxColor = 0xFFded943;
		
		if (RegCustom._capturing_units_number[Reg._tn] == 1) _color = FlxColor.BLUE;
		if (RegCustom._capturing_units_number[Reg._tn] == 2) _color = FlxColor.BROWN;
		if (RegCustom._capturing_units_number[Reg._tn] == 3) _color = FlxColor.CYAN;
		if (RegCustom._capturing_units_number[Reg._tn] == 4) _color = FlxColor.GRAY;
		if (RegCustom._capturing_units_number[Reg._tn] == 5) _color = FlxColor.GREEN;
		if (RegCustom._capturing_units_number[Reg._tn] == 6) _color = FlxColor.LIME;
		if (RegCustom._capturing_units_number[Reg._tn] == 7) _color = FlxColor.MAGENTA;
		if (RegCustom._capturing_units_number[Reg._tn] == 8) _color = FlxColor.ORANGE;
		if (RegCustom._capturing_units_number[Reg._tn] == 9) _color = FlxColor.PINK;	 
		if (RegCustom._capturing_units_number[Reg._tn] == 10) _color = FlxColor.PURPLE;
		if (RegCustom._capturing_units_number[Reg._tn] == 11) _color = FlxColor.RED;
		if (RegCustom._capturing_units_number[Reg._tn] == 12) _color = FlxColor.YELLOW;
		if (RegCustom._capturing_units_number[Reg._tn] == 13) _color = FlxColor.WHITE;
		return _color;
	}
	
	public static function background_scene_color():FlxColor
	{
		var _color:FlxColor = 0xFF000000;
		var _num = FlxG.random.int(1, 10);
		
		switch(_num)
		{
			case 1: _color = 0xFF40160d; // brown.
			case 2: _color = 0xFF1c400d; // dark green.
			case 3: _color = 0xFF374008; // greenish yellow. 
			case 4: _color = 0xFF0c0d42; // dark blue.
			case 5: _color = 0xFF888820; // yellow.
			case 6: _color = 0xFF208820; // green.
			case 7: _color = 0xFF202088; // blue.
			case 8: _color = 0xFF882020; // red.
			case 9: _color = 0xFF220022; // purple.
			case 10: _color = 0xffff00ff; // pink.
		}
		
		return _color;
	}
	
	/******************************
	 * chess game board piece set color.
	 */
	public static function draw_update_board_p1_set_color():FlxColor
	{
		var _color:FlxColor = 0xFFded943;
		
		switch(RegCustom._chess_set_for_player1_color_number[Reg._tn])
		{
			 case 1: _color = 0xFFded943;
			 case 2: _color = 0xFF5d275d;			 
			 case 3: _color = 0xFFcb0025;			 
			 case 4: _color = 0xFFef7d57;			 
			 case 5: _color = 0xFFa4844d;			 
			 case 6: _color = 0xFFa7f070;			 
			 case 7: _color = 0xFF27a051;			 
			 case 8: _color = 0xFF016064;
			 case 9: _color = 0xFF29366f;			 
			case 10: _color = 0xFF3b5dc9;
			case 11: _color = 0xFF41a6f6;
			case 12: _color = 0xFF40e0d0;
			case 13: _color = 0xFFca0087;
			case 14: _color = 0xFF777777;
			case 15: _color = 0xFF000000;
			case 16: _color = 0xFF800000;
			case 17: _color = 0xFF9c5b3e;
			case 18: _color = 0xFF553038;
			case 19: _color = 0xFF005711;
			case 20: _color = 0xFF2a201e;			
			case 21: _color = 0xFF141623;
			case 22: _color = 0xFF300a30;
			case 23: _color = 0xFFb7465b;
			case 24: _color = 0xFF563226;
			case 25: _color = 0xFFffa500;
		}

		return _color;
	}
	
	/******************************
	 * chess game board piece set color.
	 */
	public static function draw_update_board_p2_set_color():FlxColor
	{
		var _color:FlxColor = 0xFFded943;
		
		switch(RegCustom._chess_set_for_player2_color_number[Reg._tn])
		{
			 case 1: _color = 0xFFded943;
			 case 2: _color = 0xFF5d275d;			 
			 case 3: _color = 0xFFcb0025;			 
			 case 4: _color = 0xFFef7d57;			 
			 case 5: _color = 0xFFa4844d;			 
			 case 6: _color = 0xFFa7f070;			 
			 case 7: _color = 0xFF27a051;			 
			 case 8: _color = 0xFF016064;
			 case 9: _color = 0xFF29366f;			 
			case 10: _color = 0xFF3b5dc9;
			case 11: _color = 0xFF41a6f6;
			case 12: _color = 0xFF40e0d0;
			case 13: _color = 0xFFca0087;
			case 14: _color = 0xFF777777;
			case 15: _color = 0xFF000000;
			case 16: _color = 0xFF800000;
			case 17: _color = 0xFF9c5b3e;
			case 18: _color = 0xFF553038;
			case 19: _color = 0xFF005711;
			case 20: _color = 0xFF2a201e;			
			case 21: _color = 0xFF141623;
			case 22: _color = 0xFF300a30;
			case 23: _color = 0xFFb7465b;
			case 24: _color = 0xFF563226;
			case 25: _color = 0xFFffa500;
		}
		
		return _color;
	}
	
	public static function colorToggleUnitsOdd(_id:Int):FlxColor
	{
		
		var _color:FlxColor = 0xFFFFFFFF;
		
		if (RegCustom._gameboard_units_odd_color_number[Reg._tn][_id] == 1) _color = 0xFFFFFFFF;
		if (RegCustom._gameboard_units_odd_color_number[Reg._tn][_id] == 2) _color = 0xFF5d275d;
		if (RegCustom._gameboard_units_odd_color_number[Reg._tn][_id] == 3) _color = 0xFFcb0025;
		if (RegCustom._gameboard_units_odd_color_number[Reg._tn][_id] == 4) _color = 0xFFef7d57;
		if (RegCustom._gameboard_units_odd_color_number[Reg._tn][_id] == 5) _color = 0xFFa4844d;
		if (RegCustom._gameboard_units_odd_color_number[Reg._tn][_id] == 6) _color = 0xFFa7f070;
		if (RegCustom._gameboard_units_odd_color_number[Reg._tn][_id] == 7) _color = 0xFF27a051;
		if (RegCustom._gameboard_units_odd_color_number[Reg._tn][_id] == 8) _color = 0xFF016064;
		if (RegCustom._gameboard_units_odd_color_number[Reg._tn][_id] == 9) _color = 0xFF29366f;
		if (RegCustom._gameboard_units_odd_color_number[Reg._tn][_id] == 10) _color = 0xFF3b5dc9;
		if (RegCustom._gameboard_units_odd_color_number[Reg._tn][_id] == 11) _color = 0xFF41a6f6;
		if (RegCustom._gameboard_units_odd_color_number[Reg._tn][_id] == 12) _color = 0xFF40e0d0;
		if (RegCustom._gameboard_units_odd_color_number[Reg._tn][_id] == 13) _color = 0xFFca0087;
		if (RegCustom._gameboard_units_odd_color_number[Reg._tn][_id] == 14) _color = 0xFF777777;
		if (RegCustom._gameboard_units_odd_color_number[Reg._tn][_id] == 15) _color = 0xFF000000;
		if (RegCustom._gameboard_units_odd_color_number[Reg._tn][_id] == 16) _color = 0xFF800000;
		if (RegCustom._gameboard_units_odd_color_number[Reg._tn][_id] == 17) _color = 0xFF9c5b3e;
		if (RegCustom._gameboard_units_odd_color_number[Reg._tn][_id] == 18) _color = 0xFF553038;
		if (RegCustom._gameboard_units_odd_color_number[Reg._tn][_id] == 19) _color = 0xFF005711;
		if (RegCustom._gameboard_units_odd_color_number[Reg._tn][_id] == 20) _color = 0xFFded943;		
		if (RegCustom._gameboard_units_odd_color_number[Reg._tn][_id] == 21) _color = 0xFF141623;
		if (RegCustom._gameboard_units_odd_color_number[Reg._tn][_id] == 22) _color = 0xFF300a30;
		if (RegCustom._gameboard_units_odd_color_number[Reg._tn][_id] == 23) _color = 0xFFb7465b;
		if (RegCustom._gameboard_units_odd_color_number[Reg._tn][_id] == 24) _color = 0xFF563226;
		if (RegCustom._gameboard_units_odd_color_number[Reg._tn][_id] == 25) _color = 0xFFffa500;
	
		return _color;
	}
	
	/******************************
	 * changes the color of game board units.
	 */
	public static function colorToggleUnitsEven(_id:Int):FlxColor
	{		
		var _color:FlxColor = 0xFFFFFFFF;
		
		if (RegCustom._gameboard_units_even_color_number[Reg._tn][_id] == 1) _color = 0xFFFFFFFF;
		if (RegCustom._gameboard_units_even_color_number[Reg._tn][_id] == 2) _color = 0xFF5d275d;
		if (RegCustom._gameboard_units_even_color_number[Reg._tn][_id] == 3) _color = 0xFFcb0025;
		if (RegCustom._gameboard_units_even_color_number[Reg._tn][_id] == 4) _color = 0xFFef7d57;
		if (RegCustom._gameboard_units_even_color_number[Reg._tn][_id] == 5) _color = 0xFFa4844d;
		if (RegCustom._gameboard_units_even_color_number[Reg._tn][_id] == 6) _color = 0xFFa7f070;
		if (RegCustom._gameboard_units_even_color_number[Reg._tn][_id] == 7) _color = 0xFF27a051;
		if (RegCustom._gameboard_units_even_color_number[Reg._tn][_id] == 8) _color = 0xFF016064;
		if (RegCustom._gameboard_units_even_color_number[Reg._tn][_id] == 9) _color = 0xFF29366f;
		if (RegCustom._gameboard_units_even_color_number[Reg._tn][_id] == 10) _color = 0xFF3b5dc9;
		if (RegCustom._gameboard_units_even_color_number[Reg._tn][_id] == 11) _color = 0xFF41a6f6;
		if (RegCustom._gameboard_units_even_color_number[Reg._tn][_id] == 12) _color = 0xFF40e0d0;
		if (RegCustom._gameboard_units_even_color_number[Reg._tn][_id] == 13) _color = 0xFFca0087;
		if (RegCustom._gameboard_units_even_color_number[Reg._tn][_id] == 14) _color = 0xFF777777;
		if (RegCustom._gameboard_units_even_color_number[Reg._tn][_id] == 15) _color = 0xFF000000;
		if (RegCustom._gameboard_units_even_color_number[Reg._tn][_id] == 16) _color = 0xFF800000;
		if (RegCustom._gameboard_units_even_color_number[Reg._tn][_id] == 17) _color = 0xFF9c5b3e;
		if (RegCustom._gameboard_units_even_color_number[Reg._tn][_id] == 18) _color = 0xFF553038;
		if (RegCustom._gameboard_units_even_color_number[Reg._tn][_id] == 19) _color = 0xFF005711;
		if (RegCustom._gameboard_units_even_color_number[Reg._tn][_id] == 20) _color = 0xFFded943;
		if (RegCustom._gameboard_units_even_color_number[Reg._tn][_id] == 21) _color = 0xFF141623;
		if (RegCustom._gameboard_units_even_color_number[Reg._tn][_id] == 22) _color = 0xFF300a30;
		if (RegCustom._gameboard_units_even_color_number[Reg._tn][_id] == 23) _color = 0xFFb7465b;
		if (RegCustom._gameboard_units_even_color_number[Reg._tn][_id] == 24) _color = 0xFF563226;
		if (RegCustom._gameboard_units_even_color_number[Reg._tn][_id] == 25) _color = 0xFFffa500;
		
		return _color;
	}
	
	public static function color_client_background_defaults():FlxColor
	{
		if (CID2._text_client_background_brightness == null)
			return 0xFFFFFFFF;
			
		var _color:FlxColor = 0xFFFFFFFF;
		
		if (RegCustom._client_background_image_number[Reg._tn] == 1) 
		{
			_color = 0xFFFFFFFF;			
			
			// white.
			CID2._text_client_background_brightness.text = "0.95";
			RegCustom._client_background_brightness[Reg._tn] = 0.95;
		}
		
		if (RegCustom._client_background_image_number[Reg._tn] == 2)
		{
			_color = 0xFF5d275d;
			
			// purple
			CID2._text_client_background_brightness.text = "0.35";
			RegCustom._client_background_brightness[Reg._tn] = 0.35;
		}
		
		if (RegCustom._client_background_image_number[Reg._tn] == 3)
		{
			_color = 0xFFcb0025;
			
			// red
			CID2._text_client_background_brightness.text = "0.8";
			RegCustom._client_background_brightness[Reg._tn] = 0.8;
		}
		
		if (RegCustom._client_background_image_number[Reg._tn] == 4) 
		{
			_color = 0xFFef7d57;
			
			// tan
			CID2._text_client_background_brightness.text = "0.9";
			RegCustom._client_background_brightness[Reg._tn] = 0.9;
		}
		
		if (RegCustom._client_background_image_number[Reg._tn] == 5) 
		{
			_color = 0xFFa4844d;
			
			// pumpkins
			CID2._text_client_background_brightness.text = "0.65";
			RegCustom._client_background_brightness[Reg._tn] = 0.65;
		}
		
		if (RegCustom._client_background_image_number[Reg._tn] == 6) 
		{
			_color = 0xFFa7f070;
			
			// light green
			CID2._text_client_background_brightness.text = "0.65";
			RegCustom._client_background_brightness[Reg._tn] = 0.65;
		}
		
		if (RegCustom._client_background_image_number[Reg._tn] == 7)
		{
			_color = 0xFF27a051;
			
			// bright green
			CID2._text_client_background_brightness.text = "0.95";
			RegCustom._client_background_brightness[Reg._tn] = 0.95;
			
		}
		
		if (RegCustom._client_background_image_number[Reg._tn] == 8) 
		{
			_color = 0xFF016064;
			
			// ocean
			CID2._text_client_background_brightness.text = "0.75";
			RegCustom._client_background_brightness[Reg._tn] = 0.75;
		}
		
		if (RegCustom._client_background_image_number[Reg._tn] == 9) 
		{
			_color = 0xFF29366f;
			
			// dark blue
			CID2._text_client_background_brightness.text = "0.45";
			RegCustom._client_background_brightness[Reg._tn] = 0.45;
		}
		
		if (RegCustom._client_background_image_number[Reg._tn] == 10) 
		{
			_color = 0xFF3b5dc9;
			
			// blue
			CID2._text_client_background_brightness.text = "0.8";
			RegCustom._client_background_brightness[Reg._tn] = 0.8;
		}
		
		if (RegCustom._client_background_image_number[Reg._tn] == 11)
		{
			_color = 0xFF41a6f6;
			
			// light blue
			CID2._text_client_background_brightness.text = "0.95";
			RegCustom._client_background_brightness[Reg._tn] = 0.95;
		}
		
		if (RegCustom._client_background_image_number[Reg._tn] == 12) 
		{
			_color = 0xFF40e0d0;
			
			// turquoise
			CID2._text_client_background_brightness.text = "0.95";
			RegCustom._client_background_brightness[Reg._tn] = 0.95;
		}
		
		if (RegCustom._client_background_image_number[Reg._tn] == 13)
		{
			_color = 0xFFca0087;
			
			// magenta
			CID2._text_client_background_brightness.text = "0.8";
			RegCustom._client_background_brightness[Reg._tn] = 0.8;
		}
		
		if (RegCustom._client_background_image_number[Reg._tn] == 14)
		{
			_color = 0xFF777777;
			
			// gray
			CID2._text_client_background_brightness.text = "0.55";
			RegCustom._client_background_brightness[Reg._tn] = 0.55;
		}
		
		if (RegCustom._client_background_image_number[Reg._tn] == 15) 
		{
			_color = 0xFF000000;
			
			// black
			CID2._text_client_background_brightness.text = "0.15";
			RegCustom._client_background_brightness[Reg._tn] = 0.15;
		}
		
		if (RegCustom._client_background_image_number[Reg._tn] == 16) 
		{
			_color = 0xFF800000;
			
			// maroon
			CID2._text_client_background_brightness.text = "0.35";
			RegCustom._client_background_brightness[Reg._tn] = 0.35;
		}
		
		if (RegCustom._client_background_image_number[Reg._tn] == 17) 
		{
			_color = 0xFF9c5b3e;
			
			// fire
			CID2._text_client_background_brightness.text = "0.6";
			RegCustom._client_background_brightness[Reg._tn] = 0.6;
		}
		
		if (RegCustom._client_background_image_number[Reg._tn] == 18) 
		{
			_color = 0xFF553038;
			
			// brown
			CID2._text_client_background_brightness.text = "0.3";
			RegCustom._client_background_brightness[Reg._tn] = 0.3;
		}
		
		if (RegCustom._client_background_image_number[Reg._tn] == 19)
		{
			_color = 0xFF005711;
			
			// dark green
			CID2._text_client_background_brightness.text = "0.35";
			RegCustom._client_background_brightness[Reg._tn] = 0.35;
		}
		
		if (RegCustom._client_background_image_number[Reg._tn] == 20)
		{
			_color = 0xFFded943;
			
			// yellow
			CID2._text_client_background_brightness.text = "0.85";
			RegCustom._client_background_brightness[Reg._tn] = 0.85;
		}
		
		if (RegCustom._client_background_image_number[Reg._tn] == 21)
		{
			_color = 0xFF141623;
			
			// livid
			CID2._text_client_background_brightness.text = "0.15";
			RegCustom._client_background_brightness[Reg._tn] = 0.15;
		}
		
		if (RegCustom._client_background_image_number[Reg._tn] == 22)
		{
			_color = 0xFF300a30;
			
			// dark purple
			CID2._text_client_background_brightness.text = "0.15";
			RegCustom._client_background_brightness[Reg._tn] = 0.15;
		}
		
		if (RegCustom._client_background_image_number[Reg._tn] == 23) 
		{
			_color = 0xFFb7465b;
			
			// pink
			CID2._text_client_background_brightness.text = "0.7";
			RegCustom._client_background_brightness[Reg._tn] = 0.7;
		}
		
		if (RegCustom._client_background_image_number[Reg._tn] == 24) 
		{
			_color = 0xFF563226;
			
			// dark brown
			CID2._text_client_background_brightness.text = "0.35";
			RegCustom._client_background_brightness[Reg._tn] = 0.35;
		}
		
		if (RegCustom._client_background_image_number[Reg._tn] == 25)
		{
			_color = 0xFFffa500;
			
			// davy's gray
			CID2._text_client_background_brightness.text = "0.45";
			RegCustom._client_background_brightness[Reg._tn] = 0.45;
		}
	
		return _color;
	}
	
	public static function color_client_background():FlxColor
	{
		if (Reg._at_configuration_menu == true 
		&&	CID2._text_client_background_brightness == null)
			return 0xFFFFFFFF;
			
		var _color:FlxColor = 0xFFFFFFFF;
		
		if (RegCustom._client_background_image_number[Reg._tn] == 1) 
			_color = 0xFFFFFFFF;			
		
		if (RegCustom._client_background_image_number[Reg._tn] == 2)
			_color = 0xFF5d275d;
		
		if (RegCustom._client_background_image_number[Reg._tn] == 3)
			_color = 0xFFcb0025;
		
		if (RegCustom._client_background_image_number[Reg._tn] == 4) 
			_color = 0xFFef7d57;
		
		if (RegCustom._client_background_image_number[Reg._tn] == 5) 
			_color = 0xFFa4844d;
		
		if (RegCustom._client_background_image_number[Reg._tn] == 6) 
			_color = 0xFFa7f070;
		
		if (RegCustom._client_background_image_number[Reg._tn] == 7)
			_color = 0xFF27a051;
		
		if (RegCustom._client_background_image_number[Reg._tn] == 8) 
			_color = 0xFF016064;
		
		if (RegCustom._client_background_image_number[Reg._tn] == 9) 
			_color = 0xFF29366f;
		
		if (RegCustom._client_background_image_number[Reg._tn] == 10) 
			_color = 0xFF3b5dc9;
		
		if (RegCustom._client_background_image_number[Reg._tn] == 11)
			_color = 0xFF41a6f6;
		
		if (RegCustom._client_background_image_number[Reg._tn] == 12) 
			_color = 0xFF40e0d0;
		
		if (RegCustom._client_background_image_number[Reg._tn] == 13)
			_color = 0xFFca0087;
		
		if (RegCustom._client_background_image_number[Reg._tn] == 14)
			_color = 0xFF777777;
		
		if (RegCustom._client_background_image_number[Reg._tn] == 15) 
			_color = 0xFF000000;
		
		if (RegCustom._client_background_image_number[Reg._tn] == 16) 
			_color = 0xFF800000;
		
		if (RegCustom._client_background_image_number[Reg._tn] == 17) 
			_color = 0xFF9c5b3e;
		
		if (RegCustom._client_background_image_number[Reg._tn] == 18) 
			_color = 0xFF553038;
		
		if (RegCustom._client_background_image_number[Reg._tn] == 19)
			_color = 0xFF005711;
		
		if (RegCustom._client_background_image_number[Reg._tn] == 20)
			_color = 0xFFded943;
		
		if (RegCustom._client_background_image_number[Reg._tn] == 21)
			_color = 0xFF141623;
		
		if (RegCustom._client_background_image_number[Reg._tn] == 22)
			_color = 0xFF300a30;
		
		if (RegCustom._client_background_image_number[Reg._tn] == 23) 
			_color = 0xFFb7465b;
		
		if (RegCustom._client_background_image_number[Reg._tn] == 24) 
			_color = 0xFF563226;
		
		if (RegCustom._client_background_image_number[Reg._tn] == 25)
			_color = 0xFFffa500;
			
		return _color;
	}
		
		
	public static function notation_panel_background_color():FlxColor
	{
		
		var _color:FlxColor = 0xFFFFFFFF;
		
		if (RegCustom._notation_panel_background_color_number[Reg._tn] == 1) _color = 0xFFFFFFFF;
		if (RegCustom._notation_panel_background_color_number[Reg._tn] == 2) _color = 0xFF5d275d;
		if (RegCustom._notation_panel_background_color_number[Reg._tn] == 3) _color = 0xFFcb0025;
		if (RegCustom._notation_panel_background_color_number[Reg._tn] == 4) _color = 0xFFef7d57;
		if (RegCustom._notation_panel_background_color_number[Reg._tn] == 5) _color = 0xFFa4844d;
		if (RegCustom._notation_panel_background_color_number[Reg._tn] == 6) _color = 0xFFa7f070;
		if (RegCustom._notation_panel_background_color_number[Reg._tn] == 7) _color = 0xFF27a051;
		if (RegCustom._notation_panel_background_color_number[Reg._tn] == 8) _color = 0xFF016064;
		if (RegCustom._notation_panel_background_color_number[Reg._tn] == 9) _color = 0xFF29366f;
		if (RegCustom._notation_panel_background_color_number[Reg._tn] == 10) _color = 0xFF3b5dc9;
		if (RegCustom._notation_panel_background_color_number[Reg._tn] == 11) _color = 0xFF41a6f6;
		if (RegCustom._notation_panel_background_color_number[Reg._tn] == 12) _color = 0xFF40e0d0;
		if (RegCustom._notation_panel_background_color_number[Reg._tn] == 13) _color = 0xFFca0087;
		if (RegCustom._notation_panel_background_color_number[Reg._tn] == 14) _color = 0xFF777777;
		if (RegCustom._notation_panel_background_color_number[Reg._tn] == 15) _color = 0xFF000000;
		if (RegCustom._notation_panel_background_color_number[Reg._tn] == 16) _color = 0xFF800000;
		if (RegCustom._notation_panel_background_color_number[Reg._tn] == 17) _color = 0xFF9c5b3e;
		if (RegCustom._notation_panel_background_color_number[Reg._tn] == 18) _color = 0xFF553038;
		if (RegCustom._notation_panel_background_color_number[Reg._tn] == 19) _color = 0xFF005711;
		if (RegCustom._notation_panel_background_color_number[Reg._tn] == 20) _color = 0xFFded943;
		if (RegCustom._notation_panel_background_color_number[Reg._tn] == 21) _color = 0xFF141623;
		if (RegCustom._notation_panel_background_color_number[Reg._tn] == 22) _color = 0xFF300a30;
		if (RegCustom._notation_panel_background_color_number[Reg._tn] == 23) _color = 0xFFb7465b;
		if (RegCustom._notation_panel_background_color_number[Reg._tn] == 24) _color = 0xFF563226;
		if (RegCustom._notation_panel_background_color_number[Reg._tn] == 25) _color = 0xFFffa500;
	
		return _color;
	}

	public static function notation_panel_text_color():FlxColor
	{
		
		var _color:FlxColor = 0xFFFFFFFF;
		
		if (RegCustom._notation_panel_text_color_number[Reg._tn] == 1) _color = 0xFFFFFFFF;
		if (RegCustom._notation_panel_text_color_number[Reg._tn] == 2) _color = 0xFF5d275d;
		if (RegCustom._notation_panel_text_color_number[Reg._tn] == 3) _color = 0xFFcb0025;
		if (RegCustom._notation_panel_text_color_number[Reg._tn] == 4) _color = 0xFFef7d57;
		if (RegCustom._notation_panel_text_color_number[Reg._tn] == 5) _color = 0xFFa4844d;
		if (RegCustom._notation_panel_text_color_number[Reg._tn] == 6) _color = 0xFFa7f070;
		if (RegCustom._notation_panel_text_color_number[Reg._tn] == 7) _color = 0xFF27a051;
		if (RegCustom._notation_panel_text_color_number[Reg._tn] == 8) _color = 0xFF016064;
		if (RegCustom._notation_panel_text_color_number[Reg._tn] == 9) _color = 0xFF29366f;
		if (RegCustom._notation_panel_text_color_number[Reg._tn] == 10) _color = 0xFF3b5dc9;
		if (RegCustom._notation_panel_text_color_number[Reg._tn] == 11) _color = 0xFF41a6f6;
		if (RegCustom._notation_panel_text_color_number[Reg._tn] == 12) _color = 0xFF40e0d0;
		if (RegCustom._notation_panel_text_color_number[Reg._tn] == 13) _color = 0xFFca0087;
		if (RegCustom._notation_panel_text_color_number[Reg._tn] == 14) _color = 0xFF777777;
		if (RegCustom._notation_panel_text_color_number[Reg._tn] == 15) _color = 0xFF000000;
		if (RegCustom._notation_panel_text_color_number[Reg._tn] == 16) _color = 0xFF800000;
		if (RegCustom._notation_panel_text_color_number[Reg._tn] == 17) _color = 0xFF9c5b3e;
		if (RegCustom._notation_panel_text_color_number[Reg._tn] == 18) _color = 0xFF553038;
		if (RegCustom._notation_panel_text_color_number[Reg._tn] == 19) _color = 0xFF005711;
		if (RegCustom._notation_panel_text_color_number[Reg._tn] == 20) _color = 0xFFded943;
		if (RegCustom._notation_panel_text_color_number[Reg._tn] == 21) _color = 0xFF141623;
		if (RegCustom._notation_panel_text_color_number[Reg._tn] == 22) _color = 0xFF300a30;
		if (RegCustom._notation_panel_text_color_number[Reg._tn] == 23) _color = 0xFFb7465b;
		if (RegCustom._notation_panel_text_color_number[Reg._tn] == 24) _color = 0xFF563226;
		if (RegCustom._notation_panel_text_color_number[Reg._tn] == 25) _color = 0xFFffa500;
	
		return _color;
	}
	
	/******************************
	 * button fill color is the color behind the button text.
	 */
	public static function button_colors():FlxColor
	{		
		var _color:FlxColor = 0xFFffffff;
		
		if (RegCustom._button_color_number[Reg._tn] == 1) _color = 0xFFffffff;
		if (RegCustom._button_color_number[Reg._tn] == 2) _color = 0xFF5d275d;
		if (RegCustom._button_color_number[Reg._tn] == 3) _color = 0xFFcb0025;
		if (RegCustom._button_color_number[Reg._tn] == 4) _color = 0xFFef7d57;
		if (RegCustom._button_color_number[Reg._tn] == 5) _color = 0xFFa4844d;
		if (RegCustom._button_color_number[Reg._tn] == 6) _color = 0xFFa7f070;
		if (RegCustom._button_color_number[Reg._tn] == 7) _color = 0xFF27a051;
		if (RegCustom._button_color_number[Reg._tn] == 8) _color = 0xFF016064;
		if (RegCustom._button_color_number[Reg._tn] == 9) _color = 0xFF29366f;
		if (RegCustom._button_color_number[Reg._tn] == 10) _color = 0xFF3b5dc9;
		if (RegCustom._button_color_number[Reg._tn] == 11) _color = 0xFF41a6f6;
		if (RegCustom._button_color_number[Reg._tn] == 12) _color = 0xFF40e0d0;
		if (RegCustom._button_color_number[Reg._tn] == 13) _color = 0xFFca0087;
		if (RegCustom._button_color_number[Reg._tn] == 14) _color = 0xFF777777;
		if (RegCustom._button_color_number[Reg._tn] == 15) _color = 0xFF000000;
		if (RegCustom._button_color_number[Reg._tn] == 16) _color = 0xFF800000;
		if (RegCustom._button_color_number[Reg._tn] == 17) _color = 0xFF9c5b3e;
		if (RegCustom._button_color_number[Reg._tn] == 18) _color = 0xFF553038;
		if (RegCustom._button_color_number[Reg._tn] == 19) _color = 0xFF005711;
		if (RegCustom._button_color_number[Reg._tn] == 20) _color = 0xFFded943;
		if (RegCustom._button_color_number[Reg._tn] == 21) _color = 0xFF141623;
		if (RegCustom._button_color_number[Reg._tn] == 22) _color = 0xFF300a30;
		if (RegCustom._button_color_number[Reg._tn] == 23) _color = 0xFFb7465b;
		if (RegCustom._button_color_number[Reg._tn] == 24) _color = 0xFF563226;
		if (RegCustom._button_color_number[Reg._tn] == 25) _color = 0xFFffa500;
		
		return _color;
	}
	
	/******************************
	 * button border color.
	 */
	public static function button_border_colors():FlxColor
	{		
		var _color:FlxColor = 0xFFffffff;
		
		if (RegCustom._button_border_color_number[Reg._tn] == 1) _color = 0xFFffffff;
		if (RegCustom._button_border_color_number[Reg._tn] == 2) _color = 0xFF5d275d;
		if (RegCustom._button_border_color_number[Reg._tn] == 3) _color = 0xFFcb0025;
		if (RegCustom._button_border_color_number[Reg._tn] == 4) _color = 0xFFef7d57;
		if (RegCustom._button_border_color_number[Reg._tn] == 5) _color = 0xFFa4844d;
		if (RegCustom._button_border_color_number[Reg._tn] == 6) _color = 0xFFa7f070;
		if (RegCustom._button_border_color_number[Reg._tn] == 7) _color = 0xFF27a051;
		if (RegCustom._button_border_color_number[Reg._tn] == 8) _color = 0xFF016064;
		if (RegCustom._button_border_color_number[Reg._tn] == 9) _color = 0xFF29366f;
		if (RegCustom._button_border_color_number[Reg._tn] == 10) _color = 0xFF3b5dc9;
		if (RegCustom._button_border_color_number[Reg._tn] == 11) _color = 0xFF41a6f6;
		if (RegCustom._button_border_color_number[Reg._tn] == 12) _color = 0xFF40e0d0;
		if (RegCustom._button_border_color_number[Reg._tn] == 13) _color = 0xFFca0087;
		if (RegCustom._button_border_color_number[Reg._tn] == 14) _color = 0xFF777777;
		if (RegCustom._button_border_color_number[Reg._tn] == 15) _color = 0xFF000000;
		if (RegCustom._button_border_color_number[Reg._tn] == 16) _color = 0xFF800000;
		if (RegCustom._button_border_color_number[Reg._tn] == 17) _color = 0xFF9c5b3e;
		if (RegCustom._button_border_color_number[Reg._tn] == 18) _color = 0xFF553038;
		if (RegCustom._button_border_color_number[Reg._tn] == 19) _color = 0xFF005711;
		if (RegCustom._button_border_color_number[Reg._tn] == 20) _color = 0xFFded943;
		if (RegCustom._button_border_color_number[Reg._tn] == 21) _color = 0xFF141623;
		if (RegCustom._button_border_color_number[Reg._tn] == 22) _color = 0xFF300a30;
		if (RegCustom._button_border_color_number[Reg._tn] == 23) _color = 0xFFb7465b;
		if (RegCustom._button_border_color_number[Reg._tn] == 24) _color = 0xFF563226;
		if (RegCustom._button_border_color_number[Reg._tn] == 25) _color = 0xFFffa500;
		
		return _color;
	}
	
	/******************************
	 * button text color.
	 */
	public static function button_text_colors():FlxColor
	{		
		var _color:FlxColor = 0xFFffffff;
		
		if (RegCustom._button_text_color_number[Reg._tn] == 1) _color = 0xFFffffff;
		if (RegCustom._button_text_color_number[Reg._tn] == 2) _color = 0xFF5d275d;
		if (RegCustom._button_text_color_number[Reg._tn] == 3) _color = 0xFFcb0025;
		if (RegCustom._button_text_color_number[Reg._tn] == 4) _color = 0xFFef7d57;
		if (RegCustom._button_text_color_number[Reg._tn] == 5) _color = 0xFFa4844d;
		if (RegCustom._button_text_color_number[Reg._tn] == 6) _color = 0xFFa7f070;
		if (RegCustom._button_text_color_number[Reg._tn] == 7) _color = 0xFF27a051;
		if (RegCustom._button_text_color_number[Reg._tn] == 8) _color = 0xFF016064;
		if (RegCustom._button_text_color_number[Reg._tn] == 9) _color = 0xFF29366f;
		if (RegCustom._button_text_color_number[Reg._tn] == 10) _color = 0xFF3b5dc9;
		if (RegCustom._button_text_color_number[Reg._tn] == 11) _color = 0xFF41a6f6;
		if (RegCustom._button_text_color_number[Reg._tn] == 12) _color = 0xFF40e0d0;
		if (RegCustom._button_text_color_number[Reg._tn] == 13) _color = 0xFFca0087;
		if (RegCustom._button_text_color_number[Reg._tn] == 14) _color = 0xFF777777;
		if (RegCustom._button_text_color_number[Reg._tn] == 15) _color = 0xFF000000;
		if (RegCustom._button_text_color_number[Reg._tn] == 16) _color = 0xFF800000;
		if (RegCustom._button_text_color_number[Reg._tn] == 17) _color = 0xFF9c5b3e;
		if (RegCustom._button_text_color_number[Reg._tn] == 18) _color = 0xFF553038;
		if (RegCustom._button_text_color_number[Reg._tn] == 19) _color = 0xFF005711;
		if (RegCustom._button_text_color_number[Reg._tn] == 20) _color = 0xFFded943;
		if (RegCustom._button_text_color_number[Reg._tn] == 21) _color = 0xFF141623;
		if (RegCustom._button_text_color_number[Reg._tn] == 22) _color = 0xFF300a30;
		if (RegCustom._button_text_color_number[Reg._tn] == 23) _color = 0xFFb7465b;
		if (RegCustom._button_text_color_number[Reg._tn] == 24) _color = 0xFF563226;
		if (RegCustom._button_text_color_number[Reg._tn] == 25) _color = 0xFFffa500;
			
		return _color;
	}
		
	public static function title_bar_background_color():FlxColor
	{
		var _color:FlxColor = 0xFFFFFFFF;
		
		if (RegCustom._title_bar_background_number[Reg._tn] == 1) _color = 0xFFFFFFFF;
		if (RegCustom._title_bar_background_number[Reg._tn] == 2) _color = 0xFF5d275d;
		if (RegCustom._title_bar_background_number[Reg._tn] == 3) _color = 0xFFcb0025;
		if (RegCustom._title_bar_background_number[Reg._tn] == 4) _color = 0xFFef7d57;
		if (RegCustom._title_bar_background_number[Reg._tn] == 5) _color = 0xFFa4844d;
		if (RegCustom._title_bar_background_number[Reg._tn] == 6) _color = 0xFFa7f070;
		if (RegCustom._title_bar_background_number[Reg._tn] == 7) _color = 0xFF27a051;
		if (RegCustom._title_bar_background_number[Reg._tn] == 8) _color = 0xFF016064;
		if (RegCustom._title_bar_background_number[Reg._tn] == 9) _color = 0xFF29366f;
		if (RegCustom._title_bar_background_number[Reg._tn] == 10) _color = 0xFF3b5dc9;
		if (RegCustom._title_bar_background_number[Reg._tn] == 11) _color = 0xFF41a6f6;
		if (RegCustom._title_bar_background_number[Reg._tn] == 12) _color = 0xFF40e0d0;
		if (RegCustom._title_bar_background_number[Reg._tn] == 13) _color = 0xFFca0087;
		if (RegCustom._title_bar_background_number[Reg._tn] == 14) _color = 0xFF777777;
		if (RegCustom._title_bar_background_number[Reg._tn] == 15) _color = 0xFF000000;
		if (RegCustom._title_bar_background_number[Reg._tn] == 16) _color = 0xFF800000;
		if (RegCustom._title_bar_background_number[Reg._tn] == 17) _color = 0xFF9c5b3e;
		if (RegCustom._title_bar_background_number[Reg._tn] == 18) _color = 0xFF553038;
		if (RegCustom._title_bar_background_number[Reg._tn] == 19) _color = 0xFF005711;
		if (RegCustom._title_bar_background_number[Reg._tn] == 20) _color = 0xFFded943;
		if (RegCustom._title_bar_background_number[Reg._tn] == 21) _color = 0xFF141623;
		if (RegCustom._title_bar_background_number[Reg._tn] == 22) _color = 0xFF300a30;
		if (RegCustom._title_bar_background_number[Reg._tn] == 23) _color = 0xFFb7465b;
		if (RegCustom._title_bar_background_number[Reg._tn] == 24) _color = 0xFF563226;
		if (RegCustom._title_bar_background_number[Reg._tn] == 25) _color = 0xFFffa500;
	
		return _color;
	}
	
	public static function menu_bar_background_color():FlxColor
	{
		
		var _color:FlxColor = 0xFFFFFFFF;
		
		if (RegCustom._menu_bar_background_number[Reg._tn] == 1) _color = 0xFFFFFFFF;
		if (RegCustom._menu_bar_background_number[Reg._tn] == 2) _color = 0xFF5d275d;
		if (RegCustom._menu_bar_background_number[Reg._tn] == 3) _color = 0xFFcb0025;
		if (RegCustom._menu_bar_background_number[Reg._tn] == 4) _color = 0xFFef7d57;
		if (RegCustom._menu_bar_background_number[Reg._tn] == 5) _color = 0xFFa4844d;
		if (RegCustom._menu_bar_background_number[Reg._tn] == 6) _color = 0xFFa7f070;
		if (RegCustom._menu_bar_background_number[Reg._tn] == 7) _color = 0xFF27a051;
		if (RegCustom._menu_bar_background_number[Reg._tn] == 8) _color = 0xFF016064;
		if (RegCustom._menu_bar_background_number[Reg._tn] == 9) _color = 0xFF29366f;
		if (RegCustom._menu_bar_background_number[Reg._tn] == 10) _color = 0xFF3b5dc9;
		if (RegCustom._menu_bar_background_number[Reg._tn] == 11) _color = 0xFF41a6f6;
		if (RegCustom._menu_bar_background_number[Reg._tn] == 12) _color = 0xFF40e0d0;
		if (RegCustom._menu_bar_background_number[Reg._tn] == 13) _color = 0xFFca0087;
		if (RegCustom._menu_bar_background_number[Reg._tn] == 14) _color = 0xFF777777;
		if (RegCustom._menu_bar_background_number[Reg._tn] == 15) _color = 0xFF000000;
		if (RegCustom._menu_bar_background_number[Reg._tn] == 16) _color = 0xFF800000;
		if (RegCustom._menu_bar_background_number[Reg._tn] == 17) _color = 0xFF9c5b3e;
		if (RegCustom._menu_bar_background_number[Reg._tn] == 18) _color = 0xFF553038;
		if (RegCustom._menu_bar_background_number[Reg._tn] == 19) _color = 0xFF005711;
		if (RegCustom._menu_bar_background_number[Reg._tn] == 20) _color = 0xFFded943;
		if (RegCustom._menu_bar_background_number[Reg._tn] == 21) _color = 0xFF141623;
		if (RegCustom._menu_bar_background_number[Reg._tn] == 22) _color = 0xFF300a30;
		if (RegCustom._menu_bar_background_number[Reg._tn] == 23) _color = 0xFFb7465b;
		if (RegCustom._menu_bar_background_number[Reg._tn] == 24) _color = 0xFF563226;
		if (RegCustom._menu_bar_background_number[Reg._tn] == 25) _color = 0xFFffa500;
	
		return _color;
	}
	
}
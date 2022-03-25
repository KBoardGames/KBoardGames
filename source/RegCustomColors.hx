/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
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
		var _c = colors(RegCustom._chess_future_capturing_units_number[Reg._tn]);
		return _c;
	}
	
	public static function color_path_to_king():FlxColor
	{
		var _c = colors(RegCustom._chess_path_to_king_number[Reg._tn]);
		return _c;
	}
	
	/******************************
	 * regular units that the piece can capture.
	 */
	public static function color_capturing_units():FlxColor
	{
		var _c = colors(RegCustom._capturing_units_number[Reg._tn]);
		return _c;
	}
	
	/******************************
	 * chess game board piece set color.
	 */
	public static function draw_update_board_p1_set_color():FlxColor
	{
		var _c = colors(RegCustom._chess_set_for_player1_color_number[Reg._tn]);
		return _c;
	}
	
	/******************************
	 * chess game board piece set color.
	 */
	public static function draw_update_board_p2_set_color():FlxColor
	{
		var _c = colors(RegCustom._chess_set_for_player2_color_number[Reg._tn]);
		return _c;
	}
	
	public static function colorToggleUnitsOdd(_id:Int):FlxColor
	{
		var _c = colors(RegCustom._gameboard_units_odd_color_number[Reg._tn][_id]);
		return _c;
	}
	
	/******************************
	 * changes the color of game board units.
	 */
	public static function colorToggleUnitsEven(_id:Int):FlxColor
	{		
		var _c = colors(RegCustom._gameboard_units_even_color_number[Reg._tn][_id]);
		return _c;
	}
	
	public static function color_client_background():FlxColor
	{
		var _c = colors(RegCustom._client_background_image_number[Reg._tn]);
		return _c;
	}
	
	public static function color_table_body_background():FlxColor
	{
		var _c = colors(RegCustom._table_body_background_image_number[Reg._tn]);
		return _c;
	}
	
	public static function notation_panel_background_color():FlxColor
	{
		var _c = colors(RegCustom._notation_panel_background_color_number[Reg._tn]);
		return _c;
	}

	public static function notation_panel_text_color():FlxColor
	{		
		var _c = colors(RegCustom._notation_panel_text_color_number[Reg._tn]);
		return _c;
	}
	
	public static function gradient_color():FlxColor
	{		
		var _c = colors(RegCustom._gradient_background_image_number[Reg._tn]);
		return _c;
	}
	
	public static function client_topic_title_text_color():FlxColor
	{		
		var _c = colors(RegCustom._client_topic_title_text_color_number[Reg._tn]);
		return _c;
	}
	
	public static function client_text_color():FlxColor
	{		
		var _c = colors(RegCustom._client_text_color_number[Reg._tn]);
		return _c;
	}
	
	public static function title_bar_text_color():FlxColor
	{		
		var _c = colors(RegCustom._title_bar_text_color_number[Reg._tn]);
		return _c;
	}
	
	public static function table_body_text_color():FlxColor
	{		
		var _c = colors(RegCustom._table_body_text_color_number[Reg._tn]);
		return _c;
	}
	
	public static function chatter_text_color():FlxColor
	{		
		var _c = colors(RegCustom._chatter_text_color_number[Reg._tn]);
		return _c;
	}
	
	/******************************
	 * button fill color is the color behind the button text.
	 */
	public static function button_colors():FlxColor
	{		
		var _c = colors(RegCustom._button_color_number[Reg._tn]);
		return _c;
	}
	
	/******************************
	 * button border color.
	 */
	public static function button_border_colors():FlxColor
	{		
		var _c = colors(RegCustom._button_border_color_number[Reg._tn]);
		return _c;
	}
	
	/******************************
	 * button text color.
	 */
	public static function button_text_colors():FlxColor
	{		
		var _c = colors(RegCustom._button_text_color_number[Reg._tn]);
		return _c;
	}
		
	public static function title_bar_background_color():FlxColor
	{
		var _c = colors(RegCustom._title_bar_background_number[Reg._tn]);
		return _c;
	}
	
	public static function menu_bar_background_color():FlxColor
	{
		var _c = colors(RegCustom._menu_bar_background_number[Reg._tn]);
		return _c;
	}
	
	public static function title_icon_color():FlxColor
	{
		var _c = colors(RegCustom._title_icon_number[Reg._tn]);
		return _c;
	}
	
	public static function number_wheel_shadow_color():FlxColor
	{
		var _c = colors(RegCustom._number_wheel_shadow_image_number[Reg._tn]);
		return _c;
	}
	
	public static function number_wheel_color():FlxColor
	{
		var _c = colors(RegCustom._number_wheel_image_number[Reg._tn]);
		return _c;
	}
	
	public static function number_wheel_numbers_color():FlxColor
	{
		var _c = colors(RegCustom._number_wheel_numbers_image_number[Reg._tn]);
		return _c;
	}
	
	public static function number_wheel_highlighter_color():FlxColor
	{
		var _c = colors(RegCustom._number_wheel_highlighter_image_number[Reg._tn]);
		return _c;
	}
	
	public static function number_wheel_button_color():FlxColor
	{
		var _c = colors(RegCustom._number_wheel_button_image_number[Reg._tn]);
		return _c;
	}
	
	private static function colors(_c:Int):FlxColor
	{
		switch(_c)
		{
			 case 1: _c = 0xFFffffff;
			 case 2: _c = 0xFF800080;			 
			 case 3: _c = 0xFF800015;			 
			 case 4: _c = 0xFF801e00;			 
			 case 5: _c = 0xFF805200;
			 case 6: _c = 0xFF807c00;
			 case 7: _c = 0xFF368000;			 
			 case 8: _c = 0xFF00802a;			 
			 case 9: _c = 0xFF007b80;			 
			case 10: _c = 0xFF004880;
			case 11: _c = 0xFF001580;
			case 12: _c = 0xFF000000;
			case 13: _c = 0xFF555555;
		}

		return _c;
	}
}
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
 * this class is created when clicking the gear button. It has configuration stuff such as setting up the game board unit colors.
 * @author kboardgames.com
 */
class MenuConfigurationsGeneral extends FlxGroup
{
	private var __action_keyboard:ActionKeyboard;
	
	private var  _gameboard_border_title:FlxText;
	
	// title text for odd units.
	private var _text_title_odd_units:FlxText;
	private var _text_title_even_units:FlxText;
	
	// shades of grayscale.
	private var _text_odd_units_shader:FlxText;
	private var _text_even_units_shader:FlxText;
	
	// color applied to a shaded unit.
	private var _text_odd_units_color:FlxText;
	private var _text_even_units_color:FlxText;
	
	// plus and minus buttons for shade images of odd units.
	public var _button_shader_odd_units_minus:ButtonGeneralNetworkNo;
	public var	_button_shader_odd_units_plus:ButtonGeneralNetworkNo;
	public var _button_shader_even_units_minus:ButtonGeneralNetworkNo;
	public var	_button_shader_even_units_plus:ButtonGeneralNetworkNo;
	
	public var _button_color_odd_units_minus:ButtonGeneralNetworkNo;
	public var	_button_color_odd_units_plus:ButtonGeneralNetworkNo;
	public var _button_color_even_units_minus:ButtonGeneralNetworkNo;
	public var	_button_color_even_units_plus:ButtonGeneralNetworkNo;
		
	private var _sprite_gameboard_border:FlxSprite;
	private var _sprite_gameboard_coordinates:FlxSprite;
	private var _sprite_game_room_image:FlxSprite;
	private var _sprite_game_show_capturing_units_number:FlxSprite;
	
	private var _button_game_room_minus:ButtonGeneralNetworkNo;
	private var	_button_game_room_plus:ButtonGeneralNetworkNo;
	
	private var _sprite_board_game_unit_odd:FlxSprite;
	private var _sprite_board_game_unit_even:FlxSprite;
	
	private var _button_game_show_capturing_units_minus:ButtonGeneralNetworkNo;
	private var	_button_game_show_capturing_units_plus:ButtonGeneralNetworkNo;
	
	private var _offset_x:Int = -80;
	private var _offset_y:Int = 30;
	private var _offset:Int = 30;	
	
	private var _leaderboard_question:FlxText;
	private var _button_leaderboard_enabled:ButtonGeneralNetworkNo;

	private var _button_general:ButtonToggleFlxState;	

	/******************************
	* anything added to this group will be placed inside of the boxScroller field. 
	*/
	public var _group:FlxSpriteGroup;	
	
	/******************************
	 * value starts at 0. access members here. for regular buttons.
	 */
	public var _group_button:Array<ButtonGeneralNetworkNo> = [];
	
	public var _button_default_colors_checkers:ButtonToggleFlxState;
	public var _button_default_colors_chess:ButtonToggleFlxState;
	

	private var _text_background_brightness:FlxText;
	
	/******************************
	 * this is the "Output" text displayed beside the button that shows the example, a sample of, the button's fill, border and text color.
	 */
	private var _question_button_colors_output:FlxText;
	
	/******************************
	 * this is the "Configuration Menu: " for the title text that a scene can add to. when clicking a button at the SceneMenu, the scene name will append to this var. for example, "Configuration Menu: Avatars.".
	 */
	private var _text_for_title:String = "Configuration Menu: ";
	private var _house_feature_question:FlxText;
	private var _button_house_feature_enabled:ButtonGeneralNetworkNo;
	private var _button_save_goto_lobby_enabled:ButtonGeneralNetworkNo;
	private var _button_gameboard_border_minus:ButtonGeneralNetworkNo;
	private var _button_gameboard_border_enabled:ButtonGeneralNetworkNo;
	private var _button_gameboard_coordinates_enabled:ButtonGeneralNetworkNo;
	private var _button_send_automatic_start_game_request:ButtonGeneralNetworkNo;
	private var _button_start_game_offline_confirmation:ButtonGeneralNetworkNo;
	private var _button_accept_automatic_start_game_request:ButtonGeneralNetworkNo;
	private var _button_to_lobby_waiting_room_confirmation:ButtonGeneralNetworkNo;
	private var _button_to_lobby_game_room_confirmation:ButtonGeneralNetworkNo;
	private var _button_to_game_room_confirmation:ButtonGeneralNetworkNo;
	private var _button_to_title_confirmation:ButtonGeneralNetworkNo;
	private var _button_chat_turn_off_for_lobby:ButtonGeneralNetworkNo;
	private var _button_chat_turn_off_when_in_room:ButtonGeneralNetworkNo;
	private var _button_move_timer:ButtonGeneralNetworkNo;
	private var _button_move_total:ButtonGeneralNetworkNo;
	private var _button_notation_panel_enabled:ButtonGeneralNetworkNo;
	private var _button_notation_panel_alpha_apply:ButtonGeneralNetworkNo;
	private var _button_units_even_gameboard_show:ButtonGeneralNetworkNo;
	private var _button_game_room_background_enabled:ButtonGeneralNetworkNo;
	private var _button_game_room_background_alpha_enabled:ButtonGeneralNetworkNo;
	private var _button_game_show_capturing_units:ButtonGeneralNetworkNo;
	private var _button_background_brightness_minus:ButtonGeneralNetworkNo;
	private var _button_background_brightness_plus:ButtonGeneralNetworkNo;
	private var _button_color:ButtonGeneralNetworkNo;
	private var _button_border_color:ButtonGeneralNetworkNo;
	private var _button_text_color:ButtonGeneralNetworkNo;
	private var _button_color_output:ButtonGeneralNetworkNo;
	
	private var __menu_configurations_output:MenuConfigurationsOutput;
	
	/******************************
	 * this is the value of a toggle button clicked. 0:checkers. 1:chess, etc.
	 */
	public static var _num:Int = 0;
	
	override public function new(menu_configurations_output:MenuConfigurationsOutput):Void
	{
		super();
		
		_num = 0;
		__menu_configurations_output = menu_configurations_output;
		
		sceneGeneral();		
		
		if (RegCustom._units_even_gameboard_show == false)
			_sprite_board_game_unit_even.alpha = 0;
		else
			_sprite_board_game_unit_even.alpha = 1;
	}
	
	public function sceneGeneral():Void
	{
		// reset this var here because it is used before playing a game to set _num value at this class so that the game board colors are set the the game selected.
		Reg._gameId = 0;
		_num = 0;
		
		_group = cast add(new FlxSpriteGroup());
		_group_button.splice(0, _group_button.length);
		
		var _title_sub = new FlxText(0, 100, 0, "Gameboard");
		_title_sub.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.ORANGE);
		_title_sub.screenCenter(X);
		_group.add(_title_sub);
		
		
		//############################# checkers and chess default board colors.
		var _default_colors_title = new FlxText(0, 0, 0, "Gameboard Colors");
		_default_colors_title.setFormat(Reg._fontDefault, Reg._font_size);
		_default_colors_title.setPosition((FlxG.width / 2) + (FlxG.width / 4) - (_default_colors_title.fieldWidth / 2) + _offset_x, 100 + _offset_y + _offset);
		_group.add(_default_colors_title);
		
		_button_default_colors_checkers = new ButtonToggleFlxState(_default_colors_title.x + (_default_colors_title.fieldWidth / 2) - 200 - 7, _default_colors_title.y + 50 - 3, 1, "Checkers", 200, 35, Reg._font_size, RegCustom._button_text_color, 0, defaultColorsCheckers, RegCustom._button_color);
		_button_default_colors_checkers.label.font = Reg._fontDefault;
		_button_default_colors_checkers.set_toggled(true);
		_button_default_colors_checkers.has_toggle = true;
		_group.add(_button_default_colors_checkers);
		
		_button_default_colors_chess = new ButtonToggleFlxState(_default_colors_title.x + (_default_colors_title.fieldWidth / 2) + 7, _default_colors_title.y + 50 - 3, 2, "Chess", 200, 35, Reg._font_size, RegCustom._button_text_color, 0, defaultColorsChess, RegCustom._button_color);
		_button_default_colors_chess.label.font = Reg._fontDefault;
		_button_default_colors_chess.set_toggled(false);
		_button_default_colors_chess.has_toggle = false;	
		_group.add(_button_default_colors_chess);
		
		// title text for odd and even units.
		_text_title_odd_units = new FlxText(0, 0, 0, "Odd Units");
		_text_title_odd_units.setFormat(Reg._fontDefault, Reg._font_size);
		_text_title_odd_units.setPosition((FlxG.width / 2) + (FlxG.width / 4) - (_text_title_odd_units.fieldWidth / 2) + _offset_x, _button_default_colors_chess.y + 75);
		_group.add(_text_title_odd_units);	
		
		//-----------------------------
		
		// color applied to a shaded unit.
		_text_odd_units_shader = new FlxText(0, 0, 0, "Shader");
		_text_odd_units_shader.setFormat(Reg._fontDefault, Reg._font_size);
		_text_odd_units_shader.setPosition((_text_title_odd_units.x + _text_title_odd_units.fieldWidth / 2) - 225, _text_title_odd_units.y + 50);
		_group.add(_text_odd_units_shader);	
		
		_text_title_even_units = new FlxText(0, 0, 0, "Even Units");
		_text_title_even_units.setFormat(Reg._fontDefault, Reg._font_size);
		_text_title_even_units.setPosition((FlxG.width / 2) + (FlxG.width / 4) - (_text_title_even_units.fieldWidth / 2) + _offset_x, _text_odd_units_shader.y + 55);
		_group.add(_text_title_even_units);	
		
		_text_even_units_shader = new FlxText(0, 0, 0, "Shader");
		_text_even_units_shader.setFormat(Reg._fontDefault, Reg._font_size);
		_text_even_units_shader.setPosition((_text_title_even_units.x + _text_title_even_units.fieldWidth / 2) - 225, _text_title_even_units.y + 50);
		_group.add(_text_even_units_shader);	
		
		//############################# plus and minus buttons for shade images of odd units.	
		_button_shader_odd_units_minus = new ButtonGeneralNetworkNo(_text_odd_units_shader.x + _text_odd_units_shader.fieldWidth + 15, _text_odd_units_shader.y - 3, "-", 35, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_button_shader_odd_units_minus.label.font = Reg._fontDefault;
		_button_shader_odd_units_minus.visible = false;
		
		_group_button.push(_button_shader_odd_units_minus);
		_group.add(_group_button[0]);		
		
		_button_shader_odd_units_plus = new ButtonGeneralNetworkNo(_button_shader_odd_units_minus.x + _button_shader_odd_units_minus.label.fieldWidth + 15, _text_odd_units_shader.y - 3, "+", 35, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_button_shader_odd_units_plus.label.font = Reg._fontDefault;
		_button_shader_odd_units_plus.visible = false;	
		
		_group_button.push(_button_shader_odd_units_plus);
		_group.add(_group_button[1]);
		
		//############################# even buttons for shade images
		_button_shader_even_units_minus = new ButtonGeneralNetworkNo(_text_even_units_shader.x + _text_even_units_shader.fieldWidth + 15, _text_even_units_shader.y - 3, "-", 35, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_button_shader_even_units_minus.label.font = Reg._fontDefault;
		_button_shader_even_units_minus.visible = false;
		
		_group_button.push(_button_shader_even_units_minus);
		_group.add(_group_button[2]);
		
		_button_shader_even_units_plus = new ButtonGeneralNetworkNo(_button_shader_even_units_minus.x + _button_shader_even_units_minus.label.fieldWidth + 15, _text_even_units_shader.y - 3, "+", 35, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_button_shader_even_units_plus.label.font = Reg._fontDefault;
		_button_shader_even_units_plus.visible = false;	
		
		_group_button.push(_button_shader_even_units_plus);
		_group.add(_group_button[3]);
		
		//############################# color applied to a shaded units.
		_text_odd_units_color = new FlxText(0, 0, 0, "Color");
		_text_odd_units_color.setFormat(Reg._fontDefault, Reg._font_size);
		_text_odd_units_color.setPosition((_text_title_odd_units.x + _text_title_odd_units.fieldWidth / 2) + 40, _text_title_odd_units.y + 50);
		_group.add(_text_odd_units_color);	
		
		_text_even_units_color = new FlxText(0, 0, 0, "Color");
		_text_even_units_color.setFormat(Reg._fontDefault, Reg._font_size);
		_text_even_units_color.setPosition((_text_title_even_units.x + _text_title_even_units.fieldWidth / 2) + 40, _text_title_even_units.y + 50);
		_group.add(_text_even_units_color);		
		
		//############################# plus and minus buttons for color of odd units.	
		_button_color_odd_units_minus = new ButtonGeneralNetworkNo(_text_odd_units_color.x + _text_odd_units_color.fieldWidth + 15, _text_odd_units_color.y - 3, "-", 35, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_button_color_odd_units_minus.label.font = Reg._fontDefault;
		_button_color_odd_units_minus.visible = false;
		
		_group_button.push(_button_color_odd_units_minus);
		_group.add(_group_button[4]);
		
		_button_color_odd_units_plus = new ButtonGeneralNetworkNo(_button_color_odd_units_minus.x + _button_color_odd_units_minus.label.fieldWidth + 15, _text_odd_units_color.y - 3, "+", 35, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_button_color_odd_units_plus.label.font = Reg._fontDefault;
		_button_color_odd_units_plus.visible = false;
		
		_group_button.push(_button_color_odd_units_plus);
		_group.add(_group_button[5]);
		
		_button_color_even_units_minus = new ButtonGeneralNetworkNo(_text_even_units_color.x + _text_even_units_color.fieldWidth + 15, _text_even_units_color.y - 3, "-", 35, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_button_color_even_units_minus.label.font = Reg._fontDefault;
		_button_color_even_units_minus.visible = false;
		
		_group_button.push(_button_color_even_units_minus);
		_group.add(_group_button[6]);
		
		_button_color_even_units_plus = new ButtonGeneralNetworkNo(_button_color_even_units_minus.x + _button_color_even_units_minus.label.fieldWidth + 15, _text_even_units_color.y - 3, "+", 35, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_button_color_even_units_plus.label.font = Reg._fontDefault;
		_button_color_even_units_plus.visible = false;
		
		_group_button.push(_button_color_even_units_plus);
		_group.add(_group_button[7]);
		
		//-----------------------
		_gameboard_border_title = new FlxText(0, 0, 0, "Gameboard Border Colors");
		_gameboard_border_title.setFormat(Reg._fontDefault, Reg._font_size);
		_gameboard_border_title.setPosition((FlxG.width / 2) + (FlxG.width / 4) - (_gameboard_border_title.fieldWidth / 2) + _offset_x, _button_color_even_units_plus.y + 100);
		_gameboard_border_title.x -= 35;
		_group.add(_gameboard_border_title);
		
		_button_gameboard_border_minus = new ButtonGeneralNetworkNo(_gameboard_border_title.x + _gameboard_border_title.fieldWidth + 15, _gameboard_border_title.y - 3, "-", 35, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_button_gameboard_border_minus.label.font = Reg._fontDefault;
		_button_gameboard_border_minus.visible = false;
		
		_group_button.push(_button_gameboard_border_minus);
		_group.add(_group_button[8]);
		
		var _button_gameboard_border_plus = new ButtonGeneralNetworkNo(_gameboard_border_title.x + _gameboard_border_title.fieldWidth + 15 + 50, _gameboard_border_title.y - 3, "+", 35, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_button_gameboard_border_plus.label.font = Reg._fontDefault;
		_button_gameboard_border_plus.visible = false;
		
		_group_button.push(_button_gameboard_border_plus);
		_group.add(_group_button[9]);
		
		
		//--------------- sprites
		_sprite_board_game_unit_even = new FlxSprite(0, 0, "assets/images/scenes/tiles/even/"+ RegCustom._units_even_spr_num[0] +".png");
		_sprite_board_game_unit_even.setPosition(80, 105 + _offset);
		_sprite_board_game_unit_even.scale.set(0.8, 0.8);
		_group.add(_sprite_board_game_unit_even);
		_sprite_board_game_unit_even.color = colorToggleUnitsEven();
		_sprite_board_game_unit_even.alpha = 0;
		
		_sprite_board_game_unit_odd = new FlxSprite(0, 0, "assets/images/scenes/tiles/odd/"+ Std.string(RegCustom._units_odd_spr_num[0]) +".png");
		_sprite_board_game_unit_odd.setPosition(80, 105 + _offset);
		_sprite_board_game_unit_odd.scale.set(0.8, 0.8);
		_group.add(_sprite_board_game_unit_odd);
		_sprite_board_game_unit_odd.color = colorToggleUnitsOdd();	
		
		_sprite_gameboard_border = new FlxSprite(0, 0, "assets/images/gameboardBorder"+ RegCustom._gameboardBorder_num +".png");
		_sprite_gameboard_border.setPosition(50, 105 + _offset - 30);
		_sprite_gameboard_border.scale.set(0.8, 0.8);
		if (RegCustom._gameboard_border_enabled == false)
			_sprite_gameboard_border.alpha = 0;
		_group.add(_sprite_gameboard_border);
		
		_sprite_gameboard_coordinates = new FlxSprite(0, 0, "assets/images/coordinates.png");
		_sprite_gameboard_coordinates.setPosition(50, 105 + _offset - 30);
		_sprite_gameboard_coordinates.scale.set(0.8, 0.8);
		if (RegCustom._gameboard_coordinates_enabled == false) _sprite_gameboard_coordinates.alpha = 0;
		_group.add(_sprite_gameboard_coordinates);
		
		var _question_gameboard_border_enabled = new FlxText(15, 0, 0, "Show border?");
		_question_gameboard_border_enabled.setFormat(Reg._fontDefault, Reg._font_size);
		_question_gameboard_border_enabled.x = _gameboard_border_title.x;
		_question_gameboard_border_enabled.y = _button_gameboard_border_plus.height + _button_gameboard_border_plus.y + 40;
		_group.add(_question_gameboard_border_enabled);
		
		_button_gameboard_border_enabled = new ButtonGeneralNetworkNo(_question_gameboard_border_enabled.x + _question_gameboard_border_enabled.width + 15, _question_gameboard_border_enabled.y - 8, "", 100, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_button_gameboard_border_enabled.label.font = Reg._fontDefault;
		_button_gameboard_border_enabled.label.text = Std.string(RegCustom._gameboard_border_enabled);
		
		_group_button.push(_button_gameboard_border_enabled);
		_group.add(_group_button[10]);
		
		var _question_gameboard_coordinates_enabled = new FlxText(15, 0, 0, "Show coordinates?");
		_question_gameboard_coordinates_enabled.setFormat(Reg._fontDefault, Reg._font_size);
		_question_gameboard_coordinates_enabled.x = _gameboard_border_title.x;
		_question_gameboard_coordinates_enabled.y = _button_gameboard_border_enabled.height + _button_gameboard_border_enabled.y + 40;
		_group.add(_question_gameboard_coordinates_enabled);
		
		_button_gameboard_coordinates_enabled = new ButtonGeneralNetworkNo(_question_gameboard_coordinates_enabled.x + _question_gameboard_coordinates_enabled.width + 15, _question_gameboard_coordinates_enabled.y - 8, "", 100, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_button_gameboard_coordinates_enabled.label.font = Reg._fontDefault;
		_button_gameboard_coordinates_enabled.label.text = Std.string(RegCustom._gameboard_coordinates_enabled);
		
		_group_button.push(_button_gameboard_coordinates_enabled);
		_group.add(_group_button[11]);
		
		var _question_notation_panel_alpha_apply = new FlxText(15, 0, 0, "Apply 40% transparency to the notation panel?");
		_question_notation_panel_alpha_apply.setFormat(Reg._fontDefault, Reg._font_size);
		_question_notation_panel_alpha_apply.y = _button_gameboard_coordinates_enabled.height + _button_gameboard_coordinates_enabled.y + 100;
		_group.add(_question_notation_panel_alpha_apply);
		
		_button_notation_panel_alpha_apply = new ButtonGeneralNetworkNo(_question_notation_panel_alpha_apply.width + 30, _question_notation_panel_alpha_apply.y - 8, "", 100, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_button_notation_panel_alpha_apply.label.font = Reg._fontDefault;
		_button_notation_panel_alpha_apply.label.text = Std.string(RegCustom._notation_panel_alpha_apply);
		
		_group_button.push(_button_notation_panel_alpha_apply);
		_group.add(_group_button[12]);
		
		var _question_units_even_gameboard_show = new FlxText(15, 0, 0, "Show even gameboard units?");
		_question_units_even_gameboard_show.setFormat(Reg._fontDefault, Reg._font_size);
		_question_units_even_gameboard_show.y = _question_notation_panel_alpha_apply.height + _question_notation_panel_alpha_apply.y + 40;
		_group.add(_question_units_even_gameboard_show);
		
		_button_units_even_gameboard_show = new ButtonGeneralNetworkNo(_question_units_even_gameboard_show.width + 30, _question_units_even_gameboard_show.y - 8, "", 100, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_button_units_even_gameboard_show.label.font = Reg._fontDefault;
		_button_units_even_gameboard_show.label.text = Std.string(RegCustom._units_even_gameboard_show);
		
		_group_button.push(_button_units_even_gameboard_show);
		_group.add(_group_button[13]);
		
		//----------------------------
		var _question_game_room_background_enabled = new FlxText(15, 0, 0, "Display a gameboard background?");
		_question_game_room_background_enabled.setFormat(Reg._fontDefault, Reg._font_size);
		_question_game_room_background_enabled.y = _question_units_even_gameboard_show.height + _question_units_even_gameboard_show.y + 40;
		_group.add(_question_game_room_background_enabled);
		
		_button_game_room_background_enabled = new ButtonGeneralNetworkNo(_question_game_room_background_enabled.width + 30, _question_game_room_background_enabled.y - 8, "", 100, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_button_game_room_background_enabled.label.font = Reg._fontDefault;
		_button_game_room_background_enabled.label.text = Std.string(RegCustom._game_room_background_enabled);
		_button_game_room_background_enabled.visible = false;
		
		_group_button.push(_button_game_room_background_enabled);
		_group.add(_group_button[14]);
		
		_button_game_room_minus = new ButtonGeneralNetworkNo(_button_game_room_background_enabled.x + _button_game_room_background_enabled.width + 15, _button_game_room_background_enabled.y + 7, "-", 35, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_button_game_room_minus.label.font = Reg._fontDefault;
	
		_group_button.push(_button_game_room_minus);
		_group.add(_group_button[15]);		
		
		_button_game_room_plus = new ButtonGeneralNetworkNo(_button_game_room_minus.x + _button_game_room_minus.label.fieldWidth + 15, _button_game_room_background_enabled.y + 7, "+", 35, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_button_game_room_plus.label.font = Reg._fontDefault;
		
		_group_button.push(_button_game_room_plus);
		_group.add(_group_button[16]);
		
		_sprite_game_room_image = new FlxSprite(_question_game_room_background_enabled.width + 350, _question_game_room_background_enabled.y - _question_game_room_background_enabled.height - 30, "assets/images/gameboardBackground" + Std.string(RegCustom._game_room_background_image_number) + "b.jpg");
		if (RegCustom._game_room_background_enabled == false)
			_sprite_game_room_image.alpha = 0;
		_group.add(_sprite_game_room_image);
	
		var _question_game_room_background_alpha_enabled = new FlxText(15, 0, 0, "Apply a 75% transparency to the gameboard background?");
		_question_game_room_background_alpha_enabled.setFormat(Reg._fontDefault, Reg._font_size);
		_question_game_room_background_alpha_enabled.y = _question_game_room_background_enabled.height + _question_game_room_background_enabled.y + 110;
		_group.add(_question_game_room_background_alpha_enabled);
		
		_button_game_room_background_alpha_enabled = new ButtonGeneralNetworkNo(_question_game_room_background_alpha_enabled.width + 30, _question_game_room_background_alpha_enabled.y - 8, "", 100, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_button_game_room_background_alpha_enabled.label.font = Reg._fontDefault;
		_button_game_room_background_alpha_enabled.label.text = Std.string(RegCustom._game_room_background_alpha_enabled);
		_button_game_room_background_alpha_enabled.visible = false;
		
		_group_button.push(_button_game_room_background_alpha_enabled);
		_group.add(_group_button[17]);
		
		//----------------------------
		_leaderboard_question = new FlxText(15, 0, 0, "Show leading competitors in various game statistics? (leaderboard.)");
		_leaderboard_question.setFormat(Reg._fontDefault, Reg._font_size);
		_leaderboard_question.y = _question_game_room_background_alpha_enabled.height + _question_game_room_background_alpha_enabled.y + 40;
		_group.add(_leaderboard_question);
		
		_button_leaderboard_enabled = new ButtonGeneralNetworkNo(_leaderboard_question.width + 30, _leaderboard_question.y - 8, "", 100, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_button_leaderboard_enabled.label.font = Reg._fontDefault;
		_button_leaderboard_enabled.label.text = Std.string(RegCustom._config_leaderboard_enabled);
		_button_leaderboard_enabled.visible = false;
		
		_group_button.push(_button_leaderboard_enabled);
		_group.add(_group_button[18]);
		
		_house_feature_question = new FlxText(15, 0, 0, "Enable the house side game?");
		_house_feature_question.setFormat(Reg._fontDefault, Reg._font_size);
		_house_feature_question.y = _button_leaderboard_enabled.height + _button_leaderboard_enabled.y + 40;
		_group.add(_house_feature_question);
		
		_button_house_feature_enabled = new ButtonGeneralNetworkNo(_house_feature_question.width + 30, _house_feature_question.y - 8, "", 100, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_button_house_feature_enabled.label.font = Reg._fontDefault;
		_button_house_feature_enabled.label.text = Std.string(RegCustom._config_house_feature_enabled);
		_button_house_feature_enabled.visible = false;
		
		_group_button.push(_button_house_feature_enabled);
		_group.add(_group_button[19]);
		
		var _save_goto_lobby_question = new FlxText(15, 0, 0, "Go back to the title scene after these configuration options are saved?");
		_save_goto_lobby_question.setFormat(Reg._fontDefault, Reg._font_size);
		_save_goto_lobby_question.y = _button_house_feature_enabled.height + _button_house_feature_enabled.y + 40;
		_group.add(_save_goto_lobby_question);
		
		_button_save_goto_lobby_enabled = new ButtonGeneralNetworkNo(_save_goto_lobby_question.width + 30, _save_goto_lobby_question.y - 8, "", 100, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_button_save_goto_lobby_enabled.label.font = Reg._fontDefault;
		_button_save_goto_lobby_enabled.label.text = Std.string(RegCustom._config_save_goto_lobby_enabled);
		_button_save_goto_lobby_enabled.visible = false;
		
		_group_button.push(_button_save_goto_lobby_enabled);
		_group.add(_group_button[20]);
		//----------------------------- start game request when host enters room?
		
		var _save_start_game_request_question = new FlxText(15, 0, FlxG.width-200, "Should host of the room automatically send a start game request to other player(s) after entering the game room?");
		_save_start_game_request_question.setFormat(Reg._fontDefault, Reg._font_size);
		_save_start_game_request_question.y = _button_save_goto_lobby_enabled.height + _button_save_goto_lobby_enabled.y + 40;
		_group.add(_save_start_game_request_question);
		
		_button_send_automatic_start_game_request = new ButtonGeneralNetworkNo(FlxG.width-200 - 20, _save_start_game_request_question.y + 8, "", 100, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_button_send_automatic_start_game_request.label.font = Reg._fontDefault;
		_button_send_automatic_start_game_request.label.text = Std.string(RegCustom._send_automatic_start_game_request);
		_button_send_automatic_start_game_request.visible = false;
		
		_group_button.push(_button_send_automatic_start_game_request);
		_group.add(_group_button[21]);
		
		var _question_start_game_offline_confirmation = new FlxText(15, 0, 0, "Start a game in offline mode without confirmation?");
		_question_start_game_offline_confirmation.setFormat(Reg._fontDefault, Reg._font_size);
		_question_start_game_offline_confirmation.y = _button_send_automatic_start_game_request.height + 15 + _button_send_automatic_start_game_request.y + 40;
		_group.add(_question_start_game_offline_confirmation);
		
		_button_start_game_offline_confirmation = new ButtonGeneralNetworkNo(_question_start_game_offline_confirmation.width + 30, _question_start_game_offline_confirmation.y - 8, "", 100, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_button_start_game_offline_confirmation.label.font = Reg._fontDefault;
		_button_start_game_offline_confirmation.label.text = Std.string(RegCustom._start_game_offline_confirmation);
		_button_start_game_offline_confirmation.visible = false;
		
		_group_button.push(_button_start_game_offline_confirmation);
		_group.add(_group_button[22]);
		
		var _question_accept_start_game_request = new FlxText(15, 0, 0, "Automatically accept a start game request after entering the game room?");
		_question_accept_start_game_request.setFormat(Reg._fontDefault, Reg._font_size);
		_question_accept_start_game_request.y = _button_start_game_offline_confirmation.height + _button_start_game_offline_confirmation.y + 40;
		_group.add(_question_accept_start_game_request);
		
		_button_accept_automatic_start_game_request = new ButtonGeneralNetworkNo(_question_accept_start_game_request.width + 30, _question_accept_start_game_request.y - 8, "", 100, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_button_accept_automatic_start_game_request.label.font = Reg._fontDefault;
		_button_accept_automatic_start_game_request.label.text = Std.string(RegCustom._accept_automatic_start_game_request);
		_button_accept_automatic_start_game_request.visible = false;
		
		_group_button.push(_button_accept_automatic_start_game_request);
		_group.add(_group_button[23]);
			
		var _question_to_lobby_waiting_room_confirmation = new FlxText(15, 0, 0, "At waiting room do you need confirmation before returning to lobby?");
		_question_to_lobby_waiting_room_confirmation.setFormat(Reg._fontDefault, Reg._font_size);
		_question_to_lobby_waiting_room_confirmation.y = _button_accept_automatic_start_game_request.height + _button_accept_automatic_start_game_request.y + 40;
		_group.add(_question_to_lobby_waiting_room_confirmation);
		
		_button_to_lobby_waiting_room_confirmation = new ButtonGeneralNetworkNo(_question_to_lobby_waiting_room_confirmation.width + 30, _question_to_lobby_waiting_room_confirmation.y - 8, "", 100, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_button_to_lobby_waiting_room_confirmation.label.font = Reg._fontDefault;
		_button_to_lobby_waiting_room_confirmation.label.text = Std.string(RegCustom._to_lobby_waiting_room_confirmation);
		_button_to_lobby_waiting_room_confirmation.visible = false;
		
		_group_button.push(_button_to_lobby_waiting_room_confirmation);
		_group.add(_group_button[24]);
		
		var _question_to_lobby_game_room_confirmation = new FlxText(15, 0, 0, "At game room do you need confirmation before returning to lobby?");
		_question_to_lobby_game_room_confirmation.setFormat(Reg._fontDefault, Reg._font_size);
		_question_to_lobby_game_room_confirmation.y = _button_to_lobby_waiting_room_confirmation.height + _button_to_lobby_waiting_room_confirmation.y + 40;
		_group.add(_question_to_lobby_game_room_confirmation);
		
		_button_to_lobby_game_room_confirmation = new ButtonGeneralNetworkNo(_question_to_lobby_game_room_confirmation.width + 30, _question_to_lobby_game_room_confirmation.y - 8, "", 100, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_button_to_lobby_game_room_confirmation.label.font = Reg._fontDefault;
		_button_to_lobby_game_room_confirmation.label.text = Std.string(RegCustom._to_lobby_game_room_confirmation);
		_button_to_lobby_game_room_confirmation.visible = false;
		
		_group_button.push(_button_to_lobby_game_room_confirmation);
		_group.add(_group_button[25]);
				
		var _question_to_game_room_confirmation = new FlxText(15, 0, 0, "At waiting room do you need confirmation before returning to game room?");
		_question_to_game_room_confirmation.setFormat(Reg._fontDefault, Reg._font_size);
		_question_to_game_room_confirmation.y = _button_to_lobby_game_room_confirmation.height + _button_to_lobby_game_room_confirmation.y + 40;
		_group.add(_question_to_game_room_confirmation);
		
		_button_to_game_room_confirmation = new ButtonGeneralNetworkNo(_question_to_game_room_confirmation.width + 30, _question_to_game_room_confirmation.y - 8, "", 100, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_button_to_game_room_confirmation.label.font = Reg._fontDefault;
		_button_to_game_room_confirmation.label.text = Std.string(RegCustom._to_game_room_confirmation);
		_button_to_game_room_confirmation.visible = false;
		
		_group_button.push(_button_to_game_room_confirmation);
		_group.add(_group_button[26]);
		
		var _question_to_title_confirmation = new FlxText(15, 0, 0, "Do you need confirmation before returning to title?");
		_question_to_title_confirmation.setFormat(Reg._fontDefault, Reg._font_size);
		_question_to_title_confirmation.y = _button_to_game_room_confirmation.height + _button_to_game_room_confirmation.y + 40;
		_group.add(_question_to_title_confirmation);
		
		_button_to_title_confirmation = new ButtonGeneralNetworkNo(_question_to_title_confirmation.width + 30, _question_to_title_confirmation.y - 8, "", 100, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_button_to_title_confirmation.label.font = Reg._fontDefault;
		_button_to_title_confirmation.label.text = Std.string(RegCustom._to_title_confirmation);
		_button_to_title_confirmation.visible = false;
		
		_group_button.push(_button_to_title_confirmation);
		_group.add(_group_button[27]);
		
		var _question_chat_turn_off_for_lobby = new FlxText(15, 0, 0, "Turn off chat when at lobby?");
		_question_chat_turn_off_for_lobby.setFormat(Reg._fontDefault, Reg._font_size);
		_question_chat_turn_off_for_lobby.y = _button_to_title_confirmation.height + _button_to_title_confirmation.y + 40;
		_group.add(_question_chat_turn_off_for_lobby);
		
		_button_chat_turn_off_for_lobby = new ButtonGeneralNetworkNo(_question_chat_turn_off_for_lobby.width + 30, _question_chat_turn_off_for_lobby.y - 8, "", 100, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_button_chat_turn_off_for_lobby.label.font = Reg._fontDefault;
		_button_chat_turn_off_for_lobby.label.text = Std.string(RegCustom._chat_turn_off_for_lobby);
		_button_chat_turn_off_for_lobby.visible = false;
		
		_group_button.push(_button_chat_turn_off_for_lobby);
		_group.add(_group_button[28]);
		
		var _question_chat_turn_off_for_room = new FlxText(15, 0, 0, "Turn off chat when at any room?");
		_question_chat_turn_off_for_room.setFormat(Reg._fontDefault, Reg._font_size);
		_question_chat_turn_off_for_room.y = _button_chat_turn_off_for_lobby.height + _button_chat_turn_off_for_lobby.y + 40;
		_group.add(_question_chat_turn_off_for_room);
		
		_button_chat_turn_off_when_in_room = new ButtonGeneralNetworkNo(_question_chat_turn_off_for_room.width + 30, _question_chat_turn_off_for_room.y - 8, "", 100, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_button_chat_turn_off_when_in_room.label.font = Reg._fontDefault;
		_button_chat_turn_off_when_in_room.label.text = Std.string(RegCustom._chat_turn_off_when_in_room);
		_button_chat_turn_off_when_in_room.visible = false;
		
		_group_button.push(_button_chat_turn_off_when_in_room);
		_group.add(_group_button[29]);
				
		var _question_move_timer = new FlxText(15, 0, FlxG.width-240, "Enable the player's piece move timer? Note: tournament play ignores this feature.");
		_question_move_timer.setFormat(Reg._fontDefault, Reg._font_size);
		_question_move_timer.y = _button_chat_turn_off_when_in_room.height + _button_chat_turn_off_when_in_room.y + 40;
		_group.add(_question_move_timer);
		
		_button_move_timer = new ButtonGeneralNetworkNo(_question_move_timer.width + 10, _question_move_timer.y - 8, "", 100, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_button_move_timer.label.font = Reg._fontDefault;
		_button_move_timer.label.text = Std.string(RegCustom._move_timer_enable);
		
		_group_button.push(_button_move_timer);
		_group.add(_group_button[30]);
				
		var _question_move_total = new FlxText(15, 0, 0, "Display the player's move total text?");
		_question_move_total.setFormat(Reg._fontDefault, Reg._font_size);
		_question_move_total.y = _button_move_timer.height + _button_move_timer.y + 40;
		_group.add(_question_move_total);
		
		_button_move_total = new ButtonGeneralNetworkNo(_question_move_total.width + 30, _question_move_total.y - 8, "", 100, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_button_move_total.label.font = Reg._fontDefault;
		_button_move_total.label.text = Std.string(RegCustom._move_total_enable);
		
		_group_button.push(_button_move_total);
		_group.add(_group_button[31]);
		
		var _question_notation_panel_enabled = new FlxText(15, 0, 0, "Display the notation panel?");
		_question_notation_panel_enabled.setFormat(Reg._fontDefault, Reg._font_size);
		_question_notation_panel_enabled.y = _button_move_total.height + _button_move_total.y + 40;
		_group.add(_question_notation_panel_enabled);
		
		_button_notation_panel_enabled = new ButtonGeneralNetworkNo(_question_notation_panel_enabled.width + 30, _question_notation_panel_enabled.y - 8, "", 100, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_button_notation_panel_enabled.label.font = Reg._fontDefault;
		_button_notation_panel_enabled.label.text = Std.string(RegCustom._notation_panel_enabled);
		
		_group_button.push(_button_notation_panel_enabled);
		_group.add(_group_button[32]);
		
		var _question_game_show_capturing_units = new FlxText(15, 0, 0, "Display legal moves (capturing units)?");
		_question_game_show_capturing_units.setFormat(Reg._fontDefault, Reg._font_size);
		_question_game_show_capturing_units.y = _button_notation_panel_enabled.height + _button_notation_panel_enabled.y + 40;
		_group.add(_question_game_show_capturing_units);
		
		_button_game_show_capturing_units = new ButtonGeneralNetworkNo(_question_game_show_capturing_units.width + 30, _question_game_show_capturing_units.y - 8, "", 100, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_button_game_show_capturing_units.label.font = Reg._fontDefault;
		_button_game_show_capturing_units.label.text = Std.string(RegCustom._game_show_capturing_units);
		
		_group_button.push(_button_game_show_capturing_units);
		_group.add(_group_button[33]);
		
		_button_game_show_capturing_units_minus = new ButtonGeneralNetworkNo(_button_game_show_capturing_units.x + _button_game_show_capturing_units.width + 15, _button_game_show_capturing_units.y + 7, "-", 35, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_button_game_show_capturing_units_minus.label.font = Reg._fontDefault;
	
		_group_button.push(_button_game_show_capturing_units_minus);
		_group.add(_group_button[34]);		
		
		_button_game_show_capturing_units_plus = new ButtonGeneralNetworkNo(_button_game_show_capturing_units_minus.x + _button_game_show_capturing_units_minus.label.fieldWidth + 15, _button_game_show_capturing_units_minus.y + 7, "+", 35, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_button_game_show_capturing_units_plus.label.font = Reg._fontDefault;
		
		_group_button.push(_button_game_show_capturing_units_plus);
		_group.add(_group_button[35]);
		
		_sprite_game_show_capturing_units_number = new FlxSprite(_button_game_show_capturing_units_plus.x + _button_game_show_capturing_units_plus.width + 45, _button_game_show_capturing_units_plus.y - 14);
		_sprite_game_show_capturing_units_number.loadGraphic("assets/images/capturingUnits.png", false, 75, 75);
		_sprite_game_show_capturing_units_number.color = RegFunctions.color_game_show_capturing_units();
		_group.add(_sprite_game_show_capturing_units_number);
		
		var _sprite_chess_path_to_king_bg = new FlxSprite(_button_game_show_capturing_units_plus.x + _button_game_show_capturing_units_plus.width + 45, _button_game_show_capturing_units_plus.y - 14, "assets/images/dailyQuestsBorder1.png");
		_group.add(_sprite_chess_path_to_king_bg);
		
		//-----------------------------
		var _question_background_brightness = new FlxText(15, 0, 0, "Background brightness? 0 is black. 1 is full bright.");
		_question_background_brightness.setFormat(Reg._fontDefault, Reg._font_size);
		_question_background_brightness.y = _button_game_show_capturing_units.height + _button_game_show_capturing_units.y + 60;
		_group.add(_question_background_brightness);
		
		// y - 7 is needed here.
		_button_background_brightness_minus = new ButtonGeneralNetworkNo(_question_background_brightness.x + _question_background_brightness.width + 15, _question_background_brightness.y - 7, "-", 35, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_button_background_brightness_minus.label.font = Reg._fontDefault;
	
		_group_button.push(_button_background_brightness_minus);
		_group.add(_group_button[36]);		
		
		_button_background_brightness_plus = new ButtonGeneralNetworkNo(_button_background_brightness_minus.x + _button_background_brightness_minus.label.fieldWidth + 15, _button_background_brightness_minus.y + 7, "+", 35, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_button_background_brightness_plus.label.font = Reg._fontDefault;
		
		_group_button.push(_button_background_brightness_plus);
		_group.add(_group_button[37]);
		
		_text_background_brightness = new FlxText(_button_background_brightness_plus.x + 50, _question_background_brightness.y, 0, Std.string(RegCustom._background_brightness));
		_text_background_brightness.setFormat(Reg._fontDefault, Reg._font_size);		
		_group.add(_text_background_brightness);
		
		var _question_button_colors = new FlxText(15, 0, 0, "Change the appearance of all client buttons?");
		_question_button_colors.setFormat(Reg._fontDefault, Reg._font_size);
		_question_button_colors.y = _text_background_brightness.height + _text_background_brightness.y + 40;
		_question_button_colors.fieldWidth = 400;
		_group.add(_question_button_colors);
		
		_button_color = new ButtonGeneralNetworkNo(_question_button_colors.x + _question_button_colors.fieldWidth + 15, _question_button_colors.y + 15, "Background", 190, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_button_color.label.font = Reg._fontDefault;
		
		_group_button.push(_button_color);
		_group.add(_group_button[38]);
		
		_button_border_color = new ButtonGeneralNetworkNo(_button_color.x + _button_color.label.fieldWidth + 15, _button_color.y + 7, "Border", 170, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_button_border_color.label.font = Reg._fontDefault;
		
		_group_button.push(_button_border_color);
		_group.add(_group_button[39]);
		
		_button_text_color = new ButtonGeneralNetworkNo(_button_border_color.x + _button_border_color.label.fieldWidth + 15, _button_border_color.y + 7, "Text", 170, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_button_text_color.label.font = Reg._fontDefault;
		
		_group_button.push(_button_text_color);
		_group.add(_group_button[40]);
		
		_question_button_colors_output = new FlxText(_button_text_color.x + _button_text_color.label.fieldWidth + 80, 0, 0, "Output:");
		_question_button_colors_output.setFormat(Reg._fontDefault, Reg._font_size);
		_question_button_colors_output.y = _button_color.y + 7;
		_group.add(_question_button_colors_output);
		
		_button_color_output = new ButtonGeneralNetworkNo(_question_button_colors_output.x + _question_button_colors_output.fieldWidth + 15, _button_border_color.y + 7, "Example", 110, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_button_color_output.label.font = Reg._fontDefault;
		_group.add(_button_color_output);
		
		//-----------------------------
		// DO NOT FORGET TO UPDATE THE buttonNumber() FUNCTiON.
		var _text_empty = new ButtonGeneralNetworkNo(0, _button_background_brightness_minus.y + 250, "", 100, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_text_empty.visible = false;
		_group.add(_text_empty);
		
	}
	
	/******************************
	 * this function is called when a button at this class is clicked.
	 */
	private function buttonNumber(_val:Int = 0):Void
	{
		switch (_val)
		{
			case 0: shaderUnitsOddMinus();
			case 1: shaderUnitsOddPlus();
			case 2: shaderUnitsEvenMinus();
			case 3: shaderUnitsEvenPlus();			
			case 4: colorUnitsOddMinus();
			case 5: colorUnitsOddPlus();
			case 6: colorUnitsEvenMinus();
			case 7: colorUnitsEvenPlus();
			case 8: gameboard_borderMinus();
			case 9: gameboard_borderPlus();
			case 10: save_gameboard_border();
			case 11: save_gameboard_coordinates();
			case 12: save_notation_panel_alpha();
			case 13: save_units_even_gameboard_show();
			case 14: save_game_room_background();
			case 15: save_game_room_background_number_minus();
			case 16: save_game_room_background_number_plus();
			case 17: save_game_room_background_alpha();
			case 18: leaderboardsEnable();
			case 19: houseFeatureEnabled();
			case 20: saveGotoLobby();
			case 21: save_automatic_game_request();
			case 22: save_start_game_offline_confirmation();
			case 23: save_accept_automatic_game_request();
			case 24: save_to_lobby_waiting_room_confirmation();
			case 25: save_to_lobby_game_room_confirmation();
			case 26: save_to_game_room_confirmation();
			case 27: save_to_title_confirmation();
			case 28: save_chat_turn_off_lobby();
			case 29: save_chat_turn_off_room();
			case 30: save_move_timer();
			case 31: save_move_total();
			case 32: save_notation_panel();
			case 33: save_game_show_capturing_units();
			case 34: game_show_capturing_units_minus();
			case 35: game_show_capturing_units_plus();
			case 36: background_brightness_minus();
			case 37: background_brightness_plus();
			case 38: apply_button_background_color();
			case 39: apply_button_border_color();
			case 40: apply_button_text_color();
		}
	}
		
	/******************************
	 * this function is called when a button at this class is clicked.
	 */
	private function buttonNumberToggle():Void
	{
		switch (_num)
		{
			case 0: defaultColorsCheckers();
			case 1:	defaultColorsChess();
			
		}
	}
	
	// minus 1 to display a lesser of a shade for these units.
	private function shaderUnitsOddMinus():Void
	{
		RegCustom._units_odd_spr_num[_num] -= 1;
		if (RegCustom._units_odd_spr_num[_num] == 0) RegCustom._units_odd_spr_num[_num] = 9;
		
		shaderToggleUnitsOdd();
	}
	
	// plus 1 to display a greater of a shade for these units.
	private function shaderUnitsOddPlus():Void
	{
		RegCustom._units_odd_spr_num[_num] += 1;
		if (RegCustom._units_odd_spr_num[_num] == 10) RegCustom._units_odd_spr_num[_num] = 1;
		
		shaderToggleUnitsOdd();
	}
	
	/******************************
	 * this toggles the colors of odd board game units.
	 */
	private function shaderToggleUnitsOdd():Void
	{
		_sprite_board_game_unit_odd.loadGraphic("assets/images/scenes/tiles/odd/" + Std.string(RegCustom._units_odd_spr_num[_num]) + ".png");
	}
	
	// minus 1 to display a lesser of a shade for these units.
	private function shaderUnitsEvenMinus()
	{
		RegCustom._units_even_spr_num[_num] -= 1;
		if (RegCustom._units_even_spr_num[_num] == 0) RegCustom._units_even_spr_num[_num] = 9;
		
		shaderToggleUnitsEven();
	}
	
	// plus 1 to display a greater of a shade for these units.
	private function shaderUnitsEvenPlus()
	{
		RegCustom._units_even_spr_num[_num] += 1;
		if (RegCustom._units_even_spr_num[_num] == 10) RegCustom._units_even_spr_num[_num] = 1;
		
		shaderToggleUnitsEven();
	}
	
	/******************************
	 * this toggles the colors of odd board game units.
	 */
	private function shaderToggleUnitsEven():Void
	{
		_sprite_board_game_unit_even.loadGraphic("assets/images/scenes/tiles/even/" + RegCustom._units_even_spr_num[_num] +".png");
	}	
	
	// minus 1 to display a lesser of a color for these units.
	private function colorUnitsOddMinus()
	{
		RegCustom._units_odd_color_num[_num] -= 1;
		if (RegCustom._units_odd_color_num[_num] == 0) RegCustom._units_odd_color_num[_num] = 40;
		
		_sprite_board_game_unit_odd.color = colorToggleUnitsOdd();
	}
	
	// plus 1 to display a greater of a color for these units.
	private function colorUnitsOddPlus()
	{
		RegCustom._units_odd_color_num[_num] += 1;
		if (RegCustom._units_odd_color_num[_num] == 41) RegCustom._units_odd_color_num[_num] = 1;
		
		_sprite_board_game_unit_odd.color = colorToggleUnitsOdd();
	}	
		
	public static function colorToggleUnitsOdd():FlxColor
	{
		
		var _color:FlxColor = 0xFFFFFFFF;
		
		if (RegCustom._units_odd_color_num[_num] == 1) _color = 0xFF1a1c2c;
		if (RegCustom._units_odd_color_num[_num] == 2) _color = 0xFF5d275d;
		if (RegCustom._units_odd_color_num[_num] == 3) _color = 0xFFcb0025;
		if (RegCustom._units_odd_color_num[_num] == 4) _color = 0xFFef7d57;
		if (RegCustom._units_odd_color_num[_num] == 5) _color = 0xFFffcd75;
		if (RegCustom._units_odd_color_num[_num] == 6) _color = 0xFFa7f070;
		if (RegCustom._units_odd_color_num[_num] == 7) _color = 0xFF38b764;
		if (RegCustom._units_odd_color_num[_num] == 8) _color = 0xFF257179;
		if (RegCustom._units_odd_color_num[_num] == 9) _color = 0xFF29366f;
		if (RegCustom._units_odd_color_num[_num] == 10) _color = 0xFF3b5dc9;
		if (RegCustom._units_odd_color_num[_num] == 11) _color = 0xFF41a6f6;
		if (RegCustom._units_odd_color_num[_num] == 12) _color = 0xFF73eff7;
		if (RegCustom._units_odd_color_num[_num] == 13) _color = 0xFFf4f4f4;
		if (RegCustom._units_odd_color_num[_num] == 14) _color = 0xFF94b0c2;
		if (RegCustom._units_odd_color_num[_num] == 15) _color = 0xFF566c86;
		if (RegCustom._units_odd_color_num[_num] == 16) _color = 0xFF333c57;
		if (RegCustom._units_odd_color_num[_num] == 17) _color = 0xFF9c5b3e;
		if (RegCustom._units_odd_color_num[_num] == 18) _color = 0xFF573139;
		if (RegCustom._units_odd_color_num[_num] == 19) _color = 0xFF4c7554;
		if (RegCustom._units_odd_color_num[_num] == 20) _color = 0xFF2a201e;
		if (RegCustom._units_odd_color_num[_num] == 21) _color = 0x881a1c2c;
		if (RegCustom._units_odd_color_num[_num] == 22) _color = 0x885d275d;
		if (RegCustom._units_odd_color_num[_num] == 23) _color = 0x88b13e53;
		if (RegCustom._units_odd_color_num[_num] == 24) _color = 0x88ef7d57;
		if (RegCustom._units_odd_color_num[_num] == 25) _color = 0x88ffcd75;
		if (RegCustom._units_odd_color_num[_num] == 26) _color = 0x88a7f070;
		if (RegCustom._units_odd_color_num[_num] == 27) _color = 0x8838b764;
		if (RegCustom._units_odd_color_num[_num] == 28) _color = 0x88257179;
		if (RegCustom._units_odd_color_num[_num] == 29) _color = 0x8829366f;
		if (RegCustom._units_odd_color_num[_num] == 30) _color = 0x883b5dc9;
		if (RegCustom._units_odd_color_num[_num] == 31) _color = 0x8841a6f6;
		if (RegCustom._units_odd_color_num[_num] == 32) _color = 0x8873eff7;
		if (RegCustom._units_odd_color_num[_num] == 33) _color = 0x88f4f4f4;
		if (RegCustom._units_odd_color_num[_num] == 34) _color = 0x8894b0c2;
		if (RegCustom._units_odd_color_num[_num] == 35) _color = 0x88566c86;
		if (RegCustom._units_odd_color_num[_num] == 36) _color = 0x88333c57;
		if (RegCustom._units_odd_color_num[_num] == 37) _color = 0x889c5b3e;
		if (RegCustom._units_odd_color_num[_num] == 38) _color = 0x88573139;
		if (RegCustom._units_odd_color_num[_num] == 39) _color = 0x884c7554;
		if (RegCustom._units_odd_color_num[_num] == 40) _color = 0x882a201e;
		
		return _color;
	}
	
	// minus 1 to display a lesser of a color for these units.
	private function colorUnitsEvenMinus()
	{
		RegCustom._units_even_color_num[_num] -= 1;
		if (RegCustom._units_even_color_num[_num] == 0) RegCustom._units_even_color_num[_num] = 40;
		
		_sprite_board_game_unit_even.color = colorToggleUnitsEven();
	}
	
	// plus 1 to display a greater of a color for these units.
	private function colorUnitsEvenPlus()
	{
		RegCustom._units_even_color_num[_num] += 1;
		if (RegCustom._units_even_color_num[_num] == 41) RegCustom._units_even_color_num[_num] = 1;
		
		_sprite_board_game_unit_even.color = colorToggleUnitsEven();
	}	
	
	/******************************
	 * changes the color of game board units.
	 */
	public static function colorToggleUnitsEven():FlxColor
	{		
		var _color:FlxColor = 0xFFFFFFFF;
		
		if (RegCustom._units_even_color_num[_num] == 1) _color = 0xFF1a1c2c;
		if (RegCustom._units_even_color_num[_num] == 2) _color = 0xFF5d275d;
		if (RegCustom._units_even_color_num[_num] == 3) _color = 0xFFcb0025;
		if (RegCustom._units_even_color_num[_num] == 4) _color = 0xFFef7d57;
		if (RegCustom._units_even_color_num[_num] == 5) _color = 0xFFffcd75;
		if (RegCustom._units_even_color_num[_num] == 6) _color = 0xFFa7f070;
		if (RegCustom._units_even_color_num[_num] == 7) _color = 0xFF38b764;
		if (RegCustom._units_even_color_num[_num] == 8) _color = 0xFF257179;
		if (RegCustom._units_even_color_num[_num] == 9) _color = 0xFF29366f;
		if (RegCustom._units_even_color_num[_num] == 10) _color = 0xFF3b5dc9;
		if (RegCustom._units_even_color_num[_num] == 11) _color = 0xFF41a6f6;
		if (RegCustom._units_even_color_num[_num] == 12) _color = 0xFF73eff7;
		if (RegCustom._units_even_color_num[_num] == 13) _color = 0xFFf4f4f4;
		if (RegCustom._units_even_color_num[_num] == 14) _color = 0xFF94b0c2;
		if (RegCustom._units_even_color_num[_num] == 15) _color = 0xFF566c86;
		if (RegCustom._units_even_color_num[_num] == 16) _color = 0xFF333c57;
		if (RegCustom._units_even_color_num[_num] == 17) _color = 0xFF9c5b3e;
		if (RegCustom._units_even_color_num[_num] == 18) _color = 0xFF573139;
		if (RegCustom._units_even_color_num[_num] == 19) _color = 0xFF4c7554;
		if (RegCustom._units_even_color_num[_num] == 20) _color = 0xFF2a201e;
		if (RegCustom._units_even_color_num[_num] == 21) _color = 0x881a1c2c;
		if (RegCustom._units_even_color_num[_num] == 22) _color = 0x885d275d;
		if (RegCustom._units_even_color_num[_num] == 23) _color = 0x88b13e53;
		if (RegCustom._units_even_color_num[_num] == 24) _color = 0x88ef7d57;
		if (RegCustom._units_even_color_num[_num] == 25) _color = 0x88ffcd75;
		if (RegCustom._units_even_color_num[_num] == 26) _color = 0x88a7f070;
		if (RegCustom._units_even_color_num[_num] == 27) _color = 0x8838b764;
		if (RegCustom._units_even_color_num[_num] == 28) _color = 0x88257179;
		if (RegCustom._units_even_color_num[_num] == 29) _color = 0x8829366f;
		if (RegCustom._units_even_color_num[_num] == 30) _color = 0x883b5dc9;
		if (RegCustom._units_even_color_num[_num] == 31) _color = 0x8841a6f6;
		if (RegCustom._units_even_color_num[_num] == 32) _color = 0x8873eff7;
		if (RegCustom._units_even_color_num[_num] == 33) _color = 0x88f4f4f4;
		if (RegCustom._units_even_color_num[_num] == 34) _color = 0x8894b0c2;
		if (RegCustom._units_even_color_num[_num] == 35) _color = 0x88566c86;
		if (RegCustom._units_even_color_num[_num] == 36) _color = 0x88333c57;
		if (RegCustom._units_even_color_num[_num] == 37) _color = 0x889c5b3e;
		if (RegCustom._units_even_color_num[_num] == 38) _color = 0x88573139;
		if (RegCustom._units_even_color_num[_num] == 39) _color = 0x884c7554;
		if (RegCustom._units_even_color_num[_num] == 40) _color = 0x882a201e;
		
		return _color;
	}
	
	// minus 1 to display a lesser of a shade for these units.
	private function gameboard_borderMinus()
	{
		RegCustom._gameboardBorder_num -= 1;
		if (RegCustom._gameboardBorder_num == 0) RegCustom._gameboardBorder_num = 5;
		
		gameboard_border();
	}
	
	// plus 1 to display a greater of a shade for these units.
	private function gameboard_borderPlus()
	{
		RegCustom._gameboardBorder_num += 1;
		if (RegCustom._gameboardBorder_num == 6) RegCustom._gameboardBorder_num = 1;
		
		gameboard_border();
	}
	
	/******************************
	 * this toggles the colors of odd board game units.
	 */
	private function gameboard_border():Void
	{
		_sprite_gameboard_border.loadGraphic("assets/images/gameboardBorder"+ RegCustom._gameboardBorder_num +".png");
	}
	
	private function save_gameboard_border():Void
	{
		if (RegCustom._gameboard_border_enabled == false)
		{
			RegCustom._gameboard_border_enabled = true;
			_sprite_gameboard_border.alpha = 1;
		}
		else
		{
			RegCustom._gameboard_border_enabled = false;
			_sprite_gameboard_border.alpha = 0;
		}
			
		_button_gameboard_border_enabled.label.text = Std.string(RegCustom._gameboard_border_enabled);
	}
		
	private function save_gameboard_coordinates():Void
	{
		if (RegCustom._gameboard_coordinates_enabled == false)
		{
			RegCustom._gameboard_coordinates_enabled = true;
			_sprite_gameboard_coordinates.alpha = 1;
		}
		else
		{
			RegCustom._gameboard_coordinates_enabled = false;
			_sprite_gameboard_coordinates.alpha = 0;
		}
			
		_button_gameboard_coordinates_enabled.label.text = Std.string(RegCustom._gameboard_coordinates_enabled);
	}
	
	private function save_game_room_background_number_minus():Void
	{
		RegCustom._game_room_background_image_number -= 1;
		if (RegCustom._game_room_background_image_number <= 0) RegCustom._game_room_background_image_number = 6;
		
		update_game_room_background();
	}
	
	private function save_game_room_background_number_plus():Void
	{
		RegCustom._game_room_background_image_number += 1;
		if (RegCustom._game_room_background_image_number >= 7) RegCustom._game_room_background_image_number = 1;
		
		update_game_room_background();
	}
	
	private function update_game_room_background():Void
	{
		_sprite_game_room_image.loadGraphic("assets/images/gameboardBackground" + Std.string(RegCustom._game_room_background_image_number) + "b.jpg");
	}
	
	/******************************
	 * when the checkers button is pressed this changes the board game colors for the game to the default colors that seems to be the colors used by a fair amount of websites.
	 */
	private function defaultColorsCheckers():Void
	{		
		buttonToggle();
		
		_button_default_colors_checkers.has_toggle = true;
		_button_default_colors_checkers.set_toggled(true);
		
		shaderToggleUnitsOdd();
		shaderToggleUnitsEven();
		
		_sprite_board_game_unit_odd.color = colorToggleUnitsOdd();
		_sprite_board_game_unit_even.color = colorToggleUnitsEven();
		
		if (RegCustom._units_even_gameboard_show == false)
			_sprite_board_game_unit_even.alpha = 0;
		else
			_sprite_board_game_unit_even.alpha = 1;
		
	}
	
	/******************************
	 * when the chess button is pressed this changes the board game colors for the game to the colors used by a few popular websites.
	 */
	private function defaultColorsChess():Void
	{
		buttonToggle();
				
		_button_default_colors_chess.has_toggle = true;
		_button_default_colors_chess.set_toggled(true);	
		
		shaderToggleUnitsOdd();
		shaderToggleUnitsEven();
		
		_sprite_board_game_unit_odd.color = colorToggleUnitsOdd();
		_sprite_board_game_unit_even.color = colorToggleUnitsEven();
		
		if (RegCustom._units_even_gameboard_show == false)
			_sprite_board_game_unit_even.alpha = 0;
		else
			_sprite_board_game_unit_even.alpha = 1;
			
	}

	
	// set each button as not toggled. then elsewhere, when a toggle button is clicked that code will set a button as toggled.
	private function buttonToggle():Void
	{
		// checkers
		if (_button_default_colors_checkers != null)
		{
			_button_default_colors_checkers.has_toggle = false;
			_button_default_colors_checkers.set_toggled(false);
		}
		
		// chess
		if (_button_default_colors_chess != null)
		{
			_button_default_colors_chess.has_toggle = false;
			_button_default_colors_chess.set_toggled(false);
		}
	}
	
	private function save_game_room_background():Void
	{
		if (RegCustom._game_room_background_enabled == false)
		{
			RegCustom._game_room_background_enabled = true;
			_sprite_game_room_image.alpha = 1;
		}
		else
		{
			RegCustom._game_room_background_enabled = false;
			_sprite_game_room_image.alpha = 0;
		}
			
		_button_game_room_background_enabled.label.text = Std.string(RegCustom._game_room_background_enabled);
	}
	
	private function save_game_room_background_alpha():Void
	{
		if (RegCustom._game_room_background_alpha_enabled == false)
			RegCustom._game_room_background_alpha_enabled = true;
		else
			RegCustom._game_room_background_alpha_enabled = false;
			
		_button_game_room_background_alpha_enabled.label.text = Std.string(RegCustom._game_room_background_alpha_enabled);
	}
	
	private function leaderboardsEnable():Void
	{
		if (RegCustom._config_leaderboard_enabled == false)
			RegCustom._config_leaderboard_enabled = true;
		else
			RegCustom._config_leaderboard_enabled = false;
			
		_button_leaderboard_enabled.label.text = Std.string(RegCustom._config_leaderboard_enabled);
	}
	
	private function houseFeatureEnabled():Void
	{
		if (RegCustom._config_house_feature_enabled == false)
			RegCustom._config_house_feature_enabled = true;
		else
			RegCustom._config_house_feature_enabled = false;
			
		_button_house_feature_enabled.label.text = Std.string(RegCustom._config_house_feature_enabled);
	}
	
	private function saveGotoLobby():Void
	{
		if (RegCustom._config_save_goto_lobby_enabled == false)
			RegCustom._config_save_goto_lobby_enabled = true;
		else
			RegCustom._config_save_goto_lobby_enabled = false;
			
		_button_save_goto_lobby_enabled.label.text = Std.string(RegCustom._config_save_goto_lobby_enabled);
	}
	
	private function save_automatic_game_request():Void
	{
		if (RegCustom._send_automatic_start_game_request == false)
			RegCustom._send_automatic_start_game_request = true;
		else
			RegCustom._send_automatic_start_game_request = false;
			
		_button_send_automatic_start_game_request.label.text = Std.string(RegCustom._send_automatic_start_game_request);
	}
	
	private function save_start_game_offline_confirmation():Void
	{
		if (RegCustom._start_game_offline_confirmation == false)
			RegCustom._start_game_offline_confirmation = true;
		else
			RegCustom._start_game_offline_confirmation = false;
			
		_button_start_game_offline_confirmation.label.text = Std.string(RegCustom._start_game_offline_confirmation);
	}
	
	private function save_accept_automatic_game_request():Void
	{
		if (RegCustom._accept_automatic_start_game_request == false)
			RegCustom._accept_automatic_start_game_request = true;
		else
			RegCustom._accept_automatic_start_game_request = false;
			
		_button_accept_automatic_start_game_request.label.text = Std.string(RegCustom._accept_automatic_start_game_request);
	}
	
	private function save_to_lobby_waiting_room_confirmation():Void
	{
		if (RegCustom._to_lobby_waiting_room_confirmation == false)
			RegCustom._to_lobby_waiting_room_confirmation = true;
		else
			RegCustom._to_lobby_waiting_room_confirmation = false;
			
		_button_to_lobby_waiting_room_confirmation.label.text = Std.string(RegCustom._to_lobby_waiting_room_confirmation);
	}
	
	private function save_to_lobby_game_room_confirmation():Void
	{
		if (RegCustom._to_lobby_game_room_confirmation == false)
			RegCustom._to_lobby_game_room_confirmation = true;
		else
			RegCustom._to_lobby_game_room_confirmation = false;
			
		_button_to_lobby_game_room_confirmation.label.text = Std.string(RegCustom._to_lobby_game_room_confirmation);
	}
	
	private function save_to_game_room_confirmation():Void
	{
		if (RegCustom._to_game_room_confirmation == false)
			RegCustom._to_game_room_confirmation = true;
		else
			RegCustom._to_game_room_confirmation = false;
			
		_button_to_game_room_confirmation.label.text = Std.string(RegCustom._to_game_room_confirmation);
	}
	
	private function save_to_title_confirmation():Void
	{
		if (RegCustom._to_title_confirmation == false)
			RegCustom._to_title_confirmation = true;
		else
			RegCustom._to_title_confirmation = false;
			
		_button_to_title_confirmation.label.text = Std.string(RegCustom._to_title_confirmation);
	}
	
	private function save_chat_turn_off_lobby():Void
	{
		if (RegCustom._chat_turn_off_for_lobby == false)
			RegCustom._chat_turn_off_for_lobby = true;
		else
			RegCustom._chat_turn_off_for_lobby = false;
			
		_button_chat_turn_off_for_lobby.label.text = Std.string(RegCustom._chat_turn_off_for_lobby);
	}
	
	private function save_chat_turn_off_room():Void
	{
		if (RegCustom._chat_turn_off_when_in_room == false)
			RegCustom._chat_turn_off_when_in_room = true;
		else
			RegCustom._chat_turn_off_when_in_room = false;
			
		_button_chat_turn_off_when_in_room.label.text = Std.string(RegCustom._chat_turn_off_when_in_room);
	}
	
	private function save_move_timer():Void
	{
		if (RegCustom._move_timer_enable == false)
			RegCustom._move_timer_enable = true;
		else
			RegCustom._move_timer_enable = false;
			
		_button_move_timer.label.text = Std.string(RegCustom._move_timer_enable);
	}
	
	private function save_move_total():Void
	{
		if (RegCustom._move_total_enable == false)
			RegCustom._move_total_enable = true;
		else
			RegCustom._move_total_enable = false;
			
		_button_move_total.label.text = Std.string(RegCustom._move_total_enable);
	}
	
	private function save_notation_panel():Void
	{
		if (RegCustom._notation_panel_enabled == false)
			RegCustom._notation_panel_enabled = true;
		else
			RegCustom._notation_panel_enabled = false;
			
		_button_notation_panel_enabled.label.text = Std.string(RegCustom._notation_panel_enabled);
	}
	
	private function save_notation_panel_alpha():Void
	{
		if (RegCustom._notation_panel_alpha_apply == false)
			RegCustom._notation_panel_alpha_apply = true;
		else
			RegCustom._notation_panel_alpha_apply = false;
			
		_button_notation_panel_alpha_apply.label.text = Std.string(RegCustom._notation_panel_alpha_apply);
	}
	
	private function save_units_even_gameboard_show():Void
	{
		if (RegCustom._units_even_gameboard_show == false)
		{
			RegCustom._units_even_gameboard_show = true;
			_sprite_board_game_unit_even.alpha = 1;
		}
		else
		{
			RegCustom._units_even_gameboard_show = false;
			_sprite_board_game_unit_even.alpha = 0;
		}
			
		_button_units_even_gameboard_show.label.text = Std.string(RegCustom._units_even_gameboard_show);
	}
	
	private function save_game_show_capturing_units():Void
	{
		if (RegCustom._game_show_capturing_units == false)
			RegCustom._game_show_capturing_units = true;
		else
			RegCustom._game_show_capturing_units = false;
			
		_button_game_show_capturing_units.label.text = Std.string(RegCustom._game_show_capturing_units);
	}
	
	private function game_show_capturing_units_minus():Void
	{
		RegCustom._game_show_capturing_units_number -= 1;
		if (RegCustom._game_show_capturing_units_number == 0) RegCustom._game_show_capturing_units_number = 13;
		
		_sprite_game_show_capturing_units_number.color = RegFunctions.color_game_show_capturing_units();
	}
	
	// plus 1 to display a greater of a shade for these units.
	private function game_show_capturing_units_plus():Void
	{
		RegCustom._game_show_capturing_units_number += 1;
		if (RegCustom._game_show_capturing_units_number == 14) RegCustom._game_show_capturing_units_number = 1;
		
		_sprite_game_show_capturing_units_number.color = RegFunctions.color_game_show_capturing_units();
		
	}
	
	private function background_brightness_minus():Void
	{
		RegCustom._background_brightness -= 0.05;
		if (RegCustom._background_brightness < 0.15) RegCustom._background_brightness = 0.65;
		
		__menu_configurations_output.__boxscroller.bgColor = FlxColor.fromHSB(__menu_configurations_output._bg_color, 0.8, RegCustom._background_brightness);
		
		_text_background_brightness.text = Std.string(RegCustom._background_brightness);
	}
	
	private function background_brightness_plus():Void
	{
		RegCustom._background_brightness += 0.05;
		if (RegCustom._background_brightness > 0.65) RegCustom._background_brightness = 0.15;
		
		__menu_configurations_output.__boxscroller.bgColor = FlxColor.fromHSB(__menu_configurations_output._bg_color, 0.8, RegCustom._background_brightness);
		
		_text_background_brightness.text = Std.string(RegCustom._background_brightness);
	}
	
	/******************************
	 * apply a fill color to the example buttom. that button is used to show the changes of the fill color, border color and text color.
	 */
	private function apply_button_background_color()
	{
		RegCustom._button_color_number += 1;
		if (RegCustom._button_color_number == 41) RegCustom._button_color_number = 1;
		
		// new button color.
		RegCustom._button_color = button_colors();
		
		// the below code will remove the example buttonfrom the scene.  
		// the button will be redisplay to show the new button's fill color.
		if (_button_color_output != null)
		{			
			_group.remove(_button_color_output);
			remove(_button_color_output);
			_button_color_output.destroy();
		}
		
		_button_color_output = new ButtonGeneralNetworkNo(_question_button_colors_output.x + _question_button_colors_output.fieldWidth + 15, _button_border_color.y + 7, "Example", 110, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_button_color_output.label.font = Reg._fontDefault;
		_group.add(_button_color_output);
	}
		
	private function apply_button_border_color()
	{
		RegCustom._button_color_number += 1;
		if (RegCustom._button_color_number == 41) RegCustom._button_color_number = 1;
		
		// new button color.
		RegCustom._button_border_color = button_colors();
		
		// the below code will remove the example buttonfrom the scene.  
		// the button will be redisplay to show the new button's fill color.
		if (_button_color_output != null)
		{			
			_group.remove(_button_color_output);
			remove(_button_color_output);
			_button_color_output.destroy();
		}
		
		_button_color_output = new ButtonGeneralNetworkNo(_question_button_colors_output.x + _question_button_colors_output.fieldWidth + 15, _button_border_color.y + 7, "Example", 110, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_button_color_output.label.font = Reg._fontDefault;
		_group.add(_button_color_output);
	}
	
	private function apply_button_text_color()
	{
		RegCustom._button_color_number += 1;
		if (RegCustom._button_color_number == 41) RegCustom._button_color_number = 1;
		
		// new button color.
		RegCustom._button_text_color = button_colors();
		
		// the below code will remove the example buttonfrom the scene.  
		// the button will be redisplay to show the new button's fill color.
		if (_button_color_output != null)
		{			
			_group.remove(_button_color_output);
			remove(_button_color_output);
			_button_color_output.destroy();
		}
		
		_button_color_output = new ButtonGeneralNetworkNo(_question_button_colors_output.x + _question_button_colors_output.fieldWidth + 15, _button_border_color.y + 7, "Example", 110, 35, Reg._font_size, RegCustom._button_text_color, 0, null, RegCustom._button_color);
		_button_color_output.label.font = Reg._fontDefault;
		_group.add(_button_color_output);
	}
	
	/******************************
	 * button fill color is the color behind the button text.
	 */
	public static function button_colors():FlxColor
	{		
		var _color:FlxColor = 0xFF1a1c2c;
		
		if (RegCustom._button_color_number == 1) _color = 0xFF1a1c2c;
		if (RegCustom._button_color_number == 2) _color = 0xFF5d275d;
		if (RegCustom._button_color_number == 3) _color = 0xFFcb0025;
		if (RegCustom._button_color_number == 4) _color = 0xFFef7d57;
		if (RegCustom._button_color_number == 5) _color = 0xFFffcd75;
		if (RegCustom._button_color_number == 6) _color = 0xFFa7f070;
		if (RegCustom._button_color_number == 7) _color = 0xFF38b764;
		if (RegCustom._button_color_number == 8) _color = 0xFF257179;
		if (RegCustom._button_color_number == 9) _color = 0xFF29366f;
		if (RegCustom._button_color_number == 10) _color = 0xFF3b5dc9;
		if (RegCustom._button_color_number == 11) _color = 0xFF41a6f6;
		if (RegCustom._button_color_number == 12) _color = 0xFF73eff7;
		if (RegCustom._button_color_number == 13) _color = 0xFFf4f4f4;
		if (RegCustom._button_color_number == 14) _color = 0xFF94b0c2;
		if (RegCustom._button_color_number == 15) _color = 0xFF566c86;
		if (RegCustom._button_color_number == 16) _color = 0xFF333c57;
		if (RegCustom._button_color_number == 17) _color = 0xFF9c5b3e;
		if (RegCustom._button_color_number == 18) _color = 0xFF573139;
		if (RegCustom._button_color_number == 19) _color = 0xFF4c7554;
		if (RegCustom._button_color_number == 20) _color = 0xFF2a201e;
		if (RegCustom._button_color_number == 21) _color = 0x881a1c2c;
		if (RegCustom._button_color_number == 22) _color = 0x885d275d;
		if (RegCustom._button_color_number == 23) _color = 0x88b13e53;
		if (RegCustom._button_color_number == 24) _color = 0x88ef7d57;
		if (RegCustom._button_color_number == 25) _color = 0x88ffcd75;
		if (RegCustom._button_color_number == 26) _color = 0x88a7f070;
		if (RegCustom._button_color_number == 27) _color = 0x8838b764;
		if (RegCustom._button_color_number == 28) _color = 0x88257179;
		if (RegCustom._button_color_number == 29) _color = 0x8829366f;
		if (RegCustom._button_color_number == 30) _color = 0x883b5dc9;
		if (RegCustom._button_color_number == 31) _color = 0x8841a6f6;
		if (RegCustom._button_color_number == 32) _color = 0x8873eff7;
		if (RegCustom._button_color_number == 33) _color = 0x88f4f4f4;
		if (RegCustom._button_color_number == 34) _color = 0x8894b0c2;
		if (RegCustom._button_color_number == 35) _color = 0x88566c86;
		if (RegCustom._button_color_number == 36) _color = 0x88333c57;
		if (RegCustom._button_color_number == 37) _color = 0x889c5b3e;
		if (RegCustom._button_color_number == 38) _color = 0x88573139;
		if (RegCustom._button_color_number == 39) _color = 0x884c7554;
		if (RegCustom._button_color_number == 40) _color = 0x882a201e;
		
		return _color;
	}
	
	override public function update(elapsed:Float):Void
	{	
		if (Reg._yesNoKeyPressValueAtMessage > 0 && Reg._buttonCodeValues == "v1000")
		{
			Reg._yesNoKeyPressValueAtMessage = 0;
			
			_button_shader_even_units_minus.active = true;
			_button_shader_even_units_plus.active = true;		
			_button_shader_odd_units_minus.active = true;
			_button_shader_odd_units_plus.active = true;
			
			_button_color_even_units_minus.active = true;
			_button_color_even_units_plus.active = true;		
			_button_color_odd_units_minus.active = true;
			_button_color_odd_units_plus.active = true;
		}
		
		for (i in 0... _group_button.length)
		{
			// if mouse is on the button plus any offset made by the box scroller and mouse is pressed...
			if (FlxG.mouse.y + ButtonGeneralNetworkNo._scrollarea_offset_y >= _group_button[i]._startY &&  FlxG.mouse.y + ButtonGeneralNetworkNo._scrollarea_offset_y <= _group_button[i]._startY + _group_button[i]._button_height 
			&& FlxG.mouse.x + ButtonGeneralNetworkNo._scrollarea_offset_x >= _group_button[i]._startX &&  FlxG.mouse.x + ButtonGeneralNetworkNo._scrollarea_offset_x <= _group_button[i]._startX + _group_button[i]._button_width && FlxG.mouse.justPressed == true )
			{
				buttonNumber(i);				
				break;
			}
			
			
		}
			
		super.update(elapsed);		
		
	}
}
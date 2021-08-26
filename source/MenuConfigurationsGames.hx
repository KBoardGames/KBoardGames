package;

/**
 * this class is created when clicking the gear button. It has configuration stuff such as setting up the game board unit colors.
 * @author kboardgames.com
 */
class MenuConfigurationsGames extends FlxGroup
{
	private var _offset_x:Int = -50;
	private var _offset_y:Int = 50;
	private var _offset:Int = 30;	
	
	private var _button_games:ButtonToggleFlxState;	

	/******************************
	 * this holds the avatars. value starts at 0. access members here.
	 */
	private var _group_sprite:Array<FlxSprite> = [];
	
	private var _sprite_chess_future_capturing_units:FlxSprite;
	private var _sprite_chess_path_to_king:FlxSprite;
	
	/******************************
	 * display the pawn of the selected game board chess set.
	 */
	private var _sprite_display_pawn_from_p1_chess_set:FlxSprite;
	private var _sprite_display_pawn_from_p2_chess_set:FlxSprite;
	
	/******************************
	 * display the bishop of the selected game board chess set.
	 */
	private var _sprite_display_bishop_from_p1_chess_set:FlxSprite;
	private var _sprite_display_bishop_from_p2_chess_set:FlxSprite;
	
	/******************************
	 * display the horse of the selected game board chess set.
	 */
	private var _sprite_display_horse_from_p1_chess_set:FlxSprite;
	private var _sprite_display_horse_from_p2_chess_set:FlxSprite;
	
	/******************************
	 * display the rook of the selected game board chess set.
	 */
	private var _sprite_display_rook_from_p1_chess_set:FlxSprite;
	private var _sprite_display_rook_from_p2_chess_set:FlxSprite;
	
	/******************************
	 * display the queen of the selected game board chess set.
	 */
	private var _sprite_display_queen_from_p1_chess_set:FlxSprite;
	private var _sprite_display_queen_from_p2_chess_set:FlxSprite;
	 
	/******************************
	 * display the king of the selected game board chess set.
	 */
	private var _sprite_display_king_from_p1_chess_set:FlxSprite;
	private var _sprite_display_king_from_p2_chess_set:FlxSprite;
	
	/******************************
	* anything added to this group will be placed inside of the boxScroller field. 
	*/
	public var _group:FlxSpriteGroup;
	
	/******************************
	 * value starts at 0. access members here.
	 */
	private var _group_button:Array<ButtonGeneralNetworkNo> = [];
	
	private var __menu_configurations_output:MenuConfigurationsOutput;
	
	/******************************
	 * when increasing/decreasing the game minutes for checkers, this text changes in that game minutes total value.
	 */
	private var _checkers_game_minutes:FlxText;
	
	/******************************
	 * when increasing/decreasing the game minutes for chess, this text changes in that game minutes total value.
	 */
	private var _chess_game_minutes:FlxText;
	private var _reversi_game_minutes:FlxText;
	private var _snakes_ladders_game_minutes:FlxText;
	private var _signature_game_minutes:FlxText;
	private var _button_game_skill_level_chess:ButtonGeneralNetworkNo;
	private var _text_game_skill_level_chess:FlxText;
	private var _button_chess_opening_moves_enabled:ButtonGeneralNetworkNo;
	private var _button_chess_show_last_piece_moved:ButtonGeneralNetworkNo;
	private var _button_chess_computer_thinking_enabled:ButtonGeneralNetworkNo;
	private var _button_chess_future_capturing_units_enabled:ButtonGeneralNetworkNo;
	private var _button_chess_future_capturing_units_minus:ButtonGeneralNetworkNo;
	private var	_button_chess_future_capturing_units_plus:ButtonGeneralNetworkNo;
	private var _button_chess_future_capturing_units_number:ButtonGeneralNetworkNo;
	private var _button_chess_path_to_king_enabled:ButtonGeneralNetworkNo;
	private var	_button_chess_path_to_king_minus:ButtonGeneralNetworkNo;
	private var	_button_chess_path_to_king_plus:ButtonGeneralNetworkNo;
	private var _button_chess_path_to_king_number:ButtonGeneralNetworkNo;	
	private var _button_chess_current_piece_p1_set_minus:ButtonGeneralNetworkNo;
	private var _button_chess_current_piece_p1_set_plus:ButtonGeneralNetworkNo;
	private var _button_chess_current_piece_p1_set_color_minus:ButtonGeneralNetworkNo;
	private var _button_chess_current_piece_p1_set_color_plus:ButtonGeneralNetworkNo;
	private var _button_chess_current_piece_p2_set_minus:ButtonGeneralNetworkNo;
	private var _button_chess_current_piece_p2_set_plus:ButtonGeneralNetworkNo;
	private var _button_chess_current_piece_p2_set_color_minus:ButtonGeneralNetworkNo;
	private var _button_chess_current_piece_p2_set_color_plus:ButtonGeneralNetworkNo;
	
	override public function new(menu_configurations_output:MenuConfigurationsOutput):Void
	{
		super();
		__menu_configurations_output = menu_configurations_output;
		
		sceneGames();
	}
	
	public function sceneGames():Void
	{
		_group = cast add(new FlxSpriteGroup());
		_group_button.splice(0, _group_button.length);
				
		var _game_minutes = new FlxText(0, 100, 0, "Minutes");
		_game_minutes.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.ORANGE);
		_game_minutes.screenCenter(X);
		_group.add(_game_minutes);
		
		var _description_game_minutes = new FlxText(15, 150, 0, "Select the total allowed minutes for a game.");
		_description_game_minutes.setFormat(Reg._fontDefault, Reg._font_size);
		_group.add(_description_game_minutes);
		
		//############################# checkers time remaining,
		var _title_checkers_game_minutes = new FlxText(15, _description_game_minutes.y + 75, 0, "Checkers");
		_title_checkers_game_minutes.setFormat(Reg._fontDefault, Reg._font_size);
		_group.add(_title_checkers_game_minutes);
		
		var _checkers_minus_minutes = new ButtonGeneralNetworkNo(_title_checkers_game_minutes.fieldWidth + 40, _title_checkers_game_minutes.y - 10, "-", 40, 40, Reg._font_size, 0xFFCCFF33, 0, null);
		_checkers_minus_minutes.label.font = Reg._fontDefault;
		_checkers_minus_minutes.label.bold = true;
		_checkers_minus_minutes.visible = false;
		
		_group_button.push(_checkers_minus_minutes);
		_group.add(_group_button[0]);
		
		_checkers_game_minutes = new FlxText(_checkers_minus_minutes.x + 48, _title_checkers_game_minutes.y, 0, Std.string(RegCustom._move_time_remaining_current[0]));
		_checkers_game_minutes.setFormat(Reg._fontDefault, Reg._font_size);
		_group.add(_checkers_game_minutes);
		
		var _checkers_plus_minutes = new ButtonGeneralNetworkNo(_checkers_minus_minutes.x + 90, _title_checkers_game_minutes.y - 10, "+", 40, 40, Reg._font_size, 0xFFCCFF33, 0, null);		
		_checkers_plus_minutes.label.font = Reg._fontDefault;	
		_checkers_plus_minutes.label.bold = true;
		_checkers_plus_minutes.visible = false;
		
		_group_button.push(_checkers_plus_minutes);
		_group.add(_group_button[1]);
		
		//############################# chess time remaining,
		var _title_chess_game_minutes = new FlxText(15, _checkers_plus_minutes.y + 75, 0, "chess");
		_title_chess_game_minutes.setFormat(Reg._fontDefault, Reg._font_size);
		_group.add(_title_chess_game_minutes);
		
		var _chess_minus_minutes = new ButtonGeneralNetworkNo(_title_chess_game_minutes.fieldWidth + 40, _title_chess_game_minutes.y - 10, "-", 40, 40, Reg._font_size, 0xFFCCFF33, 0, null);
		_chess_minus_minutes.label.font = Reg._fontDefault;
		_chess_minus_minutes.label.bold = true;
		_chess_minus_minutes.visible = false;
		
		_group_button.push(_chess_minus_minutes);
		_group.add(_group_button[2]);
				
		_chess_game_minutes = new FlxText(_chess_minus_minutes.x + 48, _title_chess_game_minutes.y, 0, Std.string(RegCustom._move_time_remaining_current[1]));
		_chess_game_minutes.setFormat(Reg._fontDefault, Reg._font_size);
		_group.add(_chess_game_minutes);
		
		var _chess_plus_minutes = new ButtonGeneralNetworkNo(_chess_minus_minutes.x + 90, _title_chess_game_minutes.y - 10, "+", 40, 40, Reg._font_size, 0xFFCCFF33, 0, null);
		_chess_plus_minutes.label.font = Reg._fontDefault;	
		_chess_plus_minutes.label.bold = true;
		_chess_plus_minutes.visible = false;
		
		_group_button.push(_chess_plus_minutes);
		_group.add(_group_button[3]);
		
		//############################# Reversi time remaining,
		var _title_reversi_game_minutes = new FlxText(15, _chess_plus_minutes.y + 75, 0, "reversi");
		_title_reversi_game_minutes.setFormat(Reg._fontDefault, Reg._font_size);
		_group.add(_title_reversi_game_minutes);
		
		var _reversi_minus_minutes = new ButtonGeneralNetworkNo(_title_reversi_game_minutes.fieldWidth + 40, _title_reversi_game_minutes.y - 10, "-", 40, 40, Reg._font_size, 0xFFCCFF33, 0, null);
		_reversi_minus_minutes.label.font = Reg._fontDefault;
		_reversi_minus_minutes.label.bold = true;
		_reversi_minus_minutes.visible = false;
		
		_group_button.push(_reversi_minus_minutes);
		_group.add(_group_button[4]);
				
		_reversi_game_minutes = new FlxText(_reversi_minus_minutes.x + 48, _title_reversi_game_minutes.y, 0, Std.string(RegCustom._move_time_remaining_current[2]));
		_reversi_game_minutes.setFormat(Reg._fontDefault, Reg._font_size);
		_group.add(_reversi_game_minutes);
		
		var _reversi_plus_minutes = new ButtonGeneralNetworkNo(_reversi_minus_minutes.x + 90, _title_reversi_game_minutes.y - 10, "+", 40, 40, Reg._font_size, 0xFFCCFF33, 0, null);
		_reversi_plus_minutes.label.font = Reg._fontDefault;	
		_reversi_plus_minutes.label.bold = true;
		_reversi_plus_minutes.visible = false;
		
		_group_button.push(_reversi_plus_minutes);
		_group.add(_group_button[5]);
		
		//############################# snakes and ladders time remaining,
		var _title_snakes_ladders_game_minutes = new FlxText(15, _reversi_plus_minutes.y + 75, 0, "snakes_ladders");
		_title_snakes_ladders_game_minutes.setFormat(Reg._fontDefault, Reg._font_size);
		_group.add(_title_snakes_ladders_game_minutes);
		
		var _snakes_ladders_minus_minutes = new ButtonGeneralNetworkNo(_title_snakes_ladders_game_minutes.fieldWidth + 40, _title_snakes_ladders_game_minutes.y - 10, "-", 40, 40, Reg._font_size, 0xFFCCFF33, 0, null);
		_snakes_ladders_minus_minutes.label.font = Reg._fontDefault;
		_snakes_ladders_minus_minutes.label.bold = true;
		_snakes_ladders_minus_minutes.visible = false;
		
		_group_button.push(_snakes_ladders_minus_minutes);
		_group.add(_group_button[6]);
				
		_snakes_ladders_game_minutes = new FlxText(_snakes_ladders_minus_minutes.x + 48, _title_snakes_ladders_game_minutes.y, 0, Std.string(RegCustom._move_time_remaining_current[3]));
		_snakes_ladders_game_minutes.setFormat(Reg._fontDefault, Reg._font_size);
		_group.add(_snakes_ladders_game_minutes);
		
		var _snakes_ladders_plus_minutes = new ButtonGeneralNetworkNo(_snakes_ladders_minus_minutes.x + 90, _title_snakes_ladders_game_minutes.y - 10, "+", 40, 40, Reg._font_size, 0xFFCCFF33, 0, null);
		_snakes_ladders_plus_minutes.label.font = Reg._fontDefault;	
		_snakes_ladders_plus_minutes.label.bold = true;
		_snakes_ladders_plus_minutes.visible = false;
		
		_group_button.push(_snakes_ladders_plus_minutes);
		_group.add(_group_button[7]);
		
		//############################# signature time remaining,
		var _title_signature_game_minutes = new FlxText(15, _snakes_ladders_plus_minutes.y + 75, 0, "signature");
		_title_signature_game_minutes.setFormat(Reg._fontDefault, Reg._font_size);
		_group.add(_title_signature_game_minutes);
		
		var _signature_minus_minutes = new ButtonGeneralNetworkNo(_title_signature_game_minutes.fieldWidth + 40, _title_signature_game_minutes.y - 10, "-", 40, 40, Reg._font_size, 0xFFCCFF33, 0, null);
		_signature_minus_minutes.label.font = Reg._fontDefault;
		_signature_minus_minutes.label.bold = true;
		_signature_minus_minutes.visible = false;
		
		_group_button.push(_signature_minus_minutes);
		_group.add(_group_button[8]);
				
		_signature_game_minutes = new FlxText(_signature_minus_minutes.x + 48, _title_signature_game_minutes.y, 0, Std.string(RegCustom._move_time_remaining_current[4]));
		_signature_game_minutes.setFormat(Reg._fontDefault, Reg._font_size);
		_group.add(_signature_game_minutes);
		
		var _signature_plus_minutes = new ButtonGeneralNetworkNo(_signature_minus_minutes.x + 90, _title_signature_game_minutes.y - 10, "+", 40, 40, Reg._font_size, 0xFFCCFF33, 0, null);		
		_signature_plus_minutes.label.font = Reg._fontDefault;	
		_signature_plus_minutes.label.bold = true;
		_signature_plus_minutes.visible = false;
		
		_group_button.push(_signature_plus_minutes);
		_group.add(_group_button[9]);
		
		// chess title.
		var _chess = new FlxText(15, _signature_plus_minutes.y + 100, 0, "Chess.");
		_chess.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.ORANGE);
		_chess.screenCenter(X);
		_group.add(_chess);
	
		_text_game_skill_level_chess = new FlxText(15, _chess.y + 90, 0, "Are you a beginner, intermediate or advanced chess player.");
		_text_game_skill_level_chess.setFormat(Reg._fontDefault, Reg._font_size);
		_group.add(_text_game_skill_level_chess);
		
		_button_game_skill_level_chess = new ButtonGeneralNetworkNo(_text_game_skill_level_chess.x + _text_game_skill_level_chess.fieldWidth + 15, _text_game_skill_level_chess.y - 10, "", 240, 40, Reg._font_size, 0xFFCCFF33, 0, null);
		
		if (RegCustom._game_skill_level_chess == 0) 
			_button_game_skill_level_chess.label.text = "Beginner";
		else if (RegCustom._game_skill_level_chess == 1)
			_button_game_skill_level_chess.label.text = "Intermediate";
		else _button_game_skill_level_chess.label.text = "Advanced";
		
		_button_game_skill_level_chess.label.font = Reg._fontDefault;	
		_button_game_skill_level_chess.label.bold = true;
		_button_game_skill_level_chess.visible = false;

		_group_button.push(_button_game_skill_level_chess);
		_group.add(_group_button[10]);
		
		
		var _question_chess_opening_moves_enabled = new FlxText(15, 0, 0, "Display the chess opening move text?");
		_question_chess_opening_moves_enabled.setFormat(Reg._fontDefault, Reg._font_size);
		_question_chess_opening_moves_enabled.y = _button_game_skill_level_chess.height + _button_game_skill_level_chess.y + 40;
		_group.add(_question_chess_opening_moves_enabled);
		
		_button_chess_opening_moves_enabled = new ButtonGeneralNetworkNo(_question_chess_opening_moves_enabled.width + 30, _question_chess_opening_moves_enabled.y - 8, "", 100, 35, Reg._font_size, 0xFFCCFF33, 0, null);
		_button_chess_opening_moves_enabled.label.font = Reg._fontDefault;
		_button_chess_opening_moves_enabled.label.text = Std.string(RegCustom._chess_opening_moves_enabled);
		
		_group_button.push(_button_chess_opening_moves_enabled);
		_group.add(_group_button[11]);
		
		var _question_chess_show_last_piece_moved = new FlxText(15, 0, 0, "Show last piece moved?");
		_question_chess_show_last_piece_moved.setFormat(Reg._fontDefault, Reg._font_size);
		_question_chess_show_last_piece_moved.y = _button_chess_opening_moves_enabled.height + _button_chess_opening_moves_enabled.y + 40;
		_group.add(_question_chess_show_last_piece_moved);
		
		_button_chess_show_last_piece_moved = new ButtonGeneralNetworkNo(_question_chess_show_last_piece_moved.width + 30, _question_chess_show_last_piece_moved.y - 8, "", 100, 35, Reg._font_size, 0xFFCCFF33, 0, null);
		_button_chess_show_last_piece_moved.label.font = Reg._fontDefault;
		_button_chess_show_last_piece_moved.label.text = Std.string(RegCustom._chess_show_last_piece_moved);
		
		_group_button.push(_button_chess_show_last_piece_moved);
		_group.add(_group_button[12]);
		
		var _question_chess_computer_thinking_enabled = new FlxText(15, 0, 0, "Show computer spinner image when thinking?");
		_question_chess_computer_thinking_enabled.setFormat(Reg._fontDefault, Reg._font_size);
		_question_chess_computer_thinking_enabled.y = _button_chess_show_last_piece_moved.height + _button_chess_show_last_piece_moved.y + 40;
		_group.add(_question_chess_computer_thinking_enabled);
		
		_button_chess_computer_thinking_enabled = new ButtonGeneralNetworkNo(_question_chess_computer_thinking_enabled.width + 30, _question_chess_computer_thinking_enabled.y - 8, "", 100, 35, Reg._font_size, 0xFFCCFF33, 0, null);
		_button_chess_computer_thinking_enabled.label.font = Reg._fontDefault;
		_button_chess_computer_thinking_enabled.label.text = Std.string(RegCustom._chess_computer_thinking_enabled);
		
		_group_button.push(_button_chess_computer_thinking_enabled);
		_group.add(_group_button[13]);
		
		var _question_chess_future_capturing_units_enabled = new FlxText(15, 0, FlxG.width-500, "The future capturing units feature show upcoming attacks to the king and is only available while playing against the computer with a chess skill level of beginner. Enabled the futute capturing units feature?");
		_question_chess_future_capturing_units_enabled.setFormat(Reg._fontDefault, Reg._font_size);
		_question_chess_future_capturing_units_enabled.y = _button_chess_computer_thinking_enabled.height +  _button_chess_computer_thinking_enabled.y + 40;
		_group.add(_question_chess_future_capturing_units_enabled);
		
		_button_chess_future_capturing_units_enabled = new ButtonGeneralNetworkNo(_question_chess_future_capturing_units_enabled.width + 20, _question_chess_future_capturing_units_enabled.y + 10, "", 100, 35, Reg._font_size, 0xFFCCFF33, 0, null);
		_button_chess_future_capturing_units_enabled.label.font = Reg._fontDefault;
		_button_chess_future_capturing_units_enabled.label.text = Std.string(RegCustom._chess_future_capturing_units_enabled);
		
		_group_button.push(_button_chess_future_capturing_units_enabled);
		_group.add(_group_button[14]);
		
		//############################## plus and minus future capturing unit buttons.
		_button_chess_future_capturing_units_minus = new ButtonGeneralNetworkNo(_button_chess_future_capturing_units_enabled.x + _button_chess_future_capturing_units_enabled.width + 15, _button_chess_future_capturing_units_enabled.y + 7, "-", 35, 35, Reg._font_size, 0xFFCCFF33, 0, null);
		_button_chess_future_capturing_units_minus.label.font = Reg._fontDefault;
		_button_chess_future_capturing_units_minus.visible = false;
		
		_group_button.push(_button_chess_future_capturing_units_minus);
		_group.add(_group_button[15]);		
		
		_button_chess_future_capturing_units_plus = new ButtonGeneralNetworkNo(_button_chess_future_capturing_units_minus.x + _button_chess_future_capturing_units_minus.width + 15, _button_chess_future_capturing_units_minus.y + 7, "+", 35, 35, Reg._font_size, 0xFFCCFF33, 0, null);
		_button_chess_future_capturing_units_plus.label.font = Reg._fontDefault;
		_button_chess_future_capturing_units_plus.visible = false;	
		
		_group_button.push(_button_chess_future_capturing_units_plus);
		_group.add(_group_button[16]);
		
		var _sprite_chess_future_capturing_units_bg = new FlxSprite(_button_chess_future_capturing_units_plus.x + _button_chess_future_capturing_units_plus.width + 45, _button_chess_future_capturing_units_plus.y - 14, "assets/images/blackBackground.jpg");
		_group.add(_sprite_chess_future_capturing_units_bg);
		
		_sprite_chess_future_capturing_units = new FlxSprite(_button_chess_future_capturing_units_plus.x + _button_chess_future_capturing_units_plus.width + 45, _button_chess_future_capturing_units_plus.y - 14);
		_sprite_chess_future_capturing_units.loadGraphic("assets/images/futureCapturingUnits.png", true, 75, 75);
		_sprite_chess_future_capturing_units.animation.add("path empty unit", [2], 1, false);
		_sprite_chess_future_capturing_units.animation.play("path empty unit");
		_sprite_chess_future_capturing_units.color = RegFunctions.color_future_capturing_units();
		_group.add(_sprite_chess_future_capturing_units);
		
		//##############################
		
		var _question_chess_path_to_king_enabled = new FlxText(15, 0, FlxG.width-500, "the path to king are units in a straight line showing where an attack on the king is coming from. Enable the path to king feature?");
		_question_chess_path_to_king_enabled.setFormat(Reg._fontDefault, Reg._font_size);
		_question_chess_path_to_king_enabled.y = _question_chess_future_capturing_units_enabled.height +  _question_chess_future_capturing_units_enabled.y + 40;
		_group.add(_question_chess_path_to_king_enabled);
		
		_button_chess_path_to_king_enabled = new ButtonGeneralNetworkNo(_question_chess_path_to_king_enabled.width + 10, _question_chess_path_to_king_enabled.y + 10, "", 100, 35, Reg._font_size, 0xFFCCFF33, 0, null);
		_button_chess_path_to_king_enabled.label.font = Reg._fontDefault;
		_button_chess_path_to_king_enabled.label.text = Std.string(RegCustom._chess_path_to_king_enabled);
		
		_group_button.push(_button_chess_path_to_king_enabled);
		_group.add(_group_button[17]);

		//############################## plus and minus path to king buttons.
		_button_chess_path_to_king_minus = new ButtonGeneralNetworkNo(_button_chess_path_to_king_enabled.x + _button_chess_path_to_king_enabled.width + 15, _button_chess_path_to_king_enabled.y + 7, "-", 35, 35, Reg._font_size, 0xFFCCFF33, 0, null);
		_button_chess_path_to_king_minus.label.font = Reg._fontDefault;
		_button_chess_path_to_king_minus.visible = false;
		
		_group_button.push(_button_chess_path_to_king_minus);
		_group.add(_group_button[18]);		
		
		_button_chess_path_to_king_plus = new ButtonGeneralNetworkNo(_button_chess_path_to_king_minus.x + _button_chess_path_to_king_minus.width + 15, _button_chess_path_to_king_minus.y + 7, "+", 35, 35, Reg._font_size, 0xFFCCFF33, 0, null);
		_button_chess_path_to_king_plus.label.font = Reg._fontDefault;
		_button_chess_path_to_king_plus.visible = false;	
		
		_group_button.push(_button_chess_path_to_king_plus);
		_group.add(_group_button[19]);
				
		_sprite_chess_path_to_king = new FlxSprite(_button_chess_path_to_king_plus.x + _button_chess_path_to_king_plus.width + 45, _button_chess_path_to_king_plus.y - 14);
		_sprite_chess_path_to_king.loadGraphic("assets/images/pathToKing.png", false, 75, 75);
		_sprite_chess_path_to_king.color = RegFunctions.color_path_to_king();
		_group.add(_sprite_chess_path_to_king);
		
		var _sprite_chess_path_to_king_bg = new FlxSprite(_button_chess_path_to_king_plus.x + _button_chess_path_to_king_plus.width + 45, _button_chess_path_to_king_plus.y - 14, "assets/images/dailyQuestsBorder1.png");
		_group.add(_sprite_chess_path_to_king_bg);
		
		//##############################
		
		var _question_chess_current_piece_p1_set = new FlxText(15, 0, 0, "Player 1 chess piece set.");
		_question_chess_current_piece_p1_set.setFormat(Reg._fontDefault, Reg._font_size);
		_question_chess_current_piece_p1_set.y = _question_chess_path_to_king_enabled.height + _question_chess_path_to_king_enabled.y + 40;
		_group.add(_question_chess_current_piece_p1_set);
		
		_button_chess_current_piece_p1_set_minus = new ButtonGeneralNetworkNo(_question_chess_current_piece_p1_set.width + 30, _question_chess_current_piece_p1_set.y - 8, "", 35, 35, Reg._font_size, 0xFFCCFF33, 0, null);
		_button_chess_current_piece_p1_set_minus.label.font = Reg._fontDefault;
		_button_chess_current_piece_p1_set_minus.label.text = "-";
		
		_group_button.push(_button_chess_current_piece_p1_set_minus);
		_group.add(_group_button[20]);
		
		_button_chess_current_piece_p1_set_plus = new ButtonGeneralNetworkNo(_question_chess_current_piece_p1_set.width + 30 + 50, _question_chess_current_piece_p1_set.y - 8, "", 35, 35, Reg._font_size, 0xFFCCFF33, 0, null);
		_button_chess_current_piece_p1_set_plus.label.font = Reg._fontDefault;
		_button_chess_current_piece_p1_set_plus.label.text = "+";
		
		_group_button.push(_button_chess_current_piece_p1_set_plus);
		_group.add(_group_button[21]);
		
		_sprite_display_pawn_from_p1_chess_set = new FlxSprite(_button_chess_current_piece_p1_set_plus.x + _button_chess_current_piece_p1_set_plus.width + 120, _button_chess_current_piece_p1_set_plus.y + 18);
		_sprite_display_pawn_from_p1_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_current_piece_p1_set + "/1.png", false, 75, 75);
		_sprite_display_pawn_from_p1_chess_set.color = RegFunctions.draw_update_board_p1_set_color();
		_group.add(_sprite_display_pawn_from_p1_chess_set);
		
		_sprite_display_bishop_from_p1_chess_set = new FlxSprite(_button_chess_current_piece_p1_set_plus.x + _button_chess_current_piece_p1_set_plus.width + 120 + 90, _button_chess_current_piece_p1_set_plus.y + 18);
		_sprite_display_bishop_from_p1_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_current_piece_p1_set + "/2.png", false, 75, 75);
		_sprite_display_bishop_from_p1_chess_set.color = RegFunctions.draw_update_board_p1_set_color();
		_group.add(_sprite_display_bishop_from_p1_chess_set);
		
		_sprite_display_horse_from_p1_chess_set = new FlxSprite(_button_chess_current_piece_p1_set_plus.x + _button_chess_current_piece_p1_set_plus.width + 120 + (2 * 90), _button_chess_current_piece_p1_set_plus.y + 18);
		_sprite_display_horse_from_p1_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_current_piece_p1_set + "/3.png", false, 75, 75);
		_sprite_display_horse_from_p1_chess_set.color = RegFunctions.draw_update_board_p1_set_color();
		_group.add(_sprite_display_horse_from_p1_chess_set);
		
		_sprite_display_rook_from_p1_chess_set = new FlxSprite(_button_chess_current_piece_p1_set_plus.x + _button_chess_current_piece_p1_set_plus.width + 120 + (3 * 90), _button_chess_current_piece_p1_set_plus.y + 18);
		_sprite_display_rook_from_p1_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_current_piece_p1_set + "/4.png", false, 75, 75);
		_sprite_display_rook_from_p1_chess_set.color = RegFunctions.draw_update_board_p1_set_color();
		_group.add(_sprite_display_rook_from_p1_chess_set);
		
		_sprite_display_queen_from_p1_chess_set = new FlxSprite(_button_chess_current_piece_p1_set_plus.x + _button_chess_current_piece_p1_set_plus.width + 120 + (4 * 90), _button_chess_current_piece_p1_set_plus.y + 18);
		_sprite_display_queen_from_p1_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_current_piece_p1_set + "/5.png", false, 75, 75);
		_sprite_display_queen_from_p1_chess_set.color = RegFunctions.draw_update_board_p1_set_color();
		_group.add(_sprite_display_queen_from_p1_chess_set);
		
		_sprite_display_king_from_p1_chess_set = new FlxSprite(_button_chess_current_piece_p1_set_plus.x + _button_chess_current_piece_p1_set_plus.width + 120 + (5 * 90), _button_chess_current_piece_p1_set_plus.y + 18);
		_sprite_display_king_from_p1_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_current_piece_p1_set + "/6.png", false, 75, 75);
		_sprite_display_king_from_p1_chess_set.color = RegFunctions.draw_update_board_p1_set_color();
		_group.add(_sprite_display_king_from_p1_chess_set);
		
		
		var _question_chess_current_piece_p1_set_color = new FlxText(15, 0, 0, "chess piece set color 1.");
		_question_chess_current_piece_p1_set_color.setFormat(Reg._fontDefault, Reg._font_size);
		_question_chess_current_piece_p1_set_color.y = _question_chess_current_piece_p1_set.height + _question_chess_current_piece_p1_set.y + 40;
		_group.add(_question_chess_current_piece_p1_set_color);
		
		_button_chess_current_piece_p1_set_color_minus = new ButtonGeneralNetworkNo(_question_chess_current_piece_p1_set_color.width + 30, _question_chess_current_piece_p1_set_color.y - 8, "", 35, 35, Reg._font_size, 0xFFCCFF33, 0, null);
		_button_chess_current_piece_p1_set_color_minus.label.font = Reg._fontDefault;
		_button_chess_current_piece_p1_set_color_minus.label.text = "-";
		
		_group_button.push(_button_chess_current_piece_p1_set_color_minus);
		_group.add(_group_button[22]);
		
		_button_chess_current_piece_p1_set_color_plus = new ButtonGeneralNetworkNo(_question_chess_current_piece_p1_set_color.width + 30 + 50, _question_chess_current_piece_p1_set_color.y - 8, "", 35, 35, Reg._font_size, 0xFFCCFF33, 0, null);
		_button_chess_current_piece_p1_set_color_plus.label.font = Reg._fontDefault;
		_button_chess_current_piece_p1_set_color_plus.label.text = "+";
		
		_group_button.push(_button_chess_current_piece_p1_set_color_plus);
		_group.add(_group_button[23]);
		
		//#############################
		
		var _question_chess_current_piece_p2_set = new FlxText(15, 0, 0, "Player 2 chess piece set.");
		_question_chess_current_piece_p2_set.setFormat(Reg._fontDefault, Reg._font_size);
		_question_chess_current_piece_p2_set.y = _button_chess_current_piece_p1_set_color_plus.height + _button_chess_current_piece_p1_set_color_plus.y + 40;
		_group.add(_question_chess_current_piece_p2_set);
		
		_button_chess_current_piece_p2_set_minus = new ButtonGeneralNetworkNo(_question_chess_current_piece_p2_set.width + 30, _question_chess_current_piece_p2_set.y - 8, "", 35, 35, Reg._font_size, 0xFFCCFF33, 0, null);
		_button_chess_current_piece_p2_set_minus.label.font = Reg._fontDefault;
		_button_chess_current_piece_p2_set_minus.label.text = "-";
		
		_group_button.push(_button_chess_current_piece_p2_set_minus);
		_group.add(_group_button[24]);
		
		_button_chess_current_piece_p2_set_plus = new ButtonGeneralNetworkNo(_question_chess_current_piece_p2_set.width + 30 + 50, _question_chess_current_piece_p2_set.y - 8, "", 35, 35, Reg._font_size, 0xFFCCFF33, 0, null);
		_button_chess_current_piece_p2_set_plus.label.font = Reg._fontDefault;
		_button_chess_current_piece_p2_set_plus.label.text = "+";
		
		_group_button.push(_button_chess_current_piece_p2_set_plus);
		_group.add(_group_button[25]);
		
		_sprite_display_pawn_from_p2_chess_set = new FlxSprite(_button_chess_current_piece_p2_set_plus.x + _button_chess_current_piece_p2_set_plus.width + 120, _button_chess_current_piece_p2_set_plus.y + 18);
		_sprite_display_pawn_from_p2_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_current_piece_p2_set + "/1.png", false, 75, 75);
		_sprite_display_pawn_from_p2_chess_set.color = RegFunctions.draw_update_board_p2_set_color();
		_group.add(_sprite_display_pawn_from_p2_chess_set);
		
		_sprite_display_bishop_from_p2_chess_set = new FlxSprite(_button_chess_current_piece_p2_set_plus.x + _button_chess_current_piece_p2_set_plus.width + 120 + 90, _button_chess_current_piece_p2_set_plus.y + 18);
		_sprite_display_bishop_from_p2_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_current_piece_p2_set + "/2.png", false, 75, 75);
		_sprite_display_bishop_from_p2_chess_set.color = RegFunctions.draw_update_board_p2_set_color();
		_group.add(_sprite_display_bishop_from_p2_chess_set);
		
		_sprite_display_horse_from_p2_chess_set = new FlxSprite(_button_chess_current_piece_p2_set_plus.x + _button_chess_current_piece_p2_set_plus.width + 120 + (2 * 90), _button_chess_current_piece_p2_set_plus.y + 18);
		_sprite_display_horse_from_p2_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_current_piece_p2_set + "/3.png", false, 75, 75);
		_sprite_display_horse_from_p2_chess_set.color = RegFunctions.draw_update_board_p2_set_color();
		_group.add(_sprite_display_horse_from_p2_chess_set);
		
		_sprite_display_rook_from_p2_chess_set = new FlxSprite(_button_chess_current_piece_p2_set_plus.x + _button_chess_current_piece_p2_set_plus.width + 120 + (3 * 90), _button_chess_current_piece_p2_set_plus.y + 18);
		_sprite_display_rook_from_p2_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_current_piece_p2_set + "/4.png", false, 75, 75);
		_sprite_display_rook_from_p2_chess_set.color = RegFunctions.draw_update_board_p2_set_color();
		_group.add(_sprite_display_rook_from_p2_chess_set);
		
		_sprite_display_queen_from_p2_chess_set = new FlxSprite(_button_chess_current_piece_p2_set_plus.x + _button_chess_current_piece_p2_set_plus.width + 120 + (4 * 90), _button_chess_current_piece_p2_set_plus.y + 18);
		_sprite_display_queen_from_p2_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_current_piece_p2_set + "/5.png", false, 75, 75);
		_sprite_display_queen_from_p2_chess_set.color = RegFunctions.draw_update_board_p2_set_color();
		_group.add(_sprite_display_queen_from_p2_chess_set);
		
		_sprite_display_king_from_p2_chess_set = new FlxSprite(_button_chess_current_piece_p2_set_plus.x + _button_chess_current_piece_p2_set_plus.width + 120 + (5 * 90), _button_chess_current_piece_p2_set_plus.y + 18);
		_sprite_display_king_from_p2_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_current_piece_p2_set + "/6.png", false, 75, 75);
		_sprite_display_king_from_p2_chess_set.color = RegFunctions.draw_update_board_p2_set_color();
		_group.add(_sprite_display_king_from_p2_chess_set);
		
		
		var _question_chess_current_piece_p2_set_color = new FlxText(15, 0, 0, "chess piece set color 2.");
		_question_chess_current_piece_p2_set_color.setFormat(Reg._fontDefault, Reg._font_size);
		_question_chess_current_piece_p2_set_color.y = _question_chess_current_piece_p2_set.height + _question_chess_current_piece_p2_set.y + 40;
		_group.add(_question_chess_current_piece_p2_set_color);
		
		_button_chess_current_piece_p2_set_color_minus = new ButtonGeneralNetworkNo(_question_chess_current_piece_p2_set_color.width + 30, _question_chess_current_piece_p2_set_color.y - 8, "", 35, 35, Reg._font_size, 0xFFCCFF33, 0, null);
		_button_chess_current_piece_p2_set_color_minus.label.font = Reg._fontDefault;
		_button_chess_current_piece_p2_set_color_minus.label.text = "-";
		
		_group_button.push(_button_chess_current_piece_p2_set_color_minus);
		_group.add(_group_button[26]);
		
		_button_chess_current_piece_p2_set_color_plus = new ButtonGeneralNetworkNo(_question_chess_current_piece_p2_set_color.width + 30 + 50, _question_chess_current_piece_p2_set_color.y - 8, "", 35, 35, Reg._font_size, 0xFFCCFF33, 0, null);
		_button_chess_current_piece_p2_set_color_plus.label.font = Reg._fontDefault;
		_button_chess_current_piece_p2_set_color_plus.label.text = "+";
		
		_group_button.push(_button_chess_current_piece_p2_set_color_plus);
		_group.add(_group_button[27]);
		
		
		
		
		
		var _button = new ButtonGeneralNetworkNo(0, (_button_chess_current_piece_p2_set_minus).y + 200, "", 240, 40, Reg._font_size, 0xFFCCFF33, 0, null);
		_group.add(_button);

	}
		
	/******************************
	 * this function is called when a button at this class is clicked.
	 */
	private function buttonNumber(_num:Int):Void
	{
		switch (_num)
		{
			case 0: minusMinutes(0);
			case 1: plusMinutes(0);
			case 2: minusMinutes(1);
			case 3: plusMinutes(1);
			case 4: minusMinutes(2);
			case 5: plusMinutes(2);
			case 6: minusMinutes(3);
			case 7: plusMinutes(3);
			case 8: minusMinutes(4);
			case 9: plusMinutes(4);
			case 10: chess_skill_level();
			case 11: save_chess_opening_moves_enabled();
			case 12: save_chess_show_last_piece_moved();
			case 13: save_chess_computer_thinking_enabled();
			case 14: save_chess_future_capturing_units();
			case 15: save_chess_future_capturing_units_minus();
			case 16: save_chess_future_capturing_units_plus();
			case 17: save_chess_path_to_king();
			case 18: save_chess_path_to_king_minus();
			case 19: save_chess_path_to_king_plus();
			case 20: save_chess_piece_p1_set_current_minus();
			case 21: save_chess_piece_p1_set_current_plus();
			case 22: save_chess_piece_p1_set_color_current_minus();
			case 23: save_chess_piece_p1_set_color_current_plus();
			case 24: save_chess_piece_p2_set_current_minus();
			case 25: save_chess_piece_p2_set_current_plus();
			case 26: save_chess_piece_p2_set_color_current_minus();
			case 27: save_chess_piece_p2_set_color_current_plus();
		}
	}
	
	/******************************
	 * minus 5 from total of the minutes allowed for the game.
	 * @param	_id		Game id
	 */
	private function minusMinutes(_id:Int):Void
	{
		// minus 5 from the total time for the game selected.
		if (RegCustom._move_time_remaining_current[_id]
		!=  RegCustom._move_time_remaining_minimum[_id])
			RegCustom._move_time_remaining_current[_id] -= 5;	
		
		updateGameMinutes(_id);
	}
	
	/******************************
	 * plus 5 from total of the minutes allowed for the game.
	 * @param	_id		Game id
	 */
	private function plusMinutes(_id:Int):Void
	{
		// plus 5 from the total time for the game selected.
		if (RegCustom._move_time_remaining_current[_id]
		!=  RegCustom._move_time_remaining_maximum[_id])
			RegCustom._move_time_remaining_current[_id] += 5;	
		
		updateGameMinutes(_id);
	}
	
	/******************************
	 * game minutes text for a game of _id is updated when a plus button or minus button (buttons that changes the minutes for a game) is clicked.
	 */
	private function updateGameMinutes(_id:Int):Void
	{
		switch (_id)
		{
			// checkers
			case 0: _checkers_game_minutes.text = Std.string(RegCustom._move_time_remaining_current[0]);
			case 1: _chess_game_minutes.text = Std.string(RegCustom._move_time_remaining_current[1]);
			case 2: _reversi_game_minutes.text = Std.string(RegCustom._move_time_remaining_current[2]);
			case 3: _snakes_ladders_game_minutes.text = Std.string(RegCustom._move_time_remaining_current[3]);
			case 4: _signature_game_minutes.text = Std.string(RegCustom._move_time_remaining_current[4]);
		}
	}
		
	private function chess_skill_level():Void
	{
		RegCustom._game_skill_level_chess += 1;
		
		if (RegCustom._game_skill_level_chess == 3)
			RegCustom._game_skill_level_chess = 0;
		
		if (RegCustom._game_skill_level_chess == 0)
			_button_game_skill_level_chess.label.text = "Beginner";
		
		if (RegCustom._game_skill_level_chess == 1)
			_button_game_skill_level_chess.label.text = "Intermediate";
		
		if (RegCustom._game_skill_level_chess == 2)
			_button_game_skill_level_chess.label.text = "Advanced";			
	}
	
	private function save_chess_opening_moves_enabled():Void
	{
		if (RegCustom._chess_opening_moves_enabled == false)
			RegCustom._chess_opening_moves_enabled = true;
		else
			RegCustom._chess_opening_moves_enabled = false;
			
		_button_chess_opening_moves_enabled.label.text = Std.string(RegCustom._chess_opening_moves_enabled);
	}
	
	private function save_chess_show_last_piece_moved():Void
	{
		if (RegCustom._chess_show_last_piece_moved == false)
			RegCustom._chess_show_last_piece_moved = true;
		else
			RegCustom._chess_show_last_piece_moved = false;
			
		_button_chess_show_last_piece_moved.label.text = Std.string(RegCustom._chess_show_last_piece_moved);
	}
	
	private function save_chess_computer_thinking_enabled():Void
	{
		if (RegCustom._chess_computer_thinking_enabled == false)
			RegCustom._chess_computer_thinking_enabled = true;
		else
			RegCustom._chess_computer_thinking_enabled = false;
			
		_button_chess_computer_thinking_enabled.label.text = Std.string(RegCustom._chess_computer_thinking_enabled);
	}
	
	private function save_chess_future_capturing_units():Void
	{
		if (RegCustom._chess_future_capturing_units_enabled == false)
			RegCustom._chess_future_capturing_units_enabled = true;
		else
			RegCustom._chess_future_capturing_units_enabled = false;
			
		_button_chess_future_capturing_units_enabled.label.text = Std.string(RegCustom._chess_future_capturing_units_enabled);
	}
	
	private function save_chess_future_capturing_units_minus():Void
	{
		RegCustom._chess_future_capturing_units_number -= 1;
		if (RegCustom._chess_future_capturing_units_number == 0) RegCustom._chess_future_capturing_units_number = 13;
		
		_sprite_chess_future_capturing_units.color = RegFunctions.color_future_capturing_units();
	}
	
	// plus 1 to display a greater of a shade for these units.
	private function save_chess_future_capturing_units_plus():Void
	{
		RegCustom._chess_future_capturing_units_number += 1;
		if (RegCustom._chess_future_capturing_units_number == 14) RegCustom._chess_future_capturing_units_number = 1;
		
		_sprite_chess_future_capturing_units.color = RegFunctions.color_future_capturing_units();
		
	}
	
	private function save_chess_path_to_king():Void
	{
		if (RegCustom._chess_path_to_king_enabled == false)
			RegCustom._chess_path_to_king_enabled = true;
		else
			RegCustom._chess_path_to_king_enabled = false;
			
		_button_chess_path_to_king_enabled.label.text = Std.string(RegCustom._chess_path_to_king_enabled);
	}
	
	private function save_chess_path_to_king_minus():Void
	{
		RegCustom._chess_path_to_king_number -= 1;
		if (RegCustom._chess_path_to_king_number == 0) RegCustom._chess_path_to_king_number = 13;
		
		_sprite_chess_path_to_king.color = RegFunctions.color_path_to_king();
	}
	
	// plus 1 to display a greater of a shade for these units.
	private function save_chess_path_to_king_plus():Void
	{
		RegCustom._chess_path_to_king_number += 1;
		if (RegCustom._chess_path_to_king_number == 14) RegCustom._chess_path_to_king_number = 1;
		
		_sprite_chess_path_to_king.color = RegFunctions.color_path_to_king();
		
	}
	
	private function save_chess_piece_p1_set_current_minus():Void
	{
		RegCustom._chess_current_piece_p1_set -= 1;
		if (RegCustom._chess_current_piece_p1_set == 0) RegCustom._chess_current_piece_p1_set = 8;
		
		draw_update_p1_board_set();
	}
	
	private function save_chess_piece_p1_set_current_plus():Void
	{
		RegCustom._chess_current_piece_p1_set += 1;
		if (RegCustom._chess_current_piece_p1_set == 9) RegCustom._chess_current_piece_p1_set = 1;
		
		draw_update_p1_board_set();
	}
	
	private function save_chess_piece_p1_set_color_current_minus():Void
	{
		RegCustom._chess_current_piece_p1_set_color -= 1;
		if (RegCustom._chess_current_piece_p1_set_color == 0) RegCustom._chess_current_piece_p1_set_color = 26;
		
		var _color = RegFunctions.draw_update_board_p1_set_color();
		
		_sprite_display_pawn_from_p1_chess_set.color = _color;
		_sprite_display_bishop_from_p1_chess_set.color = _color;
		_sprite_display_horse_from_p1_chess_set.color = _color;
		_sprite_display_rook_from_p1_chess_set.color = _color;
		_sprite_display_queen_from_p1_chess_set.color = _color;
		_sprite_display_king_from_p1_chess_set.color = _color;
	}
	
	
	private function save_chess_piece_p1_set_color_current_plus():Void
	{
		RegCustom._chess_current_piece_p1_set_color += 1;
		if (RegCustom._chess_current_piece_p1_set_color == 27) RegCustom._chess_current_piece_p1_set_color = 1;
		
		var _color = RegFunctions.draw_update_board_p1_set_color();
		
		_sprite_display_pawn_from_p1_chess_set.color = _color;
		_sprite_display_bishop_from_p1_chess_set.color = _color;
		_sprite_display_horse_from_p1_chess_set.color = _color;
		_sprite_display_rook_from_p1_chess_set.color = _color;
		_sprite_display_queen_from_p1_chess_set.color = _color;
		_sprite_display_king_from_p1_chess_set.color = _color;
	}
	
	private function draw_update_p1_board_set():Void
	{
		_sprite_display_pawn_from_p1_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_current_piece_p1_set + "/1.png", false, 75, 75);
		_sprite_display_bishop_from_p1_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_current_piece_p1_set + "/2.png", false, 75, 75);
		_sprite_display_horse_from_p1_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_current_piece_p1_set + "/3.png", false, 75, 75);
		_sprite_display_rook_from_p1_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_current_piece_p1_set + "/4.png", false, 75, 75);
		_sprite_display_queen_from_p1_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_current_piece_p1_set + "/5.png", false, 75, 75);
		_sprite_display_king_from_p1_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_current_piece_p1_set + "/6.png", false, 75, 75);
	}
		
	private function save_chess_piece_p2_set_current_minus():Void
	{
		RegCustom._chess_current_piece_p2_set -= 1;
		if (RegCustom._chess_current_piece_p2_set == 0) RegCustom._chess_current_piece_p2_set = 8;
		
		draw_update_p2_board_set();
	}
	
	private function save_chess_piece_p2_set_current_plus():Void
	{
		RegCustom._chess_current_piece_p2_set += 1;
		if (RegCustom._chess_current_piece_p2_set == 9) RegCustom._chess_current_piece_p2_set = 1;
		
		draw_update_p2_board_set();
	}
		
	private function save_chess_piece_p2_set_color_current_minus():Void
	{
		RegCustom._chess_current_piece_p2_set_color -= 1;
		if (RegCustom._chess_current_piece_p2_set_color == 0) RegCustom._chess_current_piece_p2_set_color = 26;
		
		var _color = RegFunctions.draw_update_board_p2_set_color();
		
		_sprite_display_pawn_from_p2_chess_set.color = _color;
		_sprite_display_bishop_from_p2_chess_set.color = _color;
		_sprite_display_horse_from_p2_chess_set.color = _color;
		_sprite_display_rook_from_p2_chess_set.color = _color;
		_sprite_display_queen_from_p2_chess_set.color = _color;
		_sprite_display_king_from_p2_chess_set.color = _color;
	}
	
	private function save_chess_piece_p2_set_color_current_plus():Void
	{
		RegCustom._chess_current_piece_p2_set_color += 1;
		if (RegCustom._chess_current_piece_p2_set_color == 27) RegCustom._chess_current_piece_p2_set_color = 1;
		
		var _color = RegFunctions.draw_update_board_p2_set_color();
		
		_sprite_display_pawn_from_p2_chess_set.color = _color;
		_sprite_display_bishop_from_p2_chess_set.color = _color;
		_sprite_display_horse_from_p2_chess_set.color = _color;
		_sprite_display_rook_from_p2_chess_set.color = _color;
		_sprite_display_queen_from_p2_chess_set.color = _color;
		_sprite_display_king_from_p2_chess_set.color = _color;
	}
	
	private function draw_update_p2_board_set():Void
	{
		_sprite_display_pawn_from_p2_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_current_piece_p2_set + "/1.png", false, 75, 75);
		_sprite_display_bishop_from_p2_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_current_piece_p2_set + "/2.png", false, 75, 75);
		_sprite_display_horse_from_p2_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_current_piece_p2_set + "/3.png", false, 75, 75);
		_sprite_display_rook_from_p2_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_current_piece_p2_set + "/4.png", false, 75, 75);
		_sprite_display_queen_from_p2_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_current_piece_p2_set + "/5.png", false, 75, 75);
		_sprite_display_king_from_p2_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_current_piece_p2_set + "/6.png", false, 75, 75);
	}
	
	
	override public function update(elapsed:Float):Void
	{
		for (i in 0... _group_button.length)
		{
			// if mouse is on the button plus any offset made by the box scroller and mouse is pressed...
			if (FlxG.mouse.y + ButtonGeneralNetworkNo._scrollarea_offset_y >= _group_button[i]._startY &&  FlxG.mouse.y + ButtonGeneralNetworkNo._scrollarea_offset_y <= _group_button[i]._startY + _group_button[i]._button_height 
			&& FlxG.mouse.x + ButtonGeneralNetworkNo._scrollarea_offset_x >= _group_button[i]._startX &&  FlxG.mouse.x + ButtonGeneralNetworkNo._scrollarea_offset_x <= _group_button[i]._startX + _group_button[i]._button_width && FlxG.mouse.justPressed == true )
			{
				buttonNumber(i);
				
				break;
			}
			
			// if same as above but mouse is not pressed.
			else if (FlxG.mouse.y + ButtonGeneralNetworkNo._scrollarea_offset_y >= _group_button[i]._startY &&  FlxG.mouse.y + ButtonGeneralNetworkNo._scrollarea_offset_y <= _group_button[i]._startY + _group_button[i]._button_height 
			&& FlxG.mouse.x + ButtonGeneralNetworkNo._scrollarea_offset_x >= _group_button[i]._startX &&  FlxG.mouse.x + ButtonGeneralNetworkNo._scrollarea_offset_x <= _group_button[i]._startX + _group_button[i]._button_width)
			{
				_group_button[i].active = true;
				_group_button[i].label.color = 0xFF00FF00;
				
				break;
			}
			// if mouse is not at a button that set it not active.
			else if (FlxG.mouse.y + ButtonGeneralNetworkNo._scrollarea_offset_y < _group_button[i]._startY 
			||  FlxG.mouse.y + ButtonGeneralNetworkNo._scrollarea_offset_y > _group_button[i]._startY + _group_button[i]._button_height
			||  FlxG.mouse.x + ButtonGeneralNetworkNo._scrollarea_offset_x < _group_button[i]._startX 
			||  FlxG.mouse.x + ButtonGeneralNetworkNo._scrollarea_offset_x > _group_button[i]._startX + _group_button[i]._button_width)			
			{
				if (_group_button[i].label.color == 0xFFFFFFFF) 
					_group_button[i].active = false;
				_group_button[i].label.color = 0xFFFFFFFF;
				
			}
		}

		super.update(elapsed);		
	}
}
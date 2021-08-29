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
 * the bar displayed behind the quest description and total daily quest value completed.
 * author: kboardgames.com.
 */
class DailyQuests extends FlxGroup
{
	/******************************
	 * the bar displayed behind the quest description and total quest value completed.
	 */
	private var _bar:FlxBar;
	
	/******************************
	 * the text displayed on the bar.
	 */
	private var _bar_text:FlxText;
	
	/******************************
	 * this checkmark is displayed overtop of the bar when the quest is complete.
	 */
	private var _checkmark:FlxSprite;
	
	/******************************
	 * an array of the possible reward given for a successful quest.
	 */
	private var _reward_icon_String:Array<String> = ["EXP", "House Coins", "Credits"];
	
	private var _height_between_bars:Int = 130;	
	
	/******************************
	 * instead of "add" to scene, we add to "_group.add" so that if you pass the group to the __boxscroller or if we need to hide them all, calling this var directly is more easer to do.
	 */
	public var _group:FlxSpriteGroup;
	
	/******************************
	 * used to scroll the scene.
	 */
	public var __boxscroller:FlxScrollableArea;	
	
	/******************************
	 * used as an element id. if a value of 1, then array[_id] will call the second element. not the first because arrays always start at 0.
	 */
	private var _id:Int = 1; 
	
	/******************************
	 * a code used to stop the __boxScroller from scrolling when at the SceneMenu will stops the __boxScroller from displaying correctly when entering this class. this is the fix. used to display the __boxScroller underneath the SceneMenu.
	 */
	private var _ticks:Int = 0; 
	
	public var _rewards:Array<String> = ["0", "0", "0"];
	
	private var _close:ButtonGeneralNetworkYes;
	
	private var _quest_description:Array<String> = 
	[
	"Win three board games in a row.", 
	"Win a chess game in 5 moves or under.", 
	"Win a snakes and ladders game in under 4 moves.", 
	"Win any game in 5 minutes or under.", 
	"Buy any four house items.", 
	"Finish playing a signature game.", 
	"Occupy a total of 50 units in a reversi game.", 
	"Get 6 Kings in 1 checkers game.",
	"play all 5 board games."];
	
	/******************************
	 * At the beginning of a quest day, these var refer to the RegTypedef._dataDailyQuests default values. this var also refers to the current values of that typeDef. The reason for these duplicate values is because RegTypedef._dataDailyQuests values are sent to and from the server and this arrays are used here in this class in a loop. this var makes for easer coding.
	 * some quests have a value of either true or false. Since we are using Int, the value of 1 = true and 0 for false.
	 * take the first element in this example, the RegTypedef._dataDailyQuests._three_in_a_row shows the current games won in a row.
	 */
	private var _bar_value_current:Array<Int> = [0, 0, 0, 0, 0, 0, 0, 0, 0];
	
	/******************************
	 * some quests have a value of either true or false. Since we are using Int, the value of 1 = true and 0 for false.
	 * if a value is neither 1 or 0 then that value refers to a _bar_value_current value that increments. 
	 */
	private var _bar_value_max:Array<Int> = [3,1,1,1,4,1,1,1,5];
	
	public var __menu_bar:MenuBar;
	
	private var _button_claim_reward:ButtonGeneralNetworkYes;
	
	override public function new():Void
	{
		super();

		PlayState.clientSocket.send("Daily Quests", RegTypedef._dataDailyQuests);
		haxe.Timer.delay(function (){}, Reg2._event_sleep);
		
		FlxG.autoPause = false;	// this application will pause when not in focus.
			
	}
	
	/******************************
	 * when this class is created, a event "Daily Quests" is called and the quests data is populated at that event from NetworkEventsMain.hx then this function is called to draw stuff to scene. 
	 */
	public function options():Void
	{
		FlxG.mouse.enabled = true;
		_ticks = 0;
				
		_bar_value_current[0] = Std.parseInt(RegTypedef._dataDailyQuests._three_in_a_row);
		_bar_value_current[1] = Std.parseInt(RegTypedef._dataDailyQuests._chess_5_moves_under);
		_bar_value_current[2] = Std.parseInt(RegTypedef._dataDailyQuests._snakes_under_4_moves);
		_bar_value_current[3] = Std.parseInt(RegTypedef._dataDailyQuests._win_5_minute_game);
		_bar_value_current[4] = Std.parseInt(RegTypedef._dataDailyQuests._buy_four_house_items);
		_bar_value_current[5] = Std.parseInt(RegTypedef._dataDailyQuests._finish_signature_game);
		_bar_value_current[6] = Std.parseInt(RegTypedef._dataDailyQuests._reversi_occupy_50_units);
		_bar_value_current[7] = Std.parseInt(RegTypedef._dataDailyQuests._checkers_get_6_kings);
		_bar_value_current[8] = Std.parseInt(RegTypedef._dataDailyQuests._play_all_5_board_games); 

		var _title = new FlxText(0, 0, 0, "Daily Quests.");
		_title.setFormat(Reg._fontDefault, 30, FlxColor.ORANGE);
		_title.scrollFactor.set(0, 0);
		_title.setPosition(15, 15);
		_title.screenCenter(X);
				
		_group = cast add(new FlxSpriteGroup());

		// ------------------- static movement. not at the __boxscroller.
		__menu_bar = new MenuBar();
		add(__menu_bar);
		
		_close = new ButtonGeneralNetworkYes(30, FlxG.height - 40, "Exit", 150 + 15, 35, Reg._font_size, 0xFFCCFF33, 0, closeState, 0xFF000044, false);
		_close.label.font = Reg._fontDefault;
		_close.screenCenter(X);
		_close.x += 400;
		_close.alpha = 1;
		add(_close);
		
		_rewards.splice(3, 0);
		_rewards = RegTypedef._dataDailyQuests._rewards.split(",");
		
		var _stop:Bool = false; // used to break out of the following loop if that condition is true.
		
		for (i in 0...3)
		{
			if (_rewards[i] == "1")
			{
				_button_claim_reward = new ButtonGeneralNetworkYes(_close.x-200, FlxG.height - 40, "Claim", 185, 35, Reg._font_size, 0xFFCCFF33, 0, claimReward, 0xFF000044, false);
				_button_claim_reward.label.font = Reg._fontDefault;
				add(_button_claim_reward);
				
				_stop = true;
				break;
			}
			
			if (_stop == true) break;
		}
		//----------------------------
		
		for (i in 0...9)
		{
			createBar((i+1), _quest_description[i], _bar_value_current[i], _bar_value_max[i], _rewards[0], _rewards[1], _rewards[2]);
		}		
		
		// needed extra vertical space to show all last element.
		var _button = new ButtonGeneralNetworkYes(0, 13 * _height_between_bars, "", 200, 35, Reg._font_size, 0xFFCCFF33, 0, null);
		_button.visible = false;
		_group.add(_button);
		
		// a negative x value moves the boxScroller in the opposite direction.
		if (__boxscroller != null) FlxG.cameras.remove(__boxscroller);
		__boxscroller = new FlxScrollableArea(new FlxRect( 0, 0, FlxG.width, FlxG.height-50), new FlxRect( 0, 0, FlxG.width-40, _group.height), ResizeMode.NONE, 0, 100, -1, FlxColor.LIME, null, 100, true);
		__boxscroller.bgColor = 0xFF000066;
		FlxG.cameras.add( __boxscroller );
		__boxscroller.antialiasing = true;
		__boxscroller.pixelPerfectRender = true;
		
		//-----------------------------
		// none scrollable background behind title.
		var background = new FlxSprite(0, 0);
		background.makeGraphic(FlxG.width, 200, 0xFF220000);
		background.setPosition(0, 0);
		background.scrollFactor.set(0, 0);
		add(background);
		
		add(_title);
		
		drawRewardIconsAndText();
		drawGaugeEmpty();
		drawGaugeFilled();
	}
	
	override public function destroy()
	{		
		if (_group != null)
		{
			_group.destroy();
			_group = null;
		}
		
		if (__boxscroller != null)
		{
			__boxscroller.visible = false;			
			cameras.remove(__boxscroller);
			__boxscroller.destroy();
			__boxscroller = null;
		}
		
		super.destroy();
	}
	
	/******************************
	 * These are the reward icons. When the dashed filled icon reaches one of these icons then a daily reward can be claimed.
	 */
	private function drawRewardIconsAndText():Void
	{
		for (i in 0...3)
		{
			var _reward_icon = new FlxSprite(0, 57);			
			if (i == 0) _reward_icon.x = 400;
			if (i == 1) _reward_icon.x = 700 - 37.5; // half of width.
			if (i == 2) _reward_icon.x = 1000 - 75; // full width of image.
			_reward_icon.loadGraphic("assets/images/dailyQuestsRewardIcon"+(i+1)+".png", true, 75, 75);
			_reward_icon.animation.add("active", [0]);
			_reward_icon.animation.play("active");
			_reward_icon.scrollFactor.set();
			add(_reward_icon);
			
			var _reward_text = new FlxText(0, 133, 0, _reward_icon_String[i]);
			if (i == 0) _reward_text.x = 412;
			if (i == 1) _reward_text.x = 610;
			if (i == 2) _reward_text.x = 909;
			_reward_text.setFormat(Reg._fontDefault, Reg._font_size);
			_reward_text.scrollFactor.set();
			add(_reward_text);
		}
	}
	
	/******************************
	 * this is the dashed line that runs horizontally across the top part of the scene. There are three reward icons. then the dash filled line reaches a reward icon then a claim reward button will appear.
	 */
	private function drawGaugeEmpty():Void
	{
		var _arr = [225, 312.5, 400, 487.5, 575, 662.5, 750, 837.5, 925]; // 262.5
		
		for (i in 0...9)
		{
			var _gauge = new FlxSprite(_arr[i] + 5, 165);
			_gauge.loadGraphic("assets/images/gaugeEmpty.png");
			_gauge.scrollFactor.set();
			add(_gauge);
		}
	}
	
	/******************************
	 * this is the dashed line that runs horizontally across the top part of the scene. There are three reward icons. then the dash filled line reaches a reward icon then a claim reward button will appear.
	 */
	private function drawGaugeFilled():Void
	{
		var _arr = [225, 312.5, 400, 487.5, 575, 662.5, 750, 837.5, 925]; // 262.5
		
		var _count = 0;
		for (i in 0...9)
		{
			if (_bar_value_current[i] == _bar_value_max[i])
				_count += 1;
		}
		
		for (i in 0... _count)
		{
			var _gauge = new FlxSprite(_arr[i] + 5, 165);
			_gauge.loadGraphic("assets/images/gaugeFilled.png");
			_gauge.scrollFactor.set();
			add(_gauge);
		}
	}
	
	/******************************
	 * This creates the bar showing the progress of a daily quest. On that bar is a description of the quest and text showing if the quest is complete or not. Once completed the bar will show a checkmark image.
	 * @param	_id			used to call an element of an array.
	 * @param	_str		string used to output the array elements description.
	 * @param	_current	the current value of the array element.
	 * @param	_max		the value that _current var needs to reach before a quest can be completed.
	 */
	private function createBar(_id:Int, _str:String, _current:Int, _max:Int, _reward1:String, _reward2:String, _reward3:String):Void
	{
		// create the quest bars.		
		_bar = new FlxBar(100, _id * _height_between_bars + 100, FlxBarFillDirection.LEFT_TO_RIGHT, FlxG.width - 550, 110, null, "", 0, _max, true);
		_bar.createColoredEmptyBar(0xFF000044, true);
		_bar.createColoredFilledBar(0xFF111199, true);
		_bar.screenCenter(X);		
		
		_bar.value = _current;
		
		if (_bar.value >= _bar.max)
		{
			_bar.createColoredEmptyBar(0xFF001100, true);
			_bar.createColoredFilledBar(0xFF001100, true);				
		}
		_group.add(_bar);
		
		//--------------------------
		if (_bar.value == _bar.max )
		{
			if (_id <= 3 && _reward1 == "2"
			||  _id >= 4 && _id <= 6 && _reward2 == "2"
			||  _id >= 7 && _id <= 9 && _reward3 == "2")
			{
				_checkmark = new FlxSprite(FlxG.width - 410, ((_id + 1) * _height_between_bars));
				_checkmark.loadGraphic("assets/images/dailyQuestsCheckmark.png", false);
				_checkmark.x = (FlxG.width - 550 / 2) - 10 - _checkmark.width; 
				//_group.add(_checkmark);
			}
		}
		
		// create each text to display overtop of each bar.
		if (_max > 1)
			_bar_text = new FlxText(_bar.x + 10, _id * _height_between_bars, 0, _str + "\n" + Std.string(_current) + "/" + Std.string(_max), 0);
		else
		{
			if (_current == 0)
				_bar_text = new FlxText(_bar.x + 10, _id * _height_between_bars, 0, _str + "\nFalse", 0);
			else
				_bar_text = new FlxText(_bar.x + 10, _id * _height_between_bars, 0, _str + "\nTrue", 0);
		}
		_bar_text.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.YELLOW);
		_bar_text.y = _bar.y + 5;
		_group.add(_bar_text);

	}

	override public function update(elapsed:Float):Void
	{
		if (RegTriggers.__daily_quests == true)
		{
			RegTriggers.__daily_quests = false;
			options();
		}
		
		if (_ticks < 5) _ticks += 1;
		
		// if at SceneMenu then set __boxScroller active to false so that a mouse click at SceneMenu cannot trigger a button click at __boxScroller.
		if (_ticks >= 5 && _group != null && __menu_bar != null)
		{
			if (FlxG.mouse.y >= FlxG.height - 50)
			{
				_group.active = false;
				__boxscroller._verticalScrollbar.active = false;
				__boxscroller._horizontalScrollbar.active = false;
				__boxscroller.active = false;
			}
					
			else
			{
				_group.active = true;
				__boxscroller.active = true;
				__boxscroller._verticalScrollbar.active = true;
				__boxscroller._horizontalScrollbar.active = true;
			}
		}
		
		if (Reg._buttonCodeValues != "") buttonCodeValues();
		
		super.update(elapsed);
	}
	
	/******************************
	 * at the time a button is created, a Reg._buttonCodeValues will be given a value. that value is used here to determine what block of code to read. 
	 * a Reg._yesNoKeyPressValueAtMessage with a value of one means that the "yes" button was clicked. a value of two refers to button with text of "no". 
	 */
	public function buttonCodeValues():Void
	{
		if (Reg._yesNoKeyPressValueAtMessage == 1 && Reg._buttonCodeValues == "d1000")
		{
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;

			rewardGivenUpdateBar();
		}
		
		if (Reg._yesNoKeyPressValueAtMessage == 1 && Reg._buttonCodeValues == "d1010")
		{
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;

			rewardGivenUpdateBar();
		}
		
		if (Reg._yesNoKeyPressValueAtMessage == 1 && Reg._buttonCodeValues == "d1020")
		{
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;

			rewardGivenUpdateBar();
		}
	}
	
	private function rewardGivenUpdateBar():Void
	{
		for (i in 0...9)
		{
			createBar((i+1), _quest_description[i], _bar_value_current[i], _bar_value_max[i], _rewards[0], _rewards[1], _rewards[2]);
		}
	}
	
	private function closeState():Void
	{
		if (RegCustom._enable_sound == true
		&&  Reg2._boxScroller_is_scrolling == false)
		{
			 FlxG.sound.play("click", 1, false);
		}
		
		FlxG.mouse.reset();
				
		RegTriggers._returnToLobbyMakeButtonsActive = true;
		
		__boxscroller.visible = false;
		visible = false;
		active = false;
		
	}
	
	private function claimReward():Void
	{
		_rewards.splice(3, 0);
		_rewards =  RegTypedef._dataDailyQuests._rewards.split(",");
		
		if (_rewards[2] == "1")
		{
			_rewards[2] = "2";
			RegTypedef._dataDailyQuests._rewards = _rewards[0] + "," + _rewards[1] + "," + _rewards[2];
			messageRewardGiven3();
		}
				
		if (_rewards[1] == "1")
		{
			_rewards[1] = "2";
			RegTypedef._dataDailyQuests._rewards = _rewards[0] + "," + _rewards[1] + "," + _rewards[2];
			messageRewardGiven2();
		}
		
		if (_rewards[0] == "1")
		{
			_rewards[0] = "2";
			RegTypedef._dataDailyQuests._rewards = _rewards[0] + "," + _rewards[1] + "," + _rewards[2];
			messageRewardGiven1();
		}
		
		_button_claim_reward.visible = false;
		_button_claim_reward.active = false;		
	}
	
	
	private function messageRewardGiven1():Void
	{	
		Reg._messageId = 5001;
		Reg._buttonCodeValues = "d1000";		
		SceneGameRoom.messageBoxMessageOrder();

		RegTypedef._dataStatistics._experiencePoints += 300;
			
		PlayState.clientSocket.send("Daily Quests Claim", RegTypedef._dataDailyQuests);
		haxe.Timer.delay(function (){}, Reg2._event_sleep);
		
		PlayState.clientSocket.send("Daily Reward Save", RegTypedef._dataStatistics);
		haxe.Timer.delay(function (){}, Reg2._event_sleep);
	}
	
	private function messageRewardGiven2():Void
	{	
		Reg._messageId = 5002;
		Reg._buttonCodeValues = "d1010";		
		SceneGameRoom.messageBoxMessageOrder();

		RegTypedef._dataStatistics._houseCoins += 100;
		
		PlayState.clientSocket.send("Daily Quests Claim", RegTypedef._dataDailyQuests);
		haxe.Timer.delay(function (){}, Reg2._event_sleep);
		
		PlayState.clientSocket.send("Daily Reward Save", RegTypedef._dataStatistics);
		haxe.Timer.delay(function (){}, Reg2._event_sleep);
	}
	
	private function messageRewardGiven3():Void
	{	
		Reg._messageId = 5003;
		Reg._buttonCodeValues = "d1020";		
		SceneGameRoom.messageBoxMessageOrder();

		RegTypedef._dataStatistics._creditsTotal += 50;
		
		PlayState.clientSocket.send("Daily Quests Claim", RegTypedef._dataDailyQuests);
		haxe.Timer.delay(function (){}, Reg2._event_sleep);
		
		PlayState.clientSocket.send("Daily Reward Save", RegTypedef._dataStatistics);
		haxe.Timer.delay(function (){}, Reg2._event_sleep);
	}
}//
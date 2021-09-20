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

/******************************
 * game events are drawn on this calendar so that players can see upcoming events.
 * @author kboardgames.com.
 */
class EventSchedule extends FlxState
{
	/******************************
	 * to title text
	 */
	private var _title:ButtonGeneralNetworkNo;
	
	/******************************
	 * Event Schedule text
	 */
	private var _textCalendarTitle:FlxText;
	
	/******************************
	 * print the numbers of the month on the calendar.
	 */
	private var _stringDayPrintToCalendar:Array<String> = 
	[for (p in 0...42) ""];
	
	/******************************
	 * first event if any for that day.
	 */
	private var _stringEventRow1PrintToCalendar:Array<String> = 
	[for (p in 0...42) ""];
	
	/******************************
	 * second event if any for that day.
	 */
	private var _stringEventRow2PrintToCalendar:Array<String> = 
	[for (p in 0...42) ""];
	
	/******************************
	 * third event if any for that day.
	 */
	private var _stringEventRow3PrintToCalendar:Array<String> = 
	[for (p in 0...42) ""];
	
	/******************************
	 * FlxText to display the Sun, Mon, Tue, Wed, Thu, Fri, Sat text below the calendar title.
	 */
	private var _text_title_days:Array<FlxText> = [];
	
	/******************************
	 * Sun, Mon, Tue, Wed, Thu, Fri, Sat text for the calendar _text_title_days sub title.
	 */
	private var _title_days:Array<String> = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
	
	/******************************
	 * y offset used with the _text_title_days FlxText array.
	 */
	private var _offsetTextDayWord:Int = 40;	
	
	/******************************
	 * current month text.
	 */
	public static var _textMonth:String;
	
	/******************************
	 * current year text.
	 */
	private var _textYear:String;
	
	/******************************
	 * current year number.
	 */
	private var _intYear:Int;	
	
	/******************************
	 * day of week starts at 0 for Sunday.
	 */
	private var _intDayOfWeek:Int;
	
	/******************************
	 * current day number.
	 */
	private var _intDay:Int;
	
	/******************************
	 * month January starts at month 0 not 1.
	 */
	private var _intMonth:Int;
	
	/******************************
	 * this is the real current calendar month. the month from the command _intMonth = Std.parseInt(DateTools.format(Date.now(), "%m")) -1; the month that we live in.
	 */
	private var _intMonthCurrent:Int;
	
	/******************************
	* Used in loop to represent the date display and will continue to run until the number of days in that month have been reached
	*/
	private var _intDateCounter:Int = 1;
	
	/******************************
	 * the amount of days for the month selected.
	 */
	public static var  _intDaysInMonth:Int = 0;
	
	/******************************
	 * used to change the weeks when this counter reaches 7.
	 */
	private var  _intDayOfWeekCounter:Int = 0;
		
	/******************************
	 * y values used to display the day number text and events text on the calendar.
	 */
	private var _intCalendarCoordinateY:Array<Int> = 
	[117, 226, 335, 444, 553, 662];
	 
	/******************************
	 * x values used to display the day number text and events text on the calendar.
	 */
	private var _intCalendarCoordinateX:Array<Int> = 
	[129, 296, 463, 629, 796, 963, 1130];
	
	/******************************
	 * calendar square event row background y offset.
	 */
	private var _offsetBgRowY:Int = 1;
	
	/******************************
	 * calendar square event row background x offset.
	 */
	private var _offsetBgRowX:Int = -6;
	
	/******************************
	 * event row FlxText y offset.
	 */
	private var _offsetY:Int = -2;
	
	/******************************
	 * there are three rows for the event on one calendar square. this offset var is used when an event text and its background need to be actually positioned.
	 */
	private var _offsetEventRow1Y:Int = 25;
	
	/******************************
	 * there are three rows for the event on one calendar square. this offset var is used when an event text and its background need to be actually positioned.
	 */
	private var _offsetEventRow2Y:Int = 50;
	
	/******************************
	 * there are three rows for the event on one calendar square. this offset var is used when an event text and its background need to be actually positioned.
	 */
	private var _offsetEventRow3Y:Int = 75;
	
	/******************************
	 * this borders the current day on the calendar.
	 */
	private var _current_day_border:FlxSprite;
	
	/******************************
	 * outputs the day numbers on the calendar. _textDayNumber[1].text is located at the first calendar square.
	 */
	private var _textDayNumber:Array<FlxText> = [];
		
	/******************************
	 * used to change the background of the event at the _bgEventRow1Number sprite element.
	 */
	private static var _bgRow1Colour:Array<FlxColor> = 
	[for (p in 0...42) 0xFF000000 ];
	
	/******************************
	 * used to change the background of the event at the _bgEventRow2Number sprite element.
	 */
	private static var _bgRow2Colour:Array<FlxColor> = 
	[for (p in 0...42) 0xFF000000 ];
	
	/******************************
	 * used to change the background of the event at the _bgEventRow3Number sprite element.
	 */
	private static var _bgRow3Colour:Array<FlxColor> = 
	[for (p in 0...42) 0xFF000000 ];
	
	/******************************
	 * the background behind a calendar square. Each square can have three events on it. the location of the event text is called a row.
	 */	
	private var _bgEventRow1Number:Array<FlxSprite> = [];
	
	/******************************
	 * the background behind a calendar square. Each square can have three events on it. the location of the event text is called a row.
	 */
	private var _bgEventRow2Number:Array<FlxSprite> = [];
	
	/******************************
	 * the background behind a calendar square. Each square can have three events on it. the location of the event text is called a row.
	 */
	private var _bgEventRow3Number:Array<FlxSprite> = [];
	
	/******************************
	 * three events can be displayed one after another on a calendar day square. This var is displayed just under the day number of that calendar square. so, if its the first day of the month and an event have a day property of day_1 then that event will be displayed just under the day text on the calendar.
	 */
	private var _textEventRow1Number:Array<FlxText> = [];
	
	/******************************
	 * if there is an event displayed on the calendar just under the day 1 text then this text will be displayed just under that event so that there are two events displayed at day 1. so if _textEventRow2Number1.text is not empty then this var will be used.
	 */	
	private var _textEventRow2Number:Array<FlxText> = [];
	
	/******************************
	 * there event rows can be used on each calendar day. if for whatever reason there is a four event for that day then that event should not be used.
	 */
	private var _textEventRow3Number:Array<FlxText> = [];	
	
	/******************************
	 * go back 1 month.
	 */
	private var _backwards:ButtonGeneralNetworkNo;
	
	/******************************
	 * go forward 1 month.
	 */
	private var _forwards:ButtonGeneralNetworkNo;
	
	/******************************
	 * a value of 0 and user cannot go back a month. A value of 6 and a user cannot go any more forward in month. this var stop a user from going back past the current month because those events are no more, plus cannot go too far in the future because that year might not be supported by Date command.
	 */
	private var _locationInCalendar:Int = 0;	
	
	/******************************
	 * used to stop a double firing of mouse. the firing is once at mainState when clicking the text to enter this class and again at this class if mouse is located at a calendar text.
	 */
	private var _ticks:Int = 0;
	
	override public function create():Void
	{
		persistentDraw = false;
		persistentUpdate = false;
		
		FlxG.mouse.reset();
		FlxG.mouse.enabled = true;
		
		_ticks = 0;
		
		_textDayNumber.splice(0, _textDayNumber.length);
		_bgEventRow1Number.splice(0, _bgEventRow1Number.length);
		_textEventRow1Number.splice(0, _textEventRow1Number.length);
		_bgEventRow2Number.splice(0, _bgEventRow2Number.length);
		_textEventRow2Number.splice(0, _textEventRow2Number.length);
		_bgEventRow3Number.splice(0, _bgEventRow3Number.length);
		_textEventRow3Number.splice(0, _textEventRow3Number.length);
		_text_title_days.splice(0, _text_title_days.length);
		
		FlxG.stage.quality = StageQuality.BEST;		
		FlxG.camera.antialiasing = true;
		FlxG.camera.pixelPerfectRender = true;
				
		// fill the screen with a random color.
		var _background_scene_color = new FlxSprite();
		_background_scene_color.makeGraphic(FlxG.width,FlxG.height,FlxColor.WHITE);
		_background_scene_color.color = FlxColor.fromHSB(FlxG.random.int(1, 360), 0.8, RegCustom._background_brightness[Reg._tn]);
		_background_scene_color.scrollFactor.set(0, 0);
		add(_background_scene_color);
		
		var _calendarBackground = new FlxSprite(0, 0);
		_calendarBackground.loadGraphic("assets/images/calendarGrid.png", false);
		_calendarBackground.scrollFactor.set(0, 0);	
		_calendarBackground.screenCenter(XY);
		_calendarBackground.y += 53;
		add(_calendarBackground);
		
		_current_day_border = new FlxSprite(0, 0);
		_current_day_border.loadGraphic("assets/images/calendarDayBorder.png", false);
		_current_day_border.scrollFactor.set(0, 0);	
		add(_current_day_border);		
					
		_intDay = Std.parseInt(DateTools.format(Date.now(), "%d"));
		// month January starts at 0 not 1.
		_intMonth = Std.parseInt(DateTools.format(Date.now(), "%m")) -1;	
		_intMonthCurrent = _intMonth;
		_intYear = 	Std.parseInt(DateTools.format(Date.now(), "%Y"));
						
		_textCalendarTitle = new FlxText(0, 0, 0, "");
		_textCalendarTitle.scrollFactor.set();
		_textCalendarTitle.text = "Event Schedule. " + Std.string(_intYear) + "-" + _textMonth + "-" + Std.string(_intDay);
		_textCalendarTitle.setFormat(Reg._fontTitle, 44, FlxColor.YELLOW);
		_textCalendarTitle.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 3);
		_textCalendarTitle.screenCenter(X);
		_textCalendarTitle.x += 40;
		_textCalendarTitle.y = 20;
		add(_textCalendarTitle);		
		
		daysNewItToScene();
			
		eventRow1NewItToScene();
		eventRow2NewItToScene();
		eventRow3NewItToScene();
		
		calendarOutput();		
		calendarDayImageOutput();		
			
		_backwards = new ButtonGeneralNetworkNo(117, 0, "<", 80, 35, 22, RegCustom._button_text_color[Reg._tn], 0, calendarBackward);
		_backwards.label.font = Reg._fontDefault;
		_backwards.label.size = 22;
		_backwards.y = 20;
		_backwards.visible = false;
		_backwards.active = false;
		add(_backwards);
		
		_forwards = new ButtonGeneralNetworkNo(222, 0, ">", 80, 35, 22, RegCustom._button_text_color[Reg._tn], 0, calendarForward);
		_forwards.label.font = Reg._fontDefault;
		_forwards.label.size = 22;
		_forwards.y = 20;
		add(_forwards);
		
		_title = new ButtonGeneralNetworkNo(FlxG.width - 300, 0, "To Title", 170 + 15, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, backToTitle);
		_title.label.font = Reg._fontDefault;
		_title.y = 20;
		add(_title);
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (_ticks == 0 && FlxG.mouse.pressed == false) _ticks = 1; 
		
		else if (ActionInput.justPressed() == true && _ticks == 1)
		{
			for (i in 0...37)
			{
				if (ActionInput.overlaps(_bgEventRow1Number[i])
				&&  _textEventRow1Number[i].text != "")
				{
					if (RegCustom._sound_enabled[Reg._tn] == true
					&&  Reg2._boxScroller_is_scrolling == false)
						FlxG.sound.play("click", 1, false);
					openSubState(new GameMessageEvent(_textEventRow1Number[i].text));
				}
				
				if (ActionInput.overlaps(_bgEventRow2Number[i])
				&&  _textEventRow2Number[i].text != "")
				{
					if (RegCustom._sound_enabled[Reg._tn] == true
					&&  Reg2._boxScroller_is_scrolling == false)
						FlxG.sound.play("click", 1, false);
					openSubState(new GameMessageEvent(_textEventRow2Number[i].text));
				}
				
				if (ActionInput.overlaps(_bgEventRow3Number[i])
				&&  _textEventRow3Number[i].text != "")
				{
					if (RegCustom._sound_enabled[Reg._tn] == true
					&&  Reg2._boxScroller_is_scrolling == false)
						FlxG.sound.play("click", 1, false);
					openSubState(new GameMessageEvent(_textEventRow3Number[i].text));
				}
				
			}			
			
		}
		
		super.update(elapsed);	
	}
	
	
	/******************************
	 * prints the calendar day border image that surrounds the current day to the stage.
	 */
	private function calendarDayImageOutput():Void
	{
		_intDayOfWeekCounter = _intDayOfWeek;
		var _row:Int = 0;
		
		_current_day_border.visible = false;
		
		// This loop represents the date display and will continue to run until the number of days in that month have been reached
		for (_intDateCounter in 1..._intDaysInMonth+1)
		{				
			
			if (_intDayOfWeekCounter > 6)
			{
				_intDayOfWeekCounter = 0;
				_row += 1;
			}
			
			if (_intDateCounter == _intDay && _intMonthCurrent == _intMonth)
			{
				_current_day_border.y = _intCalendarCoordinateY[_row]-6;
				_current_day_border.x = _intCalendarCoordinateX[_intDayOfWeekCounter] - 13;
				
				_current_day_border.visible = true;
			}			
			
			_intDayOfWeekCounter += 1;
		}

	}
	
	// print the calendar to the stage.
	private function calendarOutput():Void
	{
		getDaysInMonth(_intMonth, _textMonth, _intYear);
		_textMonth = getMonthText(_intMonth, _textMonth);
		
		// this does leap years. 0 = Sunday, 6 = Saturday.
		_intDayOfWeek = getDayOfWeek(_intYear, _intMonth, 1);


		// clear the calendar.
		for (i in 0...37)
		{
			_stringDayPrintToCalendar[i] = ""; 
			_stringEventRow1PrintToCalendar[i] = "";
			_stringEventRow2PrintToCalendar[i] = "";
			_stringEventRow3PrintToCalendar[i] = "";
		}
		
		// this var is used to populate the calendar with day text.
		var _step:Int = 0;
		
		for (i in _intDayOfWeek..._intDaysInMonth + _intDayOfWeek)
		{
			_step += 1;
			_stringDayPrintToCalendar[i] = Std.string(_step);			
		}
		
		_textCalendarTitle.text = "Event Schedule. " + Std.string(_intYear) + "-" + _textMonth;
		
		getBackgroundRowColours();		
		assignBackgroundColoursToRows();		
		assignTextToRows();
		
		calendarDayImageOutput();
	}
	
	/******************************
	 * Get a color for _bgRow#Colour[] from the Reg2._eventBackgroundColour then changeBackgroundRowColours will use that _bgRow#Colour[] for the background sprite at drawBackgroundRowColours().
	 */
	private function getBackgroundRowColours():Void
	{
		// check if there are events for the month.
		for (i in 0...40) // max events in this board game is 40.
		{
			// find the event to display on calendar for the current month.
			if (Reg2._eventMonths[i] != null)
			{
				if (Reg2._eventMonths[i][_intMonth] == 1) // 1 = true.
				{
					// an event exists for this month so find the days.
					for (ii in 0...28)
					{
						if (Reg2._eventDays[i][ii] == 1) // day found for event.
						{
							// if row1's text is empty...
							if (_stringEventRow1PrintToCalendar[ii + _intDayOfWeek] == "")
							{
								_stringEventRow1PrintToCalendar[ii + _intDayOfWeek] = Reg2._eventName[i];
								
								// set the colour to this var so that the _bgEventRow1Number## can change to that colour.
								_bgRow1Colour[ii + _intDayOfWeek] = setBgRowColor(Reg2._eventBackgroundColour[i]);
								
							}
							// else if row2's text is empty...
							else if (_stringEventRow2PrintToCalendar[ii + _intDayOfWeek] == "")
							{
								_stringEventRow2PrintToCalendar[ii + _intDayOfWeek] = Reg2._eventName[i];
								
								_bgRow2Colour[ii + _intDayOfWeek] = setBgRowColor(Reg2._eventBackgroundColour[i]);
							}
							
							else 
							{
								_stringEventRow3PrintToCalendar[ii + _intDayOfWeek] = Reg2._eventName[i];
								
								_bgRow3Colour[ii + _intDayOfWeek] = setBgRowColor(Reg2._eventBackgroundColour[i]);
							}
						}
					}
				}
			}
		}
	
	}
		
	
	/******************************
	 * this assigns the background colours behind the event text if _bgRow#Colour at getBackgroundRowColours() has a colour other than black. the change of the background colours will happen at next update().
	 */	
	private function assignBackgroundColoursToRows():Void
	{
		for (i in 0...37)
		{
			if (_stringEventRow1PrintToCalendar[i] != "")
			_bgEventRow1Number[i].color = _bgRow1Colour[i];
			else _bgEventRow1Number[i].color = 0xFF000000;
			
			if (_stringEventRow2PrintToCalendar[i] != "")
			_bgEventRow2Number[i].color = _bgRow2Colour[i];
			else _bgEventRow2Number[i].color = 0xFF000000;
			
			if (_stringEventRow3PrintToCalendar[i] != "")
			_bgEventRow3Number[i].color = _bgRow3Colour[i];
			else _bgEventRow3Number[i].color = 0xFF000000;
		}
		
	}
	
	/******************************
	 * if the text equals nothing then the text will clear any of its data that may have been at a calendar square. also, if text now has data then that data will be printed to the calendar day.
	 * _textDayNumber[1].text is located at the first calendar square.
	 * text will be updated at the next update().
	 */
	private function assignTextToRows():Void
	{
		for (i in 0...37)
		{
			_textDayNumber[i].text = _stringDayPrintToCalendar[i];
			_textEventRow1Number[i].text = _stringEventRow1PrintToCalendar[i];
			_textEventRow2Number[i].text = _stringEventRow2PrintToCalendar[i];
			_textEventRow3Number[i].text = _stringEventRow3PrintToCalendar[i];
		}
		
	}
	
	/******************************
	* this does leap years. 0 = Sunday, 6 = Saturday.
	*/
	public static function getDayOfWeek(_intYear:Int, _intMonth:Int, _intDay:Int):Int
	{
		var _intDayOfWeek = new Date(_intYear, _intMonth, _intDay, 1, 1, 1).getDay();
		return _intDayOfWeek;
	}
	
	/******************************
	* Get the amount of days in a month. this does leap years. 0 = January,  11 = December.
	*/
	public static function getDaysInMonth(_intMonth:Int, _textMonth:String, _intYear:Int):Int
	{
		switch (_intMonth)
		{
			case 0: // January
			{
				_intDaysInMonth = 31;
			}
		  
			case 1: // February.
			{
				if (_intYear % 400 == 0 || (_intYear % 4 == 0 && _intYear % 100 != 0))
					_intDaysInMonth = 29;
				else
					_intDaysInMonth = 28;
			}
		  
			case 2: // March
			{
				_intDaysInMonth = 31;
			}
			
			case 3: // April
			{
				_intDaysInMonth = 30;
			}
			
			case 4: // May
			{
				_intDaysInMonth = 31;
			}
			
			case 5: // June
			{
				_intDaysInMonth = 30;
			}
			
			case 6: // July
			{
				_intDaysInMonth = 31;
			}
			
			case 7: // August
			{
				_intDaysInMonth = 31;
			}
				
			case 8: // September
			{
				_intDaysInMonth = 30;
			}
		
			case 9: // October
			{
				_intDaysInMonth = 31;
			}
			
			case 10: // November
			{
				_intDaysInMonth = 30;
			}
			
			case 11: // December
			{
				_intDaysInMonth = 31;
			}
		  
		}
		
		return _intDaysInMonth;
	}

	/******************************
	* Get the amount of days in a month. this does leap years. 0 = January,  11 = December.
	*/
	public static function getMonthText(_intMonth:Int, _textMonth:String):String
	{
		switch (_intMonth)
		{
			case 0:
			{
				_textMonth = "Jan";
			}
		  
			case 1:
			{
				_textMonth = "Feb";
			}
		  
			case 2:
			{
				_textMonth = "Mar";
			}
			
			case 3:
			{
				_textMonth = "Apr";
			}
			
			case 4:
			{
				_textMonth = "May";
			}
			
			case 5:
			{
				_textMonth = "Jun";
			}
			
			case 6:
			{
				_textMonth = "Jul";
			}
			
			case 7:
			{
				_textMonth = "Aug";
			}
				
			case 8:
			{
				_textMonth = "Sep";
			}
		
			case 9:
			{
				_textMonth = "Oct";
			}
			
			case 10:
			{
				_textMonth = "Nov";				
			}
			
			case 11:
			{
				_textMonth = "Dec";
			}
		  
		}
		
		return _textMonth;
	}

		
	private function calendarBackward():Void
	{
		_locationInCalendar -= 1;
		
		_forwards.active = true;
		_forwards.visible = true;
		
		_intMonth -= 1;
			
		if (_intMonth < 0) // months start at 0.
		{
			_intMonth = 11;
			_intYear -= 1;
		}
			
		calendarOutput();
		
		if (_locationInCalendar == 0)
		{
			_backwards.visible = false;
			_backwards.active = false;			
		}	
		
	}
	
	private function calendarForward():Void
	{
		_locationInCalendar += 1;
		
		_backwards.active = true;
		_backwards.visible = true;
		
		_intMonth += 1;
			
		if (_intMonth > 11) // value of 11 is December.
		{
			_intMonth = 0;
			_intYear += 1;
		}

		calendarOutput();

		if (_locationInCalendar == 6)
		{
			_forwards.visible = false;
			_forwards.active = false;			
		}		
	}

	private function backToTitle():Void
	{
		RegTriggers._mainStateMakeActiveElements = true;
		
		//close();
		FlxG.switchState(new MenuState());
	}
	
	
	/******************************
	 * print the days to the scene.
	 */
	private function daysNewItToScene():Void
	{
		for (i in 0...7)
		{
			_text_title_days[i] = new FlxText(0, 0, 0, _title_days[i]);
			_text_title_days[i].setFormat(Reg._fontDefault, 26, FlxColor.YELLOW);
			_text_title_days[i].setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
			_text_title_days[i].scrollFactor.set();
			_text_title_days[i].fieldWidth = 152;
			_text_title_days[i].setPosition(_intCalendarCoordinateX[i], _intCalendarCoordinateY[0] - _offsetTextDayWord);
			add(_text_title_days[i]);
		}		
			
		var _i = -1;	// array elements, used to create them.
		
		// draw the day numbers to the scene.
		for (yy in 0...7)
		{
			for (xx in 0...7)
			{
				_i += 1;
				
				var _textDay = new FlxText(_intCalendarCoordinateX[xx], _intCalendarCoordinateY[yy], 0, "");
				_textDay.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.WHITE);
				_textDay.scrollFactor.set();
				_textDay.fieldWidth = 152;
				_textDay.text = _stringDayPrintToCalendar[_i];
								
				_textDayNumber.push(_textDay);
				add(_textDayNumber[_i]);
				
				if (_i >= 36) break;
			}
			
			if (_i >= 36) break;
			
		}
		
	}
	
	/******************************
	 * get the FlxColor from the Reg2._eventBackgroundColour. That color is then returned and then set to the background underneath of event text.
	 */
	public static function setBgRowColor(_eventColour:Int):FlxColor
	{
		var _colourToReturn:FlxColor = 0xFF000000;
		
		switch(_eventColour)
		{
			case 0: // red
			{
				_colourToReturn = 0xFF330000;
			}
			
			case 1: //yellow
			{
				_colourToReturn = 0xFF333300;
			}
			
			case 2: // blue
			{
				_colourToReturn = 0xFF000033;
			}
			
			case 3: // green
			{				
				_colourToReturn = 0xFF003333;
			}
			
			case 4: // purple
			{				
				_colourToReturn = 0xFF330033;
			}
			
			case 5: // orange
			{				
				_colourToReturn = 0xFF993300;
			}
			
			case 6: // brown
			{				
				_colourToReturn = 0xFF442200;
			}
			
			case 7: // pink
			{				
				_colourToReturn = 0xFF991133;
			}
			
			case 8: // grey
			{				
				_colourToReturn = 0xFF333333;
			}
		}
		
		return _colourToReturn;
	}
	
	
	/******************************
	 * print everts at row 1 to the scene.
	 */
	private function eventRow1NewItToScene():Void
	{
		var _i = -1;	// array elements, used to create them.
		
		// draw the day numbers to the scene.
		for (yy in 0...7)
		{
			for (xx in 0...7)
			{
				_i += 1;
				
				var _bgEventRow1 = new FlxSprite(_intCalendarCoordinateX[xx] + _offsetBgRowX, _intCalendarCoordinateY[yy] + _offsetEventRow1Y + _offsetBgRowY);
				_bgEventRow1.makeGraphic(156, 25);
				_bgEventRow1.scrollFactor.set(0, 0);	
				add(_bgEventRow1);
								
				_bgEventRow1Number.push(_bgEventRow1);
				add(_bgEventRow1Number[_i]);
				
				
				var _textEventRow1 = new FlxText(_intCalendarCoordinateX[xx], _intCalendarCoordinateY[yy] + _offsetEventRow1Y + _offsetY, 0, "");
				_textEventRow1.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.WHITE);
				_textEventRow1.scrollFactor.set();
				_textEventRow1.fieldWidth = 152;
				_textEventRow1.wordWrap = false;
				_textEventRow1.text = _stringEventRow1PrintToCalendar[0];
				add(_textEventRow1);
				
				_textEventRow1Number.push(_textEventRow1);
				add(_textEventRow1Number[_i]);
				
				if (_i >= 36) break;
			}
			
			if (_i >= 36) break;
			
		}
		
	}
	
	
	/******************************
	* print everts at row 2 to the scene.
	*/
	private function eventRow2NewItToScene():Void
	{
		var _i = -1;	// array elements, used to create them.
		
		// draw the day numbers to the scene.
		for (yy in 0...7)
		{
			for (xx in 0...7)
			{
				_i += 1;
				
				var _bgEventRow2 = new FlxSprite(_intCalendarCoordinateX[xx] + _offsetBgRowX, _intCalendarCoordinateY[yy] + _offsetEventRow2Y + _offsetBgRowY);
				_bgEventRow2.makeGraphic(156, 25);
				_bgEventRow2.scrollFactor.set(0, 0);	
				add(_bgEventRow2);
								
				_bgEventRow2Number.push(_bgEventRow2);
				add(_bgEventRow2Number[_i]);
				
				
				var _textEventRow2 = new FlxText(_intCalendarCoordinateX[xx], _intCalendarCoordinateY[yy] + _offsetEventRow2Y + _offsetY, 0, "");
				_textEventRow2.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.WHITE);
				_textEventRow2.scrollFactor.set();
				_textEventRow2.fieldWidth = 152;
				_textEventRow2.wordWrap = false;
				_textEventRow2.text = _stringEventRow2PrintToCalendar[0];
				add(_textEventRow2);
				
				_textEventRow2Number.push(_textEventRow2);
				add(_textEventRow2Number[_i]);
				
				if (_i >= 36) break;
			}
			
			if (_i >= 36) break;
			
		}
	}
	
	/******************************
	* print everts at row 3 to the scene.
	*/
	private function eventRow3NewItToScene():Void
	{
		var _i = -1;	// array elements, used to create them.
		
		// draw the day numbers to the scene.
		for (yy in 0...7)
		{
			for (xx in 0...7)
			{
				_i += 1;
				
				var _bgEventRow3 = new FlxSprite(_intCalendarCoordinateX[xx] + _offsetBgRowX, _intCalendarCoordinateY[yy] + _offsetEventRow3Y + _offsetBgRowY);
				_bgEventRow3.makeGraphic(156, 25);
				_bgEventRow3.scrollFactor.set(0, 0);	
				add(_bgEventRow3);
								
				_bgEventRow3Number.push(_bgEventRow3);
				add(_bgEventRow3Number[_i]);
				
				
				var _textEventRow3 = new FlxText(_intCalendarCoordinateX[xx], _intCalendarCoordinateY[yy] + _offsetEventRow3Y + _offsetY, 0, "");
				_textEventRow3.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.WHITE);
				_textEventRow3.scrollFactor.set();
				_textEventRow3.fieldWidth = 152;
				_textEventRow3.wordWrap = false;
				_textEventRow3.text = _stringEventRow3PrintToCalendar[0];
				add(_textEventRow3);
				
				_textEventRow3Number.push(_textEventRow3);
				add(_textEventRow3Number[_i]);
				
				if (_i >= 36) break;
			}
			
			if (_i >= 36) break;
			
		}
	}
}//
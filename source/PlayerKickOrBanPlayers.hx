/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

/**
 * at __scene_waiting_room, a player that hosts the room can kick or ban other players by clicking the player name which will display a message box with the choices of kick or ban.
 * @author kboardgames.com
 */

class PlayerKickOrBanPlayers extends FlxState
 {	/**********************************************************************************
	* at __scene_waiting_room, this is the name of the player in front of the player's stats. this text of player 1 is always shown while player is the host of the room. the button with the name of the other players will be shown over top of the other text.
	*/
	public var textKickOrBan1:FlxText;
	public var textKickOrBan2:FlxText;
	public var textKickOrBan3:FlxText;
	public var textKickOrBan4:FlxText;
	
	/******************************
	* button 1 referring to player 1 is not needed because host of the room should not kick or ban self. these buttons with the names of player 2, 3 and 4 will only display for the host of the room. clicking a button will display a message box with kick and ban options.
	*/
	public var buttonKickOrBan2:ButtonGeneralNetworkNo;
	public var buttonKickOrBan3:ButtonGeneralNetworkNo;
	public var buttonKickOrBan4:ButtonGeneralNetworkNo;
	
	public function new ()
	{
		super();
		
		RegFunctions.fontsSharpen();

		// name of each player in front of each player's stats of win, lose or draw.
		textKickOrBan1 = new FlxText(60, 572, 0, "", 20);
		textKickOrBan1.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		if (RegCustom._chat_when_at_room_enabled[Reg._tn] == false)
			textKickOrBan1.x += 180; // half of 360 is the width of chatter. half is used to center it to scene.
		textKickOrBan1.scrollFactor.set(0, 0);
		add(textKickOrBan1);
		
		// player 2's name.
		textKickOrBan2 = new FlxText(280, 572, 0, "", 20);
		textKickOrBan2.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		if (RegCustom._chat_when_at_room_enabled[Reg._tn] == false)
			textKickOrBan2.x += 180; // half of 360 is the width of chatter. half is used to center it to scene.
		textKickOrBan2.scrollFactor.set(0, 0);
		add(textKickOrBan2);
		
		textKickOrBan3 = new FlxText(500, 572, 0, "", 20);
		textKickOrBan3.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		if (RegCustom._chat_when_at_room_enabled[Reg._tn] == false)
			textKickOrBan3.x += 180; // half of 360 is the width of chatter. half is used to center it to scene.
		textKickOrBan3.scrollFactor.set(0, 0);
		add(textKickOrBan3);
		
		textKickOrBan4 = new FlxText(720, 572, 0, "", 20);
		textKickOrBan4.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		if (RegCustom._chat_when_at_room_enabled[Reg._tn] == false)
			textKickOrBan4.x += 180; // half of 360 is the width of chatter. half is used to center it to scene.
		textKickOrBan4.scrollFactor.set(0, 0);
		add(textKickOrBan4);
				
		//----------------------------------
		// buttons which are displayed over top of text players name but never for player 1. those buttons trigger kick/ban message box.
		buttonKickOrBan2 = new ButtonGeneralNetworkNo(280, 565, "", 205, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, kickOrBanMessage.bind(2), RegCustom._button_color[Reg._tn], false);
		buttonKickOrBan2.label.font = Reg._fontDefault;
		buttonKickOrBan2.label.alignment = FlxTextAlign.LEFT;
		buttonKickOrBan2.label.fieldWidth = 200;
		if (RegCustom._chat_when_at_room_enabled[Reg._tn] == false)
			buttonKickOrBan2.x += 180; // half of 360 is the width of chatter. half is used to center it to scene.
		add(buttonKickOrBan2);
		buttonKickOrBan2.visible = false;
		buttonKickOrBan2.active = false;
		
		buttonKickOrBan3 = new ButtonGeneralNetworkNo(500, 565, "", 205, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, kickOrBanMessage.bind(3), RegCustom._button_color[Reg._tn], false);
		buttonKickOrBan3.label.font = Reg._fontDefault;
		buttonKickOrBan3.label.alignment = FlxTextAlign.LEFT;
		buttonKickOrBan3.label.fieldWidth = 200;
		if (RegCustom._chat_when_at_room_enabled[Reg._tn] == false)
			buttonKickOrBan3.x += 180; // half of 360 is the width of chatter. half is used to center it to scene.
		add(buttonKickOrBan3);
		buttonKickOrBan3.visible = false;
		buttonKickOrBan3.active = false;
		
		buttonKickOrBan4 = new ButtonGeneralNetworkNo(720, 565, "", 205, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, kickOrBanMessage.bind(4), RegCustom._button_color[Reg._tn], false);
		buttonKickOrBan4.label.font = Reg._fontDefault;
		buttonKickOrBan4.label.alignment = FlxTextAlign.LEFT;
		buttonKickOrBan4.label.fieldWidth = 200;
		if (RegCustom._chat_when_at_room_enabled[Reg._tn] == false)
			buttonKickOrBan4.x += 180; // half of 360 is the width of chatter. half is used to center it to scene.
		add(buttonKickOrBan4);
		buttonKickOrBan4.visible = false;
		buttonKickOrBan4.active = false;
	}
	
	public function kickOrBanMessage(_num:Int):Void
	{
		Reg._messageId = 13005;
		Reg._buttonCodeValues = "p1000";
		SceneGameRoom.messageBoxMessageOrder();
		
		RegTypedef._dataPlayers._usernameInvite = RegTypedef._dataOnlinePlayers._usernamesOnline[_num];
		
		// set the name of the player that host would like to either kick or ban. the host can still cancel the action by clicking the top right corner of message box.
		// we can use this var to get the current kicked or banned username when that user tries to re-enter the room.
		Reg._actionWho = RegTypedef._dataPlayers._actionWho = RegTypedef._dataPlayers._usernamesDynamic[_num-1]; 
				
	}
	
	private function buttonCodeValues():Void
	{
			
		// kick
		if (Reg._yesNoKeyPressValueAtMessage == 1 &&  Reg._buttonCodeValues == "p1000")
		{
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;
			
			RegTypedef._dataPlayers._actionNumber = 1;
			RegTypedef._dataPlayers._actionWho = Reg._actionWho;
			
			PlayState.send("Action By Player", RegTypedef._dataPlayers);
			
		}
		
		// ban
		if (Reg._yesNoKeyPressValueAtMessage == 2 && Reg._buttonCodeValues == "p1000")
		{			
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;
			
			RegTypedef._dataPlayers._actionNumber = 2;
			RegTypedef._dataPlayers._actionWho = Reg._actionWho;
			
			PlayState.send("Action By Player", RegTypedef._dataPlayers);
			
		}
		
		// action ban/kick user. "X" button mouse clicked.
		if (Reg._yesNoKeyPressValueAtMessage == 3 && Reg._buttonCodeValues == "p1000")
		{			
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;

		}
	}	
	
	override public function update(elapsed:Float):Void 
	{	
		textKickOrBan1.text = Std.string(RegTypedef._dataPlayers._usernamesDynamic[0]);
				
		// at server, RegTypedef._dataPlayers._usernamesDynamic are grabbed from the MySQL database, and here at client, at __scene_waiting_room, the event "Get Statistics Win Loss Draw" gets the current players, populates this var and here we determine if a name should be displayed to screen.
		
		// enter if player exists for this room.
		if (RegTypedef._dataPlayers._usernamesDynamic[1] != "" && RegTypedef._dataPlayers._actionWho != RegTypedef._dataPlayers._usernamesDynamic[1])
		{
			// set the text of the players name to both players 1's text and button
			textKickOrBan2.text = RegTypedef._dataPlayers._usernamesDynamic[1];buttonKickOrBan2.label.text = " " + RegTypedef._dataPlayers._usernamesDynamic[1];
			
			// if this condition is true then player is host of the room. display the buttons over top of the text.
			if (Std.string(RegTypedef._dataAccount._username) == Std.string(RegTypedef._dataPlayers._usernamesDynamic[0]))
			{
				buttonKickOrBan2.active = true;
				buttonKickOrBan2.visible = true;
				textKickOrBan2.visible = false; // needed because the last character of a long name can be seen peeking out of the right side of the buttonKickOrBan2 button.
			}
			
			else if (Reg._buttonCodeValues != "p1000")
			{
				buttonKickOrBan2.visible = false;
				buttonKickOrBan2.active = false;
				textKickOrBan2.visible = true;
			}			
		}	
		
		else if (RegTypedef._dataPlayers._usernamesDynamic[1] == "" && Reg._buttonCodeValues != "p1000") // player does not exist so delete button.
		{
			buttonKickOrBan2.label.text = "";
			textKickOrBan2.text = "";
			
			buttonKickOrBan2.visible = false;
			buttonKickOrBan2.active = false;
			textKickOrBan2.visible = true;
		}
		
		// this block of code is almost the same as the above but it is for player 3. remember that arrays always start at 0 not 1.
		if (RegTypedef._dataPlayers._usernamesDynamic[2] != "" && RegTypedef._dataPlayers._actionWho != RegTypedef._dataPlayers._usernamesDynamic[2])
		{
			textKickOrBan3.text = RegTypedef._dataPlayers._usernamesDynamic[2];buttonKickOrBan3.label.text = " " + RegTypedef._dataPlayers._usernamesDynamic[2];
			
			if (Std.string(RegTypedef._dataAccount._username) == Std.string(RegTypedef._dataPlayers._usernamesDynamic[0]))
			{
				buttonKickOrBan3.active = true;
				buttonKickOrBan3.visible = true;
				textKickOrBan3.visible = false;
			}
			
			else if (Reg._buttonCodeValues != "p1000")
			{
				buttonKickOrBan3.visible = false;
				buttonKickOrBan3.active = false;
				textKickOrBan3.visible = true;
			}
			
		}	
		
		else if (RegTypedef._dataPlayers._usernamesDynamic[2] == "" && Reg._buttonCodeValues != "p1000")
		{
			buttonKickOrBan3.label.text = "";
			textKickOrBan3.text = "";
			
			buttonKickOrBan3.visible = false;
			buttonKickOrBan3.active = false;
			textKickOrBan3.visible = true;
		}
		
		if (RegTypedef._dataPlayers._usernamesDynamic[3] != "" && RegTypedef._dataPlayers._actionWho != RegTypedef._dataPlayers._usernamesDynamic[3])
		{
			textKickOrBan4.text = RegTypedef._dataPlayers._usernamesDynamic[3];buttonKickOrBan4.label.text = " " + RegTypedef._dataPlayers._usernamesDynamic[3];
			
			if (Std.string(RegTypedef._dataAccount._username) == Std.string(RegTypedef._dataPlayers._usernamesDynamic[0]))
			{
				buttonKickOrBan4.active = true;
				buttonKickOrBan4.visible = true;
				textKickOrBan4.visible = false;
			}
			
			else if (Reg._buttonCodeValues != "p1000")
			{
				buttonKickOrBan4.visible = false;
				buttonKickOrBan4.active = false;
				textKickOrBan4.visible = true;
			}
			
		}	
	
		else if (RegTypedef._dataPlayers._usernamesDynamic[3] == "" && Reg._buttonCodeValues != "p1000")
		{
			buttonKickOrBan4.label.text = "";
			textKickOrBan4.text = "";
			
			buttonKickOrBan4.visible = false;
			buttonKickOrBan4.active = false;
			textKickOrBan4.visible = true;
		}
		
		if (Reg._buttonCodeValues != "") buttonCodeValues();
		
		super.update(elapsed);
	}
	
}

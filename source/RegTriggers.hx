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
 * Triggers are usually at an update function. when a trigger is true, a block of code will be read.
 * @author kboardgames.com
 */
class RegTriggers
{
	
	public static var _kickOrBan:Bool = false; // Trigger the kicked or banned message.
	
	/******************************
	 * when true at SceneGameRoom.hx update() a message saying that a player has left the game will be displayed.
	 */
	public static var _playerLeftGame:Bool = false;
	
	public static var _win:Bool = false; // triggers the win message box.
	public static var _loss:Bool = false;
	public static var _draw:Bool = false;
	
	public static var _messageWin:String = ""; // triggers the win message box.
	public static var _messageLoss:String = "";
	public static var _messageDraw:String = "";	
	
	/******************************
	 * when value is zero, the trigger will not be used. this is used with _spriteGroup at SceneGameRoom.hx to bring a sprite to the front.
	 */
	public static var _spriteGroup:Int = 0;	
	 
	/******************************
	* go to this room when value is true.
	*/
	public static var __scene_waiting_room:Bool = false;	
	
	/******************************
	* go to this room when value is true.
	*/
	public static var _createRoom:Bool = false;
	
	/******************************
	* go to this room when value is true.
	*/
	public static var _lobby:Bool = false;
	
	/******************************
	 * display a message such as kicked or banned by user.
	 */
	public static var _actionMessage = false;
	
	public static var _chessCheckmateEvent:Bool = false;
	
	
	/******************************
	* used to populate the online users list at OnlinePlayersList.hx.
	*/
	public static var _onlineList:Bool = false;
	
	/******************************
	 * at GameImageCurrentUnit.hx. this stops the currentUnit image from displaying after the dice is clicked. a value of true = display currentUnit image.	
	 */
	public static var _signatureGameUnitImage:Bool = true;
	
	/******************************
	 * use a hollow square box to show what unit is highlighted. this var highlights only the parameter of the game board.
	 */
	public static var _highlightOnlyOuterUnits:Bool = false;
	
	/******************************
	 * used to call options() function at SignatureGame.hx.
	 */
	public static var _signatureGame:Bool = false;
	
	/******************************
	* when rolling a 6, it was possible to move again before the other player finished moving. the Reg._rolledA6 stops that from happening and this keeps the NumberWheel.hx rotating when another roll from the same player can be done.
	*/
	public static var _snakesAndLaddersRollAgainMessage:Bool = false;
	
	/******************************
	* when sliding down the snake or climbing a ladder, this var makes that player move at both clients at the same time.
	*/
	public static var _eventForAllPlayers:Bool = true;
	
	/******************************
	 * this var is true when the other player receives that trade request.
	 */
	public static var _tradeProposalOffer:Bool = false;
	
	/******************************
	 * used when the other player receives that trade request and answers yes to the trade. if value is true for yes then a code will trigger at SignatureGameSelecte.hx for the player that first sent the request to trade.
	 */
	public static var _tradeWasAnswered:Bool = false;
	
	/******************************
	 * used at the static function SignatureGameInnerUnitsEvents.hx to make a jump to SignatureGameSelect.notEnoughCash();
	 */
	public static var _notEnoughCash:Bool = false;
	
	/******************************
	 * At SignatureGameSelect.hx, when _isInDebt is true, at SignatureGameSelect.update() everything within a code block will execute when this var is true. 
	 * displays buttons to get cash to pay debt with, and the _unitTitleDebt text and _unitImageDebt image which are both displayed at the right side of the background header.
	 */
	public static var _displayDebtStuff:Bool = false;
	
	/******************************
	 * player left the game and there is still 2 or more players playing the game, so remove the player's piece and remove player's timer text and anything else that need to be removed from the stage and then new again some other classes so that the other players' pieces for those players still in room playing the game will the correct move order of those other players.
	 */
	public static var _removePlayersDataFromStage:Bool = false;
			
	/******************************
	 * triggers an event to display a message from the message box class to the spectator that is watching the game being played.
	 */
	public static var _eventSpectatorWatchingMessageBoxMessages:Bool = false;
	
	/******************************
	 * when spectator joins a game in progress, this is used to more one back in history then fast forward to display every move until the end move is reached. 
	 * the history does not start for the watcher until a game player does a move after the spectator joins room, then the history will fast forward until the last move is reached.
	 */
	public static var _historyFastForwardSpectatorWatching:Bool = false;
	
	public static var _makeMiscellaneousMenuClassActive:Bool = false;
	public static var _makeMiscellaneousMenuClassNotActive:Bool = false;
	
	public static var _miscellaneousMenuOutputClassActive:Bool = false;
	
	/******************************
	 * miscellaneousMenu is closing state.
	 */
	public static var _returnToLobbyMakeButtonsActive:Bool = false;
	
	/******************************
	 * When lobby is first entered, this is used to load the first part of house options(). this helps to increase the first load up time of house.
	 */
	public static var _houseDrawSpritesDoNotEnter:Bool;
	
	/******************************
	 * when the first part of the house is loaded this is set to true so that the second part of house images can be drown to the map.
	 */
	public static var _houseFirstPartComplete:Bool;		
	
	public static var _new_the_house:Bool;
	
	/******************************
	* furniture item bought. this var is used to trigger HouseFurnitureItemsFront.hx update() to go to its class function to add the sprite to the scene.
	*/
	public static var _furnitureItemSpriteAddToMapFront:Bool;
	public static var _furnitureItemSpriteAddToMapBack:Bool;
	
	/******************************
	* furniture item bought. this var is used to trigger HouseFurniturePut.hx update() to go to its class function to add the sprite to the panel.
	*/
	public static var _furnitureItemSpriteAddToPutPanel:Bool;
	
	/******************************
	 * trigger for the display of an item in the list of bought items that was selected from the HouseFurniturePut.hx class.
	 */
	public static var _item_select_triggered_from_put_panel:Bool;
	
	/******************************
	 * Title scene buttons could be executed from within The event scheduler scene.
	 * this trigger sets the back to active true when exiting the event scheduler.
	 */
	public static var _mainStateMakeActiveElements:Bool = false;
	
	/******************************
	 * show the keyboard.
	 */
	public static var _keyboard_open:Bool = false; 
	/******************************
	 * used to set active false to the some elements displayed underneath the keyboard.
	 */
	public static var _keyboard_opened:Bool = false; 
	public static var _keyboard_close:Bool = false;
	
	public static var _button_show_all_scene_game_room:Bool = false;
	public static var _button_hide_all_scene_game_room:Bool = false;
	
	public static var _leaderboards_show:Bool = false;
	
	/******************************
	 * notice displayed when saving at MenuConfigurations.hx.
	 */
	public static var _config_menu_save_notice:Bool = false;
	
	/******************************
	 * used to display the daily quests data once that data is populated from the server.
	*/
	public static var __daily_quests:Bool = false;
	
	/******************************
	 * // this fixes a bug where the chat input element is not seen when returning to the lobby from the waiting room.
	 */
	public static var _recreate_chatter_input_chat:Bool  = false;
	
	/******************************
	 * print the notation to screen.
	 */
	public static var _notationPrint:Bool = false;
	
	/******************************
	 * refresh list button was pressed at waiting room. trigger event.
	 * this is used to stop the population of the list when first entering the waiting room.
	 */
	public static var _waiting_room_refresh_list:Bool = false;
	
	/*****************************
	 * jump to the 8 player standard chess tournament options.
	 */
	public static var _jump_to_tournament_standard_chess_8:Bool = false;
	
	/*****************************
	 * to center the button's text at menuBar to button's height, those buttons need more than one update() call. when this var is not 0 then these buttons will be visible to scene, since the buttons text is now centered. without this var, the buttons text will be displayed at top of buttons for a brief second, showing what appears to be a display bug.
	 */
	public static var _ticks_buttons_menuBar:Bool = false;
	
	/*****************************
	 * all buttons except the button from ButtonAlwaysActiveNetworkYes.hx will not be updated when this is true. at those button class, this trigger sets a condition to the super.update. when this value is true the super.update at ButtonAlwaysActiveNetworkYes.hx will not be called and hence the buttons in that class will not be active. 
	 */
	public static var _buttons_set_not_active:Bool = false;
	
	public static function resetTriggers():Void
	{
		_playerLeftGame = false;
		_win = false;
		_loss = false;
		_draw = false;
		
		_messageWin = "";
		_messageLoss = "";
		_messageDraw = "";
		_chessCheckmateEvent = false;
		_onlineList = false;
		
		__scene_waiting_room = false;
		_createRoom = false;
		_lobby = false;
		_actionMessage = false;
		
		_signatureGame = false;
		_signatureGameUnitImage = true;
		_highlightOnlyOuterUnits = false;
		_notEnoughCash = false;
		_spriteGroup = 0;
		//_snakesAndLaddersRollAgainMessage = false; // not needed.
		_displayDebtStuff = false;
		_eventForAllPlayers = true;
		_tradeProposalOffer = false;
		_tradeWasAnswered = false;
		_removePlayersDataFromStage = false;
		_eventSpectatorWatchingMessageBoxMessages = false;
		_historyFastForwardSpectatorWatching = false;
		_makeMiscellaneousMenuClassActive = false;
		_makeMiscellaneousMenuClassNotActive = false;		
		_miscellaneousMenuOutputClassActive = false;
		_returnToLobbyMakeButtonsActive = false;
		_houseDrawSpritesDoNotEnter = false;
		_new_the_house = false;
		//_houseFirstPartComplete = false; not needed
		_furnitureItemSpriteAddToMapFront = false;
		_furnitureItemSpriteAddToMapBack = false;
		_furnitureItemSpriteAddToPutPanel = false;
		_item_select_triggered_from_put_panel = false;
		_mainStateMakeActiveElements = false;
		_keyboard_open = false;
		_keyboard_opened = false;
		_keyboard_close = false;
		_button_show_all_scene_game_room = false;
		_button_hide_all_scene_game_room = false;
		_config_menu_save_notice = false;
		_leaderboards_show = false;	
		__daily_quests = false;
		_recreate_chatter_input_chat = false;
		_notationPrint = false;
		_jump_to_tournament_standard_chess_8 = false;
		_waiting_room_refresh_list = false;
		_ticks_buttons_menuBar = false;
		_buttons_set_not_active = false;
	}	
	
}//
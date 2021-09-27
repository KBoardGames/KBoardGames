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
 * game 0 to 4 vars plus any vars to get them working. a var cab be just for a game or used for all games.
 * @author kboardgames.com
 */

//############################# NOTES
// The invalid operation errors on Neko come from uninitialized variables (int, bool, float), since these are by default null on Neko. Checking for null errors are important. To fix do var foo:int = 0. The 0 initializes that variable.

class Reg
{
	//..STUDY THIS...
	//if (Reg._roomPlayerLimit <= 1) // it give a win or lose only when there is 1 player left unless its a normal end to a game, such as checkmate, then this var has a value of <= 2. in a three or four player game, when 1 player disconnects, the game is not over yet and therefore should not give a win or lose to the other players at this time. search this var for how this value is used.
	
	//############################# START CONFIG
	// change these values below this line.
	
	public static var _maximum_server_connections:Int = 119;
		
	
	/* far below this code, at the resetRegVarsOnce() function, change this var to true when you are ready to release this version of the client to the public. this var will hide the fullscreen button and disable the windows key which will stop the user from making the client shown in windows mode.
	 */
	public static var _clientReadyForPublicRelease:Bool = true;
	
	/******************************
	 * only change the version number here. this value must be changed every time this complete program with dll's are copied to the localhost/files/windows folder.
	 * no need to copy this var then paste to the bottom of this class because this value does not change while client is running.
	 */
	public static var _version:String = "1.16.10";
	
	/******************************
	 * total games available in this release.
	 */
	public static var _total_games_in_release:Int = 5;
	
	/******************************
	 * website domain does not end in "/" nor has http://.
	 */
	public static var _websiteHomeUrl:String = "kboardgames.com";
	
	public static var _websiteNameTitle:String = "";
	public static var _websiteNameTitleCompare:String = "";
	
	/******************************
	 * Whether to skip the flixel splash screen that appears in release mode.
	 */
	public static var _skipSplash:Bool = false;	
	
	/******************************
	 * Whether to start the game in fullscreen on desktop targets. also change this var at resetRegVarsOnce().
	 */
	public static var _startFullscreen:Bool = false; 
			
	public static var _ipAddress:String = ""; //value is one of these two below. 
	public static var _ipAddressServerMain:String = ""; // 8x8 board game site.
	public static var _ipAddressServerOther:String = "";// your hosted game. someone that would like to download the server and client then install it for others to join that hosted website and board games. 
	
	/******************************
	 * Should users have an option to select either kg website and their website when selecting multiplayer from MenuState.hx. if this is set to false then only kg website name or its IP address will be used when connecting to server.
	 * set this true to enable paid server feature. paid members can host their own domain and that domain can be selected at MenuState as an option to connect to that server.
	 */
	public static var _useThirdPartyIpAddress:Bool = false;
			
	/******************************
	 * Warning, server will crash if there are about 56 open clients on windows. Therefore, set this var to false when game is finish. also change this var at near the bottom of this class.
	 */
	public static var _loginMoreThanOnce = false;
	
	//############################# END CONFIG
	
	/******************************
	* How many frames per second the game should update. How many frames per second the game should run at. // faster = lower value. remember to change the value at the function far below this line.
	*/
	public static var _framerate:Int = 60;
	
	public static var _port:Int = 9306; // 443 is wss:// (websockets)

	public static var _ipAddressSession:String = ""; // used to temp hold the value of an IP address until the restart of the program.
		
	/******************************
	* this var will not decrease in value. it is the maximum amount of time that the user has to move or to use an action key for the player before the timer triggers a player disconnect from server event.
	*/
	public static var _logoffTime:Int = 9999999; // 2200 is a good number. ALSO CHANGE THIS VALUE AT resetRegVars().
	
	/******************************
	* this is the current amount of time left before the timer triggers a player disconnect. this var must be the same as the _logoffTine.
	*/
	public static var _logoffTimeCurrent:Int = 9999999; // ALSO CHANGE THIS VALUE AT resetRegVars().
	
	//############################# THE FOLLOWING VALUES CAN BE IGNORED...
	
	/******************************
	 * Width of the game in pixels.
	 */ 
	public static var gameWidth:Int = 1400;
	
	/******************************
	 * Height of the game in pixels.
	 */
	public static var gameHeight:Int = 770;
	
	/******************************
	 * use image.scale.set(_scaleWidth, _scaleHeight) to scale the images if the screen res is smaller than the default screen size. the default screen size is gameWidth and gameHeight.
	 */
	public static var _scaleWidth:Int = 1;
	
	/******************************
	 * use image.scale.set(_scaleWidth, _scaleHeight) to scale the images if the screen res is smaller than the default screen size. the default screen size is gameWidth and gameHeight.
	 */
	public static var _scaleHeight:Int = 1;
	
	
	public static var  _enableGameNotations:Bool = true; // you should set this to true. next search for "// pieces on set." at SceneGameRoom. is those chess pieces positioned like a new game?
	
	//############################# DO NOT CHANGE THE FOLLOWING VARS.	
	/******************************
	* a notation is found in the eco notation list for that move sequence.
	*/
	public static var _foundNotation:Bool = false;
	
	public static var _ecoOpeningsNotationsOutput:String = "";
	public static var _ecoOpeningsNamesTemp:String = "";
	public static var _ecoOpeningsNotationsTemp:String = "";
	public static var _ecoOpeningsNames:Array<String> = [];
	public static var _ecoOpeningsNotations:Array<String> = [];
		
	/******************************
	* Default font for the game.
	*/
	public static var _fontDefault:String	= "assets/fonts/LiberationMono-Regular";
	public static var _fontTitle:String		= "assets/fonts/LiberationMono-Regular.ttf";
	
	public static var _font_size:Int = 24;
	
	public static var _updateScrollbarBringUp:Bool = false;
	
	/******************************
	 * every message what is displayed after the ok or cancel is pressed has a different message value. used in a switch statement. 
	 */
	public static var _messageId:Int = 0;
	
	/******************************
	 * when more than one message popup is open, this var will have those message id and read in reverse order. so if message popup 2 and then 3 was open, this var would have values of var[0] = 2 and var[1] = 3. when message 3 is closed, that array is removed and the last array value is assigned to _messageId var, so that it can trigger code at that message popup class that its id matches _messageId value.
	 */
	public static var _messageFocusId:Array<Int> = [0];
	
	/******************************
	 * this var is passed to MenuState. if true then there is already a host with that same name connected. a message will display if found a duplicate. change _loginMoreThanOnce, not this var.
	 */
	public static var _alreadyOnlineHost:Bool = false;
	
	/******************************
	 * this var is passed to MenuState. if true then there is already a username with that same name connected. a message will display if found a duplicate. change _loginMoreThanOnce, not this var.
	 */
	public static var _alreadyOnlineUser:Bool = false;
	
	/******************************
	 * if php cannot get host from the public IP address then this value will be true. at that time, a trigger will be used to send the user back the the menu state for a message that the host cannot be found. the reason for this is that a bot could somehow use an IP address that cannot be resolved to host.
	 */ 
	public static var _hostname_message:Bool = false;
	
	/******************************
	 * html5 client needs IP address of the server. not the domain. if cannot get an IP address from a file at /htdocs/server/getHostByName.php then the user will return to menuState and this message seen.
	 */
	public static var _ip_message:Bool = false;
	
	/******************************
	 * The config.txt file at root of client has the server domain details. if this value is true then that server domain, found at MySQL users table at server_domain field, is a paid member. therefore if true, the player can connect to that server. else, only the main server can be connected to.
	 */
	public static var _isThisServerPaidMember:Bool = true;
	
	/******************************
	 * used to display to the other player that this player is no longer playing a game because this player had left the room. this var can be also used to remove game text, such as win, loss text from the room.
	 */
	public static var _playerLeftGameUsername:String = "";
	
	/******************************
	 * this var is used at PlayersLeftGameResetThoseVars.resetPlayersData() to do anything needed, such as reset the player's land back to its default state.
	 */ 
	public static var _playerLeftGameMoveNumber:Int = 0;
	
	/******************************
	 * the current room where this player is located.
	 */
	public static var _currentRoomState:Int = 0; // zero cannot be used because that value is the first room.
	
	/******************************
	 * when true, used to stop the creation of Room.hx when room already exists. also used to determine if user is creating a room.
	 */
	public static var _at_create_room:Bool = false;
	
	/******************************
	 * used to determine if user is at the chatroom.
	 */
	public static var _at_waiting_room:Bool = false;
	
	/******************************
	 * if true then the keyboard is being used. this is needed so that the buttons do not go inactive for a few milliseconds at ButtonGeneral class. we want the buttons always responsive to user input.
	 */
	public static var _at_input_keyboard:Bool = false;
	
	public static var _at_configuration_menu:Bool = false;
	
	/******************************
	 * used to stop a firing of a house button when entering the house from lobby. the bug was that when clicking house button from lobby the house "put" button was triggered also.
	 */
	public static var _at_lobby:Bool = false;
		
	/******************************
	 * used the same way as the at_lobby button;
	 */
	public static var _at_misc:Bool = false;
	public static var _at_daily_quests:Bool = false;
	public static var _at_tournaments:Bool = false;
	public static var _at_leaderboards:Bool = false;
	
	/******************************
	 * used at PlayState to make a condition to be only read once. at lobby, the scrollbar needs to be hidden or else the message box will not display it "login successful" message. this var is needed to only hide the scrollbar once along with reg._doOnce so the if statement is not read the second time.
	 */
	public static var _loginSuccessfulWasRead:Bool = false;
	
	/******************************
	* used at PlayState to make a condition to be only read once. at lobby, the scrollbar needs to be hidden or else the message box will not display it "login successful" message. this var is needed to only hide the scrollbar once with Reg._loginSuccessfulWasRead being true and that if statement is not read the second time because this var will be set to false. also this var is used from room to return the user to the lobby.
	* this var is also used at menuState to determine if a website file exists. (versionClient.txt); if _doOnce is true then there is an error message that needs to be displayed.
	*/
	public static var _doOnce:Bool = true;
	
	/******************************
	 * this calls the Player's Move event once so that the game can be played at this time.
	 */
	public static var _doStartGameOnce = true;
	
	/******************************
	 * play the title music but only once when the game first loads up.
	 */
	public static var _do_play_title_music_once = true;
	
	/******************************
	 * display a message if true that server disconnected.
	 */
	public static var _serverDisconnected:Bool = false;
   
	/******************************
	 * display a message if true that client disconnected.
	 */
	public static var _clientDisconnected:Bool = false;
	
	/******************************
	* Use this as a hack to stop double firing of a key press or button click.
	*/
	public static var _keyOrButtonDown:Bool = false;

	/******************************
	* Use this as a hack to stop double firing of a key press or button click.
	*/
	public static var _buttonDown:Bool = false;
	
	/******************************
	* is player logged in? used to stop movement and action keys of player.
	*/
	public static var _loggedIn:Bool = false;
   
   	/******************************
	 * used to delay a PlayState.clientSocket.close until a disconnect event can be called.
	 */ 
	public static var _disconnectNow:Bool = false;
	   
	/******************************
	 * this var stops a second connection to the server when already connected.
	 */
	public static var _hasUserConnectedToServer:Bool = false;
	
	/******************************
	 * this var is used to trigger PlayState to send PopupMessage.hx login information to the server.
	 */
	public static var _isLoggingIn:Bool = false;
	
	/******************************
	 * this var holds the parent state. If a class is public at playState.hx then it can be accessed at playState.hx using the code "Reg.state." then select the public class from the popup box.
	 */
	public static var state:PlayState;
	
	/******************************
	 * used to execute a block of code after an ok or cancel key has been pressed at the PopupMessage.hx.
	 */
	public static var _displayOneDeviceErrorMessage:Bool = false;
	
	/******************************
	 * used to display the cancel key at the PopupMessage.hx.
	 */
	public static var _popupMessageUseYesNoButtons:Array<Bool> = [false];
	
	/******************************
	 * when at a message box the player has a choice of a yes or no question, there is this var that has assigned to it a value at a button function. if at the popup message the ok was pressed then this value will be read and the code it refers to will be executed. if the popup message was cancelled then nothing happens. so this var is used to redirect to a code after a yes button was clicked.
	 */
	public static var _buttonCodeValues:String = "";
	public static var _buttonCodeFocusValues:Array<String> = [""];
	
	/******************************
	* this var is given a value depending on if the ok or cancel key was pressed at the popup message. 0 = no key pressed. 1 = ok was pressed. 2 = cancel key.
	*/
	public static var _yesNoKeyPressValueAtMessage:Int = 0;
	
	/******************************
	 * trade unit proposal was sent to the player waiting to move piece. a message box displays with information about the trade. 0 = no key pressed. 1 = ok was pressed. 2 = cancel key.
	 */
	public static var _yesNoKeyPressValueAtTrade:Int = 0;
	
	/******************************
	 * at PlayState this var is set to true if cannot connect to server then code goes to MenuState where the error message is displayed.
	 */
	public static var _cannotConnectToServer:Bool = false;
	
	/******************************
	 * at logging in event, user is not logged into the website forum and user has clicked the world icon at MenuState. Login failed so go back to MenuState and use this var to display a login failed message.
	 */
	public static var _login_failed:Bool = false;
	
	/******************************
	* Event "Player Move" will be called to that all players that are connected will be displayed at the client where the user had just logged in. 
	*/
	public static var _doUpdate:Bool = true;
	
	/******************************
	* used to display the room objects once and no more when returning to this lobby. 
	*/
	public static var _lobbyDisplay:Bool = true;
	
	/******************************
	* used to display the room objects once and no more when returning to this room. 
	*/
	public static var _roomDisplay:Bool = true;
	
	/******************************
	 * at chatroom, the host has clicked the game room button. all users from waiting room have entered the game room when this var is true.
	 */
	public static var _gameRoom:Bool = false;
	
	/******************************
	 * is this the other player that is playing a game with you?
	 */
	public static var _otherPlayer:Bool = false;
	
	
	
	// ###############  GAME ID VARS STARTS HERE ##################
	
	
	/******************************
	 * this vars is the castling rook piece point value.
	 */
	public static var _pointValue2:Int = -1; 
	
	/******************************
	 * this vars is the castling rook piece unique value.
	 */
	public static var _uniqueValue2:Int = -1;
	/******************************
	 * white gameboard pieces are placed into the player 1 group and black pieces into the other group. each piece has an ID. find the ID with the p value. there is a function at GameMovePlayersPiece.hx. once at the ID, eg, if ID == p, then you can remove a piece using _groupPlayer1.remove(this).
	 */ 	
	public static var _groupPlayer1:FlxSpriteGroup;
	
	/******************************
	 * SEE: _groupPlayer1
	 */
	public static var _groupPlayer2:FlxSpriteGroup;
		
	/******************************
	 * the player can move a gameboard piece when this var is true.
	 */
	public static var _playerCanMovePiece:Bool = true;
	
	/******************************
	 * used to send gameboard data to the other player.
	 */
	public static var _pieceMovedUpdateServer:Bool = false;
	
	/******************************
	 * if an array uses this var then a player attacker is moving a chess piece. 
	 */
	public static var _playerMoving:Int = 0;
	
	/******************************
	 * if an array uses this var then a player defender is moving a chess piece. 
	 */
	public static var _playerNotMoving:Int = 1;
	
	/******************************
	 * in regards to chess, white pieces are from 1 to 6 and black pieces from 11 to 16. a code block can use this var to find what piece to display. for example, 1 + this var would equal 1, a white pawn or if this var is 10 then 1 + this var which is 11, a black pawn. 
	 */
	public static var _pieceNumber:Int = 0;
	
	//############################# GENERAL GAME VARS.
	/******************************
	 * when moving a gameboard piece, "old" is the starting location. x coordinate.
	 */
	public static var _gameXXold:Int = -1;
	
	/******************************
	 * when moving a gameboard piece, "old" is the starting location. y coordinate.
	 */
	public static var _gameYYold:Int = -1; // unit y coordinate. you have requested this gameboard piece.	
	
	/******************************
	 *  "new" is where the piece will be moved to. x coordinate.
	 */	
	public static var _gameXXnew:Int = -1; // unit x coordinate. you have requested a piece be moved here.
	
	/******************************
	 *  "new" is where the piece will be moved to. y coordinate.
	 */	
	public static var _gameYYnew:Int = -1; // unit y coordinate. you have requested a piece be moved here.
	
	/******************************
	 * when moving a gameboard piece, "old" is the starting location. x coordinate.
	 */
	public static var _gameXXold2:Int = -1;
	
	/******************************
	 * when moving a gameboard piece, "old" is the starting location. y coordinate.
	 */
	public static var _gameYYold2:Int = -1; // unit y coordinate. you have requested this gameboard piece.
	
	/******************************
	 *  "new" is where the piece will be moved to. x coordinate.
	 */	
	public static var _gameXXnew2:Int = -1; // unit x coordinate. you have requested a piece be moved here.
	
	/******************************
	 *  "new" is where the piece will be moved to. y coordinate.
	 */	
	public static var _gameYYnew2:Int = -1; // unit y coordinate. you have requested a piece be moved here.	
	
	/******************************
	 *  use the var for anything.
	 */	
	public static var _gameXXoldA:Int = 0;
	
	/******************************
	 *  use the var for anything.
	 */	
	public static var _gameYYoldA:Int = 0;
	
	/******************************
	 *  use the var for anything.
	 */	
	public static var _gameXXoldB:Int = 0;
	
	/******************************
	 *  use the var for anything.
	 */	
	public static var _gameYYoldB:Int = 0;
	
	/******************************
	 *  use the var for anything.
	 */	
	public static var _gameXXnewA:Int = 0;
	
	/******************************
	 *  use the var for anything.
	 */	
	public static var _gameYYnewA:Int = 0;
	
	/******************************
	 *  use the var for anything.
	 */	
	public static var _gameXXnewB:Int = 0;
		
	/******************************
	 *  use the var for anything.
	 */	
	public static var _gameYYnewB:Int = 0;
	
	/******************************
	 *  computer is searching for a checkmate. this is the location of the piece putting the king in checkmate.
	 */	
	public static var _chessOriginOfcheckmateXXnew:Int = -1; // unit x coordinate. you have requested a piece be moved here.
	
	/******************************
	 *  computer is searching for a checkmate. this is the location of the piece putting the king in checkmate.
	 */	
	public static var _chessOriginOfcheckmateYYnew:Int = -1; // unit y coordinate. you have requested a piece be moved here.
	
	/*
	 * other player's unit new location x coordinate.
	 */
	public static var _gameOtherPlayerXold:Int = 0;
	
	/*
	 * other player's unit y new location coordinate.
	 */
	public static var _gameOtherPlayerYold:Int = 0;
	
	/*
	 * other player's unit new location x coordinate.
	 */
	public static var _gameOtherPlayerXnew:Int = 0;
	
	/*
	 * other player's unit y new location coordinate.
	 */
	public static var _gameOtherPlayerYnew:Int = 0;	
	
	/******************************
	* on a unit this value hides or displays an image of this value. -1 = hide. any other value will display an image. piece moved from unit that value.
	*/
	public static var _imageValueOfUnitOld1:Int = 0;
	public static var _imageValueOfUnitOld2:Int = 0; // second piece, castling.
	public static var _imageValueOfUnitOld3:Int = 0; // captured piece value.
	
	/******************************
	* on a unit this value hides or displays an image of this value. -1 = hide. any other value will display an image. this is the piece moved to unit value.
	*/
	public static var _imageValueOfUnitNew1:Int = 0;
	public static var _imageValueOfUnitNew2:Int = 0; // second piece.

	
	/******************************
	 * used in chess so that the computer does not move back to where it moved from. this is a last move that was done before the current move was made. when moving a gameboard piece, "old" is the starting location. x coordinate.
	 */
	public static var _chessCPUdontMoveBackXXold:Int = -2;
	
	/******************************
	 *  used in chess so that the computer does not move back to where it moved from. this is a last move that was done before the current move was made. when moving a gameboard piece, "old" is the starting location. y coordinate.
	 */
	public static var _chessCPUdontMoveBackYYold:Int = -2; // unit y coordinate. you have requested this gameboard piece.	
	/******************************
	 * true if the player is the person that hosted the game.
	 */
	public static var _gameHost:Bool = true;
	
	/******************************
	 * should the player's piece on the board be moved?
	 */
	public static var _gameMovePiece:Bool = false;
	
	/******************************
	 * this var is only used to populate another var. the first unit is the top left corner of the board and the last unit is at the bottom-right corner. each piece is given a point value so we know what image to display.
	 */
	public static var _gamePointValueOfUnit:Array<Int> = [];
	public static var _gamePointValueOfUnit2:Array<Int> = [];
	
	/******************************
	 * this is the point value of each piece on the standard gameboard using an array that holds the XY coordinate system so that a piece can be found using a mouse. for example, array[2][0], or y=2 and x=0 is the first element at the third row. 
	 * an image piece is 75 x 75 pixels wide. so, if the mouse clicked the first element at the third row then the x value would start at x times 75 and end at x time 75 + 75 for the width. if the mouse is anywhere within that number then we know that the mouse clicked that square.				
	 */
	public static var _gamePointValueForPiece:Array<Array<Int>> = 
	[for (y in 0...8) [for (x in 0...8) 0]];
	public static var _gamePointValueForPiece2:Array<Array<Int>> = 
	[for (y in 0...8) [for (x in 0...8) 0]];
	
	/******************************
	* this var is only used to populate another var. each set of piece on the board has a different value that represents that piece.
	*/
	public static var _gameUniqueValueOfUnit:Array<Int> = [];
	public static var _gameUniqueValueOfUnit2:Array<Int> = [];
	
	/******************************
	 * used in an if condition to return true if the unit had that unique value.
	 */
	public static var _gameUniqueValueForPiece:Array<Array<Int>> =
	[for (y in 0...8) [for (x in 0...8) 0]];
	public static var _gameUniqueValueForPiece2:Array<Array<Int>> =
	[for (y in 0...8) [for (x in 0...8) 0]];
	
	/******************************
	* only house, taxi or cafe, at some outer units, of this game board are used. those units can be build on and have 1 to 4 HouseTaxiCabOrCafeStore and those places will have a value here of 1 to 4.
	* in other words, the total amount of houses, taxi cabs and cafe stores that a player has.
	*/
	public static var _gameHouseTaxiCabOrCafeStoreValueOfUnit:Array<Int> = [];
	
	/******************************
	 * outputs the amount of services at that coordinate. used with Reg._gameHouseTaxiCabOrCafeStoreValueOfUnit
	 */
	public static var _gameHouseTaxiCabOrCafeStoreForPiece:Array<Array<Int>> =
	[for (y in 0...8) [for (x in 0...8) 0]];
	
	/******************************
	 * use this if two or move units share that same data.
	 */
	public static var _gameUnitGroupsForPiece:Array<Array<Int>> =
	[for (y in 0...8) [for (x in 0...8) 0]];
	
	/******************************
	* for signature game. the units that border the game board have different values than the inside units. those values will be either one or tw0 when no building is there. when that is true then that unit will be visible. to show only a bordered image of either black or white, a value of 1 or 2. when a land is built on, then the image will change and will show the regular icon for that unit. 
	*/
	public static var _gameUndevelopedValueOfUnit:Array<Int> = [];
	
	/******************************
	 * use this if two or move units share that same data. this holds the _p value at GameIDsCreateAndMain.hx.
	 */
	public static var _gameUnitGroupsValueOfUnit:Array<Int> = [];
	
	/******************************
	 * starting from the top-left corner of the grid, each piece is placed on a square and it value is incremented by 1. this is the value of one piece on the board. 
	 * used only to populate from p var and used to move a piece. see CheckersMovePlayersPiece for an example. _gameUnitNumberOld and _gameUnitNumberNew populate from this var.
	 */
	public static var _gameUnitNumber:Int = 0;
	
	/******************************
	 * unit number. 0-64. populates from _gameUnitNumber and used to move a piece. see CheckersMovePlayersPiece for an example..
	 */
	public static var _gameUnitNumberOld:Int = -1;
	
	/******************************
	 * unit number. 0-64. this var is calculated from _gameUnitNumberOld and _gameUnitNumberNew. in checkers, this var refers to the piece that was jumped over. This is used to remove that piece from the board. see CheckersMovePlayersPiece
	 */
	public static var _gameUnitNumberMiddle:Int = -1;
	
	/******************************
	 * unit number.. 0-64  populates from _gameUnitNumber and used to move a piece. see CheckersMovePlayersPiece for an example..
	 */
	public static var _gameUnitNumberNew:Int = -1;
	
	/******************************
	 * unit number. 0-64. currently used with castling and used to move that piece. see CheckersMovePlayersPiece for an example.. 
	 */
	public static var _gameUnitNumberOld2:Int = -1;
	
	/******************************
	 * unit number. 0-64. currently used with castling and used to move that piece. see CheckersMovePlayersPiece for an example..
	 */
	public static var _gameUnitNumberNew2:Int = -1; 
	
	/******************************
	 * use this in an if statement for game data to be populated in vars.
	 */
	public static var _gameDidFirstMove:Bool = false;
	
	/******************************
	 * playing against the computer while offline.
	 */
	public static var _game_offline_vs_cpu:Bool = true;
	
	/******************************
	 * playing against the computer while online.
	 */
	public static var _game_online_vs_cpu:Bool = false;
	
	//############################# CHESS VARS.	
	/******************************
	 * This array holds a image for every unit that the player can capture. when the player clicks a piece on the game board, an image box will be displayed at every grid unit that the piece can move to.
	 * array 1: p = player/ value 0 for host and 1 for other/computer player.
	 * array 2: y coordinates.
	 * array 3: x coordinates.
	*/
	public static var _capturingUnitsForImages:Array<Array<Array<Int>>> = 
	[for (p in 0...2) [for (y in 0...8) [for (x in 0...8) 0]]];
	
	/******************************
	 * you use Reg._playerNotMoving when you want to search for pieces the other player can capture. Reg._playerMoving refers to pieces that are protecting that unit and units that the piece can capture.
	 * each piece is given a capturing value of 2. empty capturing units have a value of 1. when a piece is protecting another piece then the protected piece will have a value of 3. a value of two for itself and 1 from the protecting piece.
	 * array 1: p = player/ value 0 for host and 1 for other/computer player.
	 * array 2: y coordinates.
	 * array 3: x coordinates.
	 */
	public static var _capturingUnitsForPieces:Array<Array<Array<Int>>> = 
	[for (p in 0...2) [for (y in 0...8) [for (x in 0...8) 0]]];
			/******************************
	 * if this is true then king can move to this unit.
	 * array 1: p = player/ value 0 for host and 1 for other/computer player.
	 * array 2: y coordinates.
	 * array 3: x coordinates.
	 */
	public static var _chessKingCanMoveToThisUnit:Array<Array<Array<Bool>>> = 
	[for (p in 0...2) [for (y in 0...8) [for (x in 0...8) false]]];
		
	/******************************
	 * at CheckersMovePlayersPiece.hx or ChessMovePlayersPiece.hx excreta, this var is used to move a piece. At these function, if an ID matches a var and this var is of a value then this var will increment so that the ID will not be read the second time. another ID (class element) will be read when that ID matches a value of a var and this var is of a value.
	 */
	public static var _hasPieceMovedFinished:Int = 0;

	/******************************
	 * a white pawn has moved to the first row or a black pawn has moved to the last row. that pawn can be promoted to either s queen, bishop, horse or rook. this var is used to access the subState ChessPromote.hx
	 */
	public static var _chessPromote:Bool = false;
	
	/******************************
	 * this is the first letter of the selected piece used as a notation referring to a selected piece after a promoted pawn, i.e., (Q).
	 */
	public static var _promotePieceLetter:String = "";
	 
	/******************************
	 * pawn is promoted. this var is used to change the pawn to a different piece.
	 */
	public static var _chessPawnIsPromoted:Bool = false;
	
	/******************************
	 * display a message to the other player about the chess pawn has been promoted.
	 */
	public static var _chessPawnPromotedMessage:Bool = false;
	
	/******************************
	 * [p][i][y][x] p=player number, i=instance, y=y coordinate, x=x coordinate. this array with the value of 1 or 5 = can move 1 or 2 units. 2, 4, 6 or 8 = angle movement. 
	 */
	public static var _chessPawn:Array<Array<Array<Array<Int>>>> = 
	[for (p in 0...2) [for (i in 0...8) [for (y in 0...8) [for (x in 0...8) 0]]]];
	
	/******************************
	 * [p][i][y][x] p=player number, i=instance, y=y coordinate, x=x coordinate. the defending piece is a piece that blocks its king from an attacker. if the unit location entered into this var equals zero then that is false which means no defender at the location.
	 */
	public static var _chessPawnDefenderKing:Array<Array<Array<Array<Int>>>> = 
	[for (p in 0...2) [for (i in 0...8) [for (y in 0...8) [for (x in 0...8) 0]]]];
	
	/******************************
	 * [p][i][y][x] p=player number, i=instance, y=y coordinate, x=x coordinate. the attacker piece is a piece that can check the king if no defenders blocks its king from that attacker. if the unit location entered into this var equals zero then that is false which means no attacker at the location.
	 */
	public static var _chessPawnAttackerKing:Array<Array<Array<Array<Int>>>> = 
	[for (p in 0...2) [for (i in 0...8) [for (y in 0...8) [for (x in 0...8) 0]]]];
	
	/******************************
	 * [p][i][y][x] p=player number, i=instance, y=y coordinate, x=x coordinate. this array with the value of 1=capturing units, 5=a capturing unit that has a another same colored piece. 17=piece location.
	 */
	public static var _chessHorse:Array<Array<Array<Array<Int>>>> = 
	[for (p in 0...2) [for (i in 0...10) [for (y in 0...8) [for (x in 0...8) 0]]]];
	
	/******************************
	 * [p][i][y][x] p=player number, i=instance, y=y coordinate, x=x coordinate. the defending piece is a piece that blocks its king from an attacker. if the unit location entered into this var equals zero then that is false which means no defender at the location.
	 */
	public static var _chessHorseDefenderKing:Array<Array<Array<Array<Int>>>> = 
	[for (p in 0...2) [for (i in 0...10) [for (y in 0...8) [for (x in 0...8) 0]]]];
	
	/******************************
	 * [p][i][y][x] p=player number, i=instance, y=y coordinate, x=x coordinate. the attacker piece is a piece that can check the king if no defenders blocks its king from that attacker. if the unit location entered into this var equals zero then that is false which means no attacker at the location.
	 */
	public static var _chessHorseAttackerKing:Array<Array<Array<Array<Int>>>> = 
	[for (p in 0...2) [for (i in 0...10) [for (y in 0...8) [for (x in 0...8) 0]]]];
	
	/******************************
	 * [p][i][y][x] p=player number, i=instance, y=y coordinate, x=x coordinate. this array with the value of 1=capturing units, 5=a capturing unit that has a another same colored piece. 17=piece location.
	 */
	public static var _chessBishop:Array<Array<Array<Array<Int>>>> = 
	[for (p in 0...2) [for (i in 0...10) [for (y in 0...8) [for (x in 0...8) 0]]]];
	
	/******************************
	 * [p][i][y][x] p=player number, i=instance, y=y coordinate, x=x coordinate. the defending piece is a piece that blocks its king from an attacker. if the unit location entered into this var equals zero then that is false which means no defender at the location.
	 */
	public static var _chessBishopDefenderKing:Array<Array<Array<Array<Int>>>> = 
	[for (p in 0...2) [for (i in 0...10) [for (y in 0...8) [for (x in 0...8) 0]]]];
	
	/******************************
	 * [p][i][y][x] p=player number, i=instance, y=y coordinate, x=x coordinate. the attacker piece is a piece that can check the king if no defenders blocks its king from that attacker. if the unit location entered into this var equals zero then that is false which means no attacker at the location.
	 */
	public static var _chessBishopAttackerKing:Array<Array<Array<Array<Int>>>> = 
	[for (p in 0...2) [for (i in 0...10) [for (y in 0...8) [for (x in 0...8) 0]]]];
	
	/******************************
	 * [p][i][y][x] p=player number, i=instance, y=y coordinate, x=x coordinate. this array with the value of 1=capturing units, 5=a capturing unit that has a another same colored piece. 17=piece location.
	 */
	public static var _chessRook:Array<Array<Array<Array<Int>>>> = 
	[for (p in 0...2) [for (i in 0...10) [for (y in 0...8) [for (x in 0...8) 0]]]];
	
	/******************************
	 * [p][i][y][x] p=player number, i=instance, y=y coordinate, x=x coordinate. the defending piece is a piece that blocks its king from an attacker. if the unit location entered into this var equals zero then that is false which means no defender at the location.
	 */
	public static var _chessRookDefenderKing:Array<Array<Array<Array<Int>>>> = 
	[for (p in 0...2) [for (i in 0...10) [for (y in 0...8) [for (x in 0...8) 0]]]];
	
	/******************************
	 * [p][i][y][x] p=player number, i=instance, y=y coordinate, x=x coordinate. the attacker piece is a piece that can check the king if no defenders blocks its king from that attacker. if the unit location entered into this var equals zero then that is false which means no attacker at the location.
	 */
	public static var _chessRookAttackerKing:Array<Array<Array<Array<Int>>>> = 
	[for (p in 0...2) [for (i in 0...10) [for (y in 0...8) [for (x in 0...8) 0]]]];
	
	/******************************
	 * [p][y][x] p=player number, y=y coordinate, x=x coordinate. this array with the value of 1=piece 1=capturing units, 5=a capturing unit that has a another same colored piece. 17=piece location.
	 */
	public static var _chessQueen:Array<Array<Array<Array<Int>>>> = 
	[for (p in 0...2) [for (i in 0...10) [for (y in 0...8) [for (x in 0...8) 0]]]];
	
	/******************************
	 * [p][i][y][x] p=player number, i=instance, y=y coordinate, x=x coordinate. the defending piece is a piece that blocks its king from an attacker. if the unit location entered into this var equals zero then that is false which means no defender at the location.
	 */
	public static var _chessQueenDefenderKing:Array<Array<Array<Array<Int>>>> = 
	[for (p in 0...2) [for (i in 0...10) [for (y in 0...8) [for (x in 0...8) 0]]]];
	
	/******************************
	 * [p][i][y][x] p=player number, i=instance, y=y coordinate, x=x coordinate. the attacker piece is a piece that can check the king if no defenders blocks its king from that attacker. if the unit location entered into this var equals zero then that is false which means no attacker at the location.
	 */
	public static var _chessQueenAttackerKing:Array<Array<Array<Array<Int>>>> = 
	[for (p in 0...2) [for (i in 0...10) [for (y in 0...8) [for (x in 0...8) 0]]]];
	
	/******************************
	 * [p][y][x] p=player number, y=y coordinate, x=x coordinate. this array with the value of 1=piece 1=capturing units, 5=a capturing unit that has a another same colored piece. 17=piece location.
	 */
	public static var _chessKing:Array<Array<Array<Int>>> = 
	[for (p in 0...2) [for (i in 0...8) [for (x in 0...8) 0]]];
	
	/******************************
	 * [p][y][x] p=player number, y=y coordinate, x=x coordinate. this array with the value of 1=piece 1=capturing units. computer uses this var. each unit that the king can capture acts like a queen for the king. if computer is on this queen capturing units, then that piece can capture the king's capture unit or the king unit. this is used to limited the movement of the computer to only within this capturing units.
	 */
	public static var _chessKingCapturingUnitAsQueen:Array<Array<Array<Int>>> = 
	[for (p in 0...2) [for (i in 0...8) [for (x in 0...8) 0]]];
	
	/******************************
	 * [p][y][x] p=player number, y=y coordinate, x=x coordinate. this array with the value of 1=piece 1=capturing units. computer uses this var. this var stops a check when searching for a checkmate in 2. the king acts like a queen. if the computer piece is on this queen path then moving here will be ignored if that piece puts the king in check. this var stop a check by ignoring the move at the first loop at checkmateIn2 function when attacking piece is at any of these units.
	 */
	public static var _chessKingAsQueen:Array<Array<Array<Int>>> = 
	[for (p in 0...2) [for (y in 0...8) [for (x in 0...8) 0]]];
	
	/******************************
	 * This is a straight path to the king. such as a queen is three units from the king and all the capturing unit from that queen that goes in a straight line to the unit before the king piece.
	 * 0 = empty unit. 1 capturing unit.
	 */
	public static var _chessCapturingPathToKing:Array<Array<Array<Int>>> = 
	[for (p in 0...2) [for (y in 0...8) [for (x in 0...8) 0]]];
	
	/******************************
	 * This is a straight path to the king. such as a queen's capturing piece is three units from the king and all the capturing unit from that queen's capturing piece that goes in a straight line to the unit before the king piece.
	 * this is where the queen can go to, to attack the king directly. other attacker pieces can be bishop and rook. pawn and horse are excluded from this list.
	 * 0 = empty unit. 1 capturing unit.
	 */
	public static var _chessFuturePathToKing:Array<Array<Array<Int>>> = 
	[for (p in 0...2) [for (i in 0...8) [for (x in 0...8) 0]]];
	
	/******************************
	 * p=player, d=direction of path, y=y coordinates, x=x coordinates.
	 * at ChessCapturingUnits.hx, when searching for the defender king using the direction of down, if a king was found that all units within that path is marked with the value of down. 1=up, 2=up-right, 3=right, excreta
	 * this var is useful if you need to know what path a piece is at. if zero then no attacking piece could put a king in king since the path to king is not there.
	 * the value of this var outputs the direction value. this var is used when the king is being attacked by any path.
	 */
	public static var _chessCurrentPathToKing:Array<Array<Array<Array<Int>>>> = 
	[for (p in 0...2) [for (d in 0...9) [for (y in 0...8) [for (x in 0...8) 0]]]];
	
	/******************************
	 * how many units that are located beside the king in check? array = player.
	 */
	public static var _chessUnitsInCheckTotal:Array<Int> = [0, 0];
	
	/******************************
	* is this a unit next to king P which is either a Reg._playerNotMoving or Reg._playerMoving.
	*/
	public static var _isThisUnitNextToKing:Array<Array<Array<Bool>>> = 
	[for (p in 0...2) [for (y in 0...8) [for (x in 0...9) false]]];
	/******************************
	 * by default, every unit on the board is active when value is 0. 1 means these are units next to the king in check.
	 */
	public static var _chessIsThisUnitInCheck:Array<Array<Array<Int>>> =
	[for (p in 0...2) [for (y in 0...8) [for (x in 0...8) 0]]];
	
	/******************************
	 * a value of 1 means a piece can take a king out of check.
	 */
	public static var _chessTakeKingOutOfCheckUnits:Array<Array<Array<Int>>> =
	[for (p in 0...2) [for (y in 0...8) [for (x in 0...8) 0]]];
	
	/******************************
	 * this is the location of chess king Y coordinate. use Reg._playerMoving
	 */
	public static var _chessKingYcoordinate:Array<Int> = [0,0];
	
	/******************************
	 * this is the location of chess king X coordinate. use Reg._playerMoving
	 */
	public static var _chessKingXcoordinate:Array<Int> = [0,0];
	
	/******************************
	 * value is true when king is moving such as when the player clicks on the king. this var is very useful.
	 */
	public static var _chessIsKingMoving:Bool = false;
	
	/******************************
	 * this is the x coordinate location of the piece putting the king in check.
	 */
	public static var _chessOriginOfCheckX:Array<Int> = [-1, -1, -1, -1, -1, -1, -1, -1];
	
	/******************************
	 * this is the y coordinate location of the piece putting the king in check.
	 */
	public static var _chessOriginOfCheckY:Array<Int> = [-1, -1, -1, -1, -1, -1, -1, -1];
	
	/******************************
	 * value of true means that a piece can take the king out of check.
	 */
	public static var _chessCanTakeOutOfCheck:Array<Bool> = [false,false];
	/******************************
	 * chess, checkmate and castling messages.
	 */
	public static var _gameMessage:String = "";
	
	
	/******************************
	 * true then path from is pawn or horse.
	 */
	public static var _chessPathFromPawnOrHorse:Bool = false;
		
	/******************************
	 * each path is given a value of one. when searching for a path such as two, all paths but two can be disabled. this is useful if you want to limit a piece to just path two. path starting from king then moving up has a value of 1. from king to top-right has a value of 2 and so on.
	 */
	public static var _chessPathCoordinates:Array<Array<Array<Int>>> =
	[for (p in 0...10) [for (y in 0...8) [for (x in 0...8) 0]]];
	
	/******************************
	 * this is used so that the capturing path to king is removed when there is a second defender piece at that path. no need to show the path when the king is not in jeopardy from that direction. value starts at 1.
	 * a capturing path of king can be unit highlighted without any defenders on it yet we cannot use a value of zero or else all paths would be highlighted regardless of if an attacker was on it or not. so we plus 1 here and then use > 0 in the code where needed.
	 */
	public static var _chessTotalDefendersOnPath:Array<Int> = [0,0,0,0,0,0,0,0,0,0];
	
	/******************************
	 * point value for a piece in Reversi. if a condition is true then this var values with be copied to _gamePointValueForPiece. else the values will be cleared.
	 */
	public static var _reversiGamePointValueForPiece:Array<Array<Array<Int>>> =
	[for (p in 0...10) [for (y in 0...8) [for (x in 0...8) 0]]];
	
	/******************************
	 * capturing units value for a piece in Reversi. if a condition is true then this var values with be copied to _capturingUnitsForPieces. else the values will be cleared.
	 */
	public static var _reversiCapturingUnitsForPieces:Array<Array<Array<Int>>> =
	[for (p in 0...10) [for (y in 0...8) [for (x in 0...8) 0]]];
	
	/******************************
	 * when king is in check and a defender piece at a different path is selected, when this var is not zero then the piece will be ignored because we do not want a discovered check.
	 */
	public static var _chessKeepPieceDefendingAtPath:Int = 0;
	
	/******************************
	 * the last move now puts the king in check. this is the path number to that check.
	 */
	public static var _chessPathNumberOfKingInCheck:Int =-0;	
	
	/******************************
	 * the units that surround the piece will have a value of 1. the units that surround the value of 1 will have a value of 2. this will continue until the edge of the game board is found.
	 * these units only work for 1 piece at a time. if using this var for the king, then the CPU king will move towards the king, finding a lesser value of this var per move. this var is useful when the CPU king does not have enough pieces to checkmate unless the king is one of the pieces in trying to checkmate.
	 */
	public static var _unitDistanceFromPiece:Array<Array<Int>> = 
	[for (y in 0...8) [for (x in 0...8) 0]];

	//############################# IN PASSING
	/*
	 * When a pawn advances two squares from its starting position and there is an opponent's pawn on an adjacent file next to its destination square, then the opponent's pawn can capture it En passant (in passing), and move to the square the pawn passed over. This can only be done on the very next move, otherwise the right to do so is forfeit. For example, in the animated diagram, the black pawn advances two squares from g7 to g5, and the white pawn on f5 can take it via En passant on g6 (but only on White's next move).
	 * stores each pawn movement in this var so that how many pawns a pawn made is known.
	 */
	public static var _chessPawnMovementTotalSet:Array<Array<Int>> =
	[for (p in 0...2) [for (x in 1...10) 0]];
	
	/******************************
	 * determine if the other player had moved a pawn two units with one move. if so, then we can do an En passant on that other player's pawn if our pawn is standing horizontal to that pawn.
	 */
	public static var _triggerNextStuffToDo:Int = 0;
	
	/******************************
	 * can player do En passant?
	 */
	public static var _isEnPassant:Bool = false;
	
	/******************************
	 * did player do an En passant?
	 */
	public static var _doneEnPassant:Bool = false;
	/******************************
	 * these are the pawn that is in the En passant (in passing) position.
	 */
	public static var _chessEnPassantPawnNumber:Array<Int> = [0,0];
	
	/******************************
	 * x coordinate unit location of the moving pawn now can do En passant.
	 */
	public static var _chessEnPassantPawnLocationX:Int = 0;
	
	/******************************
	 * y coordinate unit location of the moving pawn now can do En passant.
	 */
	public static var _chessEnPassantPawnLocationY:Int = 0;

	//############################# END OF IN PASSING
	//#############################     CASTLING

	/******************************
	 * if true then the king has moved. if true then castling cannot be performed.
	 */
	public static var _chessCastlingKingHasNotMoved:Array<Bool> = [true, true];

	/******************************
	 * if true then the rook has moved. if true then castling cannot be performed. p=player(_playerMoving or _playerNotMoving). v=rook piece.
	 */
	public static var _chessCastlingRookHasNotMoved:Array<Array<Bool>>  =
	[for (p in 0...2) [for (i in 0...2) true]];
	
	/******************************
	 * can the king do a castling.
	 */
	public static var _chessCastling:Bool = false;
	
	/******************************
	 * if a castling code block fails then this var will be false. if this var is not true then castling cannot be performed. one fail will exit the loop and then the _chessCastling var will be set to false. 
	 * the first array in Reg._chessCastlingDetermine[0] is the player. 0 for host and 1 for other player. the second array is rules. each rule stored as an element. this is rule 1 and at 0 element. the last array: castling at 0 for left side and 1 = right side. 
	 */
	public static var _chessCastlingDetermine:Array<Array<Array<Bool>>> =
	[for (p in 0...2) [for (i in 0...5) [for (x in 0...2) false]]];
	
	/******************************
	 * this var is used to determine which side the king is castling at. 
	 */
	public static var _chessKingCanCastleHere:Array<Array<Int>> =
	[for (y in 0...8) [for (x in 0...8) 0]]; // locations to castle.
	
	public static var _castlingSoAddToTotal:Int = 2; // when castle, the rook also needs to be moved. this var is used to add 2 to the value when an addition piece is needed to be moved. at GameMovePlayersPiece.hx, Reg._hasPieceMovedFinished is increased when a piece is removed from an unit and then added to a different unit. when Reg._hasPieceMovedFinished has a value of two, the next player can then move. since we are moving two piece, Reg._hasPieceMovedFinished 2 plus this var.
	
	//#############################  END OF CASTLING	
	
	/******************************
	 * this is the stripped down version of the displayed notation that is used to compare the notation at server. if there is a match at server then this notation will be displayed along with the title of the notation.
	 */
	public static var _chessStrippedNotation:String = "";
	public static var _chessStrippedNotationTemp:String = "";

	/******************************
	 * value of 2, 4, 8, excreta, is the other player. not host.
	 */
	public static var _gameNotationMoveNumber:Int = 0;
	
	/******************************
	 * used to display the notation text correctly.
	 */
	public static var _gameNotationOddEven:Int = 1;
	
	/******************************
	 * true then at notationPrint an "x" will be in the text referring to a capture.
	 */
	public static var _gameNotationX:Bool = false;
	
	
	/******************************
	 * this is basic notation used after the end of game when the user can press the play, rewind buttons to see the game moves. these notations are basic because they do not have two characters for the start of a move and only two characters for the end of a move. there is no extra notation such as "++" for checkmate. 
	 */
	public static var _moveHistoryPieceLocationOld1:Array<Int>  = [];
	public static var _moveHistoryPieceLocationNew1:Array<Int>  = [];
	// second piece... such as castling.
	public static var _moveHistoryPieceLocationOld2:Array<Int>  = [];
	public static var _moveHistoryPieceLocationNew2:Array<Int>  = [];
	
	/******************************
	 * do something extra, such as removing a piece or move two pieces at the same time. 
	 */
	public static var _moveHistoryPieceValueOld1:Array<Int>  = [];
	public static var _moveHistoryPieceValueNew1:Array<Int>  = [];
	
	// second piece... such as castling.
	public static var _moveHistoryPieceValueOld2:Array<Int>  = [];
	public static var _moveHistoryPieceValueNew2:Array<Int>  = [];

	// captured piece. its point value.
	public static var _moveHistoryPieceValueOld3:Array<Int>  = [];
	
	public static var _historyImageChessPromotion:Array<Int> = []; // used for history. stores the chess promotion piece, its image.
	
	public static var  _notationWhoIsMoving:Array<Int> = [];
	
	/******************************
	 * the opening defence. the other player.
	 * d=chess opening defence 
	 */
	public static var _chessDefence:Array<Array<Array<Array<String>>>> =
	[for (y1 in 0...8) [for (x1 in 0...8) [for (y2 in 0...8) [for (x2 in 0...8) ""]]]];

	/******************************
	 * opening moves are stored in this var
	 * first array = opening move number. second = move coordinates.
	 * each move has four number ####. the first two is the old y and x then last two are the new y and x.
	 */
	public static var _chessOpeningMoves:Array<Array<String>>  =
	[for (o in 0...300) [for (m in 0...10) ""]];
	
	
	//############################# these vars are used for vs computer.
		
	/******************************
	 * p=point Value Of Unit. all attacking pieces that are NOT able to capture a protecting defending piece but able to capture a piece not protected. the defending piece does not have another of its piece defending it.
	 */
	public static var _chessAbleToCaptureNotProtectedMyP:Array<Int>  = [-1];
	
	/******************************
	 * y old = current piece y value. all attacking pieces that are NOT able to capture a protecting defending piece but able to capture a piece not protected. the defending piece does not have another of its piece defending it.
	 */
	public static var _chessAbleToCaptureNotProtectedYold:Array<Int>  = [-1];
	
	/******************************
	 * x old = current piece x value. all attacking pieces that are NOT able to capture a protecting defending piece but able to capture a piece not protected. the defending piece does not have another of its piece defending it.
	 */
	public static var _chessAbleToCaptureNotProtectedXold:Array<Int>  = [-1];
	
	/******************************
	 * y new = y coordinate of unit for piece to move to. all attacking pieces that are NOT able to capture a protecting defending piece but able to capture a piece not protected. the defending piece does not have another of its piece defending it.
	 */
	public static var _chessAbleToCaptureNotProtectedYnew:Array<Int>  = [-1];
	
	/******************************
	 * x new = x coordinate of unit for piece to move to. all attacking pieces that are NOT able to capture a protecting defending piece but able to capture a piece not protected. the defending piece does not have another of its piece defending it.
	 */
	public static var _chessAbleToCaptureNotProtectedXnew:Array<Int>  = [-1];
	
	/******************************
	 * the piece value of a defending piece is store here. search through the elements to find the highest value. for the beginner level that will be the piece to capture. normal level can apply this var to a function that can calculate, for example, if that piece captured, at the attackers new unit, will check king or if piece capture can block another defender to take even a better piece next move.  the defending piece does not have another of its piece defending it. 
	 * this var is used with that vars of the same name. Note that this var has the same write-up as other vars used for the same thing.
	 */
	public static var _chessAbleToCaptureNotProtectedYourP:Array<Int>  = [-1];	
	
	/******************************
	 * p=point Value Of Unit. all attacking pieces that are able to capture a protecting defending piece. the defending piece has another of its piece defending it.
	 */
	public static var _chessAbleToCaptureProtectedMyP:Array<Int>  = [-1];
	
	/******************************
	 * y old = current piece y value. all attacking pieces that are able to capture a protecting defending piece. the defending piece has another of its piece defending it.
	 */
	public static var _chessAbleToCaptureProtectedYold:Array<Int>  =	[-1];
	
	/******************************
	 * x old = current piece x value. all attacking pieces that are able to capture a protecting defending piece. the defending piece has another of its piece defending it.
	 */
	public static var _chessAbleToCaptureProtectedXold:Array<Int>  = [-1];
	
	/******************************
	 * y new = y coordinate of unit for piece to move to. all attacking pieces that are able to capture a protecting defending piece. the defending piece has another of its piece defending it.
	 */
	public static var _chessAbleToCaptureProtectedYnew:Array<Int>  = [-1];
	
	/******************************
	 * x new = x coordinate of unit for piece to move to. all attacking pieces that are able to capture a protecting defending piece. the defending piece has another of its piece defending it.
	 */
	public static var _chessAbleToCaptureProtectedXnew:Array<Int>  = [-1];
	
	/******************************
	 * the piece value of a defending piece is store here. search through the elements to find the highest value. for the beginner level that will be the piece to capture. normal level can apply this var to a function that can calculate, for example, if that piece captured, at the attackers new unit, will check king or if piece capture can block another defender to take even a better piece next move.  the defending piece has another of its piece defending it.
	 * this var is used with that vars of the same name. Note that this var has the same write-up as other vars used for the same thing.
	 */
	public static var _chessAbleToCaptureProtectedYourP:Array<Int>  = [-1];		
	
	/******************************
	 * p=point Value Of Unit. all moving pieces that position itself to defend another piece.
	 */
	public static var _chessMovePieceToDefendNotProtectedMyP:Array<Int>  = [-1];
	
	/******************************
	 * y old = current piece y value. all moving pieces that position itself to defend another piece.
	 */
	public static var _chessMovePieceToDefendNotProtectedYold:Array<Int>  = [-1];
	
	/******************************
	 * x old = current piece x value. all moving pieces that position itself to defend another piece.
	 */
	public static var _chessMovePieceToDefendNotProtectedXold:Array<Int>  = [-1];
	
	/******************************
	 * y new = y coordinate of unit for piece to move to. all moving pieces that position itself to defend another piece.
	 */
	public static var _chessMovePieceToDefendNotProtectedYnew:Array<Int>  = [-1];
	
	/******************************
	 * x new = x coordinate of unit for piece to move to. all moving pieces that position itself to defend another piece.
	 */
	public static var _chessMovePieceToDefendNotProtectedXnew:Array<Int>  = [-1];
	
	/******************************
	 * the piece value of the other player's piece. search through the elements to find the highest value. the moving piece at the new location does not have another of its piece defending it.
	 * this var is used with that vars of the same name. Note that this var has the same write-up as other vars used for the same thing.
	 */
	public static var _chessMovePieceToDefendNotProtectedYourP:Array<Int>  = [-1];
	
	/******************************
	 * p=point Value Of Unit. all moving pieces that position itself offensively where that piece would be able to capture the defender next move.
	 */
	public static var _chessMovePieceToCaptureNotProtectedMyP:Array<Int>  = [-1];
	
	/******************************
	 * y old = current piece y value. all moving pieces that position itself offensively where that piece would be able to capture the defender next move.
	 */
	public static var _chessMovePieceToCaptureNotProtectedYold:Array<Int>  = [-1];
	
	/******************************
	 * x old = current piece x value. all moving pieces that position itself offensively where that piece would be able to capture the defender next move.
	 */
	public static var _chessMovePieceToCaptureNotProtectedXold:Array<Int>  = [-1];
	
	/******************************
	 * y new = y coordinate of unit for piece to move to. all moving pieces that position itself offensively where that piece would be able to capture the defender next move.
	 */
	public static var _chessMovePieceToCaptureNotProtectedYnew:Array<Int>  = [-1];
	
	/******************************
	 * x new = x coordinate of unit for piece to move to. all moving pieces that position itself offensively where that piece would be able to capture the defender next move.
	 */
	public static var _chessMovePieceToCaptureNotProtectedXnew:Array<Int>  = [-1];
	
	/******************************
	 * the piece value of the other player's piece. search through the elements to find the highest value. the moving piece at the new location that is inline to attack a piece.
	 * this var is used with that vars of the same name. Note that this var has the same write-up as other vars used for the same thing.
	 */
	public static var _chessMovePieceToCaptureNotProtectedYourP:Array<Int>  = [ -1];
	
	/******************************
	 * p=point Value Of Unit. pawn is at least two units from being promoted. try to move this piece. the current pawn's piece value.
	 */
	public static var _chessMovePawnToPromoteMyP:Array<Int>  = [-1];
	
	/******************************
	 * y old = current piece y value. pawn is at least two units from being promoted. try to move this piece.
	 */
	public static var _chessMovePawnToPromoteYold:Array<Int>  = [-1];
	
	/******************************
	 * x old = current piece x value. pawn is at least two units from being promoted. try to move this piece.
	 */
	public static var _chessMovePawnToPromoteXold:Array<Int>  = [-1];
	
	/******************************
	 * y new = y coordinate of unit for piece to move to. pawn is at least two units from being promoted. try to move this piece.
	 */
	public static var _chessMovePawnToPromoteYnew:Array<Int>  = [-1];
	
	/******************************
	 * x new = x coordinate of unit for piece to move to. pawn is at least two units from being promoted. try to move this piece.
	 */
	public static var _chessMovePawnToPromoteXnew:Array<Int>  = [-1];
	
	/******************************
	 * the piece value of the other player's piece. this var is not used.
	 */
	public static var _chessMovePawnToPromoteYourP:Array<Int>  = [ -1];
	
	/******************************
	 * p=point Value Of Unit. pawn is near the promotion unit. therefore, try to protect that pawn.
	 */
	public static var _chessMovePieceDefendPawnForPromotionMyP:Array<Int>  = [-1];
	
	/******************************
	 * y old = current piece y value. pawn is at least two units from being promoted. try to move this piece.
	 */
	public static var _chessMovePieceDefendPawnForPromotionYold:Array<Int>  = [-1];
	
	/******************************
	 * x old = current piece x value. pawn is at least two units from being promoted. try to move this piece.
	 */
	public static var _chessMovePieceDefendPawnForPromotionXold:Array<Int>  = [-1];
	
	/******************************
	 * y new = y coordinate of unit for piece to move to. pawn is at least two units from being promoted. try to move this piece.
	 */
	public static var _chessMovePieceDefendPawnForPromotionYnew:Array<Int>  = [-1];
	
	/******************************
	 * x new = x coordinate of unit for piece to move to. pawn is at least two units from being promoted. try to move this piece.
	 */
	public static var _chessMovePieceDefendPawnForPromotionXnew:Array<Int>  = [-1];
	
	/******************************
	 * the piece value of the other player's piece. this var is not used.
	 */
	public static var _chessMovePieceDefendPawnForPromotionYourP:Array<Int>  = [ -1];
	
	/******************************
	 * p=point Value Of Unit. move the pawn that is at 5 y coordinate or less. does not need to be an attack move.
	 */
	public static var _chessMovePawnNormallyNotProtectedMyP:Array<Int>  = [-1];
	
	/******************************
	 * y old = current piece y value. move the pawn that is at 5 y coordinate or less. does not need to be an attack move.
	 */
	public static var _chessMovePawnNormallyNotProtectedYold:Array<Int>  = [-1];
	
	/******************************
	 * x old = current piece x value. move the pawn that is at 5 y coordinate or less. does not need to be an attack move.
	 */
	public static var _chessMovePawnNormallyNotProtectedXold:Array<Int>  = [-1];
	
	/******************************
	 * y new = y coordinate of unit for piece to move to. move the pawn that is at 5 y coordinate or less. does not need to be an attack move.
	 */
	public static var _chessMovePawnNormallyNotProtectedYnew:Array<Int>  = [-1];
	
	/******************************
	 * x new = x coordinate of unit for piece to move to. move the pawn that is at 5 y coordinate or less. does not need to be an attack move.
	 */
	public static var _chessMovePawnNormallyNotProtectedXnew:Array<Int>  = [-1];
	
	/******************************
	 * the piece value of the other player's piece. move the pawn that is at 5 y coordinate or less. does not need to be an attack move.
	 */
	public static var _chessMovePawnNormallyNotProtectedYourP:Array<Int>  = [ -1];
		
	/******************************
	 * p=point Value Of Unit. capture a unit that is next to king.
	 */
	public static var _chessMoveCaptureUnitNextToKingMyP:Array<Int>  = [-1];
	
	/******************************
	 * y old = current piece y value. capture a unit that is next to king.
	 */
	public static var _chessMoveCaptureUnitNextToKingYold:Array<Int>  = [-1];
	
	/******************************
	 * x old = current piece x value. capture a unit that is next to king.
	 */
	public static var _chessMoveCaptureUnitNextToKingXold:Array<Int>  = [-1];
	
	/******************************
	 * y new = y coordinate of unit for piece to move to. capture a unit that is next to king.
	 */
	public static var _chessMoveCaptureUnitNextToKingYnew:Array<Int>  = [-1];
	
	/******************************
	 * x new = x coordinate of unit for piece to move to. capture a unit that is next to king.
	 */
	public static var _chessMoveCaptureUnitNextToKingXnew:Array<Int>  = [-1];
	
	/******************************
	 * the piece value of the other player's piece. capture a unit that is next to king.
	 */
	public static var _chessMoveCaptureUnitNextToKingYourP:Array<Int>  = [ -1];
		
	/******************************
	 * p=point Value Of Unit. capture the player's king.
	 */
	public static var _chessMoveCapturePlayerKingMyP:Array<Int>  = [-1];
	
	/******************************
	 * y old = current piece y value. capture the player's king.
	 */
	public static var _chessMoveCapturePlayerKingYold:Array<Int>  = [-1];
	
	/******************************
	 * x old = current piece x value. capture the player's king.
	 */
	public static var _chessMoveCapturePlayerKingXold:Array<Int>  = [-1];
	
	/******************************
	 * y new = y coordinate of unit for piece to move to. capture the player's king.
	 */
	public static var _chessMoveCapturePlayerKingYnew:Array<Int>  = [-1];
	
	/******************************
	 * x new = x coordinate of unit for piece to move to. capture the player's king.
	 */
	public static var _chessMoveCapturePlayerKingXnew:Array<Int>  = [-1];
	
	/******************************
	 * the piece value of the other player's piece. capture the player's king.
	 */
	public static var _chessMoveCapturePlayerKingYourP:Array<Int>  = [ -1];
		
	/******************************
	 * p=point Value Of Unit. defend the CPU king when in check.
	 */
	public static var _chessMoveAnyPieceDefendKingMyP:Array<Int>  = [-1];
	
	/******************************
	 * y old = current piece y value. defend the CPU king when in check.
	 */
	public static var _chessMoveAnyPieceDefendKingYold:Array<Int>  = [-1];
	
	/******************************
	 * x old = current piece x value. defend the CPU king when in check.
	 */
	public static var _chessMoveAnyPieceDefendKingXold:Array<Int>  = [-1];
	
	/******************************
	 * y new = y coordinate of unit for piece to move to. defend the CPU king when in check.
	 */
	public static var _chessMoveAnyPieceDefendKingYnew:Array<Int>  = [-1];
	
	/******************************
	 * x new = x coordinate of unit for piece to move to. defend the CPU king when in check.
	 */
	public static var _chessMoveAnyPieceDefendKingXnew:Array<Int>  = [-1];
	
	/******************************
	 * the piece value of the other player's piece. defend the CPU king when in check.
	 */
	public static var _chessMoveAnyPieceDefendKingYourP:Array<Int>  = [ -1];
		
	/******************************
	 * p=point Value Of Unit. defend the CPU king when in check.
	 */
	public static var _chessMoveKingOutOfCheckMyP:Array<Int>  = [-1];
	
	/******************************
	 * y old = current piece y value. defend the CPU king when in check.
	 */
	public static var _chessMoveKingOutOfCheckYold:Array<Int>  = [-1];
	
	/******************************
	 * x old = current piece x value. defend the CPU king when in check.
	 */
	public static var _chessMoveKingOutOfCheckXold:Array<Int>  = [-1];
	
	/******************************
	 * y new = y coordinate of unit for piece to move to. defend the CPU king when in check.
	 */
	public static var _chessMoveKingOutOfCheckYnew:Array<Int>  = [-1];
	
	/******************************
	 * x new = x coordinate of unit for piece to move to. defend the CPU king when in check.
	 */
	public static var _chessMoveKingOutOfCheckXnew:Array<Int>  = [-1];
	
	/******************************
	 * the piece value of the other player's piece. defend the CPU king when in check.
	 */
	public static var _chessMoveKingOutOfCheckYourP:Array<Int>  = [ -1];
		
	/******************************
	 * p=point Value Of Unit. piece should run if piece cannot attack attacker but attacker can attack piece.
	 */
	public static var _chessMoveFromAttackerMyP:Array<Int>  = [-1];
	
	/******************************
	 * y old = current piece y value. piece should run if piece cannot attack attacker but attacker can attack piece.
	 */
	public static var _chessMoveFromAttackerYold:Array<Int>  = [-1];
	
	/******************************
	 * x old = current piece x value. piece should run if piece cannot attack attacker but attacker can attack piece.
	 */
	public static var _chessMoveFromAttackerXold:Array<Int>  = [-1];
	
	/******************************
	 * y new = y coordinate of unit for piece to move to. piece should run if piece cannot attack attacker but attacker can attack piece.
	 */
	public static var _chessMoveFromAttackerYnew:Array<Int>  = [-1];
	
	/******************************
	 * x new = x coordinate of unit for piece to move to. piece should run if piece cannot attack attacker but attacker can attack piece.
	 */
	public static var _chessMoveFromAttackerXnew:Array<Int>  = [-1];
	
	/******************************
	 * the piece value of the other player's piece. piece should run if piece cannot attack attacker but attacker can attack piece.
	 */
	public static var _chessMoveFromAttackerYourP:Array<Int>  = [ -1];
	
	/******************************
	 * p=point Value Of Unit. This is the last move at whereShouldPieceBeMoveTo(). placed near the end of other movement functions. this function tends to keep a piece on a check king path but can capture the piece putting the king in check.
	 */
	public static var _chessCaptureAnyPieceMyP:Array<Int>  = [-1];
	
	/******************************
	 * y old = current piece y value. This is the last move at whereShouldPieceBeMoveTo(). this function tends to keep a piece on a check king path but can capture the piece putting the king in check.
	 */
	public static var _chessCaptureAnyPieceYold:Array<Int>  = [-1];
	
	/******************************
	 * x old = current piece x value. This is the last move at whereShouldPieceBeMoveTo(). this function tends to keep a piece on a check king path but can capture the piece putting the king in check.
	 */
	public static var _chessCaptureAnyPieceXold:Array<Int>  = [-1];
	
	/******************************
	 * y new = y coordinate of unit for piece to move to. This is the last move at whereShouldPieceBeMoveTo(). this function tends to keep a piece on a check king path but can capture the piece putting the king in check.
	 */
	public static var _chessCaptureAnyPieceYnew:Array<Int>  = [-1];
	
	/******************************
	 * x new = x coordinate of unit for piece to move to. This is the last move at whereShouldPieceBeMoveTo(). this function tends to keep a piece on a check king path but can capture the piece putting the king in check.
	 */
	public static var _chessCaptureAnyPieceXnew:Array<Int>  = [-1];
	
	/******************************
	 * the piece value of the other player's piece. This is the last move at whereShouldPieceBeMoveTo(). this function tends to keep a piece on a check king path but can capture the piece putting the king in check.
	 */
	public static var _chessCaptureAnyPieceYourP:Array<Int>  = [ -1];
	
	/******************************
	 * p=point Value Of Unit. This is the last move at whereShouldPieceBeMoveTo(). so there must be a move or there will be a game crash. so make any piece move anywhere.
	 */
	public static var _chessMovePieceAnywhereMyP:Array<Int>  = [-1];
		
	/******************************
	 * y old = current piece y value. This is the last move at whereShouldPieceBeMoveTo(). so there must be a move or there will be a game crash. so make any piece move anywhere.
	 */
	public static var _chessMovePieceAnywhereYold:Array<Int>  = [-1];
	
	/******************************
	 * x old = current piece x value. This is the last move at whereShouldPieceBeMoveTo(). so there must be a move or there will be a game crash. so make any piece move anywhere.
	 */
	public static var _chessMovePieceAnywhereXold:Array<Int>  = [-1];
	
	/******************************
	 * y new = y coordinate of unit for piece to move to. This is the last move at whereShouldPieceBeMoveTo(). so there must be a move or there will be a game crash. so make any piece move anywhere.
	 */
	public static var _chessMovePieceAnywhereYnew:Array<Int>  = [-1];
	
	/******************************
	 * x new = x coordinate of unit for piece to move to. This is the last move at whereShouldPieceBeMoveTo(). so there must be a move or there will be a game crash. so make any piece move anywhere.
	 */
	public static var _chessMovePieceAnywhereXnew:Array<Int>  = [-1];
	
	/******************************
	 * the piece value of the other player's piece. This is the last move at whereShouldPieceBeMoveTo(). so there must be a move or there will be a game crash. so make any piece move anywhere.
	 */
	public static var _chessMovePieceAnywhereYourP:Array<Int>  = [ -1];
		
	/******************************
	 * p=point Value Of Unit. This is the last move at setCheckmateIn3(). search for a checkmate in two move. this is used with other vars to move to checkmate unit.
	 */
	public static var _chessCheckmateIn3MyP:Array<Int>  = [-1];
		
	/******************************
	 * y old = current piece y value. This is the last move at setCheckmateIn3(). search for a checkmate in two move. this is used with other vars to move to checkmate unit.
	 */
	public static var _chessCheckmateIn3Yold:Array<Int>  = [-1];
	
	/******************************
	 * x old = current piece x value. This is the last move at setCheckmateIn3(). search for a checkmate in two move. this is used with other vars to move to checkmate unit.
	 */
	public static var _chessCheckmateIn3Xold:Array<Int>  = [-1];
	
	/******************************
	 * y new = y coordinate of unit for piece to move to. This is the last move at setCheckmateIn3(). search for a checkmate in two move. this is used with other vars to move to checkmate unit.
	 */
	public static var _chessCheckmateIn3Ynew:Array<Int>  = [-1];
	
	/******************************
	 * x new = x coordinate of unit for piece to move to. This is the last move at setCheckmateIn3(). search for a checkmate in one move. this is used with other vars to move to checkmate unit.
	 */
	public static var _chessCheckmateIn3Xnew:Array<Int>  = [-1];
	
	/******************************
	 * the piece value of the other player's piece. This is the last move at setCheckmateIn3(). search for a checkmate in one move. this is used with other vars to move to checkmate unit.
	 */
	public static var _chessCheckmateIn3YourP:Array<Int>  = [ -1];
		
	/******************************
	 * p=point Value Of Unit. This is the last move at setCheckmateIn2(). search for a checkmate in two move. this is used with other vars to move to checkmate unit.
	 */
	public static var _chessCheckmateIn2MyP:Array<Int>  = [-1];
		
	/******************************
	 * y old = current piece y value. This is the last move at setCheckmateIn2(). search for a checkmate in two move. this is used with other vars to move to checkmate unit.
	 */
	public static var _chessCheckmateIn2Yold:Array<Int>  = [-1];
	
	/******************************
	 * x old = current piece x value. This is the last move at setCheckmateIn2(). search for a checkmate in two move. this is used with other vars to move to checkmate unit.
	 */
	public static var _chessCheckmateIn2Xold:Array<Int>  = [-1];
	
	/******************************
	 * y new = y coordinate of unit for piece to move to. This is the last move at setCheckmateIn2(). search for a checkmate in two move. this is used with other vars to move to checkmate unit.
	 */
	public static var _chessCheckmateIn2Ynew:Array<Int>  = [-1];
	
	/******************************
	 * x new = x coordinate of unit for piece to move to. This is the last move at setCheckmateIn2(). search for a checkmate in one move. this is used with other vars to move to checkmate unit.
	 */
	public static var _chessCheckmateIn2Xnew:Array<Int>  = [-1];
	
	/******************************
	 * the piece value of the other player's piece. This is the last move at setCheckmateIn2(). search for a checkmate in one move. this is used with other vars to move to checkmate unit.
	 */
	public static var _chessCheckmateIn2YourP:Array<Int>  = [ -1];
	
	/******************************
	 * p=point Value Of Unit. This is the last move at setCheckmateIn1(). search for a checkmate in one move. this is used with other vars to move to checkmate unit.
	 */
	public static var _chessCheckmateIn1MyP:Array<Int>  = [-1];
		
	/******************************
	 * y old = current piece y value. This is the last move at setCheckmateIn1(). search for a checkmate in one move. this is used with other vars to move to checkmate unit.
	 */
	public static var _chessCheckmateIn1Yold:Array<Int>  = [-1];
	
	/******************************
	 * x old = current piece x value. This is the last move at setCheckmateIn1(). search for a checkmate in one move. this is used with other vars to move to checkmate unit.
	 */
	public static var _chessCheckmateIn1Xold:Array<Int>  = [-1];
	
	/******************************
	 * y new = y coordinate of unit for piece to move to. This is the last move at setCheckmateIn1(). search for a checkmate in one move. this is used with other vars to move to checkmate unit.
	 */
	public static var _chessCheckmateIn1Ynew:Array<Int>  = [-1];
	
	/******************************
	 * x new = x coordinate of unit for piece to move to. This is the last move at setCheckmateIn1(). search for a checkmate in one move. this is used with other vars to move to checkmate unit.
	 */
	public static var _chessCheckmateIn1Xnew:Array<Int>  = [-1];
	
	/******************************
	 * the piece value of the other player's piece. This is the last move at setCheckmateIn1(). search for a checkmate in one move. this is used with other vars to move to checkmate unit.
	 */
	public static var _chessCheckmateIn1YourP:Array<Int>  = [ -1];
		
	/******************************
	 * at ChessCheckOrCheckmate.isThisCheckOrCheckmate, this var is used to break out of ChessFindCheckmate.checkmateSearch() loop because checkmate is found.
	 */
	public static var _checkmate_break_loop :Bool = false;	
	
	/******************************
	 *	if true then this var will end the game displaying a checkmate message to the player.
	 */
	public static var _checkmate:Bool = false;
	
	/******************************
	 * true when the game ends for the player. the game will continue if there are two players still playing the game.
	 */
	public static var _gameOverForPlayer = true; 
	
	/******************************
	 * true when the game is over for all player. the game cannot continue because there are not two players that can play the game.
	 */
	public static var _gameOverForAllPlayers = true;
	
	/******************************
	 * this var is used when a CPU piece is about to move, that piece will search for new units to move to by later be using this var to determine if a move to that undetermined unit is possible.
	 * 0 = pawns / not used. 1 = angled movement. 2 = none angled movement. 3 = any direction movement. 4 = horse.
	 */
	public static var _chessForAnotherPieceValue:Int = 0;

	/******************************
	 * this chess piece is not used on board but used for another piece to determine if a move is safe to do. 
	 * every unit that piece can move to, it moves a pretend copy of itself at that location. it then populates this var with capturing units from that pretend location. therefore, this var is used to look 1 move into the future. remember that a capturing unit is a unit that can be moved to. 
	 * see ChessCapturingUnits.horseFutureCapturingUnits for an example then view ChessMoveCPUsPiece.setMoveFromAttacker on how this var is populated.
	 * u: user. value of 0=user 1, value of 1=user 2. p:piece, i:instance. y and x are the coordinates.
	 */
	public static var _futureCapturingUnitsForPiece:Array<Array<Array<Array<Array<Int>>>>> = 
	[for (u in 0...2) [for (p in 0...6) [for (i in 0...10) [for (y in 0...8) [for (x in 0...8) 0]]]]];
	
	/******************************
	 * when looking one move ahead by using the _futureCapturingUnitsForPiece var, this var pluses 1 to the total every time there is a defender's piece that can be attacked from that location the request piece can move to. The total is added to the coordinates of the pieces future location, the piece that called the _futureCapturingUnitsForPiece var. The computer will move to the unit with the highest total. If the unit has a value of 2, then if that piece moves to that unit then that piece would attack 2 defenders.
	 * the _futureCapturingUnitsForPiece populates the future units the piece can move to. at that time, if there is a defender at any unit that future location can move to, then a total is added to the attacker's future piece location. the highest value is the value where the attackers piece can attack move defenders from.
	 * u: user. value of 0=user 1, value of 1=user 2. p:piece, i:instance. y and x are the coordinates.
	 */
	public static var _futureCapturesFromPieceLocation:Array<Array<Array<Array<Array<Int>>>>> = 
	[for (u in 0...2) [for (p in 0...6) [for (i in 0...10) [for (y in 0...8) [for (x in 0...8) 0]]]]];
	
	public static var _chatterClose:Bool = false; // used to move all elements in the chatter group to the right side of the screen so that it appears that the chatter closed.
	public static var _chatterOpen:Bool = false;
	
	public static var _createGameRoom:Bool = false;
	
	public static var _goBackToLobby:Bool = false; // true then the lobby will be active and visible.
	
	public static var _clearDoubleMessage:Bool = false; // sometimes a double message is seen when changing state. when set to true then this fixes it.
	public static var _drawOffer:Bool = false;
	public static var _restartOffer:Bool = false;
		
	public static var _kickOrBanMessage:String = ""; // display a message at menuState when user is kicked or banned and that user tried to login.
	
	public static var _gameId:Int = 0; // a number referring to a game being played. 0=checkers, 1=chess, etc.
	
	public static var _jumpingWhatDirection:Int = -1; // this var is need to determine what jumped over unit to remove that units piece at. 1=NE. 2=SE. 3=SW. 4=NW. note this cannot go in a class because of the way instances are called.
	
	/******************************
	 * a player's turn will continue until this var is false.
	 */
	public static var _checkersFoundPieceToJumpOver:Bool = false;
	
	/******************************
	 * a value of 1 stops a normal piece from moving the second time. also if there are jumps available, makes a king jump to a y-0 unit and continue to jump over yet another piece.
	 * 1=normal none king pieces. 2=king. 0=empty unit.
	 */
	public static var _checkersUniquePieceValue:Array<Array<Int>> =
	[for (p in 0...8) [for (x in 0...8) 0]];
	
	public static var _isThisPieceAtBackdoor:Bool = false; // used to stop a _capturingUnitsForPieces update when player is not the player moving.
	
	/******************************
	 * when a piece is moved, at CheckersMovePlayersPiece.hx this var is given a value of true or false if the turn ends. if false then this vars at CheckersCurrentUnitClicked.hx will clear capturing unit vars.
	 */
	public static var _checkersShouldKeepJumping:Bool = false;
	
	
	public static var _checkersIsThisFirstMove:Bool = true;
	
	/*
	 * at ReversiMovePlayersPiece.hx, this var at a class instance (id) is read at update() and at that time this var is incremented. when this var reaches a total of Reg._capturingUnitsForPieces value then those class instance has been processed.
	*/
	public static var _reversiProcessAllIdsTotal:Int = 0;
	public static var _reversiMovePiece:Bool = false;
	public static var _reversiReverseIt:Bool = false; // change to other player.
	public static var _reversiReverseIt2:Bool = false; // used at move function to check if using other player is true.
	
	public static var _game_offline_vs_player:Bool = false;
	
	/******************************
	 * a turn is a players move. both players share the same count. then the value reaches zero, its then s draw.
	 */
	public static var _gameTurnsP1:Int = 50;
	public static var _gameTurnsOther:Int = 50; // maybe instead of this var, use _gameTurnsP2, p3 and p4.
	
	/******************************
	 * true if the checkers piece was just kinged.
	 */
	public static var _checkersKingThePiece:Bool = false;
		
	/******************************
	 * its used to remember the open or closed state of chatter. do not change this var to true if you want chatter open at default. instead change GameChatter._groupChatterScroller.x to 0 for open and 360 for close. this var will then be updated. "see chatter = new" for more information.
	 */
	public static var _rememberChatterIsOpen:Bool = false;
	
		
	/******************************
	 * used to move up screen elements such as game notation and side panel buttons.
	 */
	public static var _offsetScreenY:Int = 101;
	public static var _offsetScreenBG:Int = 101;
	
	public static var _username:String = "";
		
	/******************************
	 * if true then code at PlayState will fire, displaying a message.
	 */
	public static var _outputMessage:Bool = false;
	
	/******************************
	 * total number of players in the room that are playing the game. Reg._totalPlayersInRoom starts with 0 for the first player.
	 */
	public static var _totalPlayersInRoom:Int = 0;
	
	/******************************
	 * used to stop a game from updating after a player has left game. player cannot move or restart game when there is not enough players when startingGame var is true.
	 */
	public static var _playerLeftGame:Bool = false;
		
	/******************************
	 * these are the x coordinates on the snake that the player will be positioned at, when the player slides down a snake.
	 * p: snake number 0 to 3.
	 * x: x coordinates
	 */
	public static var _snakePlayerSlideDownLocationsX:Array<Array<Int>> =
	[for (p in 0...4) [for (x in 0...40) 0]];
	
	/******************************
	 * these are the Y coordinates on the snake that the player will be positioned at, when the player slides down a snake.
	 * p: snake number 0 to 3.
	 * Y: Y coordinates
	 */
	public static var _snakePlayerSlideDownLocationsY:Array<Array<Int>> =
	[for (p in 0...4) [for (y in 0...40) 0]];
	
	/******************************
	 * this number refers to the unit where the player is located. 1=first unit at bottom-left corner of the game board while 66 is the top-right corner. 0 = starting position located 1 square left of the bottom-left corner of game board.
	 */
	public static var _snakesLaddersPlayerUnitNumber:Array<Int> = [0, 0];
	
	public static var _rolledA6:Bool = false;
		
	/******************************
	 * used to draw game board squares, creating the game board. these are the squares starting from top of board and ending at bottom.
	 */
	public static var _unitYgameBoardLocation:Array<Int> = [40, 115, 190, 265, 340, 415, 490, 565];
	
	/******************************
	 * used to draw game board squares, creating the game board. these are the squares starting from left of board and ending at top right side.
	 */
	public static var _unitXgameBoardLocation:Array<Int> = [400, 475, 550, 625, 700, 775, 850, 925];	
	
	/******************************
	 * dice number. 0 = player has not yet rolled the dice.
	 */
	public static var _gameDiceCurrentIndex:Array<Int> = [0, 0, 0, 0];

	/******************************
	 * player will move on board until current dice roll value is reached regardless if the player slide down the snake or climbed up a ladder. this var is used as a backend for the client so that the other player's piece will not ignore sliding down a snake or climbing up a ladder. for example, if the original client climbed a ladder then this var is used so that the backend client, that piece, will not take the long way to the top of the ladder. 
	 */
	public static var _gameDiceMinimumIndex:Array<Int> = [0, 0, 0, 0];
	
	/******************************
	 * player will move on board until current dice roll value is reached. if the roll stops at a snake or ladder then the piece will move to that location and this value will be updated.
	 */
	public static var _gameDiceMaximumIndex:Array<Int> = [0, 0, 0, 0];
	
	/******************************
	 * in a four player game, this is the color of a gameboard piece.
	 */
	public static var _game_piece_color1:Array<Int> = [0xFFaa2222, 0xFF2222aa, 0xFF22aa22, 0xFFaaaa22];
	
	/******************************
	 * in a four player game, this is the color of a gameboard unit and game board background used when buying land.
	 */
	public static var _game_piece_color2:Array<Int> = [0xffaa0000, 0xff0000aa, 0xff00aa00, 0xff0000aa];
	
	/******************************
	 * move value passed to the second client so that client can move the first piece. 
	 */
	public static var _backdoorMoveValue:Int = -1;
	
	/******************************
	 * if true then game is a draw because moving player cannot move any piece.
	 */
	public static var _chessStalemate:Bool = false;
	
	/******************************
	 * pawns can attack different than where they can move. the result is that the _capturingUnitsForPieces var will register both as places a pawn can move. therefore, we use this var to hide the angle movements, if there is no attacking piece at those locations, until a chess stalemate check is complete.
	 */
	public static var _chessStalemateBypassCheck:Bool = false;
	
	/******************************
	 * when its the computer turn to search for a checkmate in 2 moves or more, this stops a checkmate message from displaying if checkmate is found in a loop depth greater than 1.
	 */
	public static var _chessCheckmateBypass:Bool = false;
	
	/******************************
	 * when computer is playing, this stops a second check from displaying. 1 putting the king in check and 2 when a check is searched when its the computer turn to move.
	 */
	public static var _chessCheckBypass:Bool = false;
	
	/******************************
	 * used to stop the game message that says "thinking".
	 */
	public static var _gameMessageCPUthinkingEnded:Bool = false;
	
	/******************************
	 * used before game is started at __scene_waiting_room. a value of 0 means this player moves first where as a value of 1 means this player moves after the first player moves.
	 */
	public static var _move_number_current:Int = 0; // 
	
	/******************************
	 * its compared to _move_number_current. for example, when this var value reaches the value of RegTypedef._dataPlayers._moveNumberDynamic[#] then that player can then move. value starts at 0. its compared to _move_number_current.
	 */
	public static var _move_number_next:Int = 0;
	
	/******************************
	 * if spectator, timer will not start for any player until this is set to true. at PlayerTimeRemainingMove.hx class, this var is verified.
	 */
	public static var _spectator_start_timer:Bool = false;
	
	/******************************
	 * value starts at 0.
	 */
	public static var _moveNumberCurrentForHistory:Int = 0;
	
	/******************************
	* a notation is created after a player moves, so the move number for a player will not be correct. for example, when player 1 moves, the _move_number_next will be incremented before sending to the other player(s). when the notation is created for basic notation, we cannot use that var, so this one is used instead. this value is one less than the value when a move is done, so we have the correct player to that moved.
	* _gameMessageCPUthinkingEnded is used to change players, while minus one this value is used for basic notations.
	*/
	public static var _moveNumberCurrentForNotation:Int = 0;
	
	/******************************
	* sometimes a player has another move. each time any player moves, a player number will be push() in to this array so that when the notation buttons are clicked, we will know what number piece to move. 
	*/
	public static var _moveNumberAllNotations:Array<Int> = [0];
	
	/******************************
	 * maximum total player that can play or are playing the game. value of 2 = 2 player game.
	 */
	public static var _roomPlayerLimit:Int = 0; 
	
	/******************************
	 * if this value is greater than 0 then an invite to join room was send to user. if user accepts invite then this var will be used to enter room, else var will be set back to 0.
	 */
	public static var _inviteRoomNumberToJoin:Int = 0;
	
	/******************************
	* if true then the lobby button was pressed and this triggers an action where the player can either enter the create room or waiting room. also player might get a message saying that waiting room is full or someone is already at the create room.
	*/
	public static var _getRoomData:Bool = false;
	
	public static var _actionMessage:String = ""; // lets the targeted player know about something, such as that player is kicked or a banned.
	
	public static var _displayActionMessage:Bool = false;

	/******************************
	 * how much time is left to move. the value is passed to _textMoveTimer1 at PlayerTimeRemainingMove.hx
	 */
	public static var _textTimeRemainingToMove1:String = "";	
	
	/******************************
	 * how much time is left to move. the value is passed to _textMoveTimer2 at PlayerTimeRemainingMove.hx
	 */
	public static var _textTimeRemainingToMove2:String = "";
	
	/******************************
	 * how much time is left to move. the value is passed to _textMoveTimer3 at PlayerTimeRemainingMove.hx
	 */
	public static var _textTimeRemainingToMove3:String = "";
	
	/******************************
	 * how much time is left to move. the value is passed to _textMoveTimer4 at PlayerTimeRemainingMove.hx
	 */public static var _textTimeRemainingToMove4:String = "";
	
	 /******************************
	  * when a game is restarted when offline, this var is used, for example, to go from chess computer game to MenuState1pOffline.hx file then back to the game. this var can be used as a way to stop executing or do executing a block of code at a state when a subState is used.
	  */
	public static var _gameJumpTo:Int = -1; // 
	
	
	public static var _step:Int = 0; // this steps through the move order of the move history. if step had a value of 2 and now has a value of 1 then the backward button was mouse clicked.

	/******************************
	* current player name who had a kick or ban done by the host of the room. this vars value is populated when the action is done. it is passed to server to get the username that was kicked or banned to determine is that user is still kicked or banned.
	*/
	public static var _actionWho:String = "";
		
	/******************************
	* This is used to determine if unit is a 1:house. 2:taxi cab. 3:cafe store. this var can be used with the _p value.
	*/
	public static var _gameHouseTaxiCabOrCafeStoreTypeOfUnit:Array<Int> = [];
	
	/******************************
	 * This is used to determine a 1:house. 2:taxi cab. 3:cafe store. this var can be used with 2 vars such as the Reg._gameYYold and Reg._gameXXold.
	 */
	public static var _gameHouseTaxiCabOrCafeStoreTypePiece:Array<Array<Int>> =
	[for (y in 0...8) [for (x in 0...8) 0]];
	
	/******************************
	 * timer that keeps the players time remaining to move piece. used at PlayerTimeRemainingMove.hx and at this class.
	 */
	public static var _playerAll:PlayersTimer;
	
	/******************************
	 * used when trading units. this holds the value of a unit number. this var is useful. it can change an ownership of a unit. see Reg._gameUniqueValueForPiece. there are two elements. 0:yours. 1:others.
	 */
	public static var _signatureGameUnitNumberTrade:Array<Int> = [0, 0];
		
	/******************************
	 * if playing a 3 or 4 player game and a player lost the game, then this var will keep the player at that game room, so that player waits there for another game.
	 */
	public static var _playerWaitingAtGameRoom:Bool = false;
	
	/******************************
	 * sometimes a player such as player 1 can run out of time permitted at different times at different client. in order to determine if a save or win should be given to that player we need both RegTriggers._playerLeftGame and Reg._atTimerZeroFunction to be true. only then can a gamePlayers typedef of value 2 or 3 be given to that player. when both at values are true, both functions have been read for that player at that client and a block of code at SceneGameRoom.hx be read at update().	
	 */
	public static var _atTimerZeroFunction:Bool = false;
	
	/******************************
	 * used to display a message box about a player leaving the game room. if two players stop playing the game at the same time then this var is used to display two message boxes. using this var as part of the message id. search for: RegTriggers._loss == true at SceneGameRoom.hx
	 * a value of 0 at the second array element means a message box 2 should be displayed. 	 
	 * 0 = player lost game.
	 * -1 = not used.
	 */
	public static var _playerIDs:Int = -1;
	
	/******************************
	* if in a three player game, when player 1 returns to the lobby from the game room or disconnects from the game room, a message for player 2 is displayed using _messageOKplayer1, at that time the player 2 is now player 1 and player 3 is then player 2. if player 2 leave like player 1 did, then the now player 1 will get another message box of the same id of _messageOKplayer1. so if player 1 did not close the first box then there will be message box display error, so this offset is used so that when the first player leaves, this var is plus 1 so that a double message id will not be given.
	* also helps to read the correct element in RegTypedef._dataPlayers._gamePlayersValues
	*/
	public static var _playerOffset:Int = 0;
	
	/******************************
	 * used to display the final message about what happened to end the game, such as the timer expired or the player quit the game.
	 */
	public static var _gameIsNowOver:Bool = false;
	
	public static var _player_left_game_room:Bool = false;
	
	/******************************
	 * this is needed because the first notation is not printed for some games like checkers. When entering a room in offline mode the game will start automatically and the notation window will not output anything. However, the second time starting a game by clicking the start game button the notation window outputted "1. =". this code stops that from happening.
	 */
	public static var _notation_output:Bool = true;
	
	public static var _avatar_total:Int = 0;
		
	/******************************
	* instead of using yy and xx in a for loop, this array is used. This is random instead of a linear for loop.
	* this array element is static. never changing in elements or value,
	*/
	public static var _p_all_static1:Array<Int> = 
	[ 0,  1,  2,  3,  4,  5,  6,  7,  8,  9
	,10, 11, 12, 13, 14, 15, 16, 17, 18, 19
	,20, 21, 22, 23, 24, 25, 26, 27, 28, 29
    ,30, 31, 32, 33, 34, 35, 36, 37, 38, 39
	,40, 41, 42, 43, 44, 45, 46, 47, 48, 49
	,50, 51, 52, 53, 54, 55, 56, 57, 58, 59
	,60, 61, 62, 63];
	public static var _p_all_static2:Array<Int> = 
	[ 0,  1,  2,  3,  4,  5,  6,  7,  8,  9
	,10, 11, 12, 13, 14, 15, 16, 17, 18, 19
	,20, 21, 22, 23, 24, 25, 26, 27, 28, 29
    ,30, 31, 32, 33, 34, 35, 36, 37, 38, 39
	,40, 41, 42, 43, 44, 45, 46, 47, 48, 49
	,50, 51, 52, 53, 54, 55, 56, 57, 58, 59
	,60, 61, 62, 63];
	public static var _p_all_static3:Array<Int> = 
	[ 0,  1,  2,  3,  4,  5,  6,  7,  8,  9
	,10, 11, 12, 13, 14, 15, 16, 17, 18, 19
	,20, 21, 22, 23, 24, 25, 26, 27, 28, 29
    ,30, 31, 32, 33, 34, 35, 36, 37, 38, 39
	,40, 41, 42, 43, 44, 45, 46, 47, 48, 49
	,50, 51, 52, 53, 54, 55, 56, 57, 58, 59
	,60, 61, 62, 63];
	
	/******************************
	* instead of using yy and xx in a for loop, this array is used. This is random instead of a linear for loop.
	* the array element is pop() at each use. then this array is empty of elements then it will copy from _p_all_static1.
	*/
	public static var _p_all_dynamic1:Array<Int> = [];
	public static var _p_all_dynamic2:Array<Int> = [];
	public static var _p_all_dynamic3:Array<Int> = [];
	
	/******************************
	 * at a game that uses the number wheel, sometimes the number wheel class pauses the wheel after a game gets the value. the result is, for example, the number 2 is seen on the wheel but the player only moved 1 unit. this var is used at the game click me class alone with _ticks to insure that the number wheel is updated before the game is assigned to the game class.
	 */
	public static var _number_wheel_get_value:Bool = false;
	
	/*****************************
	 * when this tick reaches a set value, the code to assign a value from the number wheel to a players piece will be made.
	 */
	public static var _number_wheel_ticks:Int = 0;
	
	public static var _menubar_color:FlxColor;
	
	/*****************************
	 * display a message only once when the spectator watching enters the game room.
	 */
	public static var _spectator_watching_entering_game_room_message:Bool = false;
	
	/*****************************
	 * path to the client executable without a trailing slash.
	 */
	public static var _program_path:String;

	/*****************************
	 * displays an inportant server message from the admin.
	 */
	public static var _server_message:String = "";
				
	/******************************
	 * true if at house.
	 */
	public static var _at_house:Bool = false;
	public static var __menu_bar:MenuBar;
	
	/******************************
	 * theme number var. default theme has this value of 0. all themes are taken from the themes folder. all themes from that folder will do a var push. so, the second theme from the folder will have a value of 2.
	 */
	public static var _tn:Int = 0;
	public static var _tn_total:Int = 0; // total amount of themes available.
	
	public static function resetCPUaiVars():Void
	{
		for (p in 0...2)
		{
			for (i in 0...65)
			{
				_chessAbleToCaptureNotProtectedMyP[i] = -1;
				_chessAbleToCaptureNotProtectedYold[i] = -1;
				_chessAbleToCaptureNotProtectedXold[i] = -1;
				_chessAbleToCaptureNotProtectedYnew[i] = -1;
				_chessAbleToCaptureNotProtectedXnew[i] = -1;
				_chessAbleToCaptureNotProtectedYourP[i] = -1;
				
				_chessAbleToCaptureProtectedMyP[i] = -1;
				_chessAbleToCaptureProtectedYold[i] = -1;
				_chessAbleToCaptureProtectedXold[i] = -1;
				_chessAbleToCaptureProtectedYnew[i] = -1;
				_chessAbleToCaptureProtectedXnew[i] = -1;
				_chessAbleToCaptureProtectedYourP[i] = -1;
				
				_chessMovePieceToDefendNotProtectedMyP[i] = -1;
				_chessMovePieceToDefendNotProtectedYold[i] = -1;
				_chessMovePieceToDefendNotProtectedXold[i] = -1;
				_chessMovePieceToDefendNotProtectedYnew[i] = -1;
				_chessMovePieceToDefendNotProtectedXnew[i] = -1;
				_chessMovePieceToDefendNotProtectedYourP[i] = -1;
				
				_chessMovePieceToCaptureNotProtectedMyP[i] = -1;
				_chessMovePieceToCaptureNotProtectedYold[i] = -1;
				_chessMovePieceToCaptureNotProtectedXold[i] = -1;
				_chessMovePieceToCaptureNotProtectedYnew[i] = -1;
				_chessMovePieceToCaptureNotProtectedXnew[i] = -1;
				_chessMovePieceToCaptureNotProtectedYourP[i] = -1;
				
				_chessMovePawnToPromoteMyP[i] = -1;
				_chessMovePawnToPromoteYold[i] = -1;
				_chessMovePawnToPromoteXold[i] = -1;
				_chessMovePawnToPromoteYnew[i] = -1;
				_chessMovePawnToPromoteXnew[i] = -1;
				_chessMovePawnToPromoteYourP[i] = -1;
				
				_chessMovePieceDefendPawnForPromotionMyP[i] = -1;
				_chessMovePieceDefendPawnForPromotionYold[i] = -1;
				_chessMovePieceDefendPawnForPromotionXold[i] = -1;
				_chessMovePieceDefendPawnForPromotionYnew[i] = -1;
				_chessMovePieceDefendPawnForPromotionXnew[i] = -1;
				_chessMovePieceDefendPawnForPromotionYourP[i] = -1;
				
				_chessMovePawnNormallyNotProtectedMyP[i] = -1;
				_chessMovePawnNormallyNotProtectedYold[i] = -1;
				_chessMovePawnNormallyNotProtectedXold[i] = -1;
				_chessMovePawnNormallyNotProtectedYnew[i] = -1;
				_chessMovePawnNormallyNotProtectedXnew[i] = -1;
				_chessMovePawnNormallyNotProtectedYourP[i] = -1;
				
				_chessMoveCaptureUnitNextToKingMyP[i] = -1;
				_chessMoveCaptureUnitNextToKingYold[i] = -1;
				_chessMoveCaptureUnitNextToKingXold[i] = -1;
				_chessMoveCaptureUnitNextToKingYnew[i] = -1;
				_chessMoveCaptureUnitNextToKingXnew[i] = -1;
				_chessMoveCaptureUnitNextToKingYourP[i] = -1;
				
				_chessMoveCapturePlayerKingMyP[i] = -1;
				_chessMoveCapturePlayerKingYold[i] = -1;
				_chessMoveCapturePlayerKingXold[i] = -1;
				_chessMoveCapturePlayerKingYnew[i] = -1;
				_chessMoveCapturePlayerKingXnew[i] = -1;
				_chessMoveCapturePlayerKingYourP[i] = -1;
				
				_chessMoveAnyPieceDefendKingMyP[i] = -1;
				_chessMoveAnyPieceDefendKingYold[i] = -1;
				_chessMoveAnyPieceDefendKingXold[i] = -1;
				_chessMoveAnyPieceDefendKingYnew[i] = -1;
				_chessMoveAnyPieceDefendKingXnew[i] = -1;
				_chessMoveAnyPieceDefendKingYourP[i] = -1;
				
				_chessMoveKingOutOfCheckMyP[i] = -1;
				_chessMoveKingOutOfCheckYold[i] = -1;
				_chessMoveKingOutOfCheckXold[i] = -1;
				_chessMoveKingOutOfCheckYnew[i] = -1;
				_chessMoveKingOutOfCheckYnew[i] = -1;
				_chessMoveKingOutOfCheckYourP[i] = -1;
				
				_chessMoveFromAttackerMyP[i] = -1;
				_chessMoveFromAttackerYold[i] = -1;
				_chessMoveFromAttackerXold[i] = -1;
				_chessMoveFromAttackerYnew[i] = -1;
				_chessMoveFromAttackerYnew[i] = -1;
				_chessMoveFromAttackerYourP[i] = -1;
				
				_chessCaptureAnyPieceMyP[i] = -1;
				_chessCaptureAnyPieceYold[i] = -1;
				_chessCaptureAnyPieceXold[i] = -1;
				_chessCaptureAnyPieceYnew[i] = -1;
				_chessCaptureAnyPieceYnew[i] = -1;
				_chessCaptureAnyPieceYourP[i] = -1;
				
				_chessMovePieceAnywhereMyP[i] = -1;
				_chessMovePieceAnywhereYold[i] = -1;
				_chessMovePieceAnywhereXold[i] = -1;
				_chessMovePieceAnywhereYnew[i] = -1;
				_chessMovePieceAnywhereYnew[i] = -1;
				_chessMovePieceAnywhereYourP[i] = -1;
				
				_chessCheckmateIn3MyP[i] = -1;
				_chessCheckmateIn3Yold[i] = -1;
				_chessCheckmateIn3Xold[i] = -1;
				_chessCheckmateIn3Ynew[i] = -1;
				_chessCheckmateIn3Ynew[i] = -1;
				_chessCheckmateIn3YourP[i] = -1;
				
				_chessCheckmateIn2MyP[i] = -1;
				_chessCheckmateIn2Yold[i] = -1;
				_chessCheckmateIn2Xold[i] = -1;
				_chessCheckmateIn2Ynew[i] = -1;
				_chessCheckmateIn2Ynew[i] = -1;
				_chessCheckmateIn2YourP[i] = -1;

				_chessCheckmateIn1MyP[i] = -1;
				_chessCheckmateIn1Yold[i] = -1;
				_chessCheckmateIn1Xold[i] = -1;
				_chessCheckmateIn1Ynew[i] = -1;
				_chessCheckmateIn1Ynew[i] = -1;
				_chessCheckmateIn1YourP[i] = -1;
			}		
		}
	}
	
	/******************************
	 * change the _public var to true if release is ready for the public.
	 * resetRegVarsOnce() calls this function.
	 * only change the "var _public = false;" line.
	 */
	public static function set_for_public():Void
	{		
		var _public = false;
		
		if (_public == false)
		{
			// just change change these three var values below this line.
			_clientReadyForPublicRelease = false;		
			_startFullscreen = false;
			
			// set true when testing a feature that needs 2 players or when not ready for the public.
			_loginMoreThanOnce = true; 
		}
		
		else
		{
			_clientReadyForPublicRelease = true;		
			_startFullscreen = true;
			_loginMoreThanOnce = false; 
		}
	}
	
	public static function system_reset():Void
	{
		_serverDisconnected = false;
		_clientDisconnected = false;
		_login_failed = false;
		_game_online_vs_cpu = false;
		_displayOneDeviceErrorMessage = false;
		_move_number_next = 0;
		_moveNumberCurrentForHistory = 0;
		
		_gameJumpTo = -1;
		_playerOffset = 0;		
		_at_lobby = false;		
		_foundNotation = false;
		_playerLeftGame = false;
		_roomPlayerLimit = 0;
		 _gameOverForPlayer = true;
		 _gameOverForAllPlayers = true;
		_totalPlayersInRoom = 0;
		
		for (p in 0...2)
		{
			for (y in 0...8)
			{
				for (x in 0...8)
				{
					_chessFuturePathToKing[p][y][x] = 0;
				}
			}
		}
		
		// the following in this function are not needed to be uncommented.
		//_gameMessage = "";
		//_outputMessage = false;
		//_alreadyOnlineHost = false;
		//_alreadyOnlineUser = false;
		//_isThisServerPaidMember = false;
		
		
		_ecoOpeningsNotationsOutput = "";
		// notation works when commenting out these two lines.
		//_ecoOpeningsNamesTemp = "";
		//_ecoOpeningsNotationsTemp = "";
		
		//_unitXgameBoardLocation and _unitYgameBoardLocation; // not needed to be reset.
		//_actionMessage = ""; // never reset this var.
		//_cannotConnectToServer = false; // don't use  this is commented because when changing states all reg.hx vars are reset. we cannot reset this because this var is used to go from menuState to playState to try to connect and then back to menuState if the connect fails.
	}
	
	/******************************
	 * call this function only from MenuState. these vars must not be reset when doing a restart game. using resetRegVars() with this function will reset everything back to default.
	 */
	public static function resetRegVarsOnce():Void
	{
		//############################# START CONFIG
		
		set_for_public();		
		
		_avatar_total = 300;
	
		_websiteHomeUrl = "kboardgames.com";
		_websiteNameTitle = "K Board Games";
		_websiteNameTitleCompare = "K Board Games";
		
		
		// use localhost if you want to work offline. // use your public IP (ipconfig at command prompt), if you want others from the internet to connect to server. must be online for the connection to server to work.
		
		_ipAddressServerMain = "kboardgames.com"; // "localhost"; always work online because the website needs to be online and while online the localhost setting will not connect to the server. do not use www, because the site stops working.; 
				
		_useThirdPartyIpAddress = true; // set this true to enable paid server feature. paid members can host their own domain and that domain can be selected at MenuState as an option to connect to that server.
		
		//############################# END CONFIG
		_menubar_color = FlxColor.fromHSB(FlxG.random.int(1, 335), 0.75, RegCustom._background_brightness[_tn]);
		
		_p_all_static1 = 
	[ 0,  1,  2,  3,  4,  5,  6,  7,  8,  9
	,10, 11, 12, 13, 14, 15, 16, 17, 18, 19
	,20, 21, 22, 23, 24, 25, 26, 27, 28, 29
    ,30, 31, 32, 33, 34, 35, 36, 37, 38, 39
	,40, 41, 42, 43, 44, 45, 46, 47, 48, 49
	,50, 51, 52, 53, 54, 55, 56, 57, 58, 59
	,60, 61, 62, 63];
	
		_pieceMovedUpdateServer = false;
		_gameHost = true;
		_game_offline_vs_player = false;
		_rememberChatterIsOpen = false;
		_game_offline_vs_cpu = true;
		_chessPawnPromotedMessage = false;
		_chessOriginOfcheckmateXXnew = -1;
		_chessOriginOfcheckmateYYnew = -1;
		_spectator_watching_entering_game_room_message = false;
		
		#if !html5
			_program_path = StringTools.replace(Path.directory(Sys.programPath()), "\\", "/");
		#end
		
		for (p in 0...4)
		{
			for (i in 0...40)
			{
				_snakePlayerSlideDownLocationsX[p][i] = 0;
				_snakePlayerSlideDownLocationsY[p][i] = 0;
			}
		}
				
		_textTimeRemainingToMove1 = "";
		_textTimeRemainingToMove2 = "";
		_textTimeRemainingToMove3 = "";
		_textTimeRemainingToMove4 = "";

		// at website you might need to "" the following for display flash client.
		_fontDefault 	= "assets/fonts/LiberationMono-Regular.ttf";
		_fontTitle 		= "assets/fonts/LiberationMono-Regular.ttf";

				
		// snake 1, bottom left corner.
		_snakePlayerSlideDownLocationsX[0][1] = 110;
		_snakePlayerSlideDownLocationsY[0][1] = 470;
		
		_snakePlayerSlideDownLocationsX[0][1] = 120;
		_snakePlayerSlideDownLocationsY[0][1] = 480;		
		
		_snakePlayerSlideDownLocationsX[0][2] = 140;
		_snakePlayerSlideDownLocationsY[0][2] = 482;		
		
		_snakePlayerSlideDownLocationsX[0][3] = 158;
		_snakePlayerSlideDownLocationsY[0][3] = 490;		
		
		_snakePlayerSlideDownLocationsX[0][4] = 170;
		_snakePlayerSlideDownLocationsY[0][4] = 500;
		
		_snakePlayerSlideDownLocationsX[0][5] = 168;
		_snakePlayerSlideDownLocationsY[0][5] = 514;
		
		_snakePlayerSlideDownLocationsX[0][6] = 160;
		_snakePlayerSlideDownLocationsY[0][6] = 530;		
		
		_snakePlayerSlideDownLocationsX[0][7] = 152;
		_snakePlayerSlideDownLocationsY[0][7] = 546;		
		
		_snakePlayerSlideDownLocationsX[0][8] = 150;
		_snakePlayerSlideDownLocationsY[0][8] = 562;
		
		_snakePlayerSlideDownLocationsX[0][9] = 156;
		_snakePlayerSlideDownLocationsY[0][9] = 576;		
		
		_snakePlayerSlideDownLocationsX[0][10] = 170;
		_snakePlayerSlideDownLocationsY[0][10] = 588;
		
		_snakePlayerSlideDownLocationsX[0][11] = 184;
		_snakePlayerSlideDownLocationsY[0][11] = 592;		
		
		_snakePlayerSlideDownLocationsX[0][12] = 200;
		_snakePlayerSlideDownLocationsY[0][12] = 590;		
		
		_snakePlayerSlideDownLocationsX[0][13] = 214;
		_snakePlayerSlideDownLocationsY[0][13] = 582;		
		
		_snakePlayerSlideDownLocationsX[0][14] = 224;
		_snakePlayerSlideDownLocationsY[0][14] = 572;		
		
		_snakePlayerSlideDownLocationsX[0][15] = 236;
		_snakePlayerSlideDownLocationsY[0][15] = 560;		
		
		_snakePlayerSlideDownLocationsX[0][16] = 246;
		_snakePlayerSlideDownLocationsY[0][16] = 548;		
		
		_snakePlayerSlideDownLocationsX[0][17] = 260;
		_snakePlayerSlideDownLocationsY[0][17] = 540;		
		
		_snakePlayerSlideDownLocationsX[0][18] = 272;
		_snakePlayerSlideDownLocationsY[0][18] = 540;		
		
		_snakePlayerSlideDownLocationsX[0][19] = 286;
		_snakePlayerSlideDownLocationsY[0][19] = 546;		
		
		_snakePlayerSlideDownLocationsX[0][20] = 296;
		_snakePlayerSlideDownLocationsY[0][20] = 556;
		
		_snakePlayerSlideDownLocationsX[0][21] = 306;
		_snakePlayerSlideDownLocationsY[0][21] = 560;		
		
		_snakePlayerSlideDownLocationsX[0][22] = 318;
		_snakePlayerSlideDownLocationsY[0][22] = 565;		
		
		_snakePlayerSlideDownLocationsX[0][23] = 300;
		_snakePlayerSlideDownLocationsY[0][23] = 525;

		// snake 2.
		_snakePlayerSlideDownLocationsX[1][0] = 182;
		_snakePlayerSlideDownLocationsY[1][0] = 266;
		
		_snakePlayerSlideDownLocationsX[1][1] = 170;
		_snakePlayerSlideDownLocationsY[1][1] = 280;
		
		_snakePlayerSlideDownLocationsX[1][2] = 166;
		_snakePlayerSlideDownLocationsY[1][2] = 296;
		
		_snakePlayerSlideDownLocationsX[1][3] = 164;
		_snakePlayerSlideDownLocationsY[1][3] = 314;
		
		_snakePlayerSlideDownLocationsX[1][4] = 170;
		_snakePlayerSlideDownLocationsY[1][4] = 328;
		
		_snakePlayerSlideDownLocationsX[1][5] = 180;
		_snakePlayerSlideDownLocationsY[1][5] = 340;
		
		_snakePlayerSlideDownLocationsX[1][6] = 194;
		_snakePlayerSlideDownLocationsY[1][6] = 348;
		
		_snakePlayerSlideDownLocationsX[1][7] = 212;
		_snakePlayerSlideDownLocationsY[1][7] = 352;
		
		_snakePlayerSlideDownLocationsX[1][8] = 228;
		_snakePlayerSlideDownLocationsY[1][8] = 356;
		
		_snakePlayerSlideDownLocationsX[1][9] = 242;
		_snakePlayerSlideDownLocationsY[1][9] = 362;
		
		_snakePlayerSlideDownLocationsX[1][10] = 254;
		_snakePlayerSlideDownLocationsY[1][10] = 374;
		
		_snakePlayerSlideDownLocationsX[1][11] = 262;
		_snakePlayerSlideDownLocationsY[1][11] = 390;
		
		_snakePlayerSlideDownLocationsX[1][12] = 266;
		_snakePlayerSlideDownLocationsY[1][12] = 404;
		
		_snakePlayerSlideDownLocationsX[1][13] = 270;
		_snakePlayerSlideDownLocationsY[1][13] = 420;
		
		_snakePlayerSlideDownLocationsX[1][14] = 280;
		_snakePlayerSlideDownLocationsY[1][14] = 436;
		
		_snakePlayerSlideDownLocationsX[1][15] = 294;
		_snakePlayerSlideDownLocationsY[1][15] = 444;
		
		_snakePlayerSlideDownLocationsX[1][16] = 312;
		_snakePlayerSlideDownLocationsY[1][16] = 446;
		
		_snakePlayerSlideDownLocationsX[1][17] = 330;
		_snakePlayerSlideDownLocationsY[1][17] = 446;
		
		_snakePlayerSlideDownLocationsX[1][18] = 348;
		_snakePlayerSlideDownLocationsY[1][18] = 450;
		
		_snakePlayerSlideDownLocationsX[1][19] = 360;
		_snakePlayerSlideDownLocationsY[1][19] = 460;
		
		_snakePlayerSlideDownLocationsX[1][20] = 370;
		_snakePlayerSlideDownLocationsY[1][20] = 474;
		
		_snakePlayerSlideDownLocationsX[1][21] = 374;
		_snakePlayerSlideDownLocationsY[1][21] = 490;
		
		_snakePlayerSlideDownLocationsX[1][22] = 378;
		_snakePlayerSlideDownLocationsY[1][22] = 506;
		
		_snakePlayerSlideDownLocationsX[1][23] = 388;
		_snakePlayerSlideDownLocationsY[1][23] = 520;
		
		_snakePlayerSlideDownLocationsX[1][24] = 404;
		_snakePlayerSlideDownLocationsY[1][24] = 520;
		
		_snakePlayerSlideDownLocationsX[1][25] = 420;
		_snakePlayerSlideDownLocationsY[1][25] = 518;
		
		_snakePlayerSlideDownLocationsX[1][26] = 438;
		_snakePlayerSlideDownLocationsY[1][26] = 520;
		
		_snakePlayerSlideDownLocationsX[1][27] = 452;
		_snakePlayerSlideDownLocationsY[1][27] = 528;
		
		_snakePlayerSlideDownLocationsX[1][28] = 464;
		_snakePlayerSlideDownLocationsY[1][28] = 542;
		
		_snakePlayerSlideDownLocationsX[1][29] = 476;
		_snakePlayerSlideDownLocationsY[1][29] = 556;
		
		_snakePlayerSlideDownLocationsX[1][30] = 450;
		_snakePlayerSlideDownLocationsY[1][30] = 525;		
		
		// snake 3.
		_snakePlayerSlideDownLocationsX[2][0] = 394;
		_snakePlayerSlideDownLocationsY[2][0] = 12;
		
		_snakePlayerSlideDownLocationsX[2][1] = 398;
		_snakePlayerSlideDownLocationsY[2][1] = 34;
		
		_snakePlayerSlideDownLocationsX[2][2] = 374;
		_snakePlayerSlideDownLocationsY[2][2] = 44;
		
		_snakePlayerSlideDownLocationsX[2][3] = 354;
		_snakePlayerSlideDownLocationsY[2][3] = 58;
		
		_snakePlayerSlideDownLocationsX[2][4] = 332;
		_snakePlayerSlideDownLocationsY[2][4] = 70;
		
		_snakePlayerSlideDownLocationsX[2][5] = 308;
		_snakePlayerSlideDownLocationsY[2][5] = 74;
		
		_snakePlayerSlideDownLocationsX[2][6] = 284;
		_snakePlayerSlideDownLocationsY[2][6] = 70;
		
		_snakePlayerSlideDownLocationsX[2][7] = 260;
		_snakePlayerSlideDownLocationsY[2][7] = 62;
		
		_snakePlayerSlideDownLocationsX[2][8] = 240;
		_snakePlayerSlideDownLocationsY[2][8] = 58;
		
		_snakePlayerSlideDownLocationsX[2][9] = 220;
		_snakePlayerSlideDownLocationsY[2][9] = 60;
		
		_snakePlayerSlideDownLocationsX[2][10] = 202;
		_snakePlayerSlideDownLocationsY[2][10] = 70;
		
		_snakePlayerSlideDownLocationsX[2][11] = 186;
		_snakePlayerSlideDownLocationsY[2][11] = 84;
		
		_snakePlayerSlideDownLocationsX[2][12] = 178;
		_snakePlayerSlideDownLocationsY[2][12] = 102;
		
		_snakePlayerSlideDownLocationsX[2][13] = 174;
		_snakePlayerSlideDownLocationsY[2][13] = 122;
		
		_snakePlayerSlideDownLocationsX[2][14] = 174;
		_snakePlayerSlideDownLocationsY[2][14] = 142;
		
		_snakePlayerSlideDownLocationsX[2][15] = 174;
		_snakePlayerSlideDownLocationsY[2][15] = 160;
		
		_snakePlayerSlideDownLocationsX[2][16] = 172;
		_snakePlayerSlideDownLocationsY[2][16] = 180;
		
		_snakePlayerSlideDownLocationsX[2][17] = 158;
		_snakePlayerSlideDownLocationsY[2][17] = 194;
		
		_snakePlayerSlideDownLocationsX[2][18] = 138;
		_snakePlayerSlideDownLocationsY[2][18] = 200;
		
		_snakePlayerSlideDownLocationsX[2][19] = 118;
		_snakePlayerSlideDownLocationsY[2][19] = 200;
		
		_snakePlayerSlideDownLocationsX[2][20] = 96;
		_snakePlayerSlideDownLocationsY[2][20] = 200;
		
		_snakePlayerSlideDownLocationsX[2][21] = 78;
		_snakePlayerSlideDownLocationsY[2][21] = 204;
		
		_snakePlayerSlideDownLocationsX[2][22] = 66;
		_snakePlayerSlideDownLocationsY[2][22] = 218;
		
		_snakePlayerSlideDownLocationsX[2][23] = 66;
		_snakePlayerSlideDownLocationsY[2][23] = 234;
		
		_snakePlayerSlideDownLocationsX[2][24] = 74;
		_snakePlayerSlideDownLocationsY[2][24] = 250;
		
		_snakePlayerSlideDownLocationsX[2][25] = 84;
		_snakePlayerSlideDownLocationsY[2][25] = 266;
		
		_snakePlayerSlideDownLocationsX[2][26] = 94;
		_snakePlayerSlideDownLocationsY[2][26] = 280;
		
		_snakePlayerSlideDownLocationsX[2][27] = 104;
		_snakePlayerSlideDownLocationsY[2][27] = 298;
		
		_snakePlayerSlideDownLocationsX[2][28] = 106;
		_snakePlayerSlideDownLocationsY[2][28] = 314;
		
		_snakePlayerSlideDownLocationsX[2][29] = 75;
		_snakePlayerSlideDownLocationsY[2][29] = 300;
		
		// snake 4.
		_snakePlayerSlideDownLocationsX[3][0] = 486;
		_snakePlayerSlideDownLocationsY[3][0] = 176;
		
		_snakePlayerSlideDownLocationsX[3][1] = 496;
		_snakePlayerSlideDownLocationsY[3][1] = 196;
		
		_snakePlayerSlideDownLocationsX[3][2] = 486;
		_snakePlayerSlideDownLocationsY[3][2] = 214;
		
		_snakePlayerSlideDownLocationsX[3][3] = 476;
		_snakePlayerSlideDownLocationsY[3][3] = 236;
		
		_snakePlayerSlideDownLocationsX[3][4] = 470;
		_snakePlayerSlideDownLocationsY[3][4] = 256;
		
		_snakePlayerSlideDownLocationsX[3][5] = 478;
		_snakePlayerSlideDownLocationsY[3][5] = 268;
		
		_snakePlayerSlideDownLocationsX[3][6] = 492;
		_snakePlayerSlideDownLocationsY[3][6] = 278;
		
		_snakePlayerSlideDownLocationsX[3][7] = 506;
		_snakePlayerSlideDownLocationsY[3][7] = 290;
		
		_snakePlayerSlideDownLocationsX[3][8] = 494;
		_snakePlayerSlideDownLocationsY[3][8] = 304;
		
		_snakePlayerSlideDownLocationsX[3][9] = 480;
		_snakePlayerSlideDownLocationsY[3][9] = 312;
		
		_snakePlayerSlideDownLocationsX[3][10] = 468;
		_snakePlayerSlideDownLocationsY[3][10] = 324;
		
		_snakePlayerSlideDownLocationsX[3][11] = 462;
		_snakePlayerSlideDownLocationsY[3][11] = 342;
		
		_snakePlayerSlideDownLocationsX[3][12] = 472;
		_snakePlayerSlideDownLocationsY[3][12] = 358;
		
		_snakePlayerSlideDownLocationsX[3][13] = 486;
		_snakePlayerSlideDownLocationsY[3][13] = 368;
		
		_snakePlayerSlideDownLocationsX[3][14] = 500;
		_snakePlayerSlideDownLocationsY[3][14] = 380;
		
		_snakePlayerSlideDownLocationsX[3][15] = 498;
		_snakePlayerSlideDownLocationsY[3][15] = 396;
		
		_snakePlayerSlideDownLocationsX[3][16] = 450;
		_snakePlayerSlideDownLocationsY[3][16] = 375;
			
	}
	
	// these vars are reset at the start of each game.
	public static function resetRegVars():Void
	{
		resetCPUaiVars();
		ChessECO.listToArray();
		
		_gameIsNowOver = false;
		_signatureGameUnitNumberTrade = [0, 0];
		_number_wheel_get_value = false;
		_number_wheel_ticks = 0;
		_step = 0; // used to step through history array elements.
		_messageId = 0;
		_messageFocusId.splice(0, _messageFocusId.length);
		_currentRoomState = 0;
		_clearDoubleMessage = false;
		_at_create_room = false;
		_at_waiting_room = false;
		_at_input_keyboard = false;
		_at_configuration_menu = false;
		_loginSuccessfulWasRead = false;
		_doOnce = true;
		_spectator_start_timer = false;
		_doStartGameOnce = true;
		_keyOrButtonDown = false;
		_loggedIn = false;
		_disconnectNow = false;
		_hasUserConnectedToServer = false;
		_isLoggingIn = false;
		_popupMessageUseYesNoButtons.splice(0, _popupMessageUseYesNoButtons.length);
		_buttonCodeValues = "";
		_buttonCodeFocusValues.splice(0, _buttonCodeFocusValues.length);
		_yesNoKeyPressValueAtMessage = 0;
		_yesNoKeyPressValueAtTrade = 0;
		_doUpdate = true;	
		_lobbyDisplay = true;
		_roomDisplay = true;		
		_buttonDown = false;
		_gameRoom = false;		
		_gameDidFirstMove = false;
		_chessPathFromPawnOrHorse = false;		
		_pieceNumber = 0;		
		_chessPromote = false;
		_promotePieceLetter = "";
		
		_chessKingXcoordinate[0] = 0;
		_chessKingYcoordinate[0] = 0;
		_chessKingXcoordinate[1] = 0;
		_chessKingYcoordinate[1] = 0;
		
		_chessKeepPieceDefendingAtPath = 0;
		_chessPathNumberOfKingInCheck = 0;
		
		_atTimerZeroFunction = false;
		
		_isEnPassant = false; 
		_doneEnPassant = false;
		_chessEnPassantPawnNumber[0] = 0;
		_chessEnPassantPawnNumber[1] = 0;
		
		for (i in 0...10)
		{
			_chessTotalDefendersOnPath[i] = 0;
		}
		
		_triggerNextStuffToDo = 0;
		
		_gameOtherPlayerXnew = 0;
		_gameOtherPlayerYnew = 0;
		
		_imageValueOfUnitOld1 = 0;
		_imageValueOfUnitNew1 = 0;
		_imageValueOfUnitOld2 = 0;
		_imageValueOfUnitNew2 = 0;
		_imageValueOfUnitOld3 = 0;
		
		_chessEnPassantPawnLocationX = 0;
		_chessEnPassantPawnLocationY = 0;
		
		_chessCastlingKingHasNotMoved[0] = true;
		_chessCastlingKingHasNotMoved[1] = true;
		
		_chessCastling = false;
		_castlingSoAddToTotal = 2;
		
		_chessStrippedNotation = "";
		_chessStrippedNotationTemp = "";
		
		_gameNotationMoveNumber = 0;
		_gameNotationOddEven = 1;		
		_gameNotationX = false;
		
		_historyImageChessPromotion.splice(0, _historyImageChessPromotion.length);
		
		_notationWhoIsMoving.splice(0, _notationWhoIsMoving.length);
		_moveNumberCurrentForNotation = 0;
		_moveNumberAllNotations.splice(0, _moveNumberAllNotations.length);
		
		_drawOffer = false;
		_restartOffer = false;
		_playerWaitingAtGameRoom = false;
		_chessForAnotherPieceValue = 0;
		_chatterClose = true;
		_chatterOpen = false;		
		_playerCanMovePiece = true;
		_enableGameNotations = true;
		_framerate = 30;
		
		gameWidth = 1400;
		gameHeight = 770;
		
		_otherPlayer = false;
		_pointValue2 = -1;
		_uniqueValue2 = -1;
		
		_gameOtherPlayerXold = 0;
		_gameOtherPlayerYold = 0;
		_gameOtherPlayerXnew = 0;
		_gameOtherPlayerYnew = 0;
		
		_chessIsKingMoving = false;
		
		_playerLeftGameUsername = "";
		_playerLeftGameMoveNumber = 0;
		_goBackToLobby = false;
		_gameUnitNumberMiddle = -1;
		_jumpingWhatDirection = -1;
		_checkersFoundPieceToJumpOver = false;
		_checkersShouldKeepJumping = false;
		_checkersIsThisFirstMove = true;
		
		_reversiReverseIt2 = false;
		_reversiReverseIt = false;
		_checkersKingThePiece = false;
		
		_offsetScreenY = 101;
		_offsetScreenBG = 101;
		
		_getRoomData = false;
		
		_displayActionMessage = false;
		
		// if client has not pressed a keyboard key nor clicked a mouse button/wheel then that client will be disconnected.
		_logoffTime = 9999999;
		_logoffTimeCurrent = 9999999;
			
		_snakesLaddersPlayerUnitNumber[0] = 0;
		_snakesLaddersPlayerUnitNumber[0] = 0;
		
		_actionWho = "";
		
		_playerIDs = -1;
		
		for (i in 0...4)
		{
			_gameDiceCurrentIndex[i] = 0;
			_gameDiceMinimumIndex[i] = 0;
			_gameDiceMaximumIndex[i] = 0;
		}
		
		
		_backdoorMoveValue = -1;
		
		_chessStalemate = false;
		_chessStalemateBypassCheck = false;
		_chessCheckmateBypass = false;
		_chessCheckBypass = false;
		_gameMessageCPUthinkingEnded = false;
		
		_inviteRoomNumberToJoin = 0;
		
		for (u in 0...2)
		{
			_chessCanTakeOutOfCheck[u] = false;
			_chessUnitsInCheckTotal[u] = 0;			
			
			for (i in 0...2)
			{
				_chessCastlingRookHasNotMoved[u][i] = true;
			}
			
			for (i in 0...5)
			{
				for (c in 0...2)
				{
					_chessCastlingDetermine[u][i][c] = false;
				}
			}
		}
		
		for (i in 0...8)
		{
			_chessOriginOfCheckX[i] = -1;
			_chessOriginOfCheckY[i] = -1;
		}
	
		for (i in 0...64)
		{
		_gamePointValueOfUnit[i] = 0;
		}
		
		for (yy in 0...8)
		{
			for (xx in 0...8)
			{
				_gamePointValueForPiece[yy][xx] = 0;
				_gameUniqueValueForPiece[yy][xx] = 0;
				_chessKingCanCastleHere[yy][xx] = 0;
				_checkersUniquePieceValue[yy][xx] = 0;
				_gameHouseTaxiCabOrCafeStoreForPiece[yy][xx] = 0;
				_gameUnitGroupsForPiece[yy][xx] = 0;
				_gameHouseTaxiCabOrCafeStoreTypePiece[yy][xx] = 0;
				_unitDistanceFromPiece[yy][xx] = 0;
			}
		}
		
		for (o in 0...300)
		{
			for (m in 0...10)
			{
				_chessOpeningMoves[o][m] = ""; 
			}
		}
		
		for (p in 1...10)
		{
			for (yy in 0...8)
			{
				for (xx in 0...8)
				{
					_reversiGamePointValueForPiece[p][yy][xx] = 0;
					_reversiCapturingUnitsForPieces[p][yy][xx] = 0;
				}
			}
		}
		
		for (p in 0...10)
		{
			for (yy in 0...8)
			{
				for (xx in 0...8)
				{
					_chessPathCoordinates[p][yy][xx] = 0;
				}
			}
		}
			
		_gameMovePiece = false;
		_gameUnitNumber = 0;
		_gameUnitNumberOld = -1; 
		_gameUnitNumberNew = -1; 
		_gameUnitNumberOld2 = -1; 
		_gameUnitNumberNew2 = -1; 
		
		_gameXXold = -1;
		_gameYYold = -1;
		_gameXXnew = -1;
		_gameYYnew = -1;
		_gameXXold2 = -1;
		_gameYYold2 = -1;
		_gameXXnew2 = -1;
		_gameYYnew2 = -1;
		
		_gameXXoldA = 0;
		_gameYYoldA = 0;
		_gameXXoldB = 0;
		_gameYYoldB = 0;
		_gameXXnewA = 0;
		_gameYYnewA = 0;
		_gameXXnewB = 0;
		_gameYYnewB = 0;
		
		_hasPieceMovedFinished = 0;		
		_checkmate_break_loop = false;
		_checkmate = false;		
		_updateScrollbarBringUp = false; // currently this var seems to be not used.
		_chessCPUdontMoveBackXXold = -2;
		_chessCPUdontMoveBackYYold = -2;		
		_chessPawnIsPromoted = false;		
		_isThisPieceAtBackdoor = false;
		_reversiProcessAllIdsTotal = 0;
		_reversiMovePiece = false;
		_gameTurnsP1 = 50;
		_gameTurnsOther = 50;
		
		_rolledA6 = false;
		
		for (p in 0...2)
		{
			for (i in 0...8)
			{
				for (y in 0...8)
				{
					for (x in 0...8)
					{
						_chessPawn[p][i][y][x] = 0;
						_chessPawnDefenderKing[p][i][y][x] = 0;
						_chessPawnAttackerKing[p][i][y][x] = 0;
					}
				}
			}
		}
		
		for (u in 0...2)
		{
			for (p in 0...6)
			{
				for (i in 0...10)
				{
					for (y in 0...8)
					{
						for (x in 0...8)
						{
							_futureCapturingUnitsForPiece[u][p][i][y][x] = 0;
							_futureCapturesFromPieceLocation[u][p][i][y][x] = 0;
						}
					}
				}
			}
		}
		
		for (p in 0...2)
		{
			for (d in 0...9)
			{
				for (y in 0...8)
				{
					for (x in 0...8)
					{		
						_chessCurrentPathToKing[p][d][y][x] = 0;
					}
				}
			}
		}
	
		for (p in 0...2)
		{
			for (i in 0...10)
			{
				for (y in 0...8)
				{
					for (x in 0...8)
					{
						_chessBishop[p][i][y][x] = 0;
						_chessHorse[p][i][y][x] = 0;
						_chessRook[p][i][y][x] = 0;
						
						_chessHorseDefenderKing[p][i][y][x] = 0;
						_chessHorseAttackerKing[p][i][y][x] = 0;
						_chessBishopDefenderKing[p][i][y][x] = 0;
						_chessBishopAttackerKing[p][i][y][x] = 0;
						_chessRookDefenderKing[p][i][y][x] = 0;						
						_chessRookAttackerKing[p][i][y][x] = 0;
												
						_chessQueen[p][i][y][x] = 0;
						_chessQueenDefenderKing[p][i][y][x] = 0;
						_chessQueenAttackerKing[p][i][y][x] = 0;
					}
				}
			}
		}
	
		for (p in 0...2)
		{
			for (c in 1...10)
			{
				_chessPawnMovementTotalSet[p][c] = 0;
			}
		}
		
		for (p in 0...2)
		{
			for (y in 0...8)
			{
				for (x in 0...8)
				{					
					_chessKing[p][y][x] = 0;
					_chessKingCapturingUnitAsQueen[p][y][x] = 0;
					_chessKingAsQueen[p][y][x] = 0;
					_chessKingCanMoveToThisUnit[p][y][x] = false;
					_capturingUnitsForPieces[p][y][x] = 0;
					_capturingUnitsForImages[p][y][x] = 0;
					_chessCapturingPathToKing[p][y][x] = 0;	
												
					_chessIsThisUnitInCheck[p][y][x] = 0;
					_chessTakeKingOutOfCheckUnits[p][y][x] = 0;
					
					_isThisUnitNextToKing[p][y][x] = false;
					
				}
			}
		}
			
		
		for (y1 in 0...8)
		{
			for (x1 in 0...8)
			{
				for (y2 in 0...8)
				{
					for (x2 in 0...8)
					{
						_chessDefence[y1][x1][y2][x2] = "";
					}
				}
			}
		}
	}
	
	public static function playChessVsCPU():Void
	{
		//ActionInput.enable();
		
		// these two vars are true only here for single mode because in 2 player mode the first player to enter lobby will set these vars to true.
		_playerCanMovePiece = true; 
		_gameHost = true;
		
		_gameId = 1; // chess.
		_game_offline_vs_player = false;
		
		_game_offline_vs_cpu = true;
				
		_move_number_current = 0;
		_move_number_next = 0;
		_gameJumpTo = 0; 
		
	}
	
	public static function playSignatureGame():Void
	{
		//ActionInput.enable();

		// these two vars are true only here for single mode because in 2 player mode the first player to enter lobby will set these vars to true.
		_playerCanMovePiece = true; 
		_gameHost = true;
		
		_gameId = 4;
		_game_offline_vs_player = false;
		
		_roomPlayerLimit = 2;		
		_totalPlayersInRoom = 1; // 1 means 2 players for this var. starts with 0 for the first player.
		_game_offline_vs_cpu = true;
		
		_move_number_current = 0;
		_move_number_next = 0;
		_gameJumpTo = 0; 
		
	}
}//
package;

/**
 * a typedef is a block of vars that are passed to the server.
 * @author kboardgames.com
 */

typedef DataGame = 
{
	/******************************
	 * player instance. this tells one player from another.
	 */
	var id: String;
	
	/******************************
	 * current room that the user is in. zero equals no room.	
	 */
	var _room: Int;
}

// checkers typedef.
typedef DataGame0 = 
{
	/******************************
	 * player instance. this tells one player from another.
	 */
	var id: String;	
	
	/******************************
	 * the username of the player.
	 */
	var _username: String;
	
	/******************************
	 * unit number. 0-64
	 */
	var _gameUnitNumberNew: Int;
	
	/******************************
	 * unit number. 0-64
	 */
	var _gameUnitNumberOld: Int;
	
	/******************************
	 * unit x coordinate. you have requested this gameboard piece.
	 */
	var _gameXXold:Int;
	
	/******************************
	 * unit y coordinate. you have requested this gameboard piece.
	 */
	var _gameYYold:Int;
	
	/******************************
	 * unit x coordinate. you have requested a piece be moved here.
	 */
	var _gameXXnew:Int;
	
	/******************************
	 * unit y coordinate. you have requested a piece be moved here.
	 */
	var _gameYYnew:Int;
	
	/******************************
	 * unit x coordinate. you have requested this gameboard piece.
	 */
	var _gameXXold2:Int;
	
	/******************************
	 * unit y coordinate. you have requested this gameboard piece.
	 */
	var _gameYYold2:Int;
	
	/******************************
	 * used to determine if the pawn is En Passant. also in Reversi, if all 4 discs have been placed on the board.
	 */
	var _triggerNextStuffToDo:Int;
	
	/******************************
	 * current room that the user is in. zero equals no room.
	 */
	var _room: Int;
	
	/******************************
	 * each board game should use this for only one var.
	 */
	var _isThisPieceAtBackdoor:Bool;
	
}

// chess typedef.
typedef DataGame1 = 
{
	/******************************
	 * player instance. this tells one player from another.
	 */
	var id: String;
	
	/******************************
	 * the username of the player.
	 */
	var _username: String;
	
	/******************************
	 * this is the point value of each piece on the standard gameboard
	 */
	var _pieceValue: Int;
	
	/******************************
	 * unique value of a piece.
	 */
	var _uniqueValue: Int;
	
	/******************************
	 * _p unit number. 0-64
	 */
	var _gameUnitNumberNew: Int;
	
	/******************************
	 * _p unit number. 0-64
	 */
	var _gameUnitNumberOld: Int;
	
	/******************************
	 * _p unit number. 0-64
	 */
	var _gameUnitNumberNew2: Int;
	
	/******************************
	 * _p unit number. 0-64
	 */
	var _gameUnitNumberOld2: Int;
	
	/******************************
	 * unit x coordinate. you have requested this gameboard piece.
	 */
	var _gameXXold:Int;
	
	/******************************
	 * unit y coordinate. you have requested this gameboard piece.
	 */
	var _gameYYold:Int;
	
	/******************************
	 * unit x coordinate. you have requested a piece be moved here.
	 */
	var _gameXXnew:Int;
	
	/******************************
	 * unit y coordinate. you have requested a piece be moved here.
	 */
	var _gameYYnew:Int;
	
	/******************************
	 * unit x coordinate. you have requested this gameboard piece.
	 */
	var _gameXXold2:Int;
	
	/******************************
	 * unit y coordinate. you have requested this gameboard piece.
	 */
	var _gameYYold2:Int;
	
	/******************************
	 * unit x coordinate. you have requested a piece be moved here.
	 */
	var _gameXXnew2:Int;
	
	/******************************
	 *  unit y coordinate. you have requested a piece be moved here.
	 */
	var _gameYYnew2:Int;
	
	/******************************
	 * is pawn En passant?
	 */
	var _isEnPassant:Bool;
	
	/******************************
	 * the most recent pawn in En passant.
	 */
	var _isEnPassantPawnNumber: Array<Int>;
	
	/******************************
	 * used to determine if the pawn is En Passant. also in Reversi, if all 4 discs have been placed on the board.
	 */
	var _triggerNextStuffToDo:Int;
	
	/******************************
	 * castling vars to move the rook.
	 */
	var _pointValue2:Int;
	
	/******************************
	 * castling vars.
	 */
	var _uniqueValue2:Int;
	
	/******************************
	 * this is the letter used in notation of a promoted piece selected.
	 */
	var _promotePieceLetter:String;
	
	/******************************
	 * for notation.
	 */
	var _doneEnPassant:Bool;
	
	/******************************
	 * current room that the user is in. zero equals no room.
	 */
	var _room: Int;
	
	/******************************
	 * capturing unit image value for history when using the backwards button.
	 */
	var _piece_capturing_image_value:Int;
	
}

// Reversi typedef
typedef DataGame2 = 
{
	/******************************
	 * player instance. this tells one player from another.
	 */
	var id: String;
	
	/******************************
	 * the username of the player.
	 */
	var _username: String;
	
	/******************************
	 * unit x coordinate. you have requested this gameboard piece.
	 */
	var _gameXXold:Int; 
	
	/******************************
	 * unit y coordinate. you have requested this gameboard piece.
	 */
	var _gameYYold:Int;
	
	/******************************
	 * used to place the four piece on the board.
	 */
	var _triggerNextStuffToDo:Int;
	
	/******************************
	 * piece number.
	 */
	var _pointValue2:Int;
	
	/******************************
	 * current room that the user is in. zero equals no room.
	 */
	var _room: Int;
	
}

// snakes and ladders typedef.
typedef DataGame3 = 
{
	/******************************
	 * player instance. this tells one player from another.
	 */
	var id: String;
	
	/******************************
	 * the username of the player.
	 */
	var _username: String;
	
	/******************************
	 * unit number. 0-64
	 */
	var _gameUnitNumberNew: Int;
	
	/******************************
	 * if true then both players piece will move at the same time.
	 */
	var _triggerEventForAllPlayers:Bool;
	
	/******************************
	 * used to determine if the pawn is En Passant. also in Reversi, if all 4 discs have been placed on the board.
	 */
	var _triggerNextStuffToDo:Int;
	
	/******************************
	 * move again.
	 */
	var _rolledA6:Bool;
	
	/******************************
	 * current room that the user is in. zero equals no room.
	 */
	var _room: Int;

}

// signature game typedef.
typedef DataGame4 = 
{
	/******************************
	 * player instance. this tells one player from another.
	 */
	var id: String;
	
	/******************************
	 * the username of the player.
	 */
	var _username: String;
	
	/******************************
	 * unit x coordinate. you have requested this gameboard piece.
	 */
	var _gameXXold:Int;
	
	/******************************
	 * unit y coordinate. you have requested this gameboard piece.
	 */
	var _gameYYold:Int;
	
	/******************************
	 * unit x coordinate. you have requested a piece be moved here.
	 */
	var _gameXXnew:Int;
	
	/******************************
	 * unit y coordinate. you have requested a piece be moved here.
	 */
	var _gameYYnew:Int;
	
	/******************************
	 * used in trade unit. this is the other player's unit. player moving would like to trade other player's unit.
	 */
	var _gameXXold2:Int;
	
	/******************************
	 * used in trade unit. this is the other player's unit. player moving would like to trade other player's unit.
	 */
	var _gameYYold2:Int;
	
	/******************************
	 * used in trade unit. this is the player that is moving piece. player would like to trade this unit.
	 */
	var _gameXXnew2:Int;
	
	/******************************
	 * used in trade unit. this is the player that is moving piece. player would like to trade this unit.
	 */
	var _gameYYnew2:Int;

	/******************************
	 * current room that the user is in. zero equals no room.
	 */
	var _room: Int;
	
	/******************************
	 * total rent bonus in game.
	 */
	var _rentBonus:Array<Float>;
	
	/******************************
	 * -1 = not used. 0 = nobody owns this unit. 1 = player 1's unit. 2:player 2's unit. 3:player 3's unit. 4:player 4's unit. the first value is yy value and the second is xx value.
	 */
	var _gameUniqueValueForPiece:Array<Array<Int>>;
	
	/******************************
	 * amount of houses, taxi or cafe on each unit. the first value is yy value and the second is xx value.
	 */
	var _gameHouseTaxiCabOrCafeStoreForPiece:Array<Array<Int>>;
	
	/******************************
	 * Undeveloped units. no houses, taxi or cafe, nobody owns this unit when a value for that unit equals not 1. the first value is yy value and the second is xx value.
	 */
	var _gameUndevelopedValueOfUnit:Array<Int>;
	
	/******************************
	 * used when trading units. this holds the value of a unit number. this var is useful. it can change an ownership of a unit. see Reg._gameUniqueValueForPiece.
	 */
	var _unitNumberTrade:Array<Int>;
}

// movement.
typedef DataMovement = 
{
	/******************************
	 * player instance. this tells one player from another.
	 */
	var id: String;
	
	/******************************
	 * the username of the player.
	 */
	var _username: String;
	
	/******************************
	 * game id. move_history fields are not deleted from the MySQL database. so this id is used so that a user accesses that correct move_history data.
	 */
	var _gid: String;
	
	/******************************
	 * true if the spectator is watching the game.
	 */
	var _spectatorWatching: Int;
	
	/******************************
	 * used to get the history from the room host.
	 */
	var _username_room_host :String;
	
	/******************************
	 * used to get all history but only once per game room session. when all history is retrieved the normal next entry event will be called.
	 */
	var _history_get_all: Int;
	
	/******************************
	 * unit number. 0-64
	 */
	var _gameDiceMaximumIndex: Int;	
	
	/******************************
	 * used to determine if the pawn is En Passant. also in Reversi, if all 4 discs have been placed on the board.
	 */
	var _triggerNextStuffToDo: Int;
	
	/******************************
	 * current room that the user is in. zero equals no room.
	 */
	var _room: Int;	
	
	/******************************
	 * If events a and b are sent from event c to the server in that order, sometimes the server will send back event b to the client before the server finishes event a.
	 * to solve that problem, at client, move event b to the bottom of event a and if this var has the name of event b then at that code line event b will be executed.
	 */
	var _triggerEvent: String;
	
	/******************************
	 * the point value of a gameboard piece.
	 */
	var _point_value: String;
	
	/******************************
	 * the unique value of a gameboard piece.
	 */
	var _unique_value: String;
	
	/******************************
	 * move history, the selected first piece
	 */
	var _moveHistoryPieceLocationOld1: String;		
	
	/******************************
	 * moved the first piece to selected location.
	 */
	var _moveHistoryPieceLocationNew1: String;		
	
	/******************************
	 * second piece, such as, the rook when castling. the second piece selected for that game move.
	 */
	var _moveHistoryPieceLocationOld2: String;		
	
	/******************************
	 * moved the second piece to selected location.
	 */
	var _moveHistoryPieceLocationNew2: String;	
	
	/******************************
	 * image value of the selected first piece. if its a rook that first player selected then its a value of 4 else for second player then its a value of 14. normally this value is 0 because after the move, no piece is at that location.
	 */
	var _moveHistoryPieceValueOld1: String;		
	
	/******************************
	 * this refers to the value of the piece at the new selected moved to location.
	 */
	var _moveHistoryPieceValueNew1: String;		
	
	/******************************
	 * the second piece value, or piece image, normally this unit is empty because the second piece was moved to a new unit.
	 */
	var _moveHistoryPieceValueOld2: String;		
	
	/******************************
	 * this is the second piece moved to value of the image, so that the image can be moved to the new location.
	 */
	var _moveHistoryPieceValueNew2: String;
	
	/******************************
	 * the captured piece value, its image.
	 */
	var _moveHistoryPieceValueOld3: String;
	
	/******************************
	 * the total amount of all moves from all player playing gaming game.
	 */
	var _moveHistoryTotalCount:Int;
	
}
	
	
// a game message such as check or checkmate.
typedef DataGameMessage = 
{
	/******************************
	 * player instance. this tells one player from another.
	 */
	var id: String;
	
	/******************************
	 * the username of the player.
	 */
	var _username: String;
	
	/******************************
	 * current room that the user is in. zero equals no room.
	 */
	var _room: Int;
	
	/******************************
	 * If events a and b are sent from event c to the server in that order, sometimes the server will send back event b to the client before the server finishes event a.
	 * to solve that problem, at client, move event b to the bottom of event a and if this var has the name of event b then at that code line event b will be executed.
	 */
	var _triggerEvent: String;
	
	/******************************
	 * an example of this would be a chess game where a player just received a message saying that the king is in check. this event sends that same message to the other party
	 */
	var _gameMessage:String;
	
	/******************************
	 * this is the player where the data at this typedef will be sent to.
	 */
	var _userTo: String;
	
	/******************************
	 * this is the player where the data at this typedef was sent from.
	 */
	var _userFrom: String;
	
	/******************************
	 * this var can hold any message.
	 */
	var _questionAnsweredAs: Bool; 
	
}

/******************************
 * complete these daily quests for rewards.
 */
typedef DataDailyQuests = 
{
	/******************************
	 * player instance. this tells one player from another.
	 */
	var id: String;
	
	/******************************
	 * the username of the player.
	 */
	var _username: String;
	
	/******************************
	 * Win three board games in a row.
	 */
	var _three_in_a_row: String;
	
	/******************************
	 * Win a chess game in 5 moves or under.
	 */
	var _chess_5_moves_under: String;
	
	/******************************
	 * Win a snakes and ladders game in under 4 moves.
	 */
	var _snakes_under_4_moves: String;
	
	/******************************
	 * Win a 5 minutes game.
	 */
	var _win_5_minute_game: String;
	
	/******************************
	 * Buy any four house items
	 */
	var _buy_four_house_items: String;
	
	/******************************
	 * Finish playing a signature game
	 */
	var _finish_signature_game: String;
	
	/******************************
	 * Occupy a total of 50 units in Reversi
	 */
	var _reversi_occupy_50_units: String;
	
	/******************************
	 * Get 6 Kinged pieces in 1 checkers game
	 */
	var _checkers_get_6_kings: String;
	
	/******************************
	 * play all 5 games.
	 */
	var _play_all_5_board_games: String;
	
	/******************************
	 * a gauge is dashed lines that runs horizontally across the top part of the dailyQuests.hx scene. There are three reward icons. then the dash filled line reaches a reward icon then a claim reward button will appear.
	 * the third dashed line refers to the first value is this string. the second value in this var refers to the sixth dashed line and the last dash lined (ninth) refers to the third value. therefore three quests need to be completed before a reward can be given. so there is 9 dashed lines, an every third line that is highlighted means that a quest reward can be given.
	 * this string look like this... "2,1,0". a zero means that no prize is available, the 1 means that a rewards can be claimed and 2 means that the reward for those quests have been claimed. remember that 2 quests are needed for every reward and that the dashed lines refer to those quests.
	 */
	var _rewards: String;
	
}


// a message box questions.
typedef DataQuestions = 
{
	/******************************
	 * player instance. this tells one player from another.
	 */
	var id: String;
	
	/******************************
	 * the username of the player.
	 */
	var _username: String;
	
	/******************************
	 * an example of this would be a chess game where a player just received a message saying that the king is in check. this event sends that same message to the other party
	 */
	var _gameMessage:String;
	
	/******************************
	 * chess draw offer. false=not yet asked. true=yes.
	 */
	var _drawOffer:Bool;
	
	/******************************
	 * chess draw was answered as, false:no, true:yes 
	 */
	var _drawAnsweredAs:Bool;
	
	/******************************
	 * restart game offer. false=not yet asked. true=yes.
	 */
	var _restartGameOffer:Bool;
	
	/******************************
	 * restart game was answered as, false:no, true:yes.
	 */
	var _restartGameAnsweredAs:Bool;
	
	/******************************
	 * current room that the user is in. zero equals no room.
	 */
	var _room: Int;
	
	/******************************
	 * If events a and b are sent from event c to the server in that order, sometimes the server will send back event b to the client before the server finishes event a.
	 * to solve that problem, at client, move event b to the bottom of event a and if this var has the name of event b then at that code line event b will be executed.
	 */
	var _triggerEvent: String;
	
	/******************************
	 * is the game over?
	 */
	var _gameOver: Bool;

}
	
// every player's name. also, win, lose and draw stats of the player.
typedef DataOnlinePlayers =
{
	/******************************
	 * player instance. this tells one player from another.
	 */
	var id:String;
	
	/******************************
	 * the username of the player.
	 */
	var _username: String;
	
	/******************************
	 * current room that the user is in. zero equals no room.
	 */
	var _room: Int;
	
	/******************************
	 * If events a and b are sent from event c to the server in that order, sometimes the server will send back event b to the client before the server finishes event a.
	 * to solve that problem, at client, move event b to the bottom of event a and if this var has the name of event b then at that code line event b will be executed.
	 */
	var _triggerEvent: String;
	
	/******************************
	 * players names that are online.
	 */
	var _usernamesOnline:Array<String>;
	
	/******************************
	 * any game played. players all game id wins of players online.
	 */
	var _gamesAllTotalWins:Array<Int>;
	
	/******************************
	 * any game played. players all game id losses of players online.
	 */
	var _gamesAllTotalLosses:Array<Int>;
	
	/******************************
	 * any game played. players all game id draws of players online.				
	 */
	var _gamesAllTotalDraws:Array<Int>;
	
	/******************************
	 * chess Elo rating for every player online.
	 */
	var _chess_elo_rating:Array<Float>;
}

typedef DataTournaments =
{
	/******************************
	 * player instance. this tells one player from another.
	 */
	var id:String;
	
	/******************************
	 * the username of the player.
	 */
	var _username: String;
	
	/******************************
	 * if this name is not empty then its the name of the user in the tournament.
	 */
	var _player1: String;
	
	/******************************
	 * if this var is not empty and username is _player1 then player1 maybe be playing against player 2,
	 */
	var _player2: String;
	
	/******************************
	 * game id. move_history fields are not deleted from the MySQL database. so this id is used so that a user accesses that correct move_history data.
	 */
	var _gid: String;	
	
	/******************************
	 * 0:not started 1:started.
	 */
	var _tournament_started: Bool;
	
	/******************************
	 * maximum total players in the current tournament. the current tournament is select with the _game_id var. see below.
	 */
	var _player_maximum: Int;
	
	/******************************
	 * current player count in the current tournament. the current tournament is select with the _game_id var. see below.
	 */
	var _player_current: Int;
	
	/******************************
	 * current room that the user is in. zero equals no room.
	 */
	var _room: Int;
	
	/******************************
	 * used to determine what tournament is being referenced. a value of 1 and the chess tournament standard was selected. that value of 1, is the id at the MySQL database "tournament data" table. a value of 0 means that no tournament game was selected.
	 */
	var _game_id: Int;
	
	var _round_current: Int;		// current round of the tournament. 16 player tournament = this value of 0. 8 players has this value set at 1.

	var _rounds_total: Int;					// when the round_current equals this value then the tournament is at its last round.
	
	/******************************
	 * game move total for player
	 */
	var _move_total: Int;
	
	/******************************
	 * a value of 1 means the game is over.
	 * if value is 0 then this player is a tournament player.
	 */
	var _game_over: Int;
	
	/******************************
	 * game move total for player
	 */
	var _won_game: Int;
	
	/******************************
	 * 0:cannot move piece 1:player can move piece.
	 */
	var _move_piece: Bool;
	
	/******************************
	 * time is seconds you have to move a piece. failing to move piece within time allowed will result in losing the game.
	 */
	var _time_remaining_player1: String;
	var _time_remaining_player2: String;
	
	/******************************
	 * is it the players turn to move. a value of 1 = player1, 2=player2, etc.
	 */
	var _move_number_current: Int;
	
	/******************************
	 * timestamp for player 1. 
	 * player 2 is not needed. the time might not be actuate when working with another players timestamp. the reason might be that a few seconds might be off from the time it takes to get and display the time. within that time, a player might have moved piece when instead we forfeit the game based on no activity from the user.
	 * for player 1, we use a lock so that the mailer knows that the player is in the process of moving a piece.
	 */
	var _timestamp: Int;
}

// player's account and server information
typedef DataAccount = 
{
	/******************************
	 * player instance. this tells one player from another.
	 */
	var id: String;
	
	/******************************
	 * the username of the player.
	 */
	var _username: String;
	
	/******************************
	 * the current message to be displayed as message box.
	 */
	var _popupMessage: String;
	
	/******************************
	 * used to return the this local hosts name.
	 */
	var _host: String;
	
	/******************************
	 * IP of player.
	 */
	var _ip: String;
	
	/******************************
	 * is there two computers with the same host name connected to server?
	 */
	var _alreadyOnlineHost: Bool;
	
	/******************************
	 * is there already a user with that username online?
	 */
	var _alreadyOnlineUser: Bool;
	
	/******************************
	 * outputs if server is blocking
	 */
	var _server_blocking: Bool;
	
	/******************************
	 * outputs if server is using fast send.
	 */
	var _server_fast_send: Bool;
	
	/******************************
	 * amount of clients connected.
	 */
	var _clients_connected: Int;
	
	/******************************
	 * if true then player is using the html5 client.
	 */
	var _guest_account: Bool;
}

typedef DataMisc = 
{
	/******************************
	 * player instance. this tells one player from another.
	 */
	var id: String;
	
	/******************************
	 * the username of the player.
	 */
	var _username: String;
	
	/******************************
	 * current room that the user is in. zero equals no room.
	 */
	var _room: Int;
	
	/******************************
	 * If events a and b are sent from event c to the server in that order, sometimes the server will send back event b to the client before the server finishes event a.
	 * to solve that problem, at client, move event b to the bottom of event a and if this var has the name of event b then at that code line event b will be executed.
	 * a value of "foo" means that the event after it will not be outputted at server console.
	 */
	var _triggerEvent: String;
	
	/******************************
	 * this user entered the game from the lobby when clicking the "watch game" button. this user can only watch the game. this player cannot play the game even when game ends.
	 */
	var _spectatorWatching:Bool; 
		
	/******************************
	 * // 0 = empty, 1 computer game, 2 creating room, 3 = firth player waiting to play game. 4 = second player in waiting room. 5 third player in waiting room if any. 6 - forth player in waiting room if any. 7 - room full, 8 - playing game / waiting game.
	 */
	var _roomState: Array<Int>;
	
	/******************************
	 * maximum number of players that can play the selected game.
	 * used to list the games at lobby. see RegFunctions.gameName(). also, for not a host player, the data from here will populate RegTypedef._dataMisc._gameId for that player. 
	 */
	var _roomPlayerLimit: Array<Int>;
	
	/******************************
	 * current total of players in a room.
	 */
	var _roomPlayerCurrentTotal: Array<Int>;
	
	/******************************
	 * used to tell one game from another. 0 checkers, 1 chess, 2 Reversi, 3 snakes and ladders, 4 signature game. 
	 */
	var _roomGameIds: Array<Int>;
	
	/******************************
	 * used at lobby, a text referring to the host name of the room.
	 */
	var _roomHostUsername: Array<String>;
	
	/******************************
	 * game id. move_history fields are not deleted from the MySQL database. so this id is used so that a user accesses that correct move_history data.
	 */
	var _gid: Array<String>;
	 
	/******************************
	 * TODO NOTE this var seems to do nothing. verify should delete.
	 * if this vars value is true then a different player will not be able change the room state until the player has finished the "Greater RoomState Value" event at "Get Room Data" event. 
	 * Note: that when a player leaves the game room, since that userLocation will always be a value of zero, a _roomIsLocked is not needed.
	 */
	var _roomIsLocked: Array<Int>;
	
	/******************************
	 * If vars value is true then a check for a room lock will be made. This is used only when entering a room. If mouse clicked the "refresh room" button or leaving a game room then a check will not be made because in these cases a check is not needed. See Note: at _roomIsLocked for the reason why.
	 */
	var _roomCheckForLock: Array<Int>;
	
	/******************************
	 * When a room lock is true then this room cannot be entered by the current player and this is the message saying that someone is already accessing the room so try again shortly.
	 */
	var _roomLockMessage: String;	
	
	/******************************
	 * currently where the user is at. lobby, __scene_waiting_room, etc. 0:lobby, 1:creating room, 2:__scene_waiting_room, 3:game room.
	 */
	var _userLocation: Int;
	
	/******************************
	 * if this value is true then the host is playing against the computer.
	 */
	var _vsComputer: Array<Int>;
	
	/******************************
	 * if true then this room allows spectators.
	 */
	var _allowSpectators: Array<Int>;
	
	/******************************
	 * chat text of the player.
	 */
	var _chat: String;
	
	/******************************
	 * enter game room if value is true.
	 */
	var _gameRoom: Bool;
	
	/******************************
	 * kick or ban message. player blocked other player for some time or from playing again that room session.
	 */
	var _clientCommandMessage: String; 
	
	/******************************
	 * currently used from banning players.
	 */
	var _clientCommandUsers: String;
	
	/******************************
	 * currently used from banning players.
	 */
	var _clientCommandIPs: String;
	
}

// all players inside a room. their data, such as cash, wins, losses.
typedef DataPlayers = 
{
	/******************************
	 * 
	 */
	var id: String;
	
	/******************************
	 * the username of the client.
	 */
	var _username:String;
	
	/******************************
	 * one to four usernames of the players in the waiting room or game room.
	 */
	var _usernamesDynamic:Array<String>;	
		
	/******************************
	 * the difference between _usernamesDynamic and _usernamesStatic is that a username can get removed from the list of _usernamesDynamic, but the _usernamesStatic will always have the same names through the actions within the game room.
	 */
	var	_usernamesStatic:Array<String>;
	
	/******************************
	 * current total of players playing the game.
	 */
	var _usernamesTotalDynamic:Int;
	
	/******************************
	 * total players that can play a game in that game room.
	 */
	var _usernamesTotalStatic:Int;
	
	/******************************
	 * user who was once playing but is now watching the game being played. 
	 */
	var _spectatorPlaying:Bool;
	
	/******************************
	 * this user entered the game from the lobby when clicking the "watch game" button. this user can only watch the game. this player cannot play the game even when game ends.
	 */
	var _spectatorWatching:Bool; 	
	
	/******************************
	 * send the current move number to the watching spectator so that the timer and white box underneath the P1, P2, P3 or P4 moves, can be updated.
	 */
	var _spectatorWatchingGetMoveNumber: Int;
	
	/******************************
	 * This is the profile avatar image number used to display the image.
	 */
	var _avatarNumber:Array<String>;
		 
	/******************************
	 * save the player's game player state to the database. is the player playing a game or waiting to play. 
	 * 0: = not playing but still at game room. 
	 * 1: playing a game. 
	 * 2: left game room while still playing it. 
	 * 3: left game room when game was over. 
	 * 4: quit game.
	 * this var is used to display players who are waiting for a game at the game room and to get the _count of how many players are waiting at game room.
	*/
	var _gamePlayersValues:Array<Int>;
	
	/******************************
	 * is it the players turn to move. a value of 1 = player1, 2=player2, etc.
	 */
	var _moveNumberDynamic:Array<Int>;
	
	/******************************
	 * current room that the user is in. zero equals no room.
	 */
	var _room: Int;
	
	/******************************
	 * If events a and b are sent from event c to the server in that order, sometimes the server will send back event b to the client before the server finishes event a.
	 * to solve that problem, at client, move event b to the bottom of event a and if this var has the name of event b then at that code line event b will be executed.
	 */
	var _triggerEvent: String;
	
	/******************************
	 * this is needed to save a game win to the game being played. if chess is being played and player won that game then this var will be used to save a win to chess, not just the overall wins of any game played.
	 */
	var _gameId: Int;
	
	/******************************
	 * any game played. total game wins.
	 */
	var _gamesAllTotalWins:Array<Int>;
	
	/******************************
	 * any game played. total game losses.
	 */
	var _gamesAllTotalLosses:Array<Int>;
	
	/******************************
	 * any game played. total game draws.
	 */
	var _gamesAllTotalDraws:Array<Int>;
	
	/******************************
	 * the game being played.
	 */
	var _gameName:String;
	
	/******************************
	 * username of the sent room invite.
	 */
	var _usernameInvite:String;
	
	/******************************
	 * game win, lose or draw messages.
	 */
	var _gameMessage:String;
	
	/******************************
	 * player that you want something done to.
	 */
	var _actionWho:String;
	
	/******************************
	 * refers to an action, eg, 1 = kick. see the "Action By Player" event at server.
	 */
	var _actionNumber:Int;
	
	/******************************
	 * targeted player must do an action of _actionNumber. this var can be a time remaining var or whatever is needed for an Int.
	 */
	var _actionDo:Int;
	
	/******************************
	 * time remaining to make a move. when time reaches 0, the game ends and that player losses.
	 */
	var _moveTimeRemaining:Array<Int>;
	
	/******************************
	 * total score in game.
	 */
	var _score:Array<Int>;
	
	/******************************
	* total cash in game.
	*/
	var _cash:Array<Float>;				

	/******************************
	 * while playing the game, a player has clicked the quit game button if true.
	 */
	var _quitGame:Bool;
		
	/******************************
	 * false if game is still being played. defaults to true because when entering the game room the game for those players has not started yet.
	 */
	var _isGameFinished: Bool;
	
	/******************************
	 * SAVE A VAR TO MYSQL SO THAT SOMEONE CANNOT INVITE WHEN STILL IN GAME ROOM. ALSO USED TO PASS A VAR TO USER SPECTATOR WATCHING. THAT VAR IS USED TO START A GAME FOR THAT SPECTATOR IF THE _gameIsFinished VALUE IS FALSE.
	 */
	var _gameIsFinished: Bool;
	
	/******************************
	 * how many times a player moved a piece.
	 */
	var _moveTotal: Int;
	
	/******************************
	 * this is the time when game is started.
	 */
	var _timeTotal: Int;
	
	/******************************
	 * total house items bought within 24 houses. this var is for the daily quest. see _buy_four_house_items
	 */
	var _house_items_daily_total: Int;
	
	/******************************
	 * this is the piece total for the winner at the end of a game.
	 * currently only used in Reversi.
	 */
	var _piece_total_for_winner: Int;
	
	/******************************
	 *	this is a daily quest var. This is the amount of kings that a player has while playing a game. this var is used at DailyQuests.hx to determine if a reward should be given to player.
	 */
	var _checkers_king_total: Int;
	
	/******************************
	 * this is a daily quest var. when a game is won, at server main.hx, at the saveWinStats() function, a value of 1 will be given to that array element for that board game played. so if playing a Reversi game then the array element of 2 will be set to a value of 1. when all array elements in this var has a value of 1 then all board games has been played.
	 */
	var _all_boardgames_played_total: Array<Int>;
	
}
/******************************
 * credits, experience points, wins, losses, draws. all player statistics.
 */
typedef DataStatistics = 
{
	/******************************
	 * player instance. this tells one player from another.
	 */
	var id: String;
	
	/******************************
	 * the username of the player.
	 */
	var _username: String;	
	
	/******************************
	 * current room that the user is in. zero equals no room.
	 */
	var _room: Int;
	
	/******************************
	* this is the time when game is started.
	*/
	var	_timeTotal: Int;
	
	/******************************
	 * time since game has started.
	 */
	var	_moveTimeRemaining: Array<Int>; 
	
	/******************************
	 * players current chess Elo rating.
	 */
	var _chess_elo_rating: Float;
	
	/******************************
	 * If events a and b are sent from event c to the server in that order, sometimes the server will send back event b to the client before the server finishes event a.
	 * to solve that problem, at client, move event b to the bottom of event a and if this var has the name of event b then at that code line event b will be executed.
	 */
	var _triggerEvent: String;	
	
	var _total_games_played:Int;
	var _highest_experience_points:Int;
	var _highest_credits:Int;
	var _highest_house_coins:Int;
	var _shortest_time_game_played:Int;
	var _longest_time_game_played:Int;
	var _longest_current_winning_streak:Int;
	/******************************
	 * from any game played.
	 */
	var _highest_winning_streak:Int;
	var _longest_current_losing_streak:Int;
	var _highest_losing_streak:Int;
	var _longest_current_draw_streak:Int;
	var _highest_draw_streak:Int;	
	
	/******************************
	 * all game wins for player.
	 */
	var _gamesAllTotalWins:Int;
	
	/******************************
	 * all game losses for player.
	 */
	var _gamesAllTotalLosses:Int;
	
	/******************************
	 * all game draws for player.				
	 */
	var _gamesAllTotalDraws:Int;
	
	var _checkersWins: Int;
	var _checkersLosses: Int;
	var _checkersDraws: Int;
	var _chessWins: Int;
	var _chessLosses: Int;
	var _chessDraws: Int;
	var _reversiWins: Int;
	var _reversiLosses: Int;
	var _reversiDraws: Int;
	var _snakesAndLaddersWins: Int;
	var _snakesAndLaddersLosses: Int;
	var _snakesAndLaddersDraws: Int;
	var _signatureGameWins: Int;
	var _signatureGameLosses: Int;
	var _signatureGameDraws: Int;
	
	/******************************
	 * credits given on event day. credits can be redeemed for a month of paid membership. Maximum of 5 credits per event day.
	 */
	var _creditsToday: Int;
	
	/******************************
	 * each credit_today value is written to this value. this value only decreases when credits are used to redeem something, such as 1 month of membership.
	 */
	var _creditsTotal: Int;
	
	/******************************
	 * each game played gives some experience points. get enough experience point to increase players level.
	 */
	var _experiencePoints: Int;
	
	/******************************
	 * at the house event, after a game is played, some coins will be given. Use those coins to buy house furniture. Access your house from the house button at lobby.
	 */
	var _houseCoins: Int;
		
}

/******************************
 * players house where they buy items, place items in room and vote for best house for prizes.
 */
typedef DataHouse = 
{
	/******************************
	 * player instance. this tells one player from another.
	 */
	var id: String;
	
	/******************************
	 * the username of the player.
	 */
	var _username: String;
		
	/******************************
	* refers to a sprite that was bought to display at house. eg, 1.png.
	 */
	var _sprite_number: String;
	
	/******************************
	 * this is the name of the sprite in the order it was bought and then after, in the order of was changed using the z-order buttons of bring to front and bring to back.
	 */
	var _sprite_name: String;
	
	/******************************
	 * all items x position that is separated by a comma.
	 */
	var _items_x: String;
	
	/******************************
	 * all items y position that is separated by a comma.
	 */
	var _items_y: String;
	
	/******************************
	 * map x coordinates on scene at the time the item was bought or mouse dragged then mouse released.
	 */
	var _map_x: String;
	
	/******************************
	 * map y coordinates on scene at the time the item was bought or mouse dragged then mouse released.
	 */
	var _map_y: String;
	
	/******************************
	 * when the map is moved up, down, left or right, this value increases in size by those pixels. this var is used at House update() so that the map hover can be displayed when outside of its default map boundaries. it is also added or subtracted to the mouse coordinates at other classes so that the map or panel items can correctly be detected by the mouse. for example, the mouse.x cannot be at a value of 2000 when the stage has a width of 1400 and the map changes in width, but it can be there when this offset is added to mouse.x.
	 */
	var _map_offset_x: String;
 	var _map_offset_y: String;
	
	/******************************
	 * is this item hidden?
	 */
	var _item_is_hidden: String;
	 
	/******************************
	 * a list of 1 and 0's separated by a comma. the first value in this list refers to item 1. if that value is 1 then that item was purchased.
	 */
	var _is_item_purchased: String;
	
	/*******************************
	 * stores the direction that the furniture item is facing.
	 * values of 0=SE, 1:SW, 2:NE, 3:NW
	 */
	var _item_direction_facing: String;
	
	/******************************
	 * the order of the furniture items displayed.
	 */
	var _item_order: String;
	
	/******************************
	 * when value is true the furniture item will be displayed on the map behind a wall. This string contains true and false values up to 200 furniture items separated by a comma.
	 */
	var _item_behind_walls: String;
	
	/******************************
	 * this holds all floor tiles on the map. This var is read from left to right but that data is placed on the map starting from the top left of map and then moving right and similar to reading words in a book.
	 */
	var _floor: String;
	
	/******************************
	 * this holds all wall tiles in the left position on the map. This var is read from left to right but that data is placed on the map starting from the top left of map and then moving right and similar to reading words in a book.
	 */
	var _wall_left: String;
	
	/******************************
	 * this holds all wall tiles in the upward position on the map. This var is read from left to right but that data is placed on the map starting from the top left of map and then moving right and similar to reading words in a book.
	 * this var is shown under a left tile. so the wall is up but behind a left wall.
	 */
	var _wall_up_behind: String;
	var _wall_up_in_front: String;
	
	/******************************
	 * the visibility state of all floor tiles.
	 */
	var _floor_is_hidden: String;
	
	/******************************
	 * the visibility state of all left wall tiles.
	 */
	var _wall_left_is_hidden: String;
	
	/******************************
	 * the visibility state of all up wall tiles.
	 */
	var _wall_up_behind_is_hidden: String;
	var _wall_up_in_front_is_hidden: String;
}
	
typedef DataLeaderboards = 
{
	/******************************
	 * player instance. this tells one player from another.
	 */
	var id: String;
	
	/******************************
	 * the username of the player.
	 */
	var _username: String;
	
	/******************************
	 * this holds all players in a top leaderboard list. the usernames in the list is separated with a comma.
	 */
	var _usernames: String;
	
	/******************************
	 * total XP for all players. each XP is separated by a comma.
	 */
	var _experiencePoints: String;
}

class RegTypedef
{
	// these _data vars must be initiated, a value set, or else the program will crash. this data is sent to and from the client and server.
	
	/*******************************
	 * the vars here are assigned to the other typedefs. For example, _miscData.id = _dataGame.id.
	 */
	public static var _dataGame:DataGame = 
	{
		id: Std.string(FlxG.random.int(100000000, 999999999)) + Std.string(FlxG.random.int(100000000, 999999999)),
		_room: 0					// current room that the user is in. zero equals no room.
		
	}
	
	/******************************
	 * checkers typedef.
	 */
	public static var _dataGame0:DataGame0 = 
	{
		id: Std.string(FlxG.random.int(100000000, 999999999)) + Std.string(FlxG.random.int(100000000, 999999999)),
		_username: "", 				// the username of the player.	
		_gameUnitNumberNew: -1,			// unit number. 0-64
		_gameUnitNumberOld: -1,			// unit number. 0-64
		_gameXXold: -1,				// unit x coordinate. you have requested this gameboard piece.
		_gameYYold: -1,				// unit y coordinate. you have requested this gameboard piece.
		_gameXXnew: -1,				// unit x coordinate. you have requested a piece be moved here.
		_gameYYnew: -1,				// unit y coordinate. you have requested a piece be moved here.
		_gameXXold2: -1,				// unit x coordinate. you have requested this gameboard piece.
		_gameYYold2: -1,				// unit y coordinate. you have requested this gameboard piece.
		_triggerNextStuffToDo:0,	// used to determine if the pawn is En Passant. also in Reversi, if all 4 discs have been placed on the board.
		_room: 0,					// current room that the user is in. zero equals no room.
		_isThisPieceAtBackdoor: false,		// each board game should use this for only one var.
		
	}
	
	/******************************
	 * chess typedef.
	 */
	public static var _dataGame1:DataGame1 = 
	{
		id: Std.string(FlxG.random.int(100000000, 999999999)) + Std.string(FlxG.random.int(100000000, 999999999)),
		_username: "", 				// the username of the player.	
		_pieceValue: -1,				// this is the point value of each piece on the standard gameboard
		_uniqueValue: -1,				// unique value of a piece.
		_gameUnitNumberNew: -1,			// unit number. 0-64
		_gameUnitNumberOld: -1,			// unit number. 0-64
		_gameUnitNumberNew2: -1,		// unit number. 0-64
		_gameUnitNumberOld2: -1,		// unit number. 0-64
		_gameXXold: -1,				// unit x coordinate. you have requested this gameboard piece.
		_gameYYold: -1,				// unit y coordinate. you have requested this gameboard piece.
		_gameXXnew: -1,				// unit x coordinate. you have requested a piece be moved here.
		_gameYYnew: -1,				// unit y coordinate. you have requested a piece be moved here.
		_gameXXold2: -1,				// unit x coordinate. you have requested this gameboard piece.
		_gameYYold2: -1,				// unit y coordinate. you have requested this gameboard piece.
		_gameXXnew2: -1,				// unit x coordinate. you have requested a piece be moved here.
		_gameYYnew2: -1,				// unit y coordinate. you have requested a piece be moved here.
		_isEnPassant: false,		// is pawn En passant? 
		_isEnPassantPawnNumber: [0,0],	// the most recent pawn in En passant.
		_triggerNextStuffToDo:0,	// used to determine if the pawn is En Passant. also in Reversi, if all 4 discs have been placed on the board.
		_pointValue2: -1,				// castling vars to move the rook.
		_uniqueValue2: -1,			// castling vars.
		_promotePieceLetter: "",		// this is the letter used in notation of a promoted piece selected.
		_doneEnPassant: false,		// for notation.
		_room: 0,					// current room that the user is in. zero equals no room.
		// capturing unit image value for history when using the backwards button.
		_piece_capturing_image_value: 0,
	}
	
	/******************************
	 * Reversi typedef
	 */
	public static var _dataGame2:DataGame2 = 
	{
		id: Std.string(FlxG.random.int(100000000, 999999999)) + Std.string(FlxG.random.int(100000000, 999999999)),
		_username: "", 				// the username of the player.	
		_gameXXold: -1,				// unit x coordinate. you have requested this gameboard piece.
		_gameYYold: -1,				// unit y coordinate. you have requested this gameboard piece.
		_triggerNextStuffToDo:0,	// used to determine if the pawn is En Passant. also in Reversi, if all 4 discs have been placed on the board.
		_pointValue2: -1,				// castling vars to move the rook.
		_room: 0,					// current room that the user is in. zero equals no room.		
	}
	
	/******************************
	 * snakes and ladders typedef.
	 */
	public static var _dataGame3:DataGame3 = 
	{
		id: Std.string(FlxG.random.int(100000000, 999999999)) + Std.string(FlxG.random.int(100000000, 999999999)),
		_username: "", 				// the username of the player.	
		_gameUnitNumberNew: -1,			// unit number. 0-64
		_triggerEventForAllPlayers: true,		// is pawn En passant? 
		_triggerNextStuffToDo:0,	// used to determine if the pawn is En Passant. also in Reversi, if all 4 discs have been placed on the board.
		_rolledA6: false,		// move again.
		_room: 0,					// current room that the user is in. zero equals no room.

	}
	
	/******************************
	 * signature game typedef.
	 */
	public static var _dataGame4:DataGame4 = 
	{
		id: Std.string(FlxG.random.int(100000000, 999999999)) + Std.string(FlxG.random.int(100000000, 999999999)),
		_username: "", 				// the username of the player.	
		_gameXXold: -1,				// unit x coordinate. you have requested this gameboard piece.
		_gameYYold: -1,				// unit y coordinate. you have requested this gameboard piece.
		_gameXXnew: -1,				// unit x coordinate. you have requested a piece be moved here.
		_gameYYnew: -1,				// unit y coordinate. you have requested a piece be moved here.
		_gameXXold2: -1,			// used in trade unit. this is the other player's unit. player moving would like to trade other player's unit.
		_gameYYold2: -1,			// used in trade unit. this is the other player's unit. player moving would like to trade other player's unit.
		_gameXXnew2: -1,			// used in trade unit. this is the player that is moving piece. player would like to trade this unit.
		_gameYYnew2: -1,			// used in trade unit. this is the player that is moving piece. player would like to trade this unit.
		_room: 0,					// current room that the user is in. zero equals no room.
		_rentBonus: [0.01, 0.01, 0.01, 0.01],		// total rent bonus. this value of 0.01 is needed because this var is used in multiplication and we cannot times by zero or else we get zero for the result which is not desired.
		_gameUniqueValueForPiece:
		[[0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0],
		[0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0],
		[0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0],
		[0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0],
		[0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0],
		[0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0],
		[0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0],
		[0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0]],	// yy and xx values. output of -1 = not used. 0 = nobody owns this unit. 1 = player 1's unit. 2:player 2's unit. 3:player 3's unit. 4:player 4's unit.		
		//amount of houses on each unit.
		_gameHouseTaxiCabOrCafeStoreForPiece:
		[[0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0],
		[0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0],
		[0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0],
		[0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0],
		[0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0],
		[0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0],
		[0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0],
		[0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0]], // the first zero is yy value and the second is xx value.
						
		_gameUndevelopedValueOfUnit: 
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0], // the first zero is yy value and the second is xx value.
			
		_unitNumberTrade: [0, 0], // used when trading units. this holds the value of a unit number. this var is useful. it can change an ownership of a unit. see Reg._gameUniqueValueForPiece.
	}
	
	/******************************
	 * used to make a player's piece move at the same time at every client playing a game.
	 */
	public static var _dataMovement:DataMovement = 
	{
		id: Std.string(FlxG.random.int(100000000, 999999999)) + Std.string(FlxG.random.int(100000000, 999999999)), // player instance. this tells one player from another.
		_username: "", 				// the username of the player.
		_gid: "",
		_spectatorWatching: 0,
		_username_room_host: "",
		_history_get_all: 0,
		
		_gameDiceMaximumIndex: -1, // unit number. 0-64
		
		 _triggerNextStuffToDo: 0, // used to determine if the pawn is En Passant. also in Reversi, if all 4 discs have been placed on the board.
		
		_room: 0, // current room that the user is in. zero equals no room
		/******************************
		 * If events a and b are sent from event c to the server in that order, sometimes the server will send back event b to the client before the server finishes event a.
		 * to solve that problem, at client, move event b to the bottom of event a and if this var has the name of event b then at that code line event b will be executed.
		 */
		_triggerEvent: "",
		
		_point_value: "",
		_unique_value: "",
		
		_moveHistoryPieceLocationOld1: "",		// move history, the selected first piece
		_moveHistoryPieceLocationNew1: "",		// moved the first piece to selected location.
		_moveHistoryPieceLocationOld2: "",		// second piece, such as, the rook when castling. the second piece selected for that game move.
		_moveHistoryPieceLocationNew2: "",		// moved the second piece to selected location.
		
		_moveHistoryPieceValueOld1: "",		// image value of the selected first piece. if its a rook that first player selected then its a value of 4 else for second player then its a value of 14. normally this value is 0 because after the move, no piece is at that location.
		_moveHistoryPieceValueNew1: "",		// this refers to the value of the piece at the new selected moved to location.
		_moveHistoryPieceValueOld2: "",		// the second piece value, or piece image, normally this unit is empty because the second piece was moved to a new unit.
		_moveHistoryPieceValueNew2: "",		// this is the second piece moved to value of the image, so that the image can be moved to the new location.
		_moveHistoryPieceValueOld3: "",		// the captured piece value, its image.
		_moveHistoryTotalCount: 0,			// the total amount of all moves from all player playing gaming game.
	}

	/******************************
	 * a game message such as check or checkmate.
	 */
	public static var _dataGameMessage:DataGameMessage = 
	{
		id: Std.string(FlxG.random.int(100000000, 999999999)) + Std.string(FlxG.random.int(100000000, 999999999)),
		_username: "", 				// the username of the player.	
		_room: 0,					// current room that the user is in. zero equals no room.
		/******************************
		 * If events a and b are sent from event c to the server in that order, sometimes the server will send back event b to the client before the server finishes event a.
		 * to solve that problem, at client, move event b to the bottom of event a and if this var has the name of event b then at that code line event b will be executed.
		 */
		_triggerEvent: "",
		_gameMessage: "",				// an example of this would be a chess game where a player just received a message saying that the king is in check. 
		_userTo: "",
		_userFrom: "",
		_questionAnsweredAs:false // this false word sometimes comes up as function. just made the word "false" without quotes.
	}
	
	public static var _dataDailyQuests:DataDailyQuests = 
	{
		id: Std.string(FlxG.random.int(100000000, 999999999)) + Std.string(FlxG.random.int(100000000, 999999999)),
		_username: "", 				// the username of the player.
		
		/******************************
		 * Win three board games in a row.
		 */
		_three_in_a_row: "0",
		
		/******************************
		 * Win a chess game in 5 moves or under.
		 */
		_chess_5_moves_under: "0",
		
		/******************************
		 * Win a snakes and ladders game in under 4 moves.
		 */
		_snakes_under_4_moves: "0",
		
		/******************************
		 * Win a 5 minute game
		 */
		_win_5_minute_game: "0",
		
		/******************************
		 * Buy any two house items
		 */
		_buy_four_house_items: "0",
		
		/******************************
		 * Finish playing a signature game
		 */
		_finish_signature_game: "0",
		
		/******************************
		 * Occupy a total of 50 units in Reversi
		 */
		_reversi_occupy_50_units: "0",
		
		/******************************
		 * Get 6 Kinged pieces in 1 checkers game
		 */
		_checkers_get_6_kings: "0",
		
		/******************************
		 * play all 5 games.
		 */
		_play_all_5_board_games: "0",
		
		/******************************
		 * a gauge is dashed lines that runs horizontally across the top part of the dailyQuests.hx scene. There are three reward icons. then the dash filled line reaches a reward icon then a claim reward button will appear.
		 * the third dashed line refers to the first value is this string. the second value in this var refers to the sixth dashed line and the last dash lined (ninth) refers to the third value. therefore three quests need to be completed before a reward can be given. so there is 9 dashed lines, an every third line that is highlighted means that a quest reward can be given.
		 * this string look like this... "2,1,0". a zero means that no prize is available, the 1 means that a rewards can be claimed and 2 means that the reward for those quests have been claimed. remember that 2 quests are needed for every reward and that the dashed lines refer to those quests.
		 */
		_rewards: "",
		
	}
		
	/******************************
	* a message box questions.
	*/
	public static var _dataQuestions:DataQuestions = 
	{
		id: Std.string(FlxG.random.int(100000000, 999999999)) + Std.string(FlxG.random.int(100000000, 999999999)),
		_username: "", 				// the username of the player.	
		_gameMessage: "",				// an example of this would be a chess game where a player just received a message saying that the king is in check. 
		_drawOffer: false,				// chess draw offer. false=not yet asked. true=yes.
		_drawAnsweredAs: false,			// chess draw was answered as, -false:no, true:yes 
		_restartGameOffer:false,		// restart game offer. false=not yet asked. true=yes.
		_restartGameAnsweredAs:false,	// restart game was answered as, false:no, true:yes.
		_room: 0,						// current room that the user is in. zero equals no room.
		/******************************
		 * If events a and b are sent from event c to the server in that order, sometimes the server will send back event b to the client before the server finishes event a.
		 * to solve that problem, at client, move event b to the bottom of event a and if this var has the name of event b then at that code line event b will be executed.
		 */
		_triggerEvent: "",
		_gameOver:false					// is the game over?
	}
	
	/******************************
	 * every player's name. also, win, lose and draw stats of the player.
	 */ 
	public static var _dataOnlinePlayers:DataOnlinePlayers =
	{
		id: Std.string(FlxG.random.int(100000000, 999999999)) + Std.string(FlxG.random.int(100000000, 999999999)),
		_username: "", 				// the username of the player.	
		_room: 0,						// current room that the user is in. zero equals no room.
		/******************************
		 * If events a and b are sent from event c to the server in that order, sometimes the server will send back event b to the client before the server finishes event a.
		 * to solve that problem, at client, move event b to the bottom of event a and if this var has the name of event b then at that code line event b will be executed.
		 */
		_triggerEvent: "",
		// players names that are online.
		_usernamesOnline: ["", "", "", "", "", "", "", "", "", "",
					"", "", "", "", "", "", "", "", "", "",
					"", "", "", "", "", "", "", "", "", "",
					"", "", "", "", "", "", "", "", "", "",
					"", "", "", "", "", "", "", "", "", "",
					"", "", "", "", "", "", "", "", "", "",
					"", "", "", "", "", "", "", "", "", "",
					"", "", "", "", "", "", "", "", "", "",
					"", "", "", "", "", "", "", "", "", "",
					"", "", "", "", "", "", "", "", "", "",
					"", "", "", "", "", "", "", "", "", "",
					"", "", "", "", "", "", "", "", "", "",],		
		// any game played. players game wins of players online.
		_gamesAllTotalWins: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],			
		// any game played. players game losses of players online.
		_gamesAllTotalLosses: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],			
		// any game played. players game draws of players online.
		_gamesAllTotalDraws: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		
		// chess Elo rating for every player online.			
		_chess_elo_rating: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],			
					
					
	}

	public static var _dataTournaments:DataTournaments = 
	{
		id: Std.string(FlxG.random.int(100000000, 999999999)) + Std.string(FlxG.random.int(100000000, 999999999)),
		_username: "", 				// the username of the player.	
		// current room that the user is in. zero equals no room.
		_player1: "",	// if this name is not empty then its the name of the user in the tournament.
		_player2: "",
		_gid: "",
		_tournament_started: false,
		_player_maximum: 0,
		_player_current: 0,
		_room: 0,
		_game_id: 0,
		_round_current: 0,
		_rounds_total: 0,
		_move_total: 0,
		_game_over: 0,
		_won_game: 0,
		_move_piece: false,
		_time_remaining_player1: "",
		_time_remaining_player2: "",
		_move_number_current: 0,
		_timestamp: 0,
	}
	
	/******************************
	 * player's account information
	 */
	public static var _dataAccount:DataAccount = 
	{
		id: Std.string(FlxG.random.int(100000000, 999999999)) + Std.string(FlxG.random.int(100000000, 999999999)),
		_username: "", 					// the username of the player.	
		_popupMessage: "",				// the current message to be displayed as a message box.
		_host: "",						// used to return the this local hosts name.
		_ip: "",						// IP of player.
		_alreadyOnlineHost: false,			// is there two computers with the same host name connected to server?
		_alreadyOnlineUser: false,			// is there already a user with that username online?
		_server_fast_send: false,
		_server_blocking: false,
		_clients_connected: 0,
		_guest_account: false,
	}
	
	/******************************
	 * data that does not go into any other typedef goes here.
	 */
	public static var _dataMisc:DataMisc = 
	{
		id: Std.string(FlxG.random.int(100000000, 999999999)) + Std.string(FlxG.random.int(100000000, 999999999)),
		_username: "", 				// the username of the player.	
		// current room that the user is in. zero equals no room.
		_room: 0,	
		/******************************
		 * If events a and b are sent from event c to the server in that order, sometimes the server will send back event b to the client before the server finishes event a.
		 * to solve that problem, at client, move event b to the bottom of event a and if this var has the name of event b then at that code line event b will be executed.
		 */
		_triggerEvent: "",
		// the username of the player.
		_spectatorWatching: false,	// this user entered the game from the lobby when clicking the "watch game" button. this user can only watch the game. this player cannot play the game even when game ends.
		
		// 0 = empty, 1 computer game, 2 creating room, 3 = firth player waiting to play game. 4 = second player in waiting room. 5 third player in waiting room if any. 6 - forth player in waiting room if any. 7 - room full, 8 - playing game / waiting game.
		_roomState:	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		// maximum number of players that can play the selected game.
		_roomPlayerLimit:	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		// current total of players in a room.						 
		_roomPlayerCurrentTotal: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					 	 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		// used to list the games at lobby. see RegFunctions.gameName(). also, for not a host player, the data from here will populate _dataMisc._gameId for that player. 
		//-1: no data, 0:checkers, 1:chess, etc.
		_roomGameIds:	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
						 -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
						 -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
						 -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
						 -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
		// a list of every username that is a host of a room.
		_roomHostUsername:
						["", "", "", "", "", "", "", "", "", "",
					"", "", "", "", "", "", "", "", "", "",
					"", "", "", "", "", "", "", "", "", "",
					"", "", "", "", "", "", "", "", "", "",
					"", "", "", "", "", "", "", "", "", ""],
					
		_gid:
						["", "", "", "", "", "", "", "", "", "",
					"", "", "", "", "", "", "", "", "", "",
					"", "", "", "", "", "", "", "", "", "",
					"", "", "", "", "", "", "", "", "", "",
					"", "", "", "", "", "", "", "", "", ""],
					
		// if this vars value is true then a different player will not be able change the room state until the player has finished the "Greater RoomState Value" event at "Get Room Data" event. Note: that when a player leaves the game room, since that userLocation will always be a value of zero, a _roomIsLocked is not needed.
		_roomIsLocked: 
						[0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					 	 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		// If vars value is true then a check for a room lock will be made. This is used only when entering a room. If mouse clicked the "refresh room" button or leaving a game room then a check will not be made because in these cases a check is not needed. See Note: at _roomIsLocked for the reason why.
		_roomCheckForLock: 
						[0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					 	 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],	
		//When a room lock is true then this room cannot be entered by the current player and this is the message saying that someone is already accessing the room so try again shortly.
		_roomLockMessage: "",
		// if this value is true than the host is playing against the computer.
		_vsComputer: 
						[0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					 	 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		// if true then this room allows spectators.
		_allowSpectators:
						[0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					 	 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],	
		_userLocation: 0,				// currently where the user is at. lobby, __scene_waiting_room, etc. 0:lobby, 1:creating room, 2:__scene_waiting_room, 3:game room.
		_chat: "",						// chat text of the player.
		_gameRoom: false,				// should player enter the game room.
		_clientCommandMessage: "",				// ban message. player blocked other player from playing at that room for that session.
		_clientCommandUsers: "",
		_clientCommandIPs: ""
		
		
	};
	
	/******************************
	 * all players inside a room. their data, such as stats wins, losses.
	 */
	public static var _dataPlayers:DataPlayers = 
	{
		id: Std.string(FlxG.random.int(100000000, 999999999)) + Std.string(FlxG.random.int(100000000, 999999999)),
		_username: "",						// username of the client.
		_usernamesDynamic: ["", "", "", ""],
		_usernamesStatic: ["", "", "", ""], 
		_usernamesTotalDynamic: 0, // current total of players playing the game.
		_usernamesTotalStatic: 0, // total players that can play a game in that game room.
		_spectatorPlaying: false, // user who was once playing but is now watching the game being played.
		_spectatorWatching: false,	// this user entered the game from the lobby when clicking the "watch game" button. this user can only watch the game. this player cannot play the game even when game ends.
		_spectatorWatchingGetMoveNumber: 0,	// send the current move number to the watching spectator so that the timer and white box underneath the P1, P2, P3 or P4 moves, can be updated.		
		_avatarNumber: ["0.png", "0.png", "0.png", "0.png"], 	// This is the profile avatar image number used to display the image.
		// save the player's game player state to the database. is the player playing a game or waiting to play. 
		// 0: = not playing but still at game room. 
		// 1: playing a game. 
		// 2: left game room while still playing it. 
		// 3: left room when game was over. 
		// 4: quit game.
		// this var is used to display players who are waiting for a game at the game room and to get the _count of how many players are waiting at game room.		
		_gamePlayersValues: [0, 0, 0, 0],		
		_moveNumberDynamic: [0, 0, 0, 0],
		_room: 0,							// current room that the user is in. zero equals no room.
		/******************************
		 * If events a and b are sent from event c to the server in that order, sometimes the server will send back event b to the client before the server finishes event a.
		 * to solve that problem, at client, move event b to the bottom of event a and if this var has the name of event b then at that code line event b will be executed.
		 */
		_triggerEvent: "",
		_gameId: -1,		
		
		_gamesAllTotalWins: [0, 0, 0, 0],			// any game played. total game wins.
		_gamesAllTotalLosses: [0, 0, 0, 0],			// any game played. total game losses.
		_gamesAllTotalDraws: [0, 0, 0, 0],			// any game played. total game draws.
		_gameName: "",						// the game being played.
		_usernameInvite: "",				// username of the sent room invite.
		_gameMessage: "",					// game win, lose or draw messages.
		_actionWho: "",						// player that you want something done to.
		_actionNumber: 0,					// refers to an action, eg, 1 = kick. see the "Action By Player" event at server.
		_actionDo: -1,						// targeted player must do an action of _actionNumber. this var can be a time remaining var or whatever is needed for an Int.
		_moveTimeRemaining: [0, 0, 0, 0],	// time remaining to make a move. when time reaches 0, the game ends and that player losses.
		_score: [0, 0, 0, 0],				// total score in game.
		_cash: [0, 0, 0, 0],				// total cash in game.
		_quitGame: false,					// player had quit game.
		_isGameFinished: true,				// false if game is still being played. defaults to true because when entering the game room the game for those players has not started yet.
		
		_gameIsFinished: false,				// SAVE A VAR TO MYSQL SO THAT SOMEONE CANNOT INVITE WHEN STILL IN GAME ROOM. ALSO USED TO PASS A VAR TO USER SPECTATOR WATCHING. THAT VAR IS USED TO START A GAME FOR THAT SPECTATOR IF THE _gameIsFinished VALUE IS FALSE.
		_moveTotal: 0, // how many times a player moved a piece.
		/******************************
		* this is the time when game is started.
		*/
		_timeTotal: 0,
		
		/******************************
		* this is a daily quest var. total house items bought within 24 houses. see _buy_four_house_items
		*/
		_house_items_daily_total: 0,
		
		/******************************
		 * this is the piece total for the winner at the end of a game.
		 * currently only used in Reversi.
		 */
		_piece_total_for_winner: 0,		
		
		/******************************
		 *	this is a daily quest var. This is the amount of kings that a player has while playing a game. this var is used at DailyQuests.hx to determine if a reward should be given to player.
		 */
		_checkers_king_total: 0,
		 		 
		/******************************
		 * this is a daily quest var. when a game is won, at server main.hx, at the saveWinStats() function, a value of 1 will be given to that array element for that board game played. so if playing a Reversi game then the array element of 2 will be set to a value of 1. when all array elements in this var has a value of 1 then all board games has been played.
		 */
		_all_boardgames_played_total: [0,0,0,0,0],
	};
	
	/******************************
	 * credits, experience points, wins, losses, draws. all player statistics.
	 */
	public static var _dataStatistics:DataStatistics = 
	{
		id: Std.string(FlxG.random.int(100000000, 999999999)) + Std.string(FlxG.random.int(100000000, 999999999)),
		_username: "", 				// the username of the player.
		_room: 0,	
		/******************************
		 * this is the time when game is started.
		 */
		_timeTotal: 0,
		_moveTimeRemaining: [0, 0, 0, 0], // time since game has started.
		_chess_elo_rating: 0, // current chess Elo rating for player.
		
		
		/******************************
		 * If events a and b are sent from event c to the server in that order, sometimes the server will send back event b to the client before the server finishes event a.
		 * to solve that problem, at client, move event b to the bottom of event a and if this var has the name of event b then at that code line event b will be executed.
		 */
		_triggerEvent: "",
		
		_total_games_played: 0,
		_highest_experience_points: 0,
		_highest_credits: 0,
		_highest_house_coins: 0,
		_shortest_time_game_played: 0,
		_longest_time_game_played: 0,
		_longest_current_winning_streak: 0,
		_highest_winning_streak: 0,
		_longest_current_losing_streak: 0,
		_highest_losing_streak: 0,
		_longest_current_draw_streak: 0,
		_highest_draw_streak: 0,
	
		_gamesAllTotalWins: 0,		// all game wins for player.
		_gamesAllTotalLosses: 0,	// all game losses for player.
		_gamesAllTotalDraws: 0,		// all game draws for player.
		
		_checkersWins: 0,
		_checkersLosses: 0,
		_checkersDraws: 0,
		_chessWins: 0,
		_chessLosses: 0,
		_chessDraws: 0,
		_reversiWins: 0,
		_reversiLosses: 0,
		_reversiDraws: 0,
		_snakesAndLaddersWins: 0,
		_snakesAndLaddersLosses: 0,
		_snakesAndLaddersDraws: 0,
		_signatureGameWins: 0,
		_signatureGameLosses: 0,
		_signatureGameDraws: 0,
		
		_creditsToday: 0,			// credits given on event day. credits can be redeemed for a month of paid membership. Maximum of 5 credits per event day.
		_creditsTotal: 0,			// each credit_today value is written to this value. this value only decreases when credits are used to redeem something, such as 1 month of membership.
		_experiencePoints: 0,		// each game played gives some experience points. get enough experience point to increase players level.
		_houseCoins: 100, 				// at the house event, after a game is played, some coins will be given. Use those coins to buy house furniture. Access your house from the house button at lobby.
		
	}
	
	/******************************
	 * players house where they buy items, place items in room and vote for best house for prizes.
	 */
	public static var _dataHouse:DataHouse = 
	{
		id: Std.string(FlxG.random.int(100000000, 999999999)) + Std.string(FlxG.random.int(100000000, 999999999)),
		_username: "", 				// the username of the player.
		_sprite_number: "", // refers to a sprite that was bought to display at house. eg, 1.png.
		_sprite_name: "", // this is the name of the sprite in the order it was bought and then after, in the order of was changed using the z-order buttons of bring to front and bring to back.
		_items_x: "", // all items x position that is separated by a comma.
		_items_y: "", // all items y position that is separated by a comma.
		_map_x: "", // map x coordinates on scene at the time the item was bought or mouse dragged then mouse released.
		_map_y: "", // map y coordinates on scene at the time the item was bought or mouse dragged then mouse released.
		_map_offset_x: "", // when the map is moved up, down, left or right, this value increases in size by those pixels. this var is used at House update() so that the map hover can be displayed when outside of its default map boundaries. it is also added or subtracted to the mouse coordinates at other classes so that the map or panel items can correctly be detected by the mouse. for example, the mouse.x cannot be at a value of 2000 when the stage has a width of 1400 and the map changes in width, but it can be there when this offset is added to mouse.x.
		_map_offset_y: "",
		_item_is_hidden: "", // is this item hidden?
		_is_item_purchased: "", // a list of 1 and 0's separated by a comma. the first value in this list refers to item 1. if that value is 1 then that item was purchased.
		_item_direction_facing: "", // stores the direction that the furniture item is facing. values of 0=SE, 1:SW, 2:NE, 3:NW.
		_item_order: "", // the order of the furniture items displayed.
		/******************************
		* when value is true the furniture item will be displayed on the map behind a wall. This string contains true and false values up to 200 furniture items separated by a comma.
		*/
		_item_behind_walls: "",
		
		/******************************
		 * this holds all floor tiles on the map. This var is read from left to right but that data is placed on the map starting from the top left of map and then moving right and similar to reading words in a book.
		 */
		_floor: "",
		
		/******************************
		 * this holds all wall tiles in the left position on the map. This var is read from left to right but that data is placed on the map starting from the top left of map and then moving right and similar to reading words in a book.
		 */
		_wall_left: "",
		
		/******************************
	 * this holds all wall tiles in the upward position on the map. This var is read from left to right but that data is placed on the map starting from the top left of map and then moving right and similar to reading words in a book.
	 * this var is shown under a left tile.
	 */
		_wall_up_behind: "",
		_wall_up_in_front: "",
		
		/******************************
		 * the visibility state of all floor tiles.
		 */
		_floor_is_hidden: "",
		
		/******************************
		 * the visibility state of all left wall tiles.
		 */
		_wall_left_is_hidden: "",
		
		/******************************
		 * the visibility state of all up wall tiles.
		 */
		_wall_up_behind_is_hidden: "",
		_wall_up_in_front_is_hidden: "",
	}
		
	public static var _dataLeaderboards:DataLeaderboards = 
	{
		id: Std.string(FlxG.random.int(100000000, 999999999)) + Std.string(FlxG.random.int(100000000, 999999999)),
		_username: "", 				// the username of the player.
		_usernames: "",				// this holds all players in a top leaderboard list. the usernames in the list is separated with a comma.
		_experiencePoints: "",		// total XP for all players. each XP is separated by a comma.
	}
	
	public static function resetHouseData():Void
	{
		_dataHouse._sprite_number = "";
		_dataHouse._sprite_name = "";
		_dataHouse._items_x = "";
		_dataHouse._items_y = "";
		_dataHouse._map_x = "";
		_dataHouse._map_y = "";
		_dataHouse._map_offset_x = ""; 
		_dataHouse._map_offset_y = "";
		_dataHouse._item_is_hidden = "";
		_dataHouse._item_order = "";
		_dataHouse._is_item_purchased = "";
		_dataHouse._item_behind_walls = "";
		_dataHouse._item_direction_facing = "";
		_dataHouse._floor = "";
		_dataHouse._wall_left = "";
		_dataHouse._wall_up_behind = "";
		_dataHouse._wall_up_in_front = "";
		_dataHouse._floor_is_hidden = "";
		_dataHouse._wall_left_is_hidden = "";
		_dataHouse._wall_up_behind_is_hidden = "";
		_dataHouse._wall_up_in_front_is_hidden = "";
	}
	
	
	// data does not get reset at the move piece event. Only gets reset at MenuState.
	public static function resetTypedefDataOnce():Void
	{
		_dataGame0.id = _dataGame.id;
		_dataGame0._username = ""; 				// the username of the player.	
		_dataGame0._room = 0;					// current room that the user is in. zero equals no room.
		
		_dataGame1.id = _dataGame.id;
		_dataGame1._username = ""; 				// the username of the player.	
		_dataGame1._room = 0;
		
		_dataGame2.id = _dataGame.id;
		_dataGame2._username = ""; 				// the username of the player.	
		_dataGame2._room = 0;
		
		_dataGame3.id = _dataGame.id;
		_dataGame3._username = ""; 				// the username of the player.	
		_dataGame3._room = 0;
		
		_dataGame4.id = _dataGame.id;
		_dataGame4._username = ""; 				// the username of the player.	
		_dataGame4._room = 0;
		
		// -1 = not used. 0 = nobody owns this unit. 1 = player 1's unit. 2:player 2's unit. 3:player 3's unit. 4:player 4's unit. the first value is yy value and the second is xx value.
		_dataGame4._gameUniqueValueForPiece = 
		[[0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0],
		[0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0],
		[0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0],
		[0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0],
		[0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0],
		[0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0],
		[0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0],
		[0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0]];	
		
		// how many house/taxi/store pieces are on units. the first value is yy value and the second is xx value.
		_dataGame4._gameHouseTaxiCabOrCafeStoreForPiece =
		[[0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0],
		[0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0],
		[0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0],
		[0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0],
		[0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0],
		[0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0],
		[0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0],
		[0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0]];
						
		// Undeveloped units. no houses, taxi or cafe, nobody owns this unit when a value for that unit equals not 0.  the first value is yy value and the second is xx value.				
		_dataGame4._gameUndevelopedValueOfUnit =
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
		
		
		//#############################
		
		_dataMovement.id = _dataGame.id;// player instance. this tells one player from another.
		_dataMovement._username = ""; 				// the username of the player.
		_dataMovement._gid = "";
		_dataMovement._spectatorWatching = 0;
		
		/******************************
		* used to get the history from the room host.
		*/
		_dataMovement._username_room_host = "";
		_dataMovement._history_get_all = 0;
		
		_dataMovement._room = 0; 		// current room that the user is in. zero equals no room.
		
		//#############################
		
		_dataGameMessage.id = _dataGame.id;
		_dataGameMessage._username = ""; 	// the username of the player.	
		_dataGameMessage._room = 0;
		
		//#############################
		
		_dataDailyQuests._three_in_a_row = "0";
		_dataDailyQuests._chess_5_moves_under = "0";
		_dataDailyQuests._snakes_under_4_moves = "0";
		_dataDailyQuests._win_5_minute_game = "0";
		_dataDailyQuests._buy_four_house_items = "0";
		_dataDailyQuests._finish_signature_game = "0";
		_dataDailyQuests._reversi_occupy_50_units = "0";
		_dataDailyQuests._checkers_get_6_kings = "0";
		_dataDailyQuests._play_all_5_board_games = "0";
	
		//#############################
		
		_dataQuestions.id = _dataGame.id;
		_dataQuestions._username = ""; 	// the username of the player.	
		_dataQuestions._room = 0;	
		
		//#############################
		
		_dataTournaments.id = _dataGame.id;
		_dataTournaments._username = ""; 		// the username of the player.	
		_dataTournaments._player1 = "";	// _player1: "",	// if this name is not empty then its the name of the user in the tournament.
		_dataTournaments._player2 = "";
		_dataTournaments._gid = "";
		_dataTournaments._tournament_started = false;
		_dataTournaments._player_maximum = 0;
		_dataTournaments._player_current = 0;
		_dataTournaments._room = 0;
		_dataTournaments._game_id = 0;
		_dataTournaments._move_total = 0;
		_dataTournaments._game_over = 0;
		_dataTournaments._round_current = 0;
		_dataTournaments._rounds_total = 0;
		_dataTournaments._move_piece = false;
		_dataTournaments._time_remaining_player1 = "";
		_dataTournaments._time_remaining_player2 = "";
		_dataTournaments._move_number_current = -1;
		_dataTournaments._timestamp = 0;
		
		//#############################
		
		_dataAccount.id = _dataGame.id;
		//_dataAccount._username = ""; 	// the username of the player.	
		_dataAccount._popupMessage = "";				// the current message to be displayed as a message box.
		_dataAccount._host = "";						// used to return the this local hosts name.
		_dataAccount._ip = "";							// IP of player.
		_dataAccount._alreadyOnlineHost = false;		// is there two computers with the same host name connected to server?
		_dataAccount._alreadyOnlineUser = false;		// is there already a user with that username online?
		
		//#############################
		
		_dataMisc.id = _dataGame.id;
		_dataMisc._username = "";			// the username of the player.
		_dataMisc._room = 0;					// current room that the user is in. zero equals no room.
		// 0 = empty, 1 computer game, 2 creating room, 3 = firth player waiting to play game. 4 = second player in waiting room. 5 third player in waiting room if any. 6 - forth player in waiting room if any. 7 - room full, 8 - playing game / waiting game.
		
		_dataMisc._roomState =	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
		// maximum number of players that can play the selected game.
		_dataMisc._roomPlayerLimit = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						  0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
		// current total of players in a room.						 
		_dataMisc._roomPlayerCurrentTotal = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
		// used to list the games at lobby. see RegFunctions.gameName(). also, for not a host player, the data from here will populate RegTypedef._dataMisc._gameId for that player. 
		//-1: no data, 0:checkers, 1:chess, etc.
		_dataMisc._roomGameIds =	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
						 -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
						 -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
						 -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
						 -1, -1, -1, -1, -1, -1, -1, -1, -1, -1];
		
		// a list of every username that is a host of a room.
		_dataMisc._roomHostUsername =
						["", "", "", "", "", "", "", "", "", "",
					"", "", "", "", "", "", "", "", "", "",
					"", "", "", "", "", "", "", "", "", "",
					"", "", "", "", "", "", "", "", "", "",
					"", "", "", "", "", "", "", "", "", ""];
					
		_dataMisc._gid =
						["", "", "", "", "", "", "", "", "", "",
					"", "", "", "", "", "", "", "", "", "",
					"", "", "", "", "", "", "", "", "", "",
					"", "", "", "", "", "", "", "", "", "",
					"", "", "", "", "", "", "", "", "", ""];
					
		// if this vars value is true then a different player will not be able change the room state until the player has finished the "Greater RoomState Value" event at "Get Room Data" event. Note: that when a player leaves the game room, since that userLocation will always be a value of zero, a _roomIsLocked is not needed.	
		_dataMisc._roomIsLocked = 
						[0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					 	 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
		// If vars value is true then a check for a room lock will be made. This is used only when entering a room. If mouse clicked the "refresh room" button or leaving a game room then a check will not be made because in these cases a check is not needed. See Note: at _roomIsLocked for the reason why.
		_dataMisc._roomCheckForLock =
						[0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					 	 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];	
		// When a room lock is true then this room cannot be entered by the current player and this is the message saying that someone is already accessing the room so try again shortly.
		_dataMisc._roomLockMessage = "";
		_dataMisc._userLocation = 0;				// currently where the user is at. lobby, __scene_waiting_room, etc. 0:lobby, 1:creating room, 2:__scene_waiting_room, 3:room game playing.
		
		//#############################
		
		_dataPlayers.id = _dataGame.id;
		_dataPlayers._username = "";					// username of the client.
		
		//#############################
		
		_dataHouse.id = _dataGame.id;
		_dataHouse._username = "";					// username of the client.
		_dataHouse._sprite_number = ""; // refers to a sprite that was bought to display at house. eg, 1.png.
		_dataHouse._sprite_name = ""; // this is the name of the sprite in the order it was bought and then after, in the order of was changed using the z-order buttons of bring to front and bring to back.
	 	_dataHouse._items_x = ""; // all items x position that is separated by a comma.
		_dataHouse._items_y = ""; // all items y position that is separated by a comma.
		_dataHouse._map_x = ""; // map x coordinates on scene at the time the item was bought or mouse dragged then mouse released.
		_dataHouse._map_y = ""; // map y coordinates on scene at the time the item was bought or mouse dragged then mouse released.
		_dataHouse._map_offset_x = ""; // when the map is moved up, down, left or right, this value increases in size by those pixels. this var is used at House update() so that the map hover can be displayed when outside of its default map boundaries. it is also added or subtracted to the mouse coordinates at other classes so that the map or panel items can correctly be detected by the mouse. for example, the mouse.x cannot be at a value of 2000 when the stage has a width of 1400 and the map changes in width, but it can be there when this offset is added to mouse.x.
		_dataHouse._map_offset_y = "";
		_dataHouse._item_is_hidden = ""; // is this item hidden?
		_dataHouse._is_item_purchased = ""; // a list of 1 and 0's separated by a comma. the first value in this list refers to item 1. if that value is 1 then that item was purchased.
		_dataHouse._item_direction_facing = ""; // stores the direction that the furniture item is facing. values of 0=SE, 1:SW, 2:NE, 3:NW.
		_dataHouse._item_order = ""; // the order of the furniture items displayed.
		/******************************
		* when value is true the furniture item will be displayed on the map behind a wall. This string contains true and false values up to 200 furniture items separated by a comma.
		*/
		_dataHouse._item_behind_walls = "";
		/******************************
		 * this holds all floor tiles on the map. This var is read from left to right but that data is placed on the map starting from the top left of map and then moving right and similar to reading words in a book.
		 */
		_dataHouse._floor = "";
		
		/******************************
		 * this holds all wall tiles in the left position on the map. This var is read from left to right but that data is placed on the map starting from the top left of map and then moving right and similar to reading words in a book.
		 */
		_dataHouse._wall_left = "";
		
		/******************************
	 * this holds all wall tiles in the upward position on the map. This var is read from left to right but that data is placed on the map starting from the top left of map and then moving right and similar to reading words in a book.
	 * this var is shown under a left tile.
	 */
		_dataHouse._wall_up_behind = "";
		_dataHouse._wall_up_in_front = "";
		/******************************
		 * the visibility state of all floor tiles.
		 */
		_dataHouse._floor_is_hidden = "";
		
		/******************************
		 * the visibility state of all left wall tiles.
		 */
		_dataHouse._wall_left_is_hidden = "";
		
		/******************************
		 * the visibility state of all up wall tiles.
		 */
		_dataHouse._wall_up_behind_is_hidden = "";
		_dataHouse._wall_up_in_front_is_hidden = "";
		
		resetTypedefDataSome(); 
		resetTypedefData();
	}
	
	// returning to lobby. called after then event "Lesser RoomState Value" is called.
	public static function resetTypedefDataSome():Void
	{
		_dataMisc._spectatorWatching = false;		// this user entered the game from the lobby when clicking the "watch game" button. this user can only watch the game. this player cannot play the game even when game ends.
		_dataPlayers._spectatorWatching = false;	// this user entered the game from the lobby when clicking the "watch game" button. this user can only watch the game. this player cannot play the game even when game ends.
		_dataPlayers._spectatorWatchingGetMoveNumber = 0;		// send the current move number to the watching spectator so that the timer and white box underneath the P1, P2, P3 or P4 moves, can be updated.
		
		_dataPlayers._usernamesDynamic = ["", "", "", ""]; // one to four usernames of the players in the waiting room or game room.
		_dataPlayers._usernamesStatic = ["", "", "", ""]; // the difference between _usernamesDynamic and _usernamesStatic is that a username can get removed from the list of _usernamesDynamic, but the _usernamesStatic will always have the same names through the actions within the game room.
		_dataPlayers._usernamesTotalDynamic = 0; // current total of players playing the game.
		_dataPlayers._usernamesTotalStatic = 0; // total players that can play a game in that game room.
		_dataPlayers._spectatorPlaying = false; 		// user who was once playing but is now watching the game being played. 
		_dataPlayers._moveNumberDynamic = [0, 0, 0, 0];
		_dataPlayers._room = 0;	// current room that the user is in. zero equals no room.
		_dataPlayers._gameId = -1;
		
		_dataPlayers._gamesAllTotalWins = [0, 0, 0, 0];			// total game wins of host player.
		_dataPlayers._gamesAllTotalLosses = [0, 0, 0, 0];		// total game losses of host player.
		_dataPlayers._gamesAllTotalDraws = [0, 0, 0, 0];			// total game draws of host player.
		_dataPlayers._gameName = "";					// the game being played.
		_dataPlayers._moveTimeRemaining = [0, 0, 0, 0];	// LEAVE THIS CODE HERE. DON'T MOVE. time remaining to make a move. when time reaches 0, the game ends and that player losses.
			
		//#################################
		//_dataTournaments._player1 = "";	// if this name is not empty then its the name of the user in the tournament.
		_dataTournaments._player2 = "";
		_dataTournaments._move_total = 0;
	}
	
	// restarting game. changing states.
	public static function resetTypedefData():Void
	{
		_dataGame0._gameUnitNumberNew = -1;			// unit number. 0-64
		_dataGame0._gameUnitNumberOld = -1;			// unit number. 0-64
		_dataGame0._gameXXold = -1;					// unit x coordinate. you have requested this gameboard piece.
		_dataGame0._gameYYold = -1;					// unit y coordinate. you have requested this gameboard piece.
		_dataGame0._gameXXnew = -1;					// unit x coordinate. you have requested a piece be moved here.
		_dataGame0._gameYYnew = -1;					// unit y coordinate. you have requested a piece be moved here.
		_dataGame0._gameXXold2 = -1;				// unit x coordinate. you have requested this gameboard piece.
		_dataGame0._gameYYold2 = -1;				// unit y coordinate. you have requested this gameboard piece.
		_dataGame0._triggerNextStuffToDo = 0;	// used to determine if the pawn is En Passant. also in Reversi, if all 4 discs have been placed on the board.
		_dataGame0._isThisPieceAtBackdoor = false;			// each board game should use this for only one var.
		
		//#############################
		
		_dataGame1._pieceValue = -1;				// this is the point value of each piece on the standard gameboard
		_dataGame1._uniqueValue = -1;				// unique value of a piece.
		_dataGame1._gameUnitNumberNew = -1;			// unit number. 0-64
		_dataGame1._gameUnitNumberOld = -1;			// unit number. 0-64
		_dataGame1._gameUnitNumberNew2 = -1;		// unit number. 0-64
		_dataGame1._gameUnitNumberOld2 = -1;		// unit number. 0-64
		_dataGame1._gameXXold = -1;					// unit x coordinate. you have requested this gameboard piece.
		_dataGame1._gameYYold = -1;					// unit y coordinate. you have requested this gameboard piece.
		_dataGame1._gameXXnew = -1;					// unit x coordinate. you have requested a piece be moved here.
		_dataGame1._gameYYnew = -1;					// unit y coordinate. you have requested a piece be moved here.
		_dataGame1._gameXXold2 = -1;				// unit x coordinate. you have requested this gameboard piece.
		_dataGame1._gameYYold2 = -1;				// unit y coordinate. you have requested this gameboard piece.
		_dataGame1._gameXXnew2 = -1;				// unit x coordinate. you have requested a piece be moved here.
		_dataGame1._gameYYnew2 = -1;				// unit y coordinate. you have requested a piece be moved here.
		_dataGame1._isEnPassant = false;		// is pawn En passant? 
		_dataGame1._isEnPassantPawnNumber = [0,0];	// the most recent pawn in En passant.
		_dataGame1._triggerNextStuffToDo = 0;	// used to determine if the pawn is En Passant. also in Reversi, if all 4 discs have been placed on the board.
		_dataGame1._pointValue2 = -1;				// castling vars to move the rook.
		_dataGame1._uniqueValue2 = -1;				// castling vars.
		_dataGame1._promotePieceLetter = "";	// this is the letter used in notation of a promoted piece selected.
		_dataGame1._doneEnPassant = false;		// for notation.
		// capturing unit image value for history when using the backwards button.
	 	_dataGame1._piece_capturing_image_value = 0;
	
		//#################################
		
		_dataGame2._gameXXold = -1;					// unit x coordinate. you have requested this gameboard piece.
		_dataGame2._gameYYold = -1;					// unit y coordinate. you have requested this gameboard piece.
		_dataGame2._triggerNextStuffToDo = 0;	// used to determine if the pawn is En Passant. also in Reversi, if all 4 discs have been placed on the board.
		_dataGame2._pointValue2 = -1;				// castling vars to move the rook.
		
		//#################################
		
		_dataGame3._gameUnitNumberNew = -1;			// unit number. 0-64
		_dataGame3._triggerEventForAllPlayers = true;
		_dataGame3._triggerNextStuffToDo = 0;
		_dataGame3._rolledA6 = false;		// move again.
		
		//#################################
		
		_dataGame4._gameXXold = -1;					// unit x coordinate. you have requested this gameboard piece.
		_dataGame4._gameYYold = -1;					// unit y coordinate. you have requested this gameboard piece.
		_dataGame4._gameXXnew = -1;					// unit x coordinate. you have requested a piece be moved here.
		_dataGame4._gameYYnew = -1;					// unit y coordinate. you have requested a piece be moved here.
		_dataGame4._gameXXold2 = -1;				// used in trade unit. this is the player that is moving piece. player would like to trade this unit.
		_dataGame4._gameYYold2 = -1;				// used in trade unit. this is the player that is moving piece. player would like to trade this unit.
		_dataGame4._gameXXnew2 = -1;				// used in trade unit. this is the other player's unit. player moving would like to trade other player's unit.
		_dataGame4._gameYYnew2 = -1;				// used in trade unit. this is the other player's unit. player moving would like to trade other player's unit.
		_dataGame4._rentBonus = [0.01, 0.01, 0.01, 0.01];			// total rent bonus in game. this value of 0.01 is needed because this var is used in multiplication and we cannot times by zero or else we get zero for the result which is not desired.
		
		_dataGame4._unitNumberTrade = [0, 0]; // used when trading units. this holds the value of a unit number. this var is useful. it can change an ownership of a unit. see Reg._gameUniqueValueForPiece.
		
		//#################################
		
		_dataMovement._gameDiceMaximumIndex = -1; // unit number. 0-64
		
		_dataMovement._triggerNextStuffToDo = 0; // used to determine if the pawn is En Passant. also in Reversi, if all 4 discs have been placed on the board.		
		
		// all players move history for the game.
		_dataMovement._moveHistoryPieceLocationOld1 = "";		// move history, the selected first piece
		_dataMovement._moveHistoryPieceLocationNew1 = "";		// moved the first piece to selected location.
		_dataMovement._moveHistoryPieceLocationOld2 = "";		// second piece, such as, the rook when castling. the second piece selected for that game move.
		_dataMovement._moveHistoryPieceLocationNew2 = "";		// moved the second piece to selected location.
		
		_dataMovement._moveHistoryPieceValueOld1 = "";		// image value of the selected first piece. if its a rook that first player selected then its a value of 4 else for second player then its a value of 14. normally this value is 0 because after the move, no piece is at that location.
		_dataMovement._moveHistoryPieceValueNew1 = "";		// this refers to the value of the piece at the new selected moved to location.
		_dataMovement._moveHistoryPieceValueOld2 = "";		// the second piece value, or piece image, normally this unit is empty because the second piece was moved to a new unit.
		_dataMovement._moveHistoryPieceValueNew2 = "";		// this is the second piece moved to value of the image, so that the image can be moved to the new location.
		_dataMovement._moveHistoryTotalCount = 0;			// the total amount of all moves from all player playing gaming game.
		_dataMovement._triggerEvent = "";
		
		//#################################
		
		_dataGameMessage._gameMessage = "";			// an example of this would be a chess game where a player just received a message saying that the king is in check. this event sends that same message to the other party.	
		_dataGameMessage._userTo = "";
		_dataGameMessage._userFrom = "";
		_dataGameMessage._questionAnsweredAs = false; 
		_dataGameMessage._triggerEvent = "";
		
		//#################################
		
		_dataQuestions._gameMessage = "";			// an example of this would be a chess game where a player just received a message saying that the king is in check. this event sends that same message to the other party.	
		_dataQuestions._drawOffer = false;			// chess draw offer. false=not yet asked. true=yes.
		_dataQuestions._drawAnsweredAs = false;		// chess draw was answered as, -false:no, true:yes 
		_dataQuestions._restartGameOffer = false;		// restart game offer. false=not yet asked. true=yes.
		_dataQuestions._restartGameAnsweredAs = false;	// restart game was answered as, false:no, true:yes.
		_dataQuestions._gameOver = false;							// is the game over?
		_dataQuestions._triggerEvent = "";

		//#################################
		
		// every player's name, win, lose, draw...
		_dataOnlinePlayers.id = _dataGame.id;
		_dataOnlinePlayers._room = 0;						// current room that the user is in. zero equals no room.
		// players names that are online.
		_dataOnlinePlayers._usernamesOnline =  ["", "", "", "", "", "", "", "", "", "",
						"", "", "", "", "", "", "", "", "", "",
						"", "", "", "", "", "", "", "", "", "",
						"", "", "", "", "", "", "", "", "", "",
						"", "", "", "", "", "", "", "", "", "",
						"", "", "", "", "", "", "", "", "", "",
						"", "", "", "", "", "", "", "", "", "",
						"", "", "", "", "", "", "", "", "", "",
						"", "", "", "", "", "", "", "", "", "",
						"", "", "", "", "", "", "", "", "", "",
						"", "", "", "", "", "", "", "", "", "",
						"", "", "", "", "", "", "", "", "", "",];		
		// players game wins of players online.
		_dataOnlinePlayers._gamesAllTotalWins = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
		// players game losses of players online.
		_dataOnlinePlayers._gamesAllTotalLosses = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,						 
						 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];		
		// players game draws of players online.
		_dataOnlinePlayers._gamesAllTotalDraws = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];		

		_dataOnlinePlayers._chess_elo_rating = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
						
		_dataOnlinePlayers._triggerEvent = "";
		
		//#################################

		_dataMisc._chat = "";					// chat text of the player.
		_dataMisc._gameRoom = false;				// should player enter the game room.
		_dataMisc._clientCommandMessage = "";				// ban message. player blocked other player from playing again at that room for that session.
		_dataMisc._clientCommandUsers = "";
		_dataMisc._clientCommandIPs = "";
		_dataMisc._triggerEvent = "";
				
		//#################################
		// save the player's game player state to the database. is the player playing a game or waiting to play. 
		// 0: = not playing but still at game room. 
		// 1: playing a game. 
		// 2: left game room while still playing it. 
		// 3: left game or game room when game was over.
		// 4: quit game.
		// this var is used to display players who are waiting for a game at the game room and to get the _count of how many players are waiting at game room.
		_dataPlayers._gamePlayersValues = [0, 0, 0, 0];
		_dataPlayers._usernameInvite = "";				// username of the sent room invite.
		_dataPlayers._score = [0, 0, 0, 0];				// total score in game.
		_dataPlayers._cash = [7000, 7000, 7000, 7000];	// total cash in game.
		_dataPlayers._gameMessage = "";			// an example of this would be a chess game where a player just received a message saying that the king is in check. 
		_dataPlayers._actionWho = "";			// player that you want something done to.
		_dataPlayers._actionNumber = 0;			// refers to an action, eg, 1 = kick. see the "Action By Player" event at server.
		_dataPlayers._actionDo = -1;			// targeted player must do an action of _actionNumber. this var can be a time remaining var or whatever is needed for an Int.
		_dataPlayers._quitGame = false;			// while playing the game, a player has clicked the quit game button if true.
		_dataPlayers._isGameFinished = true;	// false if game is still being played. defaults to true because when entering the game room the game for those players has not started yet.
		_dataPlayers._gameIsFinished = false;				// SAVE A VAR TO MYSQL SO THAT SOMEONE CANNOT INVITE WHEN STILL IN GAME ROOM. ALSO USED TO PASS A VAR TO USER SPECTATOR WATCHING. THAT VAR IS USED TO START A GAME FOR THAT SPECTATOR IF THE _gameIsFinished VALUE IS FALSE.
		_dataPlayers._triggerEvent = "";
		_dataPlayers._checkers_king_total = 0;
		
		/******************************
		 * this is the piece total for the winner at the end of a game.
		 * currently only used in Reversi.
		 */
		_dataPlayers._piece_total_for_winner = 0; 
		
		//#################################
		
		_dataTournaments._won_game = 0;
		
		//#################################

		_dataStatistics._timeTotal = 0;
		_dataStatistics._moveTimeRemaining = [0, 0, 0, 0]; // time since game has started.
		//_dataStatistics._chess_elo_rating = 0;		
		_dataStatistics._total_games_played = 0;
		_dataStatistics._highest_experience_points = 0;
		_dataStatistics._highest_credits = 0;
		_dataStatistics._highest_house_coins = 0;
		_dataStatistics._shortest_time_game_played = 0;
		_dataStatistics._longest_time_game_played = 0;
		_dataStatistics._longest_current_winning_streak = 0;
		_dataStatistics._highest_winning_streak = 0;
		_dataStatistics._longest_current_losing_streak = 0;
		_dataStatistics._highest_losing_streak = 0;
		_dataStatistics._longest_current_draw_streak = 0;
		_dataStatistics._highest_draw_streak = 0;
	
		_dataStatistics._checkersWins = 0;
		_dataStatistics._checkersLosses = 0;
		_dataStatistics._checkersDraws = 0;
		_dataStatistics._chessWins = 0;
		_dataStatistics._chessLosses = 0;
		_dataStatistics._chessDraws = 0;
		_dataStatistics._reversiWins = 0;
		_dataStatistics._reversiLosses = 0;
		_dataStatistics._reversiDraws = 0;
		_dataStatistics._snakesAndLaddersWins = 0;
		_dataStatistics._snakesAndLaddersLosses = 0;
		_dataStatistics._snakesAndLaddersDraws = 0;
		_dataStatistics._signatureGameWins = 0;
		_dataStatistics._signatureGameLosses = 0;
		_dataStatistics._signatureGameDraws = 0;
		_dataStatistics._triggerEvent = "";
	}
	
	
	
	// round cash values to cents
	public static function mathRoundCash():Void
	{
		_dataPlayers._cash[0] = FlxMath.roundDecimal(_dataPlayers._cash[0], 2);
		_dataPlayers._cash[1] = FlxMath.roundDecimal(_dataPlayers._cash[1], 2);
		
		if (_dataPlayers._cash.length > 2) 
			_dataPlayers._cash[2] = FlxMath.roundDecimal(_dataPlayers._cash[2], 2);
		if (_dataPlayers._cash.length > 3)
		_dataPlayers._cash[3] = FlxMath.roundDecimal(_dataPlayers._cash[3], 2);
	}
	
}//
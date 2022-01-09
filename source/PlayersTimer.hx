/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

/**
 * addresses a double message bug. a player lost message when time runs out and then when restarting a game the same message is displayed again. 
 * @author kboardgames.com
 */

class PlayersTimer extends Timer {
	
	override public function new( time_ms : Int )
	{
		super(time_ms);
		
		PlayerTimeRemainingMove._ticksStart = 0;
	}
	
}

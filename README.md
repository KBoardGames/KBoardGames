# K Board Games Client
[![Server Status](https://img.shields.io/pingpong/status/sp_7241145592d44ae2bd4c2a9c4558a0ef?label=kboardgames.com&style=for-the-badge)](https://kboardgames.com)
[![Discord](https://img.shields.io/discord/878790325261434923?color=%236b7ff5&label=Discord&style=for-the-badge)](https://discord.gg/7gF8t3yNDU)

The client for K Board Games. The client is used to play games online against other players. See also: <a href="https://github.com/KBoardGames/KBoardGames-Server">K Board Games server</a>

<p>Play 8x8 board games online with other players using the client software. Main features are <a href="https://kboardgames.com/en/events">scheduled events</a>, signature game, game statistics, daily quests and a <a href="https://kboardgames.com/en/viewtopic.php?f=4&t=3">isometric house side game</a>. Currently, the board games that you can play online against other players are <a href="https://kboardgames.com/en/viewtopic.php?f=10&amp;t=15">chess</a>, <a href="https://kboardgames.com/en/viewtopic.php?f=10&amp;t=14">checkers</a>, <a href="https://kboardgames.com/en/viewtopic.php?f=10&amp;t=17">snakes and ladders</a>, <a href="https://kboardgames.com/en/viewtopic.php?f=10&amp;t=16">reversi</a> and a signature game called <a href="https://kboardgames.com/en/viewtopic.php?f=10&amp;t=18">wheel estate</a>, game.</p>

## Summary
* Always 100% free client software.
* <a href="https://kboardgames.com/index.php?p=9">Custom themes</a>.
* MMO board games.
* 2000+ chess openings moves.
* 254 world flags.
* Over 56000 username suggestions.
* <a href="https://kboardgames.com/index.php?p=16">Client modules</a>.
* Over 70 customizable options.
* Maximum of 2000 XP levels for a player.
* Zillions of game room color combinations.
* 17 <a href="https://kboardgames.com/index.php?p=6">Leaderboards</a> showing top players.
* 8 different chess sets.
* Option to play chess using 2 different chess sets.
* Player move history. In game and in database.
* Client archive under 12MB in size.
* No advertisements in the client software.
* <a href="https://kboardgames.com/index.php?p=24">Chess features</a> for beginners.
* In game waiting room chatting and game room chatting.
* <a href="https://kboardgames.com/index.php?p=27">Host your own games</a> using the server software.

## Chess.
<img src="https://kboardgames.com/images/game2_chess.jpg?" alt="Image 1 of chess" width="500"/>

1: Capturing Path To King. This feature refers to a check against the king and that check is shown as a straight line of units starting from the attacker's piece and ending at the defenders king. The capturing path must be protected. The defender piece must capture one of the highlighted units after check is called.

2: Future Capturing Units. These are the capturing path to king that the attacking piece can capture on its next move. This shows any possible straight line attacks that the opponent can place on the defending king at the opponents next move by highlighting those units a different color.

## Wheel Estate
<img src="https://kboardgames.com/images/signatureGame.jpg?" alt="Image 1 of wheel estate" width="500"/>

This is a two to four player signature game of the client software that is very similar in playability to the game of monopoly.

<img src="https://kboardgames.com/images/checkers1.jpg?" alt="Image 1 of checkers" width="500"/>

<img src="https://kboardgames.com/images/reversi.jpg?" alt="reversi" width="500"/>

## Dependencies
For compilation you will need:

* Haxe 4.0.0-rc.2
* Haxeflixel (See haxelib commands below.)
* MySQL

Here are the libraries needed to build Haxeflixel games. Note that newer versions of these libraries will break the libraries found in the vendor folder.

* haxelib install actuate 1.8.9
* haxelib install flixel-addons 2.7.5
* haxelib install flixel-demos 2.7.0
* haxelib install flixel-templates 2.6.1
* haxelib install flixel-tools 1.4.4
* haxelib install flixel-ui 2.3.2
* haxelib install flixel 4.6.1
* haxelib install hxcpp 4.0.8
* haxelib install lime-tools 1.5.7
* haxelib install lime 7.3.0
* haxelib install openfl 8.9.0
* haxelib install msgpack-haxe 1.15.1
* haxelib run lime setup

## Compilation
```
haxe Build.hxml
```

## License disclaimer

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see https://www.gnu.org/licenses/.

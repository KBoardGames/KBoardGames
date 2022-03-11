/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

/**
 * the first class.
 * TODO remove all elements before the "new" call, so that memory does not grow which will slow down the client. the client becomes a bit more slower each time entering and exiting a scene.
 * @author kboardgames.com
 */
class Main extends Sprite
{

	var zoom:Float = -1; // If -1, zoom is automatically calculated to fit the window dimensions.

	public function new()
	{
		super();
		
		Reg.resetRegVarsOnce();
		
		#if neko
			// FlxStateSubSpecialEffects.hx will display parts of the scene underneath it when first starting the client. This is normal when window is maximixed at project.xml and this statement is set to false.
			Lib.application.window.maximized = false;
			
			addChild(new FlxGame(Reg._client_width, Reg._client_height, MenuState, zoom, Reg._framerate, Reg._framerate, true, false));	
		
		#else
			Lib.application.window.maximized = true;
			
			addChild(new FlxGame(Reg._client_width, Reg._client_height, SceneLogo, zoom, Reg._framerate, Reg._framerate, false, false));
		
		#end		
	}
	
}

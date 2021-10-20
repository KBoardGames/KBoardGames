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
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

/**
 * background gradient, texture and plain color for a scene.
 * @author kboardgames.com
 */
class SceneBackground extends FlxGroup
{	
	/******************************
	 * fill the screen with a random color.
	 */
	private var _background_color:FlxSprite;
	
	/******************************
	 * display a gradient image to full the scene.
	 */
	private var _background_gradient_color:FlxSprite;
	
	/******************************
	 * display a texture image to full the scene.
	 */
	private var _background_texture_color:FlxSprite;
	
	override public function new() 
	{
		super();
		
		// fill the screen with a random color.
		_background_color = new FlxSprite();
		_background_color.makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);
		_background_color.color = FlxColor.fromHSB(FlxG.random.int(1, 360), RegCustom._client_background_saturation[Reg._tn], RegCustom._client_background_brightness[Reg._tn]);
		_background_color.scrollFactor.set(0, 0);
		add(_background_color);
		
		if (RegCustom._client_background_enabled[Reg._tn] == true)
		{
			// fill the screen with a static color.
			var _color:FlxColor = RegCustomColors.color_client_background();
			
			// no saturation for gray color.
			if (RegCustom._client_background_image_number[Reg._tn] == 14)
				_background_color.color = FlxColor.fromHSB(_color.hue, 0, RegCustom._client_background_brightness[Reg._tn]);
			
			if (RegCustom._client_background_image_number[Reg._tn] == 1)
				_background_color.color = FlxColor.WHITE;
			else if (RegCustom._client_background_image_number[Reg._tn] == 15)
				_background_color.color = FlxColor.BLACK;
			else
				_background_color.color = FlxColor.fromHSB(_color.hue, RegCustom._client_background_saturation[Reg._tn], RegCustom._client_background_brightness[Reg._tn]);
			
			add(_background_color);
		}
		
		if (Reg._at_menu_state == false
		&&	Reg._at_menu_state_offline == false)
		{
			if (RegCustom._gradient_background_enabled[Reg._tn] == true)
			{
				_background_gradient_color = new FlxSprite(0, 0, "assets/images/gameboardGradientBackground" + Std.string(RegCustom._gradient_background_image_number[Reg._tn]) + ".jpg"); // 44 is half of hud height.
				_background_gradient_color.scrollFactor.set(0, 0);
				if (RegCustom._background_alpha_enabled[Reg._tn] == true)
					_background_gradient_color.alpha = 0.5;
				add(_background_gradient_color);
			}
			
			if (RegCustom._texture_background_enabled[Reg._tn] == true)
			{
				_background_texture_color = new FlxSprite(0, 0, "assets/images/scenes/textures/" + Std.string(RegCustom._texture_background_image_number[Reg._tn]) + ".jpg"); // 44 is half of hud height.
				_background_texture_color.scrollFactor.set(0, 0);
				if (RegCustom._background_alpha_enabled[Reg._tn] == true)
					_background_texture_color.alpha = 0.5;
				add(_background_texture_color);
			}
		}	
		
	}
	
}
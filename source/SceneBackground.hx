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
			if (RegCustom._client_background_image_number[Reg._tn] == 13)
			{
				if (RegCustom._client_background_brightness[Reg._tn] == 1)
					_background_color.color = 0xffffffff;
				
				if (RegCustom._client_background_brightness[Reg._tn] == 0.95)
					_background_color.color = 0xffeeeeee;
					
				if (RegCustom._client_background_brightness[Reg._tn] == 0.9)
					_background_color.color = 0xffdddddd;
					
				if (RegCustom._client_background_brightness[Reg._tn] == 0.85)
					_background_color.color = 0xffcccccc;
					
				if (RegCustom._client_background_brightness[Reg._tn] == 0.8)
					_background_color.color = 0xffbbbbbb;
					
				if (RegCustom._client_background_brightness[Reg._tn] == 0.75)
					_background_color.color = 0xffaaaaaa;
				
				if (RegCustom._client_background_brightness[Reg._tn] == 0.7)
					_background_color.color = 0xff999999;
					
				if (RegCustom._client_background_brightness[Reg._tn] == 0.65)
					_background_color.color = 0xff888888;
					
				if (RegCustom._client_background_brightness[Reg._tn] == 0.6)
					_background_color.color = 0xff777777;
					
				if (RegCustom._client_background_brightness[Reg._tn] == 0.55)
					_background_color.color = 0xff666666;
				
				if (RegCustom._client_background_brightness[Reg._tn] == 0.5)
					_background_color.color = 0xff555555;
				
				if (RegCustom._client_background_brightness[Reg._tn] == 0.45)
					_background_color.color = 0xff444444;
					
				if (RegCustom._client_background_brightness[Reg._tn] == 0.4)
					_background_color.color = 0xff333333;
					
				if (RegCustom._client_background_brightness[Reg._tn] == 0.35)
					_background_color.color = 0xff333333;
					
				if (RegCustom._client_background_brightness[Reg._tn] == 0.3)
					_background_color.color = 0xff222222;
					
				if (RegCustom._client_background_brightness[Reg._tn] == 0.25)
					_background_color.color = 0xff222222;
				
				if (RegCustom._client_background_brightness[Reg._tn] == 0.2)
					_background_color.color = 0xff111111;
					
				if (RegCustom._client_background_brightness[Reg._tn] == 0.15)
					_background_color.color = 0xff111111;
					
			}
			
			else if (RegCustom._client_background_image_number[Reg._tn] == 1)
				_background_color.color = FlxColor.WHITE;
				
			else if (RegCustom._client_background_image_number[Reg._tn] == 12)
				_background_color.color = FlxColor.BLACK;
			else
				_background_color.color = FlxColor.fromHSB(_color.hue, RegCustom._client_background_saturation[Reg._tn], RegCustom._client_background_brightness[Reg._tn]);
			
			add(_background_color);
		}
		
		if (RegCustom._gradient_background_enabled[Reg._tn] == true)
		{
			_background_gradient_color = new FlxSprite(0, 0, "assets/images/gameboardGradientBackground.jpg");
			_background_gradient_color.color = RegCustomColors.gradient_color();
			_background_gradient_color.scrollFactor.set(0, 0);
			if (RegCustom._background_alpha_enabled[Reg._tn] == true)
			// a value of 0.25 is 75% transparency.
			_background_gradient_color.alpha = 0.20;
			add(_background_gradient_color);
		}
		
		if (RegCustom._texture_background_enabled[Reg._tn] == true)
		{
			_background_texture_color = new FlxSprite(0, 0, "assets/images/scenes/textures/" + Std.string(RegCustom._texture_background_image_number[Reg._tn]) + ".jpg"); // 44 is half of hud height.
			_background_texture_color.scrollFactor.set(0, 0);
			if (RegCustom._background_alpha_enabled[Reg._tn] == true)
				_background_texture_color.alpha = 0.20;
			add(_background_texture_color);
		}
	}
	
}
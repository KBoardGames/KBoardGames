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

import yaml.Yaml;
import yaml.Parser;
import yaml.Renderer;
import yaml.util.ObjectMap;
import flixel.FlxG;
import flixel.addons.ui.FlxUIButton;
import flixel.text.FlxText.FlxTextAlign;
import flixel.text.FlxText.FlxTextBorderStyle;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxTimer;
import haxe.ds.ArraySort;
import flixel.group.FlxSpriteGroup;
import flixel.addons.ui.FlxInputText;
import vendor.ibwwg.FlxScrollableArea;
import openfl.display.StageQuality;
import flixel.math.FlxRect;
import flixel.ui.FlxBar;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.math.FlxMath;
import flixel.util.FlxSave;
import flixel.FlxGame;
import flixel.FlxState;
import openfl.display.Sprite;
import haxe.Http;
import openfl.Lib;
import openfl.errors.Error;
import openfl.net.URLRequest;
import haxe.Timer;
import haxe.io.Path;
import flixel.util.FlxSpriteUtil.LineStyle;
import vendor.mphx.client.Client;
import flixel.ui.FlxButton;
import flixel.util.FlxSpriteUtil;
import flixel.system.FlxAssets.FlxGraphicAsset;


#if !html5
	import sys.FileSystem;
#end

#if !MOBILE
	import flixel.input.keyboard.FlxKey;
#end

#if !html5
	import sys.FileSystem;
	import sys.io.File;
#end
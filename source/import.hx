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
	

import yaml.util.ObjectMap.AnyObjectMap;
import flash.display.GradientType;
import flash.display.GraphicsPathWinding;
import flash.display.Shape;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.ProgressEvent;
import flash.events.MouseEvent;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import flash.net.URLRequest;
import haxe.crypto.Md5;
import flash.text.TextFormatAlign;
import flixel.util.FlxStringUtil;
import openfl.Vector;
import flixel.math.FlxPoint;
import openfl.media.Sound;
import openfl.media.SoundChannel;
import openfl.media.SoundTransform;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.BlendMode;
import flash.display.Sprite;
import flash.Lib;
import flash.text.TextField;
import flash.text.TextFormat;
import flixel.system.FlxBasePreloader;
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
import flixel.group.FlxSpriteGroup;
import flixel.addons.ui.FlxInputText;
import flixel.util.FlxSpriteUtil.LineStyle;
import flixel.ui.FlxButton;
import flixel.util.FlxSpriteUtil;
import flixel.system.FlxAssets;
import flixel.math.FlxRect;
import flixel.ui.FlxBar;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.math.FlxMath;
import flixel.util.FlxSave;
import flixel.FlxGame;
import flixel.FlxState;
import haxe.Http;
import haxe.Timer;
import haxe.io.Path;
import haxe.ds.ArraySort;
import openfl.display.StageQuality;
import openfl.Lib;
import openfl.errors.Error;
import openfl.net.URLRequest;
import openfl.display.Sprite;
import vendor.mphx.client.Client;
import vendor.ibwwg.FlxScrollableArea;
import yaml.Yaml;
import yaml.Parser;
import yaml.Renderer;
import yaml.util.ObjectMap;

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
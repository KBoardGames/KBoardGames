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

package modules.worldFlags;

import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.util.FlxColor;

#if !html5
	import haxe.io.Path;
	import sys.io.FileOutput;
#end

#if avatars
	import modules.avatars.Avatars;
#end

#if username_suggestions
	import modules.usernameSuggestions.Usernames;
#end

/**
 * @author kboardgames.com
 */
class WorldFlags
{
	// current total flags. see https://flagpedia.net
	private static var _total:Int = 255;
	
	private static var _image_world_flags:FlxSprite;
	
	/******************************
	 * image of the selected flag.
	 */
	public static var _image_selected_world_flag:FlxSprite;
	
	/******************************
	 * the image of the sprite.
	 */
	public static var _group_flag_sprites:Array<FlxSprite> = [];
	
	
	public static var _group_flag_highlight_sprite:Array<FlxSprite> = [];
	
	private static var _text_title_world_flags:FlxText;
	private static var _world_flags_notice:FlxText;
	private static var _group_flag_text:Array<FlxText> = [];	
	private static var _world_flag_selected:FlxText;
	
	/*****************************
	 * flag abbreviations
	 */
	public static var _flags_abbv:Array<String> = [for (i in 0... _total) ""];
	
	/*****************************
	 * the name of the country.
	 */
	public static var _flags_abbv_name:Array<String> = [for (i in 0... _total) ""];
	
	/*****************************
	 * the width of the flag. the width is needed to place a slightly oversized white background behind each flag image. The oversized image will look like a white border that parameters the flag image.
	 */
	private static var _flags_width:Array<Int> = [for (i in 0... _total) 0];
	
	private static var _flags_height:Int = 40;
	
	// flag abbreviation, flag name and flag width.
	private static var _abbv:Array<String> = 
	["aa,no flag;64",
		"ad,andorra;57",
		"ae,united arab emirates;80",
		"af,afghanistan;60",
		"ag,antigua and barbuda;60",
		"ai,anguilla;80",
		"al,albania;56",
		"am,armenia;80",
		"ao,angola;60",
		"aq,antarctica;60",
		"ar,argentina;64",
		"as,american samoa;80",
		"at,austria;60",
		"au,australia;80",
		"aw,aruba;60",
		"ax,ãƒland islands;61",
		"az,azerbaijan;80",
		"ba,bosnia and herzegovina;80",
		"bb,barbados;60",
		"bd,bangladesh;67",
		"be,belgium;46",
		"bf,burkina faso;60",
		"bg,bulgaria;67",
		"bh,bahrain;67",
		"bi,burundi;67",
		"bj,benin;60",
		"bl,Saint Barthélemy;60",
		"bm,bermuda;80",
		"bn,brunei;80",
		"bo,bolivia;59",
		"bq,caribbean netherlands;60",
		"br,brazil;57",
		"bs,bahamas;80",
		"bt,bhutan;60",
		"bv,bouvet island;55",
		"bw,botswana;60",
		"by,belarus;80",
		"bz,belize;67",
		"ca,canada;80",
		"cc,cocos (keeling) islands;80",
		"cd,dr congo;53",
		"cf,central african republic;60",
		"cg,republic of the congo;60",
		"ch,switzerland;40",
		"ci,Côte dIvoire (ivory coast);60",
		"ck,cook islands;80",
		"cl,chile;60",
		"cm,cameroon;60",
		"cn,china;60",
		"co,colombia;60",
		"cr,costa rica;67",
		"cu,cuba;80",
		"cv,cape verde;68",
		"cw,Curaçao;60",
		"cx,christmas island;80",
		"cy,cyprus;60",
		"cz,czechia;60",
		"de,germany;67",
		"dj,djibouti;60",
		"dk,denmark;53",
		"dm,dominica;80",
		"do,dominican republic;60",
		"dz,algeria;60",
		"ec,ecuador;60",
		"ee,estonia;63",
		"eg,egypt;60",
		"eh,western sahara;80",
		"er,eritrea;80",
		"es,spain;60",
		"et,ethiopia;80",
		"fi,finland;65",
		"fj,fiji;80",
		"fk,falkland islands;80",
		"fm,micronesia;76",
		"fo,faroe islands;55",
		"fr,france;60",
		"ga,gabon;53",
		"gb,united kingdom;80",
		"gb-eng,england;67",
		"gb-nir,northern ireland;60",
		"gb-sct,scotland;60",
		"gb-wls,wales;60",
		"gd,grenada;60",
		"ge,georgia;80",
		"gf,french guiana;60",
		"gg,guernsey;60",
		"gh,ghana;60",
		"gi,gibraltar;60",
		"gl,greenland;60",
		"gm,gambia;60",
		"gn,guinea;80",
		"gp,guadeloupe;64",
		"gq,equatorial guinea;75",
		"gr,greece;80",
		"gs,south georgia;67",
		"gt,guatemala;60",
		"gu,guam;80",
		"gw,guinea-bissau;80",
		"gy,guyana;80",
		"hk,hong kong;67",
		"hm,heard island and mcdonald islands;80",
		"hn,honduras;60",
		"hr,croatia;80",
		"ht,haiti;55",
		"hu,hungary;80",
		"id,indonesia;60",
		"ie,ireland;80",
		"il,israel;60",
		"im,isle of man;70",
		"in,india;56",
		"io,british indian ocean territory;60",
		"iq,iraq;67",
		"ir,iran;80",
		"is,iceland;80",
		"it,italy;60",
		"je,jersey;60",
		"jm,jamaica;67",
		"jo,jordan;63",
		"jp,japan;80",
		"ke,kenya;67",
		"kg,kyrgyzstan;60",
		"kh,cambodia;80",
		"ki,kiribati;60",
		"km,comoros;80",
		"kn,saint kitts and nevis;80",
		"kp,north korea;80",
		"kr,south korea;60",
		"kw,kuwait;60",
		"ky,cayman islands;80",
		"kz,kazakhstan;67",
		"la,laos;80",
		"lb,lebanon;76",
		"lc,saint lucia;60",
		"li,liechtenstein;67",
		"lk,sri lanka;67",
		"lr,liberia;80",
		"ls,lesotho;80",
		"lt,lithuania;60",
		"lu,luxembourg;50",
		"lv,latvia;80",
		"ly,libya;80",
		"ma,morocco;60",
		"mc,monaco;60",
		"md,moldova;76",
		"me,montenegro;80",
		"mf,saint martin;60",
		"mg,madagascar;60",
		"mh,marshall islands;80",
		"mk,north macedonia;60",
		"ml,mali;80",
		"mm,myanmar;60",
		"mn,mongolia;60",
		"mo,macau;80",
		"mp,northern mariana islands;60",
		"mq,martinique;60",
		"mr,mauritania;60",
		"ms,montserrat;60",
		"mt,malta;70",
		"mu,mauritius;80",
		"mv,maldives;60",
		"mw,malawi;60",
		"mx,mexico;80",
		"my,malaysia;47",
		"mz,mozambique;80",
		"na,namibia;80",
		"nc,new caledonia;67",
		"ne,niger;60",
		"nf,norfolk island;55",
		"ng,nigeria;33",
		"ni,nicaragua;80",
		"nl,netherlands;80",
		"no,norway;80",
		"np,nepal;80",
		"nr,nauru;60",
		"nu,niue;60",
		"nz,new zealand;60",
		"om,oman;53",
		"pa,panama;80",
		"pe,peru;60",
		"pf,french polynesia;64",
		"pg,papua new guinea;60",
		"ph,philippines;80",
		"pk,pakistan;60",
		"pl,poland;80",
		"pm,saint pierre and miquelon;60",
		"pn,pitcairn islands;64",
		"pr,puerto rico;73",
		"ps,palestine;102",
		"pt,portugal;60",
		"pw,palau;60",
		"py,paraguay;60",
		"qa,qatar;60",
		"re,Réunion;60",
		"ro,romania;60",
		"rs,serbia;80",
		"ru,russia;80",
		"rw,rwanda;80",
		"sa,saudi arabia;64",
		"sb,solomon islands;60",
		"sc,seychelles;80",
		"sd,sudan;80",
		'se,sweden;55',
		"sg,singapore;60",
		"sh,saint helena, ascension and tristan da cunha;60",
		"si,slovenia;53",
		"sj,svalbard and jan mayen;60",
		"sk,slovakia;60",
		"sl,sierra leone;60",
		"sm,san marino;80",
		"sn,senegal;80",
		"so,somalia;71",
		"sr,suriname;60",
		"ss,south sudan;60",
		"st,São Tomé and Príncipe;60",
		"sv,el salvador;80",
		"sx,sint maarten;60",
		"sy,syria;60",
		"sz,eswatini (swaziland);65",
		"tc,turks and caicos islands;60",
		"td,chad;80",
		"tf,french southern and antarctic lands;80",
		"tg,togo;80",
		"th,thailand;60",
		"tj,tajikistan;60",
		"tk,tokelau;80",
		"tl,timor-leste;60",
		"tm,turkmenistan;67",
		"tn,tunisia;80",
		"to,tonga;60",
		"tr,turkey;60",
		"tt,trinidad and tobago;60",
		"tv,tuvalu;60",
		"tw,taiwan;76",
		"tz,tanzania;76",
		"ua,ukraine;60",
		"ug,uganda;80",
		"um,united states minor outlying islands;40",
		"us,united states;60",
		"uy,uruguay;60",
		"uz,uzbekistan;80",
		"va,vatican city (holy see);60",
		"vc,saint vincent and the grenadines;60",
		"ve,venezuela;67",
		"vg,british virgin islands;60",
		"vi,united states virgin islands;80",
		"vn,vietnam;56",
		"vu,vanuatu;60",
		"wf,wallis and futuna;60",
		"ws,samoa;60",
		"xk,kosovo;60",
		"ye,yemen;80",
		"yt,mayotte;67",
		"za,south africa;80",
		"zm,zambia;67",
		"zw,zimbabwe;67"];

	
	static public function main() 
	{
		// get the abbv name of a flag and store it in an array.
		for (i in 0... _total)
		{
			var _temp:Array<String> = _abbv[i].split(",");
			var _temp2:Array<String> = _temp[1].split(";");			
			var _temp3:Int = Std.parseInt(Std.string(_temp2[1]));		
			
			_flags_abbv[i] = _temp[0];
			_flags_abbv_name[i] = _temp2[0].toLowerCase();
			_flags_width[i] = 60;
		}
	}
	
	public static function world_flag_notice():Void
	{
		#if avatars
			// place this text just underneath the last avatar. 
			_text_title_world_flags = new FlxText(0, Avatars._group_sprite[299].y + 100, 0, "World Flags");
		#elseif username_suggestions
			// place this text just underneath the username suggestions buttons.
			_text_title_world_flags = new FlxText(0, Usernames._question_username_suggestions_enabled.y + 100, 0, "World Flags");
		#else
			// place this text just underneath the username inputbox.
			_text_title_world_flags = new FlxText(0, CID3._text_username.y + 75, 0, "World Flags");
		#end
		
		_text_title_world_flags.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_topic_title_text_color());
		_text_title_world_flags.screenCenter(X);
		_text_title_world_flags.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID3._group.add(_text_title_world_flags);		
		
		_world_flag_selected = new FlxText(15, 250, 0, "Selected country flag for player 1.");
		_world_flag_selected.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		_world_flag_selected.fieldWidth = FlxG.width - 90;
		_world_flag_selected.y = _text_title_world_flags.y + 55;
		_world_flag_selected.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID3._group.add(_world_flag_selected);
		
		_image_selected_world_flag = new FlxSprite(15, 300);
		_image_selected_world_flag.loadGraphic("modules/worldFlags/assets/images/" + _flags_abbv[RegCustom._world_flags_number[Reg._tn]].toLowerCase() + ".png");
		_image_selected_world_flag.y = _world_flag_selected.y + 50;
		CID3._group.add(_image_selected_world_flag);		
		
		_world_flags_notice = new FlxText(15, 0, 0, "Getting a world flag by an IP address is not exact. Therefore, please select your country flag from this list. Selecting the white flag, the flag id of ??, will exclude you from the leaderboards.");
		_world_flags_notice.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		_world_flags_notice.fieldWidth = FlxG.width - 90;
		_world_flags_notice.y = _image_selected_world_flag.y + 75;
		_world_flags_notice.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID3._group.add(_world_flags_notice);
	}
	
	public static function world_flag_highlight():Void
	{
		// used to position the world_flagss on rows.
		var _y:Float = 0;
		var _x:Float = 0;
		
		for (i in 0... _total)
		{
			var _image_flags_width = new FlxSprite(0, 0);
			_image_flags_width.makeGraphic(_flags_width[i] + 6, 40 + 6, FlxColor.WHITE);
			_image_flags_width.visible = false;
			
			CID3._group.add(_image_flags_width);
			_group_flag_highlight_sprite.push(_image_flags_width);
			
			// this number refers to how many world_flagss on displayed on a row.
			if (_x > 10)
			{
				_y += 120; // when the amount of world_flagss on a row is reached then..
				_x = 0; // .. set x back to default and increase y so that the world_flagss will display on the next row.
			}
			
			_group_flag_highlight_sprite[i].setPosition(147 + (102 * _x), _world_flags_notice.y + _world_flags_notice.height + 15 + _y - 1);
				
			_x += 1;	
			_group_flag_highlight_sprite[i].color = FlxColor.WHITE;
			_group_flag_highlight_sprite[i].visible = false;
			CID3._group.add(_group_flag_highlight_sprite[i]);
			
		}
	}
	
	public static function world_flags():Void
	{
		// used to position the world_flagss on rows.
		var _y:Float = 0;
		var _x:Float = 0;
		
		_flags_abbv.sort(function(a:String, b:String):Int 
		{
			a = a.toUpperCase();
			b = b.toUpperCase();

			if (a < b) 
			{
				return -1;
			}
			
			else if (a > b) 
			{
				return 1;
			}
			
			else
			{
				return 0;
			}
		});
		
		for (i in 0... _total)
		{			
			_image_world_flags = new FlxSprite(0, 0);
			_image_world_flags.loadGraphic("modules/worldFlags/assets/images/"+ _flags_abbv[i].toLowerCase() +".png");
			_image_world_flags.visible = false;
			_group_flag_sprites.push(_image_world_flags);
			
			CID3._group.add(_image_world_flags);
			
			// this number refers to how many world_flagss on displayed on a row.
			if (_x > 10)
			{
				_y += 120; // when the amount of world_flagss on a row is reached then..
				_x = 0; // .. set x back to default and increase y so that the world_flagss will display on the next row.
			}
			
			_group_flag_sprites[i].setPosition(150 + (102 * _x), _world_flags_notice.y + _world_flags_notice.height + 15 + _y + 2);
			_x += 1;	
			
			_group_flag_sprites[i].visible = true;
			CID3._group.add(_group_flag_sprites[i]);
			
			if (_flags_abbv[i].toLowerCase() == "aa") _group_flag_text[i] = new FlxText(0, 0, 0, "??");
			else
				_group_flag_text[i] = new FlxText(0, 0, 0, _flags_abbv[i]);
			_group_flag_text[i].setPosition(_group_flag_sprites[i].x, _world_flags_notice.y + _world_flags_notice.height + 15 + _y + 55);
			_group_flag_text[i].setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_topic_title_text_color());
			_group_flag_text[i].setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
			CID3._group.add(_group_flag_text[i]);
		}
	}
}

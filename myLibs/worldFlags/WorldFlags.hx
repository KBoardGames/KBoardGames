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

package myLibs.worldFlags;

import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.util.FlxColor;

#if avatars
	import myLibs.avatars.Avatars;
#end

/**
 * @author kboardgames.com
 */
class WorldFlags
{
	static public var _total:Int = 255;
		
	/******************************
	 * image of the selected flag.
	 */
	public static var _image_selected_world_flag:FlxSprite;
	public static var _group_flag_sprites:Array<FlxSprite> = [];
	public static var _group_flag_highlight_sprite:Array<FlxSprite> = [];
	
	public static var _text_title_world_flags:FlxText;
	public static var _world_flags_notice:FlxText;
	public static var _group_flag_text:Array<FlxText> = [];	
	public static var _world_flag_notice:FlxText;
	
	static public var _flags_abbv_name:Array<String> = [for (i in 0... _total) ""];
	
	static public var _flags_width:Array<Int> = [for (i in 0... _total) 0];
	
	static private var _flags_height:Int = 40;
	
	static private var _abbv:haxe.DynamicAccess<Int> = haxe.Json.parse('{
		"aa": "No flag",
		"ad": "Andorra",
		"ae": "United Arab Emirates",
		"af": "Afghanistan",
		"ag": "Antigua and Barbuda",
		"ai": "Anguilla",
		"al": "Albania",
		"am": "Armenia",
		"ao": "Angola",
		"aq": "Antarctica",
		"ar": "Argentina",
		"as": "American Samoa",
		"at": "Austria",
		"au": "Australia",
		"aw": "Aruba",
		"ax": "Ãland Islands",
		"az": "Azerbaijan",
		"ba": "Bosnia and Herzegovina",
		"bb": "Barbados",
		"bd": "Bangladesh",
		"be": "Belgium",
		"bf": "Burkina Faso",
		"bg": "Bulgaria",
		"bh": "Bahrain",
		"bi": "Burundi",
		"bj": "Benin",
		"bl": "Saint BarthÃ©lemy",
		"bm": "Bermuda",
		"bn": "Brunei",
		"bo": "Bolivia",
		"bq": "Caribbean Netherlands",
		"br": "Brazil",
		"bs": "Bahamas",
		"bt": "Bhutan",
		"bv": "Bouvet Island",
		"bw": "Botswana",
		"by": "Belarus",
		"bz": "Belize",
		"ca": "Canada",
		"cc": "Cocos (Keeling) Islands",
		"cd": "DR Congo",
		"cf": "Central African Republic",
		"cg": "Republic of the Congo",
		"ch": "Switzerland",
		"ci": "CÃ´te dIvoire (Ivory Coast)",
		"ck": "Cook Islands",
		"cl": "Chile",
		"cm": "Cameroon",
		"cn": "China",
		"co": "Colombia",
		"cr": "Costa Rica",
		"cu": "Cuba",
		"cv": "Cape Verde",
		"cw": "CuraÃ§ao",
		"cx": "Christmas Island",
		"cy": "Cyprus",
		"cz": "Czechia",
		"de": "Germany",
		"dj": "Djibouti",
		"dk": "Denmark",
		"dm": "Dominica",
		"do": "Dominican Republic",
		"dz": "Algeria",
		"ec": "Ecuador",
		"ee": "Estonia",
		"eg": "Egypt",
		"eh": "Western Sahara",
		"er": "Eritrea",
		"es": "Spain",
		"et": "Ethiopia",
		"fi": "Finland",
		"fj": "Fiji",
		"fk": "Falkland Islands",
		"fm": "Micronesia",
		"fo": "Faroe Islands",
		"fr": "France",
		"ga": "Gabon",
		"gb": "United Kingdom",
		"gb-eng": "England",
		"gb-nir": "Northern Ireland",
		"gb-sct": "Scotland",
		"gb-wls": "Wales",
		"gd": "Grenada",
		"ge": "Georgia",
		"gf": "French Guiana",
		"gg": "Guernsey",
		"gh": "Ghana",
		"gi": "Gibraltar",
		"gl": "Greenland",
		"gm": "Gambia",
		"gn": "Guinea",
		"gp": "Guadeloupe",
		"gq": "Equatorial Guinea",
		"gr": "Greece",
		"gs": "South Georgia",
		"gt": "Guatemala",
		"gu": "Guam",
		"gw": "Guinea-Bissau",
		"gy": "Guyana",
		"hk": "Hong Kong",
		"hm": "Heard Island and McDonald Islands",
		"hn": "Honduras",
		"hr": "Croatia",
		"ht": "Haiti",
		"hu": "Hungary",
		"id": "Indonesia",
		"ie": "Ireland",
		"il": "Israel",
		"im": "Isle of Man",
		"in": "India",
		"io": "British Indian Ocean Territory",
		"iq": "Iraq",
		"ir": "Iran",
		"is": "Iceland",
		"it": "Italy",
		"je": "Jersey",
		"jm": "Jamaica",
		"jo": "Jordan",
		"jp": "Japan",
		"ke": "Kenya",
		"kg": "Kyrgyzstan",
		"kh": "Cambodia",
		"ki": "Kiribati",
		"km": "Comoros",
		"kn": "Saint Kitts and Nevis",
		"kp": "North Korea",
		"kr": "South Korea",
		"kw": "Kuwait",
		"ky": "Cayman Islands",
		"kz": "Kazakhstan",
		"la": "Laos",
		"lb": "Lebanon",
		"lc": "Saint Lucia",
		"li": "Liechtenstein",
		"lk": "Sri Lanka",
		"lr": "Liberia",
		"ls": "Lesotho",
		"lt": "Lithuania",
		"lu": "Luxembourg",
		"lv": "Latvia",
		"ly": "Libya",
		"ma": "Morocco",
		"mc": "Monaco",
		"md": "Moldova",
		"me": "Montenegro",
		"mf": "Saint Martin",
		"mg": "Madagascar",
		"mh": "Marshall Islands",
		"mk": "North Macedonia",
		"ml": "Mali",
		"mm": "Myanmar",
		"mn": "Mongolia",
		"mo": "Macau",
		"mp": "Northern Mariana Islands",
		"mq": "Martinique",
		"mr": "Mauritania",
		"ms": "Montserrat",
		"mt": "Malta",
		"mu": "Mauritius",
		"mv": "Maldives",
		"mw": "Malawi",
		"mx": "Mexico",
		"my": "Malaysia",
		"mz": "Mozambique",
		"na": "Namibia",
		"nc": "New Caledonia",
		"ne": "Niger",
		"nf": "Norfolk Island",
		"ng": "Nigeria",
		"ni": "Nicaragua",
		"nl": "Netherlands",
		"no": "Norway",
		"np": "Nepal",
		"nr": "Nauru",
		"nu": "Niue",
		"nz": "New Zealand",
		"om": "Oman",
		"pa": "Panama",
		"pe": "Peru",
		"pf": "French Polynesia",
		"pg": "Papua New Guinea",
		"ph": "Philippines",
		"pk": "Pakistan",
		"pl": "Poland",
		"pm": "Saint Pierre and Miquelon",
		"pn": "Pitcairn Islands",
		"pr": "Puerto Rico",
		"ps": "Palestine",
		"pt": "Portugal",
		"pw": "Palau",
		"py": "Paraguay",
		"qa": "Qatar",
		"re": "RÃ©union",
		"ro": "Romania",
		"rs": "Serbia",
		"ru": "Russia",
		"rw": "Rwanda",
		"sa": "Saudi Arabia",
		"sb": "Solomon Islands",
		"sc": "Seychelles",
		"sd": "Sudan",
		"se": "Sweden",
		"sg": "Singapore",
		"sh": "Saint Helena, Ascension and Tristan da Cunha",
		"si": "Slovenia",
		"sj": "Svalbard and Jan Mayen",
		"sk": "Slovakia",
		"sl": "Sierra Leone",
		"sm": "San Marino",
		"sn": "Senegal",
		"so": "Somalia",
		"sr": "Suriname",
		"ss": "South Sudan",
		"st": "SÃ£o TomÃ© and PrÃ­ncipe",
		"sv": "El Salvador",
		"sx": "Sint Maarten",
		"sy": "Syria",
		"sz": "Eswatini (Swaziland)",
		"tc": "Turks and Caicos Islands",
		"td": "Chad",
		"tf": "French Southern and Antarctic Lands",
		"tg": "Togo",
		"th": "Thailand",
		"tj": "Tajikistan",
		"tk": "Tokelau",
		"tl": "Timor-Leste",
		"tm": "Turkmenistan",
		"tn": "Tunisia",
		"to": "Tonga",
		"tr": "Turkey",
		"tt": "Trinidad and Tobago",
		"tv": "Tuvalu",
		"tw": "Taiwan",
		"tz": "Tanzania",
		"ua": "Ukraine",
		"ug": "Uganda",
		"um": "United States Minor Outlying Islands",
		"us": "United States",
		"uy": "Uruguay",
		"uz": "Uzbekistan",
		"va": "Vatican City (Holy See)",
		"vc": "Saint Vincent and the Grenadines",
		"ve": "Venezuela",
		"vg": "British Virgin Islands",
		"vi": "United States Virgin Islands",
		"vn": "Vietnam",
		"vu": "Vanuatu",
		"wf": "Wallis and Futuna",
		"ws": "Samoa",
		"xk": "Kosovo",
		"ye": "Yemen",
		"yt": "Mayotte",
		"za": "South Africa",
		"zm": "Zambia",
		"zw": "Zimbabwe"
	}');
	
	static private var _width:haxe.DynamicAccess<Int> = haxe.Json.parse(
	'{
		"aa": "64",
		"ad": "57",
		"ae": "80",
		"af": "60",
		"ag": "60",
		"ai": "80",
		"al": "56",
		"am": "80",
		"ao": "60",
		"aq": "60",
		"ar": "64",
		"as": "80",
		"at": "60",
		"au": "80",
		"aw": "60",
		"ax": "61",
		"az": "80",
		"ba": "80",
		"bb": "60",
		"bd": "67",
		"be": "46",
		"bf": "60",
		"bg": "67",
		"bh": "67",
		"bi": "67",
		"bj": "60",
		"bl": "60",
		"bm": "80",
		"bn": "80",
		"bo": "59",
		"bq": "60",
		"br": "57",
		"bs": "80",
		"bt": "60",
		"bv": "55",
		"bw": "60",
		"by": "80",
		"bz": "67",
		"ca": "80",
		"cc": "80",
		"cd": "53",
		"cf": "60",
		"cg": "60",
		"ch": "40",
		"ci": "60",
		"ck": "80",
		"cl": "60",
		"cm": "60",
		"cn": "60",
		"co": "60",
		"cr": "67",
		"cu": "80",
		"cv": "68",
		"cw": "60",
		"cx": "80",
		"cy": "60",
		"cz": "60",
		"de": "67",
		"dj": "60",
		"dk": "53",
		"dm": "80",
		"do": "60",
		"dz": "60",
		"ec": "60",
		"ee": "63",
		"eg": "60",
		"eh": "80",
		"er": "80",
		"es": "60",
		"et": "80",
		"fi": "65",
		"fj": "80",
		"fk": "80",
		"fm": "76",
		"fo": "55",
		"fr": "60",
		"ga": "53",
		"gb": "80",
		"gd": "67",
		"ge": "60",
		"gf": "60",
		"gg": "60",
		"gh": "60",
		"gi": "80",
		"gl": "60",
		"gm": "60",
		"gn": "60",
		"gp": "60",
		"gq": "60",
		"gr": "60",
		"gs": "80",
		"gt": "64",
		"gu": "75",
		"gw": "80",
		"gy": "67",
		"hk": "60",
		"hm": "80",
		"hn": "80",
		"hr": "80",
		"ht": "67",
		"hu": "80",
		"id": "60",
		"ie": "80",
		"il": "55",
		"im": "80",
		"in": "60",
		"io": "80",
		"iq": "60",
		"ir": "70",
		"is": "56",
		"it": "60",
		"je": "67",
		"jm": "80",
		"jo": "80",
		"jp": "60",
		"ke": "60",
		"kg": "67",
		"kh": "63",
		"ki": "80",
		"km": "67",
		"kn": "60",
		"kp": "80",
		"kr": "60",
		"kw": "80",
		"ky": "80",
		"kz": "80",
		"la": "60",
		"lb": "60",
		"lc": "80",
		"li": "67",
		"lk": "80",
		"lr": "76",
		"ls": "60",
		"lt": "67",
		"lu": "67",
		"lv": "80",
		"ly": "80",
		"ma": "60",
		"mc": "50",
		"md": "80",
		"me": "80",
		"mf": "60",
		"mg": "60",
		"mh": "76",
		"mk": "80",
		"ml": "60",
		"mm": "60",
		"mn": "80",
		"mo": "60",
		"mp": "80",
		"mq": "60",
		"mr": "60",
		"ms": "80",
		"mt": "60",
		"mu": "60",
		"mv": "60",
		"mw": "60",
		"mx": "70",
		"my": "80",
		"mz": "60",
		"na": "60",
		"nc": "80",
		"ne": "47",
		"nf": "80",
		"ng": "80",
		"ni": "67",
		"nl": "60",
		"no": "55",
		"np": "33",
		"nr": "80",
		"nu": "80",
		"nz": "80",
		"om": "80",
		"pa": "60",
		"pe": "60",
		"pf": "60",
		"pg": "53",
		"ph": "80",
		"pk": "60",
		"pl": "64",
		"pm": "60",
		"pn": "80",
		"pr": "60",
		"ps": "80",
		"pt": "60",
		"pw": "64",
		"py": "73",
		"qa": "102",
		"re": "60",
		"ro": "60",
		"rs": "60",
		"ru": "60",
		"rw": "60",
		"sa": "60",
		"sb": "80",
		"sc": "80",
		"sd": "80",
		"se": "64",
		"sg": "60",
		"sh": "80",
		"si": "80",
		"sj": "55",
		"sk": "60",
		"sl": "60",
		"sm": "53",
		"sn": "60",
		"so": "60",
		"sr": "60",
		"ss": "80",
		"st": "80",
		"sv": "71",
		"sx": "60",
		"sy": "60",
		"sz": "60",
		"tc": "80",
		"td": "60",
		"tf": "60",
		"tg": "65",
		"th": "60",
		"tj": "80",
		"tk": "80",
		"tl": "80",
		"tm": "60",
		"tn": "60",
		"to": "80",
		"tr": "60",
		"tt": "67",
		"tv": "80",
		"tw": "60",
		"tz": "60",
		"ua": "60",
		"ug": "60",
		"um": "76",
		"us": "76",
		"uy": "60",
		"uz": "80",
		"va": "40",
		"vc": "60",
		"ve": "60",
		"vg": "80",
		"vi": "60",
		"vn": "60",
		"vu": "67",
		"wf": "60",
		"ws": "80",
		"xk": "56",
		"ye": "60",
		"yt": "60",
		"za": "60",
		"zm": "60",
		"zw": "80",
		"gb-eng": "67",
		"gb-nir": "80",
		"gb-sct": "67",
		"gb-wls": "67"
		
	}');
	
	static public function main() 
	{
		var _count = - 1;
		
		// get the abbv name of a flag and store it in an array.
		for (key => value in _abbv)
		{
			_count += 1; 
			_flags_abbv_name[_count] = key;
			_flags_abbv_name[_count] = _flags_abbv_name[_count].toUpperCase();
		}
		
		_count = -1;
		
		// get the width of a flag and store it in an array. the height (_height) of a flag is always 40 px.
		for (key => value in _width)
		{
			_count += 1; 
			_flags_width[_count] = Std.parseInt(Std.string(value));
		}
		
		/*
		var _path = StringTools.replace(Path.directory(Sys.programPath()), "\\", "/");
		
		
		var output:FileOutput = sys.io.File.append(_path + "/2.txt", false);
		
		for (key => value in _abbv)
		{
			var _a = new FlxSprite(0, 0);
			_a.loadGraphic("myLibs/worldFlags/assets/images/"+ key +".png");	
			
			output.writeString('"'+key+'": "'+ _a.width + '",\r' );		
		}
		
		output.close();*/
	}
	
	public static function world_flag_notice():Void
	{
		#if avatars
			// place this text just underneath the last avatar. 
			_text_title_world_flags = new FlxText(0, Avatars._group_sprite[299].y + 100, 0, "World Flags");
		#elseif username_suggestions
			// place this text just underneath the username suggestions buttons.
			_text_title_world_flags = new FlxText(0, CID3._question_username_suggestions_enabled.y + 100, 0, "World Flags");
		#else
			// place this text just underneath the username inputbox.
			_text_title_world_flags = new FlxText(0, CID3._text_username.y + 75, 0, "World Flags");
		#end
		
		_text_title_world_flags.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_topic_title_text_color());
		_text_title_world_flags.screenCenter(X);
		_text_title_world_flags.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID3._group.add(_text_title_world_flags);		
		
		_world_flag_notice = new FlxText(15, 250, 0, "Your selected country flag.");
		_world_flag_notice.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		_world_flag_notice.fieldWidth = FlxG.width - 90;
		_world_flag_notice.y = _text_title_world_flags.y + 55;
		_world_flag_notice.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID3._group.add(_world_flag_notice);
		
		_image_selected_world_flag = new FlxSprite(15, 300);
		_image_selected_world_flag.loadGraphic("myLibs/worldFlags/assets/images/" + _flags_abbv_name[RegCustom._world_flags_number[Reg._tn]].toLowerCase() + ".png");
		_image_selected_world_flag.y = _world_flag_notice.y + 50;
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
			var _image_world_flags = new FlxSprite(0, 0);
			_image_world_flags.makeGraphic(_flags_width[i] + 6, 40 + 6, FlxColor.WHITE);
			_image_world_flags.visible = false;
			
			CID3._group.add(_image_world_flags);
			
			_group_flag_highlight_sprite.push(_image_world_flags);
			
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
		
		_flags_abbv_name.sort(function(a:String, b:String):Int 
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
			var _image_world_flags = new FlxSprite(0, 0);
			_image_world_flags.loadGraphic("myLibs/worldFlags/assets/images/"+ _flags_abbv_name[i].toLowerCase() +".png");
			_image_world_flags.visible = false;
			
			CID3._group.add(_image_world_flags);
			
			_group_flag_sprites.push(_image_world_flags);
			
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
			
			if (_flags_abbv_name[i].toLowerCase() == "aa") _group_flag_text[i] = new FlxText(0, 0, 0, "??");
			else
				_group_flag_text[i] = new FlxText(0, 0, 0, _flags_abbv_name[i]);
			_group_flag_text[i].setPosition(_group_flag_sprites[i].x, _world_flags_notice.y + _world_flags_notice.height + 15 + _y + 55);
			_group_flag_text[i].setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_topic_title_text_color());
			_group_flag_text[i].setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
			CID3._group.add(_group_flag_text[i]);
		}
	}
}

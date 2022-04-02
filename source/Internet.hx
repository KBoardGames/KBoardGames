/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

/**
 * ...
 * @author kboardgames.com
 */
class Internet extends FlxGroup
{
	public static var _bool:Bool = false;
	public static var _http:Http;
	
	public static function webVersionFileExist():Void
	{
		_http = new haxe.Http("https://" + Reg._websiteHomeUrl + "/" + "files/versionClient.txt");
		
		var _str:String = "Failed to get client's version number from a file at " + Reg._websiteNameTitle + " website. ";
		Reg._doOnce = false;
		
		_http.onData = function (_data:String) 
		{
			if (_data.substr(0, 1) == "<") 
			{
				Reg._doOnce = true;
				
				_data = "";				
				Reg2._messageFileExists = _str + "Reason: File does not exist.";
			}
			
			else 
			{
				// version of client is found because file exists at website.
				Reg._doOnce = false;
				Reg2._messageFileExists = _data;
			}
		}

		_http.onError = function (_error)
		{			
			Reg._doOnce = true;			
			Reg2._messageFileExists = _str + "Reason: File does not exist.";
		}
		
		_http.request();
		
		//if (_bool == false) return _data;
		
	}
	
	public static function serverFileExist():Bool
	{
		_http = new haxe.Http("https://" + Reg._websiteHomeUrl + "/server/" + "server");
		
		var _str:String = "Server is offline. Try again later.";
		var _bool:Bool = false;
		
		_http.onData = function (_data:String) 
		{
			if (_data.substr(0, 1) == "<") 
			{
				Reg._doOnce = true;
				
				_data = "";				
				Reg2._messageFileExists = _str;
				_bool = false;
			}
			
			else 
			{
				Reg._doOnce = false;
				Reg2._messageFileExists = _data;
				_bool = true;
			}
		}

		_http.onError = function (_error)
		{			
			Reg2._messageFileExists = _str;
			_bool = false;
		}
		
		_http.request();
		
		return _bool;
		
	}
	
	/******************************
	 * from menuState, the IP address selected is sent here as _str.
	 */
	public static function isServerDomainPaid(_str:String):Bool
	{
		// we want the IP address that comes after http...
		if (_str.substr(0, 7) == "http://")
			_str = _str.substr(7, _str.length);
			
		if (_str.substr(0, 8) == "https://")
			_str = _str.substr(8, _str.length);	
		
		// check to see if this is a paid IP address. here we search the MySQL database table "users" with this IP address to see if the data found has a value of 1 which is a paid account.
		_http = new haxe.Http(Reg._websiteHomeUrl + "/server/" + "serverDomain.php");
		
		// in serverDomain.php the serverDomain parameter will have the value of _str.
		_http.setParameter( "serverDomain", _str);
				
		var _bool = false;
		
		_http.onData = function (_data:String) 
		{
			// if no data
			if (_data.length <= 1) Reg._isThisServerPaidMember = false; 
			
			else 
			{
				Reg._isThisServerPaidMember = true;
				_bool = true;
			}
		}		

		_http.onError = function (_error)
		{
			Reg._cannotConnectToServer = false;
		}
		
		_http.request();
		
		return _bool;
	}
	
	
	public static function isWebsiteAvailable(?callback:Bool->Void):Bool
	{
		var result:Bool;
		
		// any data could be in this json file. If this file is found then user is connected to the internet. This method is 10 times faster than a php request.
		_http = new haxe.Http("https://" + Reg._websiteHomeUrl + "/server/online.json");

		_http.onData = function (data:String)
		  result = true;
		
		_http.onError = function (error)
		  result = false;
		
		_http.request();

		if (result == false) return false;
		else return true;

	}
		
	public static function getAllEvents():Void
	{
		try
		{
			_http = new haxe.Http("https://" + Reg._websiteHomeUrl + "/server/" + "getAllEvents.php");
		
			// in getAllEvents.php the getAllEvents parameter will have the value of _str.
			_http.setParameter("getAllEventNames", "names");
			
			_http.onData = function(_data:String) 
			{
				// if there is data
				if (_data.length > 1) 
				{
					// hold event data.
					var _eventData:Array<String>  = 
		[for (p in 0...40) "" ];				
					 
					// at getAllEvents.php, a block of code gets all event data and puts that data in a string. for each MySQL row, at MySQL, each event has name, description, months, days and colour. that data is written to a string then the word "END" is placed at that string so that we know all data for that event ends there.
					
					// the string is split at the word "END" so now _eventSeperate hold all data for just 1 event at each of its elements. so, _eventSeperate[0] var holds name, description, months, days and colour for that event.
					var _eventSeperate:Array<String> = _data.split("END;");
					
					for (i in 0..._eventSeperate.length)
					{
						// the data is split one more time so that now we have the data for only event var i.
						_eventData = _eventSeperate[i].split(";");
								
						Reg2._eventName[i] = _eventData[0];
						Reg2._eventDescription[i] = _eventData[2];
						
						Reg2._eventMonths[i][0] = Std.parseInt(_eventData[4]);
						Reg2._eventMonths[i][1] = Std.parseInt(_eventData[5]);
						Reg2._eventMonths[i][2] = Std.parseInt(_eventData[6]);
						Reg2._eventMonths[i][3] = Std.parseInt(_eventData[7]);
						Reg2._eventMonths[i][4] = Std.parseInt(_eventData[8]);
						Reg2._eventMonths[i][5] = Std.parseInt(_eventData[9]);
						Reg2._eventMonths[i][6] = Std.parseInt(_eventData[10]);
						Reg2._eventMonths[i][7] = Std.parseInt(_eventData[11]);
						Reg2._eventMonths[i][8] = Std.parseInt(_eventData[12]);
						Reg2._eventMonths[i][9] = Std.parseInt(_eventData[13]);
						Reg2._eventMonths[i][10] = Std.parseInt(_eventData[14]);
						Reg2._eventMonths[i][11] = Std.parseInt(_eventData[15]);
						
						Reg2._eventDays[i][0] = Std.parseInt(_eventData[17]);
						Reg2._eventDays[i][1] = Std.parseInt(_eventData[18]);
						Reg2._eventDays[i][2] = Std.parseInt(_eventData[19]);
						Reg2._eventDays[i][3] = Std.parseInt(_eventData[20]);
						Reg2._eventDays[i][4] = Std.parseInt(_eventData[21]);
						Reg2._eventDays[i][5] = Std.parseInt(_eventData[22]);
						Reg2._eventDays[i][6] = Std.parseInt(_eventData[23]);
						Reg2._eventDays[i][7] = Std.parseInt(_eventData[24]);
						Reg2._eventDays[i][8] = Std.parseInt(_eventData[25]);
						Reg2._eventDays[i][9] = Std.parseInt(_eventData[26]);
						Reg2._eventDays[i][10] = Std.parseInt(_eventData[27]);
						Reg2._eventDays[i][11] = Std.parseInt(_eventData[28]);
						Reg2._eventDays[i][12] = Std.parseInt(_eventData[29]);
						Reg2._eventDays[i][13] = Std.parseInt(_eventData[30]);
						Reg2._eventDays[i][14] = Std.parseInt(_eventData[31]);
						Reg2._eventDays[i][15] = Std.parseInt(_eventData[32]);
						Reg2._eventDays[i][16] = Std.parseInt(_eventData[33]);
						Reg2._eventDays[i][17] = Std.parseInt(_eventData[34]);
						Reg2._eventDays[i][18] = Std.parseInt(_eventData[35]);
						Reg2._eventDays[i][19] = Std.parseInt(_eventData[36]);
						Reg2._eventDays[i][20] = Std.parseInt(_eventData[37]);
						Reg2._eventDays[i][21] = Std.parseInt(_eventData[38]);
						Reg2._eventDays[i][22] = Std.parseInt(_eventData[39]);
						Reg2._eventDays[i][23] = Std.parseInt(_eventData[40]);
						Reg2._eventDays[i][24] = Std.parseInt(_eventData[41]);
						Reg2._eventDays[i][25] = Std.parseInt(_eventData[42]);
						Reg2._eventDays[i][26] = Std.parseInt(_eventData[43]);
						Reg2._eventDays[i][27] = Std.parseInt(_eventData[44]);
						
						Reg2._eventBackgroundColour[i] = Std.parseInt(_eventData[46]);
					}
					
				}
			}		

			_http.onError = function (_error)
			{
				trace('error: $_error');
			}
			
			_http.request(false);
		} 
		catch (e:Error) 
		{
			trace(e);
		}	
		
	}
	
	public static function getHostname():Void
	{
		_http = new haxe.Http("https://" + Reg._websiteHomeUrl + "/server/getHostname.php?id=" + RegTypedef._dataAccount._ip);
		
		_http.onData = function (data:String) 
		{
			RegTypedef._dataAccount._hostname = data;
			if (Reg._same_device_login_more_than_once == false) isHostnameOnline();
		}

		_http.onError = function (error) 
		{
			trace('error: $error');
		
			Reg._ip_message = true;				
			Reg._client_socket_is_connected = false;
			PlayState._websocket.close();
			
			FlxG.switchState(new MenuState());
			return;
		}

		_http.request();
	}
	
	public static function isHostnameOnline():Void
	{
		var _hostname = RegTypedef._dataAccount._hostname;
		_hostname = StringTools.replace(RegTypedef._dataAccount._hostname, " ", "%20");
		
		_http = new haxe.Http("https://" + Reg._websiteHomeUrl + "/server/isHostnameOnline.php?token=H77Wox53m7syw6Ng&hostname=" + _hostname);
		
		_http.onData = function (data:String) 
		{
			if (data == RegTypedef._dataAccount._hostname) 
			{
				Reg._alreadyOnlineHost = true;				
				FlxG.switchState(new MenuState());
				return;
			}
		}

		_http.onError = function (error) 
		{
			trace('error: $error');
			
			Reg._alreadyOnlineHost = true;				
			FlxG.switchState(new MenuState());
			return;
			
		}

		_http.request();
	}
	
	public static function isUsernameOnline():Void
	{
		var _username = RegTypedef._dataAccount._username;
		_username = StringTools.replace(RegTypedef._dataAccount._username, " ", "%20");
		
		_http = new haxe.Http("https://" + Reg._websiteHomeUrl + "/server/isUsernameOnline.php?token=H77Wox53m7syw6Ng&user=" + _username);
		
		_http.onData = function (data:String) 
		{
			if (data != "nobody") 
			{
				Reg._alreadyOnlineUser = true;				
				FlxG.switchState(new MenuState());
				return;
			}
			
			else if (data == "nobody") 
			{
				Reg._can_join_server = true;	
			}
		}

		_http.onError = function (error) 
		{
			trace('error: $error');
			
			Reg._alreadyOnlineUser = true;				
			FlxG.switchState(new MenuState());
			return;
		}

		_http.request();
	}
	
	// gets queue data. should user wait in queue until the user with access enters the lobby from a timeout or when that user clicks any key. only then can the other player with a value here of 1 can go to the front door.
	public static function front_door_queue():Void
	{
		var _username = RegTypedef._dataAccount._username;
		_username = StringTools.replace(RegTypedef._dataAccount._username, " ", "%20");
		
		_http = new haxe.Http("https://" + Reg._websiteHomeUrl + "/server/frontDoorqueue.php?token=J39BsrUDd94mWd4Jd341&q=" + _username);
		
		_http.onData = function (data:String) 
		{
			PlayState._front_door_queue = Std.parseInt(data);
			
			if (data == null) PlayState._front_door_queue = 0;
					
			if (data == ""
			||	data.substr(0, 21) == "<!DOCTYPE HTML PUBLIC")
			{
				Reg._front_door_queue_data = true;
				FlxG.switchState(new MenuState());
				return;
			}
		}

		_http.onError = function (error) 
		{
			trace('error: $error');
			Reg._front_door_queue_data = true;
			FlxG.switchState(new MenuState());
			return;
		}

		_http.request();
	}
	
	// gets ip from a website file. if ip is not found then user cannot login. therefore, user must first login to the website before this works.
	// alternatively, you can use this website.
	// http://checkip.dyndns.com
	public static function getIP():Void
	{
		_http = new haxe.Http("http://ipecho.net/plain");
		
		_http.onData = function (data:String) 
		{
			RegTypedef._dataAccount._ip = data;
		}
		
		_http.onError = function (error) 
		{
			trace('error: $error');
			
			Reg._ip_message = true;
			FlxG.switchState(new MenuState());
			return;
		}

		_http.request();
	}
	
	/******************************
	 * 
	 * @param	_url	user Reg._websiteHomeUrl var.
	 * @param	_type	1:self. 2:blank new tab.
	 * @return
	 */
	public static function URLgoto(_url:String, _type:Int):Dynamic
	{
		var _str:String = "_self";
		
		if (_type == 1) _str = "_self";
		if (_type == 2) _str = "_blank";		 
		
		Lib.getURL( new URLRequest (_url), _str);   
		
		return _type;
	}
	
	override public function destroy():Void
	{
		
		super.destroy();
	}
}
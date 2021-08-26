package vendor.mphx.connection ;

import haxe.io.Input;
import vendor.mphx.serialization.ISerializer;
import vendor.mphx.server.IServer;
import vendor.mphx.server.room.Room;
import vendor.mphx.utils.event.impl.ServerEventManager;

interface IConnection
{
	public function clone() : IConnection;
	public function send (event:String,?data:Dynamic):Bool;
	public function onConnect(cnx:NetSock):Void;
	public function onAccept(cnx:NetSock):Void;
	public function dataReceived(input:Input):Void;
	public function loseConnection(?reason:String):Void;
	public function putInRoom (newRoom:vendor.mphx.server.room.Room):Bool;
	public function getContext():NetSock;
	public function isConnected():Bool;
	public function configure(_events : ServerEventManager, _server:IServer, _serializer : ISerializer = null): Void;
	public var room:Room;
	public var data:Dynamic;
}

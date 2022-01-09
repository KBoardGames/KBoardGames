package vendor.ws;

#if java

typedef SocketImpl = vendor.ws.java.NioSocket;

#elseif cs

typedef SocketImpl = vendor.ws.cs.NonBlockingSocket;

#elseif nodejs

typedef SocketImpl = vendor.ws.nodejs.NodeSocket;

#else

typedef SocketImpl = sys.net.Socket;

#end
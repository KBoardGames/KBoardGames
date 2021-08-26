package vendor.mphx.client;

#if js
import vendor.mphx.client.impl.WebsocketClient;
typedef Client = WebsocketClient;
#elseif html5
import vendor.mphx.client.impl.WebsocketClient;
typedef Client = WebsocketClient;
#elseif flash
import vendor.mphx.client.impl.TcpFlashClient;
typedef Client = TcpFlashClient;
#else
import vendor.mphx.client.impl.TcpClient;
typedef Client = TcpClient;
#end

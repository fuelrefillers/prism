import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketService {
  static final SocketService _instance = SocketService._internal();
  late io.Socket socket;

  factory SocketService() {
    return _instance;
  }

  SocketService._internal();

  void connectToServer() {
    socket = io.io('http://15.20.17.222:3000', <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
  }
}

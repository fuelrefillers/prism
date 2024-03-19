import 'package:flutter/material.dart';
import 'package:frontend/services/ip.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketService with ChangeNotifier {
  static final SocketService _instance = SocketService._internal();
  late io.Socket socket;

  factory SocketService() {
    return _instance;
  }

  SocketService._internal();

  void connectToServer() {
    socket = io.io('${ip}', <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": true,
    });
    socket.connect();
  }

  void emitSignInEvent(String facultyId) {
    socket.emit("signin", facultyId);
  }

  void sendMessage(String message, String sourceId, String targetId) {
    socket.emit("message",
        {"message": message, "sourceId": sourceId, "targetId": targetId});
  }
}

import 'package:flutter/material.dart';
import 'package:frontend/chatting/UI/widgets/Chat_card.dart';
import 'package:frontend/chatting/models/ChatModel.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatPageScreen extends StatefulWidget {
  const ChatPageScreen({super.key});

  @override
  State<ChatPageScreen> createState() {
    return _ChatPageScreen();
  }
}

class _ChatPageScreen extends State<ChatPageScreen> {
  late IO.Socket socket;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // connect();
  }

  // void connect() {
  //   // MessageModel messageModel = MessageModel(sourceId: widget.sourceChat.id.toString(),targetId: );
  //   socket = IO.io("http://192.168.29.194:3000", <String, dynamic>{
  //     "transports": ["websocket"],
  //     "autoConnect": false,
  //   });
  //   socket.connect();
  //   socket.emit("signin", "21J41A05R5");
  //   socket.emit("signin", {
  //     "message": "hiiiiiiiiiiiiii",
  //     "sourceId": "21J41A05R1",
  //     "targetId": "21J41A05R5"
  //   });

  //   socket.onConnect((data) {
  //     print("Connected");
  //     socket.on("message", (msg) {
  //       print(msg);
  //     });
  //   });
  //   // print(socket.connected);
  // }

  @override
  Widget build(BuildContext context) {
    List<ChatModel> data = [
      ChatModel(
          Id: "21J41A05R5",
          Name: "SAI THARAK REDDY VEERAVELLY",
          Department: "CSE",
          optional: "D"),
      ChatModel(
          Id: "21J41A05R1",
          Name: "Sravana Jyothi",
          Department: "CSE",
          optional: "D"),
    ];
    return Scaffold(
      body: ListView.builder(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          itemCount: data.length,
          itemBuilder: (contetxt, index) => ChartCard(data: data[index])),
    );
  }
}

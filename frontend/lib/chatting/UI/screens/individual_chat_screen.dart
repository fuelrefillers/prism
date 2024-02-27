import 'dart:convert';
import 'package:frontend/chatting/messagesStore.dart';
import 'package:frontend/chatting/socketio.dart';
import 'package:frontend/providers.dart/user_provider.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:frontend/chatting/UI/widgets/own_message_card.dart';
import 'package:frontend/chatting/UI/widgets/reply_card.dart';
import 'package:frontend/chatting/models/ChatModel.dart';
import 'package:frontend/chatting/models/MessagesModels.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class IndividualPage extends StatefulWidget {
  IndividualPage({Key? key, required this.chatModel, required this.current})
      : super(key: key);

  final ChatModel chatModel;
  final String current;

  @override
  _IndividualPageState createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  bool show = false;
  FocusNode focusNode = FocusNode();
  bool sendButton = false;
  List<MessageModel> messages = [];
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  late io.Socket socket;
  final messageStore = MessageStore();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
    // Initialize socket in initState
    socket = SocketService().socket;
    // Attach the event listener
    socket.on("message", _handleIncomingMessage);
    _initMessages();
  }

  Future<void> _initMessages() async {
    await messageStore.initPrefs();
    setState(() {
      messages = messageStore.getMessagesForId(widget.chatModel.Id);
    });
  }

  void _handleIncomingMessage(msg) {
    if (mounted) {
      print(msg["message"]);
      setMessage("destination", msg["message"]);
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void sendMessage(String message, String sourceId, String targetId) {
    setMessage("source", message);
    socket.emit("message",
        {"message": message, "sourceId": widget.current, "targetId": targetId});
  }

  void setMessage(String type, String message) {
    MessageModel messageModel = MessageModel(
      type: type,
      message: message,
      time: DateTime.now().toString().substring(10, 16),
    );
    setState(() {
      messages.add(messageModel);
    });
    messageStore.saveMessagesForId(widget.chatModel.Id, messages);

    print(messages);
  }

  @override
  void dispose() {
    // Remove the event listener in dispose
    socket.off("message", _handleIncomingMessage);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          leadingWidth: 70,
          titleSpacing: 0,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_back,
                  size: 24,
                ),
              ],
            ),
          ),
          title: InkWell(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.all(6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.chatModel.Id,
                    style: TextStyle(
                      fontSize: 18.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "last seen today at 12:05",
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  )
                ],
              ),
            ),
          ),
          actions: [
            IconButton(icon: Icon(Icons.videocam), onPressed: () {}),
            IconButton(icon: Icon(Icons.call), onPressed: () {}),
            // PopupMenuButton<String>(
            //   padding: EdgeInsets.all(0),
            //   onSelected: (value) {
            //     print(value);
            //   },
            // ),
          ],
        ),
      ),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: PopScope(
          child: Column(
            children: [
              Expanded(
                // height: MediaQuery.of(context).size.height - 150,
                child: ListView.builder(
                  shrinkWrap: true,
                  controller: _scrollController,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    if (index == messages.length) {
                      return Container(
                        height: 70,
                      );
                    }
                    if (messages[index].type == "source") {
                      return OwnMessageCard(
                        message: messages[index].message,
                        time: messages[index].time,
                      );
                    } else {
                      return ReplyCard(
                        message: messages[index].message,
                        time: messages[index].time,
                      );
                    }
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 60,
                            child: Card(
                              margin:
                                  EdgeInsets.only(left: 2, right: 2, bottom: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: TextFormField(
                                controller: _controller,
                                focusNode: focusNode,
                                textAlignVertical: TextAlignVertical.center,
                                keyboardType: TextInputType.multiline,
                                maxLines: 5,
                                minLines: 1,
                                onChanged: (value) {
                                  if (value.length > 0) {
                                    setState(() {
                                      sendButton = true;
                                    });
                                  } else {
                                    setState(() {
                                      sendButton = false;
                                    });
                                  }
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Type a message",
                                  hintStyle: TextStyle(color: Colors.grey),

                                  // suffixIcon: Row(
                                  //   mainAxisSize: MainAxisSize.min,
                                  //   children: [
                                  //     IconButton(
                                  //       icon: Icon(Icons.attach_file),
                                  //       onPressed: () {},
                                  //     ),
                                  //     IconButton(
                                  //       icon: Icon(Icons.camera_alt),
                                  //       onPressed: () {
                                  //         // Navigator.push(
                                  //         //     context,
                                  //         //     MaterialPageRoute(
                                  //         //         builder: (builder) =>
                                  //         //             CameraApp()));
                                  //       },
                                  //     ),
                                  //   ],
                                  // ),
                                  contentPadding: EdgeInsets.all(5),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 8,
                              right: 2,
                              left: 2,
                            ),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor: Color(0xFF128C7E),
                              child: IconButton(
                                icon: Icon(
                                  sendButton ? Icons.send : Icons.mic,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  if (sendButton) {
                                    _scrollController.animateTo(
                                        _scrollController
                                            .position.maxScrollExtent,
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeOut);
                                    sendMessage(_controller.text, user.RollNo,
                                        widget.chatModel.Id);
                                    _controller.clear();
                                    setState(() {
                                      sendButton = false;
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          onPopInvoked: (show) {
            setState(() {
              show = false;
            });
            // } else {
            //   Navigator.pop(context);
            // }
            // Future.value(false);
          },
        ),
      ),
    );
  }
}

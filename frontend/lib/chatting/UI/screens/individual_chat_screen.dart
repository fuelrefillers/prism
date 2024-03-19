// import 'dart:typed_data';

// import 'package:frontend/Faculty_Module/selection_pannel/file_selection_pannel.dart';
// import 'package:frontend/Faculty_Module/selection_pannel/photo_selection_pannel.dart';
// import 'package:frontend/chatting/messagesStore.dart';
// import 'package:frontend/chatting/socketio.dart';
// import 'package:frontend/providers.dart/user_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter/material.dart';
// import 'package:frontend/chatting/UI/widgets/own_message_card.dart';
// import 'package:frontend/chatting/UI/widgets/reply_card.dart';
// import 'package:frontend/chatting/models/ChatModel.dart';
// import 'package:frontend/chatting/models/MessagesModels.dart';
// import 'package:socket_io_client/socket_io_client.dart' as io;

// class IndividualPage extends StatefulWidget {
//   IndividualPage(
//       {Key? key,
//       required this.chatModel,
//       required this.current,
//       required this.type})
//       : super(key: key);

//   final ChatModel chatModel;
//   final String current;
//   final String type;

//   @override
//   _IndividualPageState createState() => _IndividualPageState();
// }

// class _IndividualPageState extends State<IndividualPage> {
//   bool show = false;
//   FocusNode focusNode = FocusNode();
//   bool sendButton = false;
//   List<MessageModel> messages = [];
//   TextEditingController _controller = TextEditingController();
//   ScrollController _scrollController = ScrollController();
//   late io.Socket socket;
//   final messageStore = MessageStore();
//   Uint8List? receivedImage;

//   @override
//   void initState() {
//     super.initState();
//     focusNode.addListener(() {
//       if (focusNode.hasFocus) {
//         setState(() {
//           show = false;
//         });
//       }
//     });
//     // Initialize socket in initState
//     socket = SocketService().socket;
//     // Attach the event listener
//     socket.on("message", _handleIncomingMessage);
//     _initMessages().then((_) {
//       // Scroll to the bottom of the list once messages are loaded
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
//       });
//     });
//   }

//   Future<void> _initMessages() async {
//     await messageStore.initPrefs();
//     setState(() {
//       messages = messageStore.getMessagesForId(widget.chatModel.Id);
//     });
//   }

//   void _handleIncomingMessage(msg) {
//     if (mounted) {
//       print(msg["message"]);
//       setMessage("destination", msg["message"]);
//     }
//     _scrollController.animateTo(
//       _scrollController.position.extentTotal,
//       duration: Duration(milliseconds: 300),
//       curve: Curves.easeOut,
//     );
//   }

//   void sendMessage(String message, String sourceId, String targetId) {
//     setMessage("source", message);
//     socket.emit("message",
//         {"message": message, "sourceId": widget.current, "targetId": targetId});
//   }

//   void sendImage(Uint8List message, String sourceId, String targetId) {
//     // setMessage("source", message);
//     socket.emit("image",
//         {"message": message, "sourceId": widget.current, "targetId": targetId});
//   }

//   void setMessage(String type, String message) async {
//     MessageModel messageModel = MessageModel(
//       type: type,
//       message: message,
//       time: DateTime.now().toString().substring(10, 16),
//     );
//     setState(() {
//       messages.add(messageModel);
//     });
//     if (messageStore.getMessagesForId(widget.chatModel.Id).isEmpty) {
//       List<ChatModel> currentlyPresent =
//           await ChatModel.getAllFromStorage(widget.type);
//       currentlyPresent.add(widget.chatModel);
//       ChatModel.saveAllToStorage(currentlyPresent, widget.type);
//       List<ChatModel> currentlyPresent1 =
//           await ChatModel.getAllFromStorage(widget.type);
//     }
//     // Scroll to the bottom to show the new message
//     _scrollController.animateTo(
//       _scrollController.position.maxScrollExtent,
//       duration: Duration(milliseconds: 0),
//       curve: Curves.easeOut,
//     );

//     messageStore.saveMessagesForId(widget.chatModel.Id, messages);
//   }

//   @override
//   void dispose() {
//     // Remove the event listener in dispose
//     socket.off("message", _handleIncomingMessage);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<UserProvider>(context).user;

//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(60),
//         child: AppBar(
//           leadingWidth: 70,
//           titleSpacing: 0,
//           leading: InkWell(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.arrow_back,
//                   size: 24,
//                 ),
//               ],
//             ),
//           ),
//           title: InkWell(
//             onTap: () {},
//             child: Container(
//               margin: EdgeInsets.all(6),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.chatModel.Id,
//                     style: TextStyle(
//                       fontSize: 18.5,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     "${widget.chatModel.Name}",
//                     style: TextStyle(
//                       fontSize: 13,
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: Container(
//         color: Colors.white,
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 // reverse: true, // Reverse mode

//                 controller: _scrollController,
//                 itemCount: messages.length,
//                 itemBuilder: (context, index) {
//                   if (index == messages.length) {
//                     return Container(
//                       height: 70,
//                     );
//                   }
//                   if (messages[index].type == "source") {
//                     return OwnMessageCard(
//                       message: messages[index].message,
//                       time: messages[index].time,
//                     );
//                   } else {
//                     return ReplyCard(
//                       message: messages[index].message,
//                       time: messages[index].time,
//                     );
//                   }
//                 },
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 8),
//               color: Colors.grey[200],
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Card(
//                       margin: EdgeInsets.all(8),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 16),
//                         child: TextFormField(
//                           controller: _controller,
//                           focusNode: focusNode,
//                           textAlignVertical: TextAlignVertical.center,
//                           keyboardType: TextInputType.multiline,
//                           maxLines: 5,
//                           minLines: 1,
//                           onChanged: (value) {
//                             if (value.length > 0) {
//                               setState(() {
//                                 sendButton = true;
//                               });
//                             } else {
//                               setState(() {
//                                 sendButton = false;
//                               });
//                             }
//                           },
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             hintText: "Type a message",
//                             hintStyle: TextStyle(color: Colors.grey),
//                             contentPadding: EdgeInsets.all(14),
//                             suffixIcon: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 IconButton(
//                                   icon: Icon(Icons.attach_file),
//                                   onPressed: () {
//                                     showPdfPickerOption(context);
//                                   },
//                                 ),
//                                 IconButton(
//                                   icon: Icon(Icons.image),
//                                   onPressed: () async {
//                                     Uint8List? temp =
//                                         await showImagePickerOption(context);
//                                     sendImage(
//                                       temp!,
//                                       user.RollNo,
//                                       widget.chatModel.Id,
//                                     );

//                                     setState(() {
//                                       receivedImage = temp;
//                                     });
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   CircleAvatar(
//                     radius: 25,
//                     backgroundColor: Color(0xFF128C7E),
//                     child: IconButton(
//                       icon: Icon(
//                         sendButton ? Icons.send : Icons.mic,
//                         color: Colors.white,
//                       ),
//                       onPressed: () {
//                         if (sendButton) {
//                           sendMessage(
//                             _controller.text,
//                             user.RollNo,
//                             widget.chatModel.Id,
//                           );
//                           _controller.clear();
//                           setState(() {
//                             sendButton = false;
//                           });
//                           _scrollController.animateTo(
//                             _scrollController.position.extentTotal,
//                             duration: Duration(milliseconds: 300),
//                             curve: Curves.easeOut,
//                           );
//                         }
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget bottomSheet() {
//     return Container(
//       height: 278,
//       width: MediaQuery.of(context).size.width,
//       child: Card(
//         margin: const EdgeInsets.all(18.0),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   iconCreation(
//                       Icons.insert_drive_file, Colors.indigo, "Document"),
//                   SizedBox(
//                     width: 40,
//                   ),
//                   iconCreation(Icons.camera_alt, Colors.pink, "Camera"),
//                   SizedBox(
//                     width: 40,
//                   ),
//                   iconCreation(Icons.insert_photo, Colors.purple, "Gallery"),
//                 ],
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   iconCreation(Icons.headset, Colors.orange, "Audio"),
//                   SizedBox(
//                     width: 40,
//                   ),
//                   iconCreation(Icons.location_pin, Colors.teal, "Location"),
//                   SizedBox(
//                     width: 40,
//                   ),
//                   iconCreation(Icons.person, Colors.blue, "Contact"),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget iconCreation(IconData icons, Color color, String text) {
//     return InkWell(
//       onTap: () {},
//       child: Column(
//         children: [
//           CircleAvatar(
//             radius: 30,
//             backgroundColor: color,
//             child: Icon(
//               icons,
//               // semanticLabel: "Help",
//               size: 29,
//               color: Colors.white,
//             ),
//           ),
//           SizedBox(
//             height: 5,
//           ),
//           Text(
//             text,
//             style: TextStyle(
//               fontSize: 12,
//               // fontWeight: FontWeight.w100,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// // import 'dart:async';

// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:frontend/chatting/messagesStore.dart';
// // import 'package:frontend/chatting/socketio.dart';
// // import 'package:frontend/providers.dart/user_provider.dart';
// // import 'package:frontend/chatting/UI/widgets/own_message_card.dart';
// // import 'package:frontend/chatting/UI/widgets/reply_card.dart';
// // import 'package:frontend/chatting/models/ChatModel.dart';
// // import 'package:frontend/chatting/models/MessagesModels.dart';
// // import 'package:socket_io_client/socket_io_client.dart' as io;

// // class IndividualPage extends StatefulWidget {
// //   IndividualPage({
// //     Key? key,
// //     required this.chatModel,
// //     required this.current,
// //     required this.type,
// //   }) : super(key: key);

// //   final ChatModel chatModel;
// //   final String current;
// //   final String type;

// //   @override
// //   _IndividualPageState createState() => _IndividualPageState();
// // }

// // class _IndividualPageState extends State<IndividualPage> {
// //   bool show = false;
// //   FocusNode focusNode = FocusNode();
// //   bool sendButton = false;
// //   TextEditingController _controller = TextEditingController();
// //   late io.Socket socket;
// //   final messageStore = MessageStore();
// //   late StreamController<List<MessageModel>> _messageStreamController;
// //   List<MessageModel> currentMessages = [];

// //   @override
// //   void initState() {
// //     super.initState();
// //     focusNode.addListener(() {
// //       if (focusNode.hasFocus) {
// //         setState(() {
// //           show = false;
// //         });
// //       }
// //     });
// //     socket = SocketService().socket;
// //     _messageStreamController = StreamController<List<MessageModel>>.broadcast();
// //     socket.on("message", _handleIncomingMessage);
// //     _initMessages();
// //   }

// //   @override
// //   void dispose() {
// //     socket.off("message", _handleIncomingMessage);
// //     _messageStreamController.close();
// //     super.dispose();
// //   }

// //   void _initMessages() async {
// //     await messageStore.initPrefs();
// //     List<MessageModel> messages =
// //         messageStore.getMessagesForId(widget.chatModel.Id);
// //     _messageStreamController.add(messages);
// //   }

// //   void _handleIncomingMessage(msg) {
// //     if (mounted) {
// //       print(msg["message"]);
// //       setMessage("destination", msg["message"]);
// //     }
// //   }

// //   void sendMessage(String message, String sourceId, String targetId) {
// //     setMessage("source", message);
// //     socket.emit("message", {
// //       "message": message,
// //       "sourceId": widget.current,
// //       "targetId": targetId,
// //     });
// //   }

// //   void setMessage(String type, String message) async {
// //     MessageModel messageModel = MessageModel(
// //       type: type,
// //       message: message,
// //       time: DateTime.now().toString().substring(10, 16),
// //     );

// //     // Fetch the current list of messages from the stream
// //     _messageStreamController.stream.listen((messages) {
// //       currentMessages = messages;
// //     });

// //     // Add the new message to the current list of messages
// //     currentMessages.add(messageModel);

// //     // Add the updated list of messages to the stream
// //     _messageStreamController.add(currentMessages);

// //     // Save messages to local storage
// //     // messageStore.saveMessagesForId(widget.chatModel.Id, currentMessages);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final user = Provider.of<UserProvider>(context).user;

// //     return Scaffold(
// //       backgroundColor: Colors.transparent,
// //       appBar: PreferredSize(
// //         preferredSize: Size.fromHeight(60),
// //         child: AppBar(
// //           leadingWidth: 70,
// //           titleSpacing: 0,
// //           leading: InkWell(
// //             onTap: () {
// //               Navigator.pop(context);
// //             },
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 Icon(
// //                   Icons.arrow_back,
// //                   size: 24,
// //                 ),
// //               ],
// //             ),
// //           ),
// //           title: InkWell(
// //             onTap: () {},
// //             child: Container(
// //               margin: EdgeInsets.all(6),
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.start,
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(
// //                     widget.chatModel.Id,
// //                     style: TextStyle(
// //                       fontSize: 18.5,
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                   ),
// //                   Text(
// //                     "last seen today at 12:05",
// //                     style: TextStyle(
// //                       fontSize: 13,
// //                     ),
// //                   )
// //                 ],
// //               ),
// //             ),
// //           ),
// //           actions: [
// //             IconButton(icon: Icon(Icons.videocam), onPressed: () {}),
// //             IconButton(icon: Icon(Icons.call), onPressed: () {}),
// //           ],
// //         ),
// //       ),
// //       body: Container(
// //         color: Colors.white,
// //         height: MediaQuery.of(context).size.height,
// //         width: MediaQuery.of(context).size.width,
// //         child: Column(
// //           children: [
// //             Expanded(
// //               child: StreamBuilder<List<MessageModel>>(
// //                 stream: _messageStreamController.stream,
// //                 builder: (context, snapshot) {
// //                   if (snapshot.hasData) {
// //                     return ListView.builder(
// //                       itemCount: snapshot.data!.length,
// //                       itemBuilder: (context, index) {
// //                         final message = snapshot.data![index];
// //                         if (message.type == "source") {
// //                           return OwnMessageCard(
// //                             message: message.message,
// //                             time: message.time,
// //                           );
// //                         } else {
// //                           return ReplyCard(
// //                             message: message.message,
// //                             time: message.time,
// //                           );
// //                         }
// //                       },
// //                     );
// //                   } else {
// //                     return Center(
// //                       child: CircularProgressIndicator(),
// //                     );
// //                   }
// //                 },
// //               ),
// //             ),
// //             Container(
// //               padding: EdgeInsets.symmetric(horizontal: 8),
// //               color: Colors.grey[200],
// //               child: Row(
// //                 children: [
// //                   Expanded(
// //                     child: Card(
// //                       margin: EdgeInsets.all(8),
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(25),
// //                       ),
// //                       child: Padding(
// //                         padding: EdgeInsets.symmetric(horizontal: 16),
// //                         child: TextFormField(
// //                           controller: _controller,
// //                           focusNode: focusNode,
// //                           textAlignVertical: TextAlignVertical.center,
// //                           keyboardType: TextInputType.multiline,
// //                           maxLines: 5,
// //                           minLines: 1,
// //                           onChanged: (value) {
// //                             if (value.length > 0) {
// //                               setState(() {
// //                                 sendButton = true;
// //                               });
// //                             } else {
// //                               setState(() {
// //                                 sendButton = false;
// //                               });
// //                             }
// //                           },
// //                           decoration: InputDecoration(
// //                             border: InputBorder.none,
// //                             hintText: "Type a message",
// //                             hintStyle: TextStyle(color: Colors.grey),
// //                             contentPadding: EdgeInsets.all(14),
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                   CircleAvatar(
// //                     radius: 25,
// //                     backgroundColor: Color(0xFF128C7E),
// //                     child: IconButton(
// //                       icon: Icon(
// //                         sendButton ? Icons.send : Icons.mic,
// //                         color: Colors.white,
// //                       ),
// //                       onPressed: () {
// //                         if (sendButton) {
// //                           sendMessage(
// //                             _controller.text,
// //                             user.RollNo,
// //                             widget.chatModel.Id,
// //                           );
// //                           _controller.clear();
// //                           setState(() {
// //                             sendButton = false;
// //                           });
// //                         }
// //                       },
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:frontend/Faculty_Module/selection_pannel/file_selection_pannel.dart';
import 'package:frontend/Faculty_Module/selection_pannel/photo_selection_pannel.dart';
import 'package:frontend/chatting/messagesStore.dart';
import 'package:frontend/chatting/socketio.dart';
import 'package:frontend/providers.dart/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:frontend/chatting/UI/widgets/own_message_card.dart';
import 'package:frontend/chatting/UI/widgets/reply_card.dart';
import 'package:frontend/chatting/models/ChatModel.dart';
import 'package:frontend/chatting/models/MessagesModels.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class IndividualPage extends StatefulWidget {
  IndividualPage({
    Key? key,
    required this.chatModel,
    required this.current,
    required this.type,
  }) : super(key: key);

  final ChatModel chatModel;
  final String current;
  final String type;

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
  Uint8List? receivedImage;

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
    socket = SocketService().socket;
    socket.on("message", _handleIncomingMessage);
    _initMessages().then((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      });
    });
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
    }
    _scrollController.animateTo(
      _scrollController.position.extentTotal,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void sendMessage(String message, String sourceId, String targetId) {
    setMessage("source", message);
    SocketService().sendMessage(message, sourceId, targetId);
  }

  void sendImage(Uint8List image, String sourceId, String targetId) {
    print(image);
    socket.emit("image",
        {"image": image, "sourceId": widget.current, "targetId": targetId});
  }

  void setMessage(String type, String message) async {
    MessageModel messageModel = MessageModel(
      type: type,
      message: message,
      time: DateTime.now().toString().substring(10, 16),
    );
    setState(() {
      messages.add(messageModel);
    });
    if (messageStore.getMessagesForId(widget.chatModel.Id).isEmpty) {
      List<ChatModel> currentlyPresent =
          await ChatModel.getAllFromStorage(widget.type);
      currentlyPresent.add(widget.chatModel);
      ChatModel.saveAllToStorage(currentlyPresent, widget.type);
      // List<ChatModel> currentlyPresent1 =
      //     await ChatModel.getAllFromStorage(widget.type);
    }
    // Scroll to the bottom to show the new message
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 0),
      curve: Curves.easeOut,
    );

    messageStore.saveMessagesForId(widget.chatModel.Id, messages);
  }

  @override
  void dispose() {
    // Remove the event listener and dispose of the socket connection
    socket.off("message", _handleIncomingMessage);
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
                    "${widget.chatModel.Name}",
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
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
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              color: Colors.grey[200],
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                      margin: EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: TextFormField(
                          controller: _controller,
                          focusNode: focusNode,
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          minLines: 1,
                          onChanged: (value) {
                            setState(() {
                              sendButton = value.isNotEmpty;
                            });
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Type a message",
                            hintStyle: TextStyle(color: Colors.grey),
                            contentPadding: EdgeInsets.all(14),
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.attach_file),
                                  onPressed: () {
                                    showPdfPickerOption(context);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.image),
                                  onPressed: () async {
                                    Uint8List? temp =
                                        await showImagePickerOption(context);
                                    if (temp != null) {
                                      sendImage(
                                        temp,
                                        user.RollNo,
                                        widget.chatModel.Id,
                                      );
                                      setState(() {
                                        receivedImage = temp;
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Color(0xFF128C7E),
                    child: IconButton(
                      icon: Icon(
                        sendButton ? Icons.send : Icons.mic,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        if (sendButton) {
                          sendMessage(
                            _controller.text,
                            widget.current,
                            widget.chatModel.Id,
                          );
                          _controller.clear();
                          setState(() {
                            sendButton = false;
                          });
                          _scrollController.animateTo(
                            _scrollController.position.extentTotal,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

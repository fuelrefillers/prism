import 'package:flutter/material.dart';
import 'package:frontend/chatting/UI/screens/chat_page_screen.dart';
// import 'package:flutter/widgets.dart';

class ChattingHomeScreen extends StatefulWidget {
  const ChattingHomeScreen({super.key});
  @override
  State<ChattingHomeScreen> createState() => _ChattingHomeScreen();
}

class _ChattingHomeScreen extends State<ChattingHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this, initialIndex: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        title: Text("CHATTTT BABES"),
        bottom: TabBar(
          // isScrollable: true,
          controller: _controller,
          indicatorColor: const Color.fromARGB(255, 251, 171, 58),
          tabs: [
            Tab(
              text: "Students",
            ),
            Tab(
              text: "Parents",
            ),
            Tab(
              text: "Faculty",
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          // CameraPage(),
          // ChatPage(
          //   chatmodels: widget.chatmodels,
          //   sourchat: widget.sourchat,
          // ),
          // Text(
          //   "Students",
          //   style: TextStyle(color: Colors.white),
          // ),
          ChatPageScreen(),
          Text("Parents"),
          Text("Faculty"),
        ],
      ),
    );
  }
}

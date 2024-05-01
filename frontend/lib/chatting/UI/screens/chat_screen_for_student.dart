import 'package:flutter/material.dart';
import 'package:frontend/chatting/UI/screens/individual_chat_screen.dart';
import 'package:frontend/chatting/UI/screens/new_chat_screen.dart';
import 'package:frontend/chatting/models/ChatModel.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:provider/provider.dart';

class StudentChatScreen extends StatefulWidget {
  const StudentChatScreen({super.key});

  @override
  State<StudentChatScreen> createState() => _StudentChatScreenState();
}

class _StudentChatScreenState extends State<StudentChatScreen> {
  List<ChatModel> data = [];

  @override
  void initState() {
    super.initState();
    getChats();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getChats();
  }

  void getChats() async {
    List<ChatModel> temp = await ChatModel.getAllFromStorage("facultystudent");
    setState(() {
      data = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    final student = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
      appBar: AppBar(
        title: Text("chat"),
      ),
      body: data.isEmpty
          ? Center(
              child: Text("Start a chat"),
            )
          : ListView.builder(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              itemCount: data.length,
              itemBuilder: (contetxt, index) {
                ChatModel contact = data[index];
                return ListTile(
                  leading: Text(
                    contact.Id,
                    style: TextStyle(fontSize: 15),
                  ),
                  title: Text(contact.Name),
                  subtitle: Text("${contact.Department}-${contact.optional}"),
                  // You can add more details here as needed
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IndividualPage(
                          chatModel: contact,
                          current: student.RollNo,
                          type: "facultystudent",
                        ),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => newchatScreen(
                type: "facultystudent",
                ID: student.RollNo,
              ),
            ),
          );
          getChats();
        },
        child: Icon(Icons.message),
      ),
    );
  }
}

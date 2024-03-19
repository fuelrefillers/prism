import 'package:flutter/material.dart';
import 'package:frontend/chatting/UI/screens/individual_chat_screen.dart';
import 'package:frontend/chatting/UI/screens/new_chat_screen.dart';
import 'package:frontend/chatting/models/ChatModel.dart';
import 'package:frontend/providers.dart/faculty_provider.dart';
import 'package:provider/provider.dart';

class ParentsChatPage extends StatefulWidget {
  const ParentsChatPage({super.key});

  @override
  State<ParentsChatPage> createState() => _ParentsChatPageState();
}

class _ParentsChatPageState extends State<ParentsChatPage> {
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
    List<ChatModel> temp = await ChatModel.getAllFromStorage("parents");
    setState(() {
      data = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    final faculty =
        Provider.of<FacultyProvider>(context, listen: false).faculty;
    return Scaffold(
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
                    "${contact.Id.split("-")[0]}\n${contact.Id.split("-")[1]}",
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
                          current: faculty.FacultyId,
                          type: "parents",
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
                type: "parents",
                ID: faculty.FacultyId,
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

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/chatting/UI/screens/individual_chat_screen.dart';
import 'package:frontend/chatting/models/ChatModel.dart';
import 'package:frontend/services/ip.dart';
import 'package:http/http.dart' as http;

class newchatScreen extends StatefulWidget {
  final String type;
  final String ID;
  const newchatScreen({super.key, required this.type, required this.ID});

  @override
  State<newchatScreen> createState() => _newchatScreenState();
}

class _newchatScreenState extends State<newchatScreen> {
  List<ChatModel> allContacts = [];
  List<ChatModel> filteredContacts = [];

  @override
  void initState() {
    super.initState();
    setAllContacts();
  }

  void setAllContacts() async {
    try {
      http.Response res = await http.post(
        Uri.parse('${ip}/api/userdata/get${widget.type}dataforchat'),
        body: jsonEncode({"Id": widget.ID}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(res.body);

      if (res.statusCode == 200) {
        final result = jsonDecode(res.body);
        List<ChatModel> dummy = [];
        for (int i = 0; i < result.length; i++) {
          ChatModel s = ChatModel.fromMap(result[i] as Map<String, dynamic>);
          dummy.add(s);
        }
        setState(() {
          allContacts = dummy;
          filteredContacts =
              allContacts; // Initialize filteredContacts with all contacts
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void filterContacts(String query) {
    List<ChatModel> filteredList = allContacts.where((contact) {
      return contact.Name.toLowerCase().contains(query.toLowerCase()) ||
          contact.Id.toLowerCase().contains(query.toLowerCase()) ||
          contact.Department.toLowerCase().contains(query.toLowerCase()) ||
          contact.optional.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredContacts = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Contact"),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                filterContacts(value);
              },
              decoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Search for contacts...',
                prefixIcon: Icon(Icons.search),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredContacts.length,
              itemBuilder: (context, index) {
                ChatModel contact = filteredContacts[index];
                return ListTile(
                  leading: Text("${contact.Id.split("-")[0]}\n"),
                  title: Text(contact.Name),
                  subtitle: Text("${contact.Department}-${contact.optional}"),
                  // You can add more details here as needed
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => IndividualPage(
                                  chatModel: filteredContacts[index],
                                  current: widget.ID,
                                  type: widget.type,
                                )));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

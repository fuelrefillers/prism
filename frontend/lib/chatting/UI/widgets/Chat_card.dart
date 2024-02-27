import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/chatting/UI/screens/individual_chat_screen.dart';
import 'package:frontend/chatting/models/ChatModel.dart';
import 'package:frontend/providers.dart/user_provider.dart';
import 'package:provider/provider.dart';

class ChartCard extends StatelessWidget {
  const ChartCard({super.key, required this.data});
  final ChatModel data;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Center(
      child: Material(
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => IndividualPage(
                          chatModel: data,
                          current: user.RollNo,
                        )));
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    width: 1.0, color: Color.fromARGB(38, 105, 105, 105)),
              ),
              // color: Colors.white,
            ),
            width: MediaQuery.of(context).size.width,
            height: 70,
            // color: Colors.amber,
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${data.Id}-${data.Name}  (${data.Department}-${data.optional})",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

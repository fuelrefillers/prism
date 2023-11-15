import 'package:flutter/material.dart';
import 'package:frontend/providers.dart/user_provider.dart';
import 'package:frontend/services/auth.dart';
import 'package:frontend/widgets/switch.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});
  @override
  Widget build(BuildContext context) {
    final Authservice authservice = Authservice();
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 175.0,
        leading: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Container(
                  clipBehavior: Clip.hardEdge,
                  height: 130,
                  width: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.network(
                    user.imageurl,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.name,
                        style: TextStyle(fontSize: 25, color: Colors.white)),
                    Text(user.rollno.toUpperCase(),
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    Text(user.branch,
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    Text(user.studentphno,
                        style: TextStyle(fontSize: 15, color: Colors.white)),
                    Text(user.studentemail,
                        style: TextStyle(fontSize: 15, color: Colors.white)),
                  ],
                )
              ],
            )),
        leadingWidth: MediaQuery.of(context).size.width,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 195, 199, 243),
              Color.fromARGB(255, 200, 168, 233)
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
          ),
        ),
      ),
      body: Column(
        children: [
          SwitchClass(
            title: "Notifications",
            desc: "Turn on or of notifications",
          ),
          SwitchClass(
            title: "Dark Mode",
            desc: "Turn on or of DarkMode",
          ),
          SizedBox(
            height: 60,
          ),
          ElevatedButton.icon(
            onPressed: () {
              authservice.signOut(context);
            },
            icon: Icon(Icons.logout),
            label: Text('logout'),
          ),
          Padding(
            padding: const EdgeInsets.all(80.0),
            child: MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: const Color.fromRGBO(49, 39, 79, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              height: 50,
              child: const Center(
                child: Text(
                  "Back",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

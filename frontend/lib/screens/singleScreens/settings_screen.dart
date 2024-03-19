import 'package:flutter/material.dart';
import 'package:frontend/providers.dart/user_provider.dart';
import 'package:frontend/services/auth.dart';
import 'package:frontend/widgets/switch.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final Authservice authservice = Authservice();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 19, 79, 90),
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        title: Center(
            widthFactor: MediaQuery.of(context).size.width / 120,
            child: Text('Settings', style: TextStyle(color: Colors.white))),
        backgroundColor: Color.fromARGB(255, 19, 79, 90),
        elevation: 0,
      ),
      body: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50), topRight: Radius.circular(50)),
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 15,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 4,
                      height: MediaQuery.of(context).size.height / 6,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: DecorationImage(
                          image: NetworkImage(user.ImageUrl),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.StudentName,
                          style: TextStyle(
                            fontSize: 22,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        Text(
                          user.StudentEmail,
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 17, 79, 90)),
                        ),
                        Text(
                          user.RollNo.toUpperCase(),
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        Text(
                          '${user.Department}-${user.Section}',
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
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
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                label: Text(
                  'logout',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 19, 79, 90)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

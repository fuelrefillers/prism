import 'package:flutter/material.dart';
import 'package:frontend/Faculty_Module/faculty_time.dart';
import 'package:frontend/providers/faculty_provider.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:frontend/screens/singleScreens/profile_screen.dart';
import 'package:frontend/screens/singleScreens/settings_screen.dart';
import 'package:frontend/services/auth.dart';
import 'package:frontend/todo/screens/home.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/screens/singleScreens/student_time_table_screen.dart';

class Drawerwidget extends StatefulWidget {
  const Drawerwidget({super.key});
  @override
  State<Drawerwidget> createState() => _DrawerwidgetState();
}

class _DrawerwidgetState extends State<Drawerwidget> {
  var m = '';
  @override
  void initState() {
    super.initState();
    getCurrentSignedin();
  }

  void getCurrentSignedin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      m = prefs.getString('whoIsSignedIn')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Authservice authService = Authservice();
    if (m == "student") {
      final user = Provider.of<UserProvider>(context).user;
      return Drawer(
        width: MediaQuery.of(context).size.width / 1.4,
        child: Column(
          children: [
            DrawerHeader(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primaryContainer,
                    Theme.of(context)
                        .colorScheme
                        .primaryContainer
                        .withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    user.RollNo.toUpperCase(),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.note_add_sharp,
                size: 26,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              title: Text(
                'ToDo',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 24,
                    ),
              ),
              onTap: () {
                Navigator.of(context).pop();

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreenToDo()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                size: 26,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              title: Text(
                'Profile',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 24,
                    ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (ctx) => ProfileScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                size: 26,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              title: Text(
                'Settings ',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 24,
                    ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (ctx) => Settings()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.calendar_view_month_sharp,
                size: 26,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              title: Text(
                'Time Table',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 24,
                    ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => StudentTimeTableScreen(
                        regulation: user.Regulation,
                        department: user.Department,
                        section: user.Section),
                  ),
                );
              },
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton.icon(
              onPressed: () {
                authService.signOut(context);
              },
              icon: Icon(Icons.logout),
              label: Text("Logout"),
            ),
          ],
        ),
      );
    } else if (m == "faculty") {
      final user = Provider.of<FacultyProvider>(context).faculty;
      return Drawer(
        width: MediaQuery.of(context).size.width / 1.4,
        child: Column(
          children: [
            DrawerHeader(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primaryContainer,
                    Theme.of(context)
                        .colorScheme
                        .primaryContainer
                        .withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    user.FacultyId.toUpperCase(),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ],
              ),
            ),
            // ListTile(
            //   leading: Icon(
            //     Icons.note_add_sharp,
            //     size: 26,
            //     color: Theme.of(context).colorScheme.onBackground,
            //   ),
            //   title: Text(
            //     'ToDo',
            //     style: Theme.of(context).textTheme.titleSmall!.copyWith(
            //           color: Theme.of(context).colorScheme.onBackground,
            //           fontSize: 24,
            //         ),
            //   ),
            //   onTap: () {
            //     Navigator.of(context).pop();
            //   },
            // ),
            // ListTile(
            //   leading: Icon(
            //     Icons.person,
            //     size: 26,
            //     color: Theme.of(context).colorScheme.onBackground,
            //   ),
            //   title: Text(
            //     'Profile',
            //     style: Theme.of(context).textTheme.titleSmall!.copyWith(
            //           color: Theme.of(context).colorScheme.onBackground,
            //           fontSize: 24,
            //         ),
            //   ),
            //   onTap: () {
            //     Navigator.of(context).pop();
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (ctx) => ProfileScreen()),
            //     );
            //   },
            // ),
            // ListTile(
            //   leading: Icon(
            //     Icons.settings,
            //     size: 26,
            //     color: Theme.of(context).colorScheme.onBackground,
            //   ),
            //   title: Text(
            //     'Settings ',
            //     style: Theme.of(context).textTheme.titleSmall!.copyWith(
            //           color: Theme.of(context).colorScheme.onBackground,
            //           fontSize: 24,
            //         ),
            //   ),
            //   onTap: () {
            //     Navigator.of(context).pop();
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (ctx) => Settings()),
            //     );
            //   },
            // ),
            ListTile(
              leading: Icon(
                Icons.calendar_view_month_sharp,
                size: 26,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              title: Text(
                'Time Table',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 24,
                    ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) =>
                          FacultyTimeTableViewScreen(title: "Your TimeTable")),
                );
              },
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton.icon(
              onPressed: () {
                authService.signOut(context);
              },
              icon: Icon(Icons.logout),
              label: Text("Logout"),
            ),
          ],
        ),
      );
    } else {
      final user = Provider.of<UserProvider>(context).user;
      return Drawer(
        width: MediaQuery.of(context).size.width / 1.4,
        child: Column(
          children: [
            DrawerHeader(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primaryContainer,
                    Theme.of(context)
                        .colorScheme
                        .primaryContainer
                        .withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    user.RollNo.toUpperCase(),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.note_add_sharp,
                size: 26,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              title: Text(
                'ToDo',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 24,
                    ),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                size: 26,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              title: Text(
                'Profile',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 24,
                    ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (ctx) => ProfileScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.send,
                size: 26,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              title: Text(
                'Gemini',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 24,
                    ),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                size: 26,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              title: Text(
                'Settings ',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 24,
                    ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (ctx) => Settings()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.calendar_view_month_sharp,
                size: 26,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              title: Text(
                'Time Table',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 24,
                    ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => StudentTimeTableScreen(
                          regulation: user.Regulation,
                          department: user.Department,
                          section: user.Section)),
                );
              },
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton.icon(
              onPressed: () {
                authService.signOut(context);
              },
              icon: Icon(Icons.logout),
              label: Text("Logout"),
            ),
          ],
        ),
      );
    }
  }
}

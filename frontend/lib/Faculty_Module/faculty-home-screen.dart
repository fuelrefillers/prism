import 'package:flutter/material.dart';
import 'package:frontend/Faculty_Module/circular_picker_screen.dart';
import 'package:frontend/Faculty_Module/home_screen.dart';
import 'package:frontend/Faculty_Module/books_picker_screen.dart';
import 'package:frontend/providers.dart/faculty_provider.dart';
import 'package:frontend/services/auth.dart';
import 'package:frontend/widgets/drawer.dart';
import 'package:frontend/widgets/home_nav_control.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class FacultyHomeScreen extends StatefulWidget {
  const FacultyHomeScreen({super.key});
  @override
  State<FacultyHomeScreen> createState() {
    return _FacultyHomeScreenState();
  }
}

class _FacultyHomeScreenState extends State<FacultyHomeScreen> {
  Authservice authservice = Authservice();

  @override
  void initState() {
    super.initState();
    authservice.getFaculty(context);
  }

  @override
  Widget build(BuildContext context) {
    final faculty =
        Provider.of<FacultyProvider>(context, listen: false).faculty;
    return Scaffold(
      appBar: AppBar(
        title: const Text("MREC Prism"),
      ),
      drawer: const Drawerwidget(),
      body: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage(
                  fadeInDuration: Duration(milliseconds: 100),
                  fadeOutDuration: Duration(milliseconds: 100),
                  placeholder: MemoryImage(kTransparentImage),
                  image: AssetImage("assets/home-screen-hero.png"),
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height / 4,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Center(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(145, 164, 164, 164),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Welcome,",
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  faculty.FacultyName,
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                Text(
                                  faculty.FacultyId,
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const VerticalDivider(),
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 30, 10, 30),
                        decoration: const BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: Color.fromARGB(255, 255, 255, 255),
                              width: 3.0,
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "ss",
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                            Text(
                              "ll",
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Expanded(
            child: GridView(
              padding: const EdgeInsets.all(15),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 30,
                childAspectRatio: 3 / 2.5,
              ),
              children: [
                Buttonhome(
                    category: "Student Attendace",
                    icon: Icons.person,
                    screen: FacultyAttendanceScreen()),
                Buttonhome(
                    category: "upload books",
                    icon: Icons.person,
                    screen: PickImage()),
                Buttonhome(
                    category: "upload circular",
                    icon: Icons.person,
                    screen: CircularPickerScreen()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

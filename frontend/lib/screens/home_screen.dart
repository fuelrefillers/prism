import 'package:flutter/material.dart';
import 'package:frontend/providers.dart/is_parent_provider.dart';
// import 'package:frontend/providers.dart/token_provider.dart';
import 'package:frontend/providers.dart/user_provider.dart';
import 'package:frontend/screens/attendance_screen.dart';
import 'package:frontend/screens/books_home_screen.dart';
import 'package:frontend/screens/circular_screen.dart';
import 'package:frontend/screens/fee_status_screen.dart';
import 'package:frontend/screens/hostels_screen.dart';
import 'package:frontend/screens/library_screen.dart';
import 'package:frontend/screens/performance_screen.dart';
import 'package:frontend/screens/time_table_screen.dart';
import 'package:frontend/screens/transport_screen.dart';
import 'package:frontend/services/auth.dart';
import 'package:frontend/widgets/drawer.dart';
import 'package:frontend/widgets/home_nav_control.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Authservice authservice = Authservice();

  @override
  void initState() {
    super.initState();
    authservice.getUser(context);
  }

  @override
  Widget build(BuildContext context) {
    // final token = Provider.of<TokenProvider>(context).token;
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: const Text("MREC prism"),
      ),
      drawer: const Drawerwidget(),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 4,
                padding: const EdgeInsets.all(10.0),
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(79, 135, 135, 135),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: Offset(
                        0,
                        10,
                      ),
                    ),
                  ],
                  image: DecorationImage(
                    image: AssetImage('assets/home-screen-hero.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(145, 164, 164, 164),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Welcome,",
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                          Consumer<IsParentLoggedIn>(
                            builder: (_, model, child) => Text(
                              model.isSignedIn ? user.parentname : user.name,
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                          ),
                          Text(
                            user.rollno.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                      const VerticalDivider(),
                      Container(
                        padding: const EdgeInsets.all(36),
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
                              user.branch,
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                            Text(
                              user.clas.toUpperCase(),
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
          const Text(
            "Here are your latest details",
            style: TextStyle(fontSize: 20),
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
                    category: "attendace",
                    icon: Icons.person,
                    screen: AttendanceScreen()),
                Buttonhome(
                    category: "performance",
                    icon: Icons.speed,
                    screen: PerformanceScreen()),
                Buttonhome(
                    category: "fee status",
                    icon: Icons.attach_money_outlined,
                    screen: FeeStatusScreen()),
                Buttonhome(
                    category: "library",
                    icon: Icons.collections_bookmark_sharp,
                    screen: LibraryScreen()),
                Buttonhome(
                    category: "books",
                    icon: Icons.book,
                    screen: BooksHomeScreen()),
                Buttonhome(
                    category: "transport",
                    icon: Icons.bus_alert_outlined,
                    screen: Transportscreen()),
                Buttonhome(
                    category: "hostel",
                    icon: Icons.apartment,
                    screen: HostelScreen()),
                Buttonhome(
                    category: "Time Table",
                    icon: Icons.view_timeline_outlined,
                    screen: TimeTableScreen()),
                Buttonhome(
                    category: "circulars",
                    icon: Icons.notification_add_sharp,
                    screen: Circulars()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// Column(
//                   mainAxisAlignment:MainAxisAlignment.center ,
//                   children: [
//                     const Text("Welcome :"),
//                     Text(user.name),
//                   ],
//                 ),
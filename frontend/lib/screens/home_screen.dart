import 'package:flutter/material.dart';
import 'package:frontend/chatting/UI/screens/chat_home_screen.dart';
import 'package:frontend/chatting/socketio.dart';
import 'package:frontend/providers.dart/who_is_signed_in.dart';
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
import 'package:frontend/services/Students_Parents_services.dart';
import 'package:frontend/services/prismBloc/prism_bloc.dart';
import 'package:frontend/widgets/drawer.dart';
import 'package:frontend/widgets/home_nav_control.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.whoissignedin});
  final String whoissignedin;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final StudentParentServices service = StudentParentServices();
  final PrismBloc prismBloc = PrismBloc();

  @override
  void initState() {
    super.initState();
    // authservice.getUser(context);

    service.getAttendance(context);
    service.getPerformance(context);
    prismBloc.add(UserInitialFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    io.Socket socket = SocketService().socket;

    // final token = Provider.of<TokenProvider>(context).token;
    var whois = Provider.of<whoIsSignedIn>(context, listen: false);
    whois.changeStatus(widget.whoissignedin);
    // var facultyprovider = Provider.of<IsfacultyLoggedIn>(context, listen: false);
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    return BlocConsumer<PrismBloc, PrismState>(
      bloc: prismBloc,
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case UserFetchingLoadingState:
            return Scaffold(
              appBar: AppBar(
                title: Text("MREC Prism"),
              ),
              drawer: const Drawerwidget(),
              body: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          case UserFetchingSuccessfullState:
            final successState = state as UserFetchingSuccessfullState;
            socket.emit("signin", successState.user.RollNo);
            userprovider.setUserFromModel(successState.user);
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
                      // Container(
                      //   width: MediaQuery.of(context).size.width,
                      //   height: MediaQuery.of(context).size.height / 4,
                      //   padding: const EdgeInsets.all(10.0),
                      //   decoration: const BoxDecoration(
                      //     boxShadow: [
                      //       BoxShadow(
                      //         color: Color.fromARGB(79, 135, 135, 135),
                      //         blurRadius: 10,
                      //         spreadRadius: 2,
                      //         offset: Offset(
                      //           0,
                      //           10,
                      //         ),
                      //       ),
                      //     ],
                      //     image: DecorationImage(
                      //       image: AssetImage('assets/home-screen-hero.png'),
                      //       fit: BoxFit.cover,
                      //     ),
                      //   ),
                      // ),
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
                                width: whois.isSignedIn == 'parent'
                                    ? MediaQuery.of(context).size.width / 1.5
                                    : MediaQuery.of(context).size.width / 2.3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Welcome,",
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.white),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          whois.isSignedIn == 'parent'
                                              ? successState.user.FatherName
                                              : successState.user.StudentName,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          whois.isSignedIn == 'parent'
                                              ? "f/o ${successState.user.StudentName}"
                                              : successState.user.RollNo
                                                  .toUpperCase(),
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const VerticalDivider(),
                              Visibility(
                                visible: whois.isSignedIn == 'student',
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 30, 10, 30),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      left: BorderSide(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        width: 3.0,
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        whois.isSignedIn == 'parent'
                                            ? "Parent"
                                            : successState.user.Department,
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                      Text(
                                        whois.isSignedIn == 'parent'
                                            ? ""
                                            : "${successState.user.Department}-${successState.user.Section}"
                                                .toUpperCase(),
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ],
                                  ),
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
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 30,
                        childAspectRatio: 3 / 2.5,
                      ),
                      children: [
                        Visibility(
                          visible: whois.isSignedIn == 'parent' ||
                              whois.isSignedIn == 'student',
                          child: Buttonhome(
                              category: " attendace",
                              icon: Icons.person,
                              screen: AttendanceScreen()),
                        ),
                        Visibility(
                          visible: whois.isSignedIn == 'parent' ||
                              whois.isSignedIn == 'student',
                          child: Buttonhome(
                              category: "performance",
                              icon: Icons.speed,
                              screen: PerformanceScreen()),
                        ),
                        Visibility(
                          visible: whois.isSignedIn == 'parent' ||
                              whois.isSignedIn == 'student',
                          child: Buttonhome(
                              category: "fee status",
                              icon: Icons.attach_money_outlined,
                              screen: FeeStatusScreen()),
                        ),
                        Visibility(
                          visible: whois.isSignedIn == 'parent' ||
                              whois.isSignedIn == 'student',
                          child: Buttonhome(
                              category: "circulars",
                              icon: Icons.notification_add_sharp,
                              screen: Circulars(
                                department: successState.user.Department,
                                regulation:
                                    successState.user.RollNo.substring(0, 2),
                              )),
                        ),
                        Visibility(
                          visible: whois.isSignedIn == 'parent' ||
                              whois.isSignedIn == 'student',
                          child: Buttonhome(
                              category: "transport",
                              icon: Icons.bus_alert_outlined,
                              screen: Transportscreen()),
                        ),
                        Visibility(
                          visible: whois.isSignedIn == 'parent' ||
                              whois.isSignedIn == 'student',
                          child: Buttonhome(
                              category: "hostel",
                              icon: Icons.apartment,
                              screen: HostelScreen()),
                        ),
                        Visibility(
                          visible: whois.isSignedIn == 'parent' ||
                              whois.isSignedIn == 'student',
                          child: Buttonhome(
                              category: "Chatt",
                              icon: Icons.apartment,
                              screen: ChattingHomeScreen()),
                        ),
                        Visibility(
                          visible: whois.isSignedIn == 'student',
                          child: Buttonhome(
                              category: "Time Table",
                              icon: Icons.view_timeline_outlined,
                              screen: TimeTableScreen(
                                regulation:
                                    successState.user.RollNo.substring(0, 2),
                                department: successState.user.Department,
                              )),
                        ),
                        Visibility(
                          visible: whois.isSignedIn == 'student',
                          child: Buttonhome(
                              category: "books",
                              icon: Icons.book,
                              screen: BooksHomeScreen()),
                        ),
                        Visibility(
                          visible: whois.isSignedIn == 'student',
                          child: Buttonhome(
                              category: "library",
                              icon: Icons.collections_bookmark_sharp,
                              screen: LibraryScreen()),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          default:
            return SizedBox();
        }
      },
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
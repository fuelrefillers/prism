import 'package:flutter/material.dart';
import 'package:frontend/hostels/screens/InstructionsScreen.dart';
import 'package:frontend/providers.dart/who_is_signed_in.dart';
import 'package:frontend/providers.dart/user_provider.dart';
import 'package:frontend/screens/AttendanceScreens/attendance_screen.dart';
import 'package:frontend/screens/booksScreens/books_home_screen.dart';
import 'package:frontend/screens/prevQPScreens/prevQPScreen.dart';
import 'package:frontend/screens/singleScreens/circular_screen.dart';
import 'package:frontend/screens/singleScreens/fee_status_screen.dart';
import 'package:frontend/screens/libraryScreens/library_screen.dart';
import 'package:frontend/screens/performanceScreens/performance_screen.dart';
import 'package:frontend/screens/busScreens/transport_screen.dart';
import 'package:frontend/screens/singleScreens/updates_screen.dart';
import 'package:frontend/screens/CertificateScreens/uploaded_certificates_screen.dart';
import 'package:frontend/services/Students_Parents_services.dart';
import 'package:frontend/services/prismBloc/prism_bloc.dart';
import 'package:frontend/widgets/custom_button.dart';
import 'package:frontend/widgets/drawer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/chatting/UI/screens/chat_screen_for_student.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.whoissignedin});
  final String whoissignedin;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final StudentParentServices authservice = StudentParentServices();
  final PrismBloc prismBloc = PrismBloc();

  @override
  void initState() {
    super.initState();
    // authservice.getUser(context);

    authservice.getAttendance(context);
    authservice.getPerformance(context);
    prismBloc.add(UserInitialFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<UserProvider>(context);
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
            userprovider.setUserFromModel(successState.user);

            return Scaffold(
              appBar: AppBar(
                elevation: 1.0,
                shadowColor: Color.fromARGB(255, 59, 58, 58),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'MREC ',
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        // const SizedBox(
                        //   width: 10.0,
                        // ),
                        const Text(
                          'PRISM',
                          style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                      ],
                    ),
                    //const SizedBox(width: 100),
                    Image.asset(
                      'assets/MREC_logo.png',
                      height: MediaQuery.of(context).size.height / 8,
                      width: MediaQuery.of(context).size.width / 8,
                    ),
                  ],
                ),
              ),
              drawer: const Drawerwidget(),
              backgroundColor: Color.fromARGB(250, 247, 248, 251),
              body: Container(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF7F8FB),
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        height: whois.isSignedIn == 'parent'
                            ? MediaQuery.of(context).size.height / 3.9
                            : MediaQuery.of(context).size.height / 4.5,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: whois.isSignedIn == 'parent'
                                    ? MediaQuery.of(context).size.width / 1.9
                                    : MediaQuery.of(context).size.width / 1.7,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 18,
                                    ),
                                    Text(
                                      'WELCOME,',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Text(
                                      whois.isSignedIn == 'parent'
                                          ? successState.user.FatherName
                                          : successState.user.StudentName,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color: Color.fromARGB(255, 0, 0, 0)),
                                    ),
                                    Text(
                                      whois.isSignedIn == 'parent'
                                          ? "f/o ${successState.user.StudentName}"
                                          : successState.user.RollNo
                                              .toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 18,
                                          color: Color.fromARGB(255, 0, 0, 0)),
                                    ),
                                    Text(
                                      "${successState.user.Department}-${successState.user.Section}",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  clipBehavior: Clip.hardEdge,
                                  height:
                                      MediaQuery.of(context).size.height / 6,
                                  width: MediaQuery.of(context).size.width / 4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: FadeInImage.assetNetwork(
                                    placeholder: 'assets/placeHolder.png',
                                    image: successState.user.ImageUrl,
                                    fit: BoxFit.fitHeight,
                                  )),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      const Center(
                        child: Text(
                          'Here are your latest updates',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Expanded(
                        child: GridView(
                          padding: const EdgeInsets.all(3),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 10,
                            childAspectRatio: 2 / 0.8,
                          ),
                          children: [
                            CustomButton(
                              buttonText: 'Attendance',
                              icon: Icons.person,
                              onPressed: AttendanceScreen(),
                            ),
                            CustomButton(
                              buttonText: 'Performance',
                              icon: Icons.speed,
                              onPressed: PerformanceScreen(),
                            ),
                            CustomButton(
                              buttonText: 'Fee Status',
                              icon: Icons.attach_money,
                              onPressed: FeeStatusScreen(),
                            ),
                            CustomButton(
                              buttonText: 'Circulars',
                              icon: Icons.blur_circular_sharp,
                              onPressed: Circulars(
                                department: successState.user.Department,
                                regulation: successState.user.Regulation,
                              ),
                            ),
                            CustomButton(
                              buttonText: 'Transpoart',
                              icon: Icons.bus_alert_rounded,
                              onPressed: Transportscreen(),
                            ),
                            CustomButton(
                              buttonText: 'Hostel',
                              icon: Icons.apartment,
                              onPressed: InstructionScreen(),
                            ),
                            Visibility(
                              visible: whois.isSignedIn == 'student',
                              child: CustomButton(
                                buttonText: 'Certificates',
                                icon: Icons.verified,
                                onPressed: UploadedCertificatesScreen(
                                    rno: successState.user.RollNo),
                              ),
                            ),
                            Visibility(
                              visible: whois.isSignedIn == 'student',
                              child: CustomButton(
                                buttonText: 'Books',
                                icon: Icons.book,
                                onPressed: BooksHomeScreen(),
                              ),
                            ),
                            Visibility(
                              visible: whois.isSignedIn == 'student',
                              child: CustomButton(
                                buttonText: 'Library',
                                icon: Icons.library_books,
                                onPressed: LibraryScreen(),
                              ),
                            ),
                            Visibility(
                              visible: whois.isSignedIn == 'student',
                              child: CustomButton(
                                buttonText: 'Prev QP',
                                icon: Icons.all_inbox_outlined,
                                onPressed: PrevQPViewScreen(),
                              ),
                            ),
                            Visibility(
                              visible: whois.isSignedIn == 'student',
                              child: CustomButton(
                                buttonText: 'Chat',
                                icon: Icons.message,
                                onPressed: StudentChatScreen(),
                              ),
                            ),
                            Visibility(
                              visible: whois.isSignedIn == 'student',
                              child: CustomButton(
                                buttonText: 'Upadtes',
                                icon: Icons.notifications,
                                onPressed: UpdatesViewScreen(
                                    department: successState.user.Department,
                                    regulation: successState.user.Regulation,
                                    section: successState.user.Section),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          default:
            return SizedBox();
        }
      },
    );
  }
}

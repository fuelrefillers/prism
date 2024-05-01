import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/Faculty_Module/Acedemics.dart';
import 'package:frontend/Faculty_Module/Announcement_screen.dart';
import 'package:frontend/Faculty_Module/adjust_attendance.dart';
import 'package:frontend/Faculty_Module/books_picker_screen.dart';
import 'package:frontend/Faculty_Module/circular_picker_screen.dart';
import 'package:frontend/Faculty_Module/delete_updates_screen.dart';
import 'package:frontend/Faculty_Module/download_attendance.dart';
import 'package:frontend/Faculty_Module/faculty_classes_assignment_deletion_screen.dart';
import 'package:frontend/Faculty_Module/home_screen.dart';
import 'package:frontend/Faculty_Module/hostel_admin/hostel_admin_home_screen.dart';
import 'package:frontend/Faculty_Module/new_faculty_or_class_assignment_screen.dart';
import 'package:frontend/Faculty_Module/substitue_page.dart';
import 'package:frontend/Faculty_Module/time_table_picker_screen.dart';
import 'package:frontend/Faculty_Module/uploadPrevQuestionPapers.dart';
import 'package:frontend/chatting/UI/screens/chat_home_screen.dart';
import 'package:frontend/location/location_sharing.dart';
import 'package:frontend/providers/faculty_provider.dart';
import 'package:frontend/services/auth.dart';
import 'package:frontend/services/faculty_services.dart';
import 'package:frontend/services/prismBloc/prism_bloc.dart';
import 'package:frontend/widgets/custom_button.dart';
import 'package:frontend/widgets/drawer.dart';
import 'package:provider/provider.dart';

class FacultyHomeScreen extends StatefulWidget {
  const FacultyHomeScreen({super.key});
  @override
  State<FacultyHomeScreen> createState() {
    return _FacultyHomeScreenState();
  }
}

class _FacultyHomeScreenState extends State<FacultyHomeScreen> {
  Authservice authservice = Authservice();
  FacultyServices ss = FacultyServices();
  final PrismBloc prismBloc =
      PrismBloc(); // Create an instance of SocketService
  @override
  void initState() {
    super.initState();
    prismBloc.add(FacultyInitialFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    final facultyprovider =
        Provider.of<FacultyProvider>(context, listen: false);
    return BlocConsumer<PrismBloc, PrismState>(
      bloc: prismBloc,
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case FacultyFetchingLoadingState:
            return Scaffold(
              appBar: AppBar(
                title: Text("MREC Prism"),
              ),
              drawer: const Drawerwidget(),
              body: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          case FacultyFetchingSuccessfullState:
            final successState = state as FacultyFetchingSuccessfullState;
            ss.setFacultyTimeTable(
                facultyId: successState.faculty.FacultyId, context: context);
            facultyprovider.setFacultyFromModel(successState.faculty);

            List<Widget> buttons = [
              CustomButton(
                buttonText: "Student Attendace",
                icon: Icons.person,
                onPressed: MarkAttendacePage(title: "Mark Attendance"),
              ),
              CustomButton(
                buttonText: "upload books",
                icon: Icons.person,
                onPressed: PickImage(),
              ),
              CustomButton(
                buttonText: "Post Updates",
                icon: Icons.person,
                onPressed: UpdatesScreen(),
              ),
              CustomButton(
                buttonText: "Delete Updates",
                icon: Icons.person,
                onPressed: DeleteUpdatesScreen(
                  name: successState.faculty.FacultyName,
                  id: successState.faculty.FacultyId,
                ),
              ),
              CustomButton(
                buttonText: "Edit Attendance",
                icon: Icons.person,
                onPressed: AdjustAttendacePage(title: "hello"),
              ),
              CustomButton(
                buttonText: "chat",
                icon: Icons.person,
                onPressed: ChattingHomeScreen(),
              ),
              CustomButton(
                buttonText: "Substitute",
                icon: Icons.person,
                onPressed: SubstitutePage(),
              ),
              // CustomButton(
              //   buttonText: "mid",
              //   icon: Icons.person,
              //   onPressed: MidMarksScreen(),
              // ),
            ];

            if (successState.faculty.IsAdmin) {
              buttons.addAll([
                CustomButton(
                  buttonText: "upload circular",
                  icon: Icons.person,
                  onPressed: CircularPickerScreen(),
                ),
                CustomButton(
                  buttonText: "upload Time Table  ",
                  icon: Icons.person,
                  onPressed: TimeTablePickerScreen(),
                ),
                CustomButton(
                  buttonText: "Acedemics",
                  icon: Icons.person,
                  onPressed: AcademicsPage(),
                ),
                CustomButton(
                  buttonText: "faculty assign",
                  icon: Icons.person,
                  onPressed: NewFacultyOrChangeClassesScreen(),
                ),
                CustomButton(
                  buttonText: "Faculty management",
                  icon: Icons.person,
                  onPressed: FacultyClassAssignmentOrdeletionScreen(),
                ),
                CustomButton(
                  buttonText: "Download Attendance",
                  icon: Icons.person,
                  onPressed: DownloadAttendanceScreen(),
                ),
                CustomButton(
                  buttonText: "prevQP",
                  icon: Icons.person,
                  onPressed: UploadPrevQPScreen(),
                ),
                CustomButton(
                  buttonText: "Location Demo",
                  icon: Icons.person,
                  onPressed: LocationTracker(),
                ),
                CustomButton(
                  buttonText: "Hostels Admin",
                  icon: Icons.person,
                  onPressed: HostelAdminHomeScreen(),
                ),
              ]);
            }

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
                          'MREC',
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
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
                        height: MediaQuery.of(context).size.height / 4.8,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 22.5,
                                    ),
                                    Text(
                                      'WELCOME,',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Text(
                                      successState.faculty.FacultyName,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Color.fromARGB(255, 0, 0, 0)),
                                    ),
                                    Text(
                                      successState.faculty.FacultyId,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          color: Color.fromARGB(255, 0, 0, 0)),
                                    ),
                                    Text(
                                      successState.faculty.FacultyDesignation,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                clipBehavior: Clip.hardEdge,
                                height: MediaQuery.of(context).size.height / 6,
                                width: MediaQuery.of(context).size.width / 4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Image(
                                  image: AssetImage('assets/placeHolder.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
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
                        child: GridView.builder(
                          padding: const EdgeInsets.all(3),
                          itemCount: buttons.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 10,
                            childAspectRatio: 2 / 0.8,
                          ),
                          itemBuilder: (context, index) => buttons[index],
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

import 'package:flutter/material.dart';
import 'package:frontend/Faculty_Module/faculty-home-screen.dart';
import 'package:frontend/providers/atten_confirm_provider.dart';
import 'package:frontend/providers/is_error_provider.dart';
import 'package:frontend/providers/is_loading_provider.dart';
import 'package:frontend/widgets/multipurpose_link_card.dart';
import 'package:provider/provider.dart';

class AttendanceLoadingScreen extends StatelessWidget {
  const AttendanceLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Consumer<isLoadinProvider>(
          builder: (context, value, child) => value.isloading
              ? Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : Consumer<isErrorProvider>(
                  builder: (context, value, child) => value.isError
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text("Error"),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              FacultyHomeScreen()),
                                      (route) => false);
                                },
                                child: Text("Go home"))
                          ],
                        )
                      : Consumer<AttendanceConfirm>(
                          builder: (context, atten, child) => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  "Attendance marked successfully",
                                  style: TextStyle(fontSize: 22),
                                ),
                              ),
                              Text(
                                "Abscentees :",
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                height: 300,
                                child: ListView.builder(
                                  itemCount:
                                      atten.attenConfirm.absentees.length,
                                  itemBuilder: (context, index) =>
                                      MultiPurposeLinkCard(
                                    url: "",
                                    category:
                                        atten.attenConfirm.absentees[index],
                                    subcategory1: '',
                                    subcategory: '',
                                    height1: 50,
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  "Total no of presentees : ${atten.attenConfirm.attendees}",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FacultyHomeScreen()),
                                        (route) => false);
                                  },
                                  child: Text("Go home"))
                            ],
                          ),
                        ),
                ),
        ),
      ),
    );
  }
}


// Consumer<AttendanceConfirm>(
//                   builder: (context, atten, child) => Column(
//                     children: [
//                       Center(
//                         child: Text(atten.attenConfirm.attendees.toString()),
//                       ),
//                       ElevatedButton(
//                           onPressed: () {
//                             Navigator.pushAndRemoveUntil(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => FacultyHomeScreen()),
//                                 (route) => false);
//                           },
//                           child: Text("Go home"))
//                     ],
//                   ),
//                 ),
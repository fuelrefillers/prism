import 'package:flutter/material.dart';
import 'package:frontend/Faculty_Module/attendace_loading_page.dart';
import 'package:frontend/providers.dart/is_error_provider.dart';
import 'package:frontend/providers.dart/is_loading_provider.dart';
import 'package:frontend/services/faculty_services.dart';
import 'package:provider/provider.dart';

class ReviewAndSubmitScreen extends StatefulWidget {
  const ReviewAndSubmitScreen(
      {super.key,
      required this.selected,
      required this.regulation,
      required this.section,
      required this.department,
      required this.startTime,
      required this.endTime});
  final List<String> selected;
  final String section;
  final String department;
  final String regulation;
  final String startTime;
  final String endTime;
  @override
  State<ReviewAndSubmitScreen> createState() {
    return _ReviewAndSubmitScreenState();
  }
}

class _ReviewAndSubmitScreenState extends State<ReviewAndSubmitScreen> {
  final FacultyServices service = FacultyServices();
  List<String> review = [];

  @override
  void initState() {
    super.initState();
    review = widget.selected;
  }

  void onRollnoSelected(bool? value, rollno) {
    if (value == true) {
      setState(() {
        review.add(rollno);
      });
    } else {
      setState(() {
        review.remove(rollno);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Review And Submit"),
      ),
      body: Column(
        children: [
          Container(
            child: Expanded(
              child: ListView.builder(
                itemCount: widget.selected.length,
                itemBuilder: (context, index) => CheckboxListTile(
                  value: review.contains(widget.selected[index]),
                  onChanged: (bool? value) {
                    onRollnoSelected(value, widget.selected[index]);
                  },
                  title: Text(widget.selected[index].toUpperCase()),
                  subtitle: const Text('Supporting text'),
                ),
              ),
            ),
          ),
          Container(
            child: Expanded(
              child: ListView.builder(
                  itemCount: review.length,
                  itemBuilder: (context, index) => ElevatedButton(
                      onPressed: () {}, child: Text(review[index]))),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          print(review);
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text("Conformation"),
              content:
                  const Text("Click ok to Submit and go back to main page"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("cancel"),
                ),
                TextButton(
                  onPressed: () {
                    service.setAttendance(
                        rollnumbers: review,
                        section: widget.section,
                        department: widget.department,
                        regulation: widget.regulation,
                        startTime: widget.startTime,
                        endTime: widget.endTime,
                        context: context);
                    Navigator.pop(context);
                    final loaging =
                        Provider.of<isLoadinProvider>(context, listen: false);
                    final Err =
                        Provider.of<isErrorProvider>(context, listen: false);
                    if (loaging.isloading == false) {
                      loaging.changeStatus();
                    }
                    if (Err.isError == true) {
                      Err.changeStatus();
                    }
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const AttendanceLoadingScreen()),
                        (route) => false);
                  },
                  child: const Text("Okay"),
                ),
              ],
            ),
          );
        },
        label: Text("Submit"),
      ),
    );
  }
}

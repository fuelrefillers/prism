import 'package:flutter/material.dart';
import 'package:frontend/models/time_table_view_model.dart';
import 'package:frontend/services/Students_Parents_services.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';

class StudentTimeTableScreen extends StatefulWidget {
  final String regulation;
  final String department;
  final String section;
  const StudentTimeTableScreen(
      {super.key,
      required this.regulation,
      required this.department,
      required this.section});

  @override
  State<StudentTimeTableScreen> createState() => _StudentTimeTableScreenState();
}

class _StudentTimeTableScreenState extends State<StudentTimeTableScreen> {
  StudentParentServices service = StudentParentServices();
  List<TimeTableView> timeTable = [];
  DateTime date = DateTime.now();

  @override
  void initState() {
    super.initState();
    assign();
  }

  void assign() async {
    List<TimeTableView> temp = await service.getTimeTableForStudents(
        regulation: widget.regulation,
        department: widget.department,
        section: widget.section);
    setState(() {
      timeTable = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Time Table"),
      ),
      body: Column(
        children: [
          _customBackgroundExample(),
          timeTable.isEmpty
              ? CircularProgressIndicator.adaptive()
              : Expanded(
                  child: date.weekday <= 6
                      ? timeTable[date.weekday - 1].Periods.isNotEmpty
                          ? ListView.builder(
                              itemCount:
                                  timeTable[date.weekday - 1].Periods.length,
                              itemBuilder: (BuildContext context, int index) {
                                final temp =
                                    timeTable[date.weekday - 1].Periods[index];
                                return ListTile(
                                  leading: Text(temp.classType),
                                  title: Text(temp.className),
                                  subtitle: Text(
                                      "${temp.startTime} - ${temp.endTime}"),
                                );
                              },
                            )
                          : Text("No Classes")
                      : Text("Today is sunday"),
                ),
        ],
      ),
    );
  }

  EasyDateTimeLine _customBackgroundExample() {
    return EasyDateTimeLine(
      initialDate: DateTime.now(),
      onDateChange: (selectedDate) {
        //`selectedDate` the new date selected.
        setState(() {
          date = selectedDate;
        });
      },
      headerProps: const EasyHeaderProps(
        monthPickerType: MonthPickerType.switcher,
        dateFormatter: DateFormatter.fullDateDMY(),
      ),
      dayProps: const EasyDayProps(
        dayStructure: DayStructure.dayStrDayNum,
        activeDayStyle: DayStyle(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff3371FF),
                Color(0xff8426D6),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

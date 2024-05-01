import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Faculty_Module/select_adjusted_rollno.dart';
import 'package:frontend/providers/time_table_view_provider.dart';
import 'package:frontend/widgets/multi_purpose_card.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AdjustAttendacePage extends StatefulWidget {
  const AdjustAttendacePage({super.key, required this.title});

  final String title;

  @override
  State<AdjustAttendacePage> createState() => _AdjustAttendacePageState();
}

class _AdjustAttendacePageState extends State<AdjustAttendacePage> {
  DateTime date = DateTime.now();
  final EasyInfiniteDateTimelineController _controller =
      EasyInfiniteDateTimelineController();
  DateTime? _focusDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final FTP = Provider.of<FacultyTimeTableProvider>(context, listen: false)
        .facultyTimeTable;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          EasyInfiniteDateTimeLine(
            controller: _controller,
            firstDate: DateTime(2024),
            focusDate: _focusDate,
            lastDate: DateTime.now(),
            onDateChange: (selectedDate) {
              print(DateFormat.Hm().format(selectedDate));
              setState(() {
                _focusDate = selectedDate;
                date = selectedDate;
              });
            },
          ),
          Expanded(
            child: date.weekday <= 6
                ? FTP.TimeTable[date.weekday - 1].Periods.isNotEmpty
                    ? ListView.builder(
                        itemCount:
                            FTP.TimeTable[date.weekday - 1].Periods.length,
                        itemBuilder: (BuildContext context, int index) {
                          final temp =
                              FTP.TimeTable[date.weekday - 1].Periods[index];
                          return MultiPurposeCard(
                            category:
                                "${temp.Department}-${temp.Section} ${temp.SubjectName}",
                            subcategory: "${temp.StartTime} - ${temp.EndTime}",
                            subcategory1: "",
                            height1: 90,
                            screen: AdjustSelectedScreen(
                              department: temp.Department,
                              section: temp.Section,
                              regulation: temp.Regulation,
                              startTime: temp.StartTime,
                              endTime: temp.EndTime,
                              selectedDate: date,
                            ),
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
}

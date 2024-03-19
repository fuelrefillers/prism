import 'package:flutter/material.dart';
import 'package:frontend/models/time_table_view_model.dart';
import 'package:frontend/providers.dart/time_table_view_provider.dart';
import 'package:provider/provider.dart';

class TimeTableViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Table'),
      ),
      body: Center(
        child: Consumer<TimeTableViewProvider>(
          builder: (context, provider, child) {
            // Access the timetable view data from the provider
            List<TimeTableView> timeTableViews = provider.timeTableViews;

            // Check if timetable data is available
            if (timeTableViews.isEmpty) {
              return CircularProgressIndicator(); // Show loading indicator
            }

            // Display timetable views in a ListView
            return ListView.builder(
              itemCount: timeTableViews.length,
              itemBuilder: (context, index) {
                TimeTableView timeTableView = timeTableViews[index];
                return ListTile(
                  title: Text(timeTableView.Day),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: timeTableView.Periods.map((period) {
                      return Text(
                          '${period.startTime} - ${period.endTime}: ${period.className} -- ${period.lecturerName}');
                    }).toList(),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

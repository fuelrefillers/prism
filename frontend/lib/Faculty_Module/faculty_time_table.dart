import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/faculty_time_table_model.dart';
import 'package:frontend/providers.dart/time_table_view_provider.dart';
import 'package:provider/provider.dart';

class FacultyTimeTableScreen extends StatefulWidget {
  const FacultyTimeTableScreen({super.key});

  @override
  State<FacultyTimeTableScreen> createState() => _FacultyTimeTableScreenState();
}

class _FacultyTimeTableScreenState extends State<FacultyTimeTableScreen> {
  Iterable<DataRow> mapSemMarksToList(List<FTimeTable> semmarks) {
    Iterable<DataRow> dataRows = semmarks.map((semmark) {
      List<DataCell> cells = [
        DataCell(
          Text(semmark.Day),
        ),
      ];

      if (semmark.Periods.isEmpty) {
        cells.add(
          DataCell(
            Text("NO Period"),
          ),
        );
      } else {
        semmark.Periods.forEach((period) {
          cells.addAll([
            DataCell(
              Text(
                "${period.Department} - ${period.Section}\n${period.SubjectName}",
              ),
            ),
          ]);
        });
      }

      return DataRow(cells: cells);
    });
    return dataRows;
  }

  @override
  Widget build(BuildContext context) {
    final FTT = Provider.of<FacultyTimeTableProvider>(context, listen: false)
        .facultyTimeTable;
    return Scaffold(
      appBar: AppBar(
        title: Text(FTT.FacultyName),
      ),
      body: FTT.TimeTable.isEmpty
          ? Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.3,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: DataTable2(
                      dataRowHeight: 60,
                      columnSpacing: 10,
                      horizontalMargin: 12,
                      minWidth: 600,
                      lmRatio: 2,
                      columns: [
                        DataColumn2(
                          label: Text('09:30 - 10:20'),
                          size: ColumnSize.L,
                        ),
                        DataColumn2(
                          fixedWidth: 150,
                          label: Text('10:20 - 11:10'),
                          size: ColumnSize.L,
                        ),
                        DataColumn2(
                          label: Text('11:20 - 12:10'),
                          size: ColumnSize.L,
                        ),
                        DataColumn2(
                          label: Text('12:10 - 01:00'),
                          size: ColumnSize.L,
                        ),
                        DataColumn2(
                          label: Text('01:45 - 02:35'),
                          size: ColumnSize.L,
                        ),
                        DataColumn2(
                          label: Text('02:35 - 03:25'),
                          size: ColumnSize.L,
                        ),
                        DataColumn2(
                          label: Text('03:25 - 04:15'),
                          size: ColumnSize.L,
                        ),
                      ],
                      rows: mapSemMarksToList(FTT.TimeTable).toList(),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}

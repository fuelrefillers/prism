import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:frontend/models/semmarks_model.dart';
import 'package:frontend/providers.dart/is_loading_provider.dart';
import 'package:frontend/services/auth.dart';
import 'package:provider/provider.dart';

class SemMarksScreen extends StatefulWidget {
  const SemMarksScreen({super.key, required this.name, required this.RollNo});
  final String name;
  final String RollNo;
  @override
  State<SemMarksScreen> createState() => _SemMarksScreenState();
}

class _SemMarksScreenState extends State<SemMarksScreen> {
  Authservice authservice = Authservice();
  bool isError = false;
  @override
  List<SemMarks> marks = [];
  void initState() {
    super.initState();
    gettingdata();
  }

  void gettingdata() async {
    List<SemMarks> marks1 =
        await authservice.getmarks(context, widget.RollNo, widget.name[4]);
    await Future.delayed(Duration(milliseconds: 700));
    setState(() {
      marks = marks1;
    });
    await Future.delayed(Duration(seconds: 5));
    if (marks.isEmpty) {
      setState(() {
        isError = true;
      });
    }
  }

  Iterable<DataRow> mapSemMarksToList(List<SemMarks> semmarks) {
    Iterable<DataRow> dataRows = semmarks.map(
      (semmark) => DataRow(
        cells: [
          DataCell(
            Text(semmark.CourseCode),
          ),
          DataCell(
            Text(semmark.CourseName),
          ),
          DataCell(
            Text(semmark.Int.toString()),
          ),
          DataCell(
            Text(semmark.Ext.toString()),
          ),
          DataCell(
            Text(semmark.Total.toString()),
          ),
          DataCell(
            Text(semmark.GradePoints.toString()),
          ),
          DataCell(
            Text(semmark.Grade),
          ),
          DataCell(
            Text(semmark.Credits.toString()),
          ),
        ],
      ),
    );
    return dataRows;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: marks.isEmpty && isError == false
          ? Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : isError
              ? Center(
                  child: Text(
                      "Something went wrong or resultrs aren't updated yet !!!"),
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
                              label: Text('Course\nCode'),
                              size: ColumnSize.L,
                            ),
                            DataColumn2(
                              fixedWidth: 150,
                              label: Text('Course\nName'),
                              size: ColumnSize.L,
                            ),
                            DataColumn2(
                              label: Text('Internal'),
                              size: ColumnSize.L,
                            ),
                            DataColumn2(
                              label: Text('External'),
                              size: ColumnSize.L,
                            ),
                            DataColumn2(
                              fixedWidth: 50,
                              label: Text('Total'),
                              //size: ColumnSize.L,
                              numeric: true,
                            ),
                            DataColumn2(
                              label: Text('Grade\nPoints'),
                              size: ColumnSize.L,
                              numeric: true,
                            ),
                            DataColumn2(
                              label: Text('Grade'),
                              size: ColumnSize.L,
                              numeric: true,
                            ),
                            DataColumn2(
                              label: Text('Credits'),
                              size: ColumnSize.L,
                              numeric: true,
                            ),
                          ],
                          rows: mapSemMarksToList(marks).toList(),
                        ),
                      ),
                    )
                  ],
                ),
    );
  }
}

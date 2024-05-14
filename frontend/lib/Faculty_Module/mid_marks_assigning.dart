import 'dart:convert';
import 'package:data_table_2/data_table_2.dart';
import 'package:frontend/Faculty_Module/mid_marks_model.dart';
import 'package:frontend/util/util.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:frontend/Faculty_Module/mid_details_model.dart';
import 'package:frontend/services/ip.dart';

class MidMarksAssigningScreen extends StatefulWidget {
  final MidDetails midDetails;
  final String FID;
  const MidMarksAssigningScreen(
      {Key? key, required this.midDetails, required this.FID})
      : super(key: key);

  @override
  State<MidMarksAssigningScreen> createState() =>
      _MidMarksAssigningScreenState();
}

class _MidMarksAssigningScreenState extends State<MidMarksAssigningScreen> {
  List<MidMarksModel> midMarks = [];
  Map<String, int> subMarks = {};
  Map<String, int> assignmentMarks = {};

  @override
  void initState() {
    super.initState();
    getMarksSheet();
  }

  void getMarksSheet() async {
    try {
      http.Response res = await http.post(
        Uri.parse(
            "${ip}/api/midmarks/getData?regulation=${widget.midDetails.Regulation}&department=${widget.midDetails.Department}&section=${widget.midDetails.Section}"),
        body: jsonEncode(
            {"LecturerId": widget.FID, "Mid": widget.midDetails.Mid}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (res.statusCode == 200) {
        print(res.body);
        List<MidMarksModel> temp = [];
        var result = jsonDecode(res.body);

        for (int i = 0; i < result.length; i++) {
          MidMarksModel s =
              MidMarksModel.fromMap(result[i] as Map<String, dynamic>);
          temp.add(s);
        }
        setState(() {
          midMarks = temp;
          midMarks.forEach((element) {
            subMarks[element.RollNo] = 0;
            assignmentMarks[element.RollNo] = 0;
          });
        });
      }
    } catch (e) {
      print(e);
    }
  }
//   Map<String, dynamic> toJson() {
//   return {
//     'RollNo': RollNo,
//     'Marks': Marks,
//   };
// }

  void updateMarks() async {
    try {
      // String midMarksJSON = jsonEncode(midMarks);
      print(midMarks.map((model) => model.toJson()).toList());
      var response = await http.post(
        Uri.parse('${ip}/api/midmarks/update'),
        body: jsonEncode({
          "Regulation": widget.midDetails.Regulation,
          "Department": widget.midDetails.Department,
          "Section": widget.midDetails.Section,
          "LecturerId": widget.FID,
          "Mid": widget.midDetails.Mid,
          "Students": midMarks.map((model) => model.toMap()).toList()
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        showSnackBar(context, "Updated");
      }
    } catch (e) {
      print(e);
    }
  }

  int calculateTotalMarks(int subjective, int assignment) {
    return subjective + assignment;
  }

  void updateTotalAndFinalMarks(MidMarksModel mm) {
    mm.Marks =
        calculateTotalMarks(subMarks[mm.RollNo]!, assignmentMarks[mm.RollNo]!);
    // Update the final marks logic here if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Assigning"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 50),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height - 200,
                child: DataTable2(
                  dataRowHeight: 60,
                  columnSpacing: 10,
                  horizontalMargin: 12,
                  minWidth: 600,
                  lmRatio: 2,
                  columns: [
                    DataColumn2(
                      label: Text('RollNo'),
                      size: ColumnSize.L,
                    ),
                    DataColumn2(
                      fixedWidth: 150,
                      label: Text('Subjective'),
                      size: ColumnSize.L,
                    ),
                    DataColumn2(
                      label: Text('Assignment'),
                      size: ColumnSize.L,
                    ),
                    DataColumn2(
                      label: Text('Total'),
                      size: ColumnSize.L,
                    ),
                    DataColumn2(
                      label: Text('Final'),
                      size: ColumnSize.L,
                    ),
                  ],
                  rows: midMarks
                      .map((mm) => DataRow(
                            cells: [
                              DataCell(Text(mm.RollNo)),
                              DataCell(TextFormField(
                                initialValue: subMarks[mm.RollNo]!.toString(),
                                onChanged: (newValue) {
                                  setState(() {
                                    subMarks[mm.RollNo] = int.parse(newValue);
                                    updateTotalAndFinalMarks(mm);
                                  });
                                },
                              )),
                              DataCell(TextFormField(
                                initialValue:
                                    assignmentMarks[mm.RollNo]!.toString(),
                                onChanged: (newValue) {
                                  setState(() {
                                    assignmentMarks[mm.RollNo] =
                                        int.parse(newValue);
                                    updateTotalAndFinalMarks(mm);
                                  });
                                },
                              )),
                              DataCell(Text(calculateTotalMarks(
                                      subMarks[mm.RollNo]!,
                                      assignmentMarks[mm.RollNo]!)
                                  .toString())),
                              DataCell(Text(mm.Marks.toString())),
                            ],
                          ))
                      .toList(),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  print(jsonEncode(midMarks));
                  updateMarks();
                },
                child: Text("submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

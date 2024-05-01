import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Faculty_Module/selection_pannel/file_selection_pannel.dart';
import 'package:frontend/services/ip.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:provider/provider.dart';

class StudentForm extends StatefulWidget {
  const StudentForm({super.key, required this.rno});
  final String rno;
  @override
  _StudentFormState createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _rollNoController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _regulationController = TextEditingController();
  final TextEditingController _sectionController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _certificationByController =
      TextEditingController();
  final TextEditingController _courseController = TextEditingController();

  String? fileName;
  String? path;
  double ovProgress = 0.00;

  bool isUploadStarted = false;
  bool isUploadComplete = false;

  Future<void> uploadCertificate(
      {required String course,
      required String? filePath,
      required String certificationBy,
      required String section,
      required String regulation,
      required String department,
      required String name}) async {
    Dio dio = Dio();

    try {
      setState(() {
        isUploadComplete = false;
        isUploadStarted = true;
      });
      FormData formData = FormData.fromMap({
        'rollno': widget.rno,
        'department': department.toUpperCase(),
        'regulation': regulation.toUpperCase(),
        'section': department.toUpperCase(),
        'certificationBy': certificationBy,
        'course': course,
        'name': name,
        'certificatePdf': await MultipartFile.fromFile(filePath!),
      });

      var response;
      response = await dio.post(
        '${ip}/api/certificates/upload',
        data: formData,
        onSendProgress: (int sent, int total) {
          double progress = sent / total;
          setState(() {
            ovProgress = progress;
          });
          // print('Upload progress: ${(progress * 100).toStringAsFixed(2)}%');
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          isUploadComplete = true;
          isUploadStarted = false;
        });
        // print(response.body);
        print('Image and data uploaded successfully');
      } else {
        print(
            'Failed to upload image and data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading image and data: $e');
    }
  }

  @override
  void dispose() {
    _rollNoController.dispose();
    _departmentController.dispose();
    _regulationController.dispose();
    _sectionController.dispose();
    _nameController.dispose();
    _certificationByController.dispose();
    _courseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: Text('Student Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Certification Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _certificationByController,
                decoration: InputDecoration(labelText: 'Certification By'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Certification By';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _courseController,
                decoration: InputDecoration(labelText: 'Course'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Course';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        List<String>? ans = await showPdfPickerOption(context);

                        if (ans.isNotEmpty && ans.length == 2) {
                          setState(() {
                            fileName = ans[0];
                            path = ans[1];
                          });
                          print(ans);
                        } else {
                          showTypeError(context,
                              "Error: Invalid response from showPdfPickerOption");
                        }
                      },
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        height: 200,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: fileName != null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/pdfexist.jpg',
                                    scale: 1.8,
                                  ),
                                  Text(
                                    fileName!.toString(),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/addpdf.jpg',
                                    scale: 1.8,
                                  ),
                                  Text("no pdf selected"),
                                ],
                              ),
                      ),
                    ),
                  ),
                ],
              ),
              isUploadStarted
                  ? LinearProgressIndicator(
                      value: ovProgress,
                    )
                  : isUploadComplete
                      ? Text("Upload complete")
                      : Text("Not yet uploaded")
              // ElevatedButton(
              //   onPressed: () {
              //     if (_formKey.currentState!.validate()) {}
              //   },
              //   child: Text('Submit'),
              // ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            uploadCertificate(
                regulation: user.Regulation,
                department: user.Department,
                section: user.Section,
                name: _nameController.text.toUpperCase(),
                course: _courseController.text.toUpperCase(),
                certificationBy: _certificationByController.text.toUpperCase(),
                filePath: path);
          }
        },
        child: Icon(Icons.upload),
      ),
    );
  }

  void showTypeError(BuildContext context, String errtxt) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Conformation"),
        content: Text(errtxt),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Okay"),
          ),
        ],
      ),
    );
  }
}

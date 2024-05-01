import 'package:flutter/material.dart';
import 'package:frontend/Faculty_Module/selection_pannel/file_selection_pannel.dart';
import 'package:frontend/providers/download_provider.dart';
import 'package:frontend/providers/upload_percentage_provider.dart';
import 'package:frontend/services/faculty_services.dart';
import 'package:provider/provider.dart';

class UploadPrevQPScreen extends StatefulWidget {
  const UploadPrevQPScreen({Key? key}) : super(key: key);

  @override
  State<UploadPrevQPScreen> createState() => _UploadPrevQPScreenState();
}

class _UploadPrevQPScreenState extends State<UploadPrevQPScreen> {
  late UploadPercentageProvider progressProvider;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final download = Provider.of<DownloadProvider>(context, listen: false);
      progressProvider =
          Provider.of<UploadPercentageProvider>(context, listen: false);
      progressProvider.setprogress(0.00);

      if (download.isDownloaded == true) {
        download.changeStatus();
      }
    });
  }

  FacultyServices facultyServices = FacultyServices();
  TextEditingController subjectNameController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController regulationController = TextEditingController();

  String? fileName;
  String? path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PrevQP Upload"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 5),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: subjectNameController,
                  decoration: InputDecoration(
                    labelText: "Subject Name",
                    fillColor: const Color.fromARGB(255, 215, 224, 243),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter subject name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: departmentController,
                  decoration: InputDecoration(
                    labelText: "Enter the Department Name",
                    fillColor: Color.fromARGB(255, 215, 224, 243),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter department name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: regulationController,
                  decoration: InputDecoration(
                    labelText: "Enter the Regulation",
                    fillColor: const Color.fromARGB(255, 215, 224, 243),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter regulation';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          List<String>? ans =
                              await showPdfPickerOption(context);

                          if (ans != null &&
                              ans.isNotEmpty &&
                              ans.length == 2) {
                            setState(() {
                              fileName = ans[0];
                              path = ans[1];
                            });
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
                Consumer<UploadPercentageProvider>(
                  builder: (context, progressfinal, child) =>
                      progressfinal.progress == 0.00
                          ? Text("not uploaded")
                          : Consumer<DownloadProvider>(
                              builder: (context, value, child) => double.parse(
                                              progressfinal.progress
                                                  .toStringAsFixed(2)) ==
                                          1.00 &&
                                      value.isDownloaded == true
                                  ? Column(
                                      children: [
                                        Text("Upload complete"),
                                        ElevatedButton(
                                            onPressed: () {
                                              _resetForm();
                                            },
                                            child: Text("upload another QP"))
                                      ],
                                    )
                                  : LinearProgressIndicator(
                                      value: progressfinal.progress,
                                    ),
                            ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _submitForm();
          }
        },
        child: Text("submit"),
      ),
    );
  }

  void _submitForm() {
    facultyServices.uploadImage(
      context: context,
      filePath: path!,
      image: null,
      type: 'prevQP',
      api: 'prevQP',
      typename: subjectNameController.text,
      regulation: regulationController.text,
      department: departmentController.text,
    );
  }

  void _resetForm() {
    subjectNameController.clear();
    departmentController.clear();
    regulationController.clear();
    final download = Provider.of<DownloadProvider>(context, listen: false);
    progressProvider =
        Provider.of<UploadPercentageProvider>(context, listen: false);
    progressProvider.setprogress(0.00);

    if (download.isDownloaded == true) {
      download.changeStatus();
    }
    setState(() {
      path = null;
      fileName = null;
    });
  }

  void showTypeError(BuildContext context, String errtxt) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Confirmation"),
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

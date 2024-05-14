import 'dart:io';
import 'package:frontend/Faculty_Module/selection_pannel/file_selection_pannel.dart';
import 'package:frontend/Faculty_Module/selection_pannel/photo_selection_pannel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/providers/download_provider.dart';
import 'package:frontend/providers/upload_percentage_provider.dart';
import 'package:frontend/services/faculty_services.dart';
import 'package:provider/provider.dart';

class PickImage extends StatefulWidget {
  const PickImage({super.key});

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  FacultyServices facultyServices = FacultyServices();
  late UploadPercentageProvider progressProvider;

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

  final TextEditingController BookNameController = TextEditingController();
  final TextEditingController DepartmentController = TextEditingController();
  final TextEditingController regulationController = TextEditingController();
  Uint8List? _image;
  String? fileName;
  String? path;
  File? selectedIMage;
  File? selectedFile;

  @override
  Widget build(BuildContext context) {
    // final progress =
    //     Provider.of<UploadPercentageProvider>(context, listen: false);

    // progress.setprogress(0.00);

    return Scaffold(
      appBar: AppBar(
        title: Text("Books Upload"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: BookNameController,
                decoration: InputDecoration(
                  labelText: "Enter the Book Name",
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 17, 79, 90),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: DepartmentController,
                decoration: InputDecoration(
                  labelText: "Enter the Department Name",
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 17, 79, 90),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: regulationController,
                decoration: InputDecoration(
                  labelText: "Enter the regulation",
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 17, 79, 90),
                  ),
                ),
              ),
              SizedBox(height: 50.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      Uint8List? dummy = await showImagePickerOption(context);
                      setState(() {
                        _image = dummy;
                      });
                    },
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      height: MediaQuery.of(context).size.height / 6,
                      width: MediaQuery.of(context).size.width / 3,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.28),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        //  border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: _image != null
                          ? Image(
                              image: MemoryImage(_image!),
                              fit: BoxFit.cover,
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/fileadd.jpg',
                                  scale: 2.5,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Add image",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 252, 164, 41)),
                                ),
                              ],
                            ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  InkWell(
                    onTap: () async {
                      List<String>? ans = await showPdfPickerOption(context);

                      if (ans.isNotEmpty && ans.length == 2) {
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
                      height: MediaQuery.of(context).size.height / 6,
                      width: MediaQuery.of(context).size.width / 3,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 152, 152, 152)
                                .withOpacity(0.28),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
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
                                  scale: 2.2,
                                ),
                                SizedBox(height: 10),
                                Text("Add pdf",
                                    style: TextStyle(
                                        color: Color.fromARGB(
                                      255,
                                      251,
                                      171,
                                      58,
                                    ))),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Consumer<UploadPercentageProvider>(
                builder: (context, Progressfinal, child) =>
                    Progressfinal.progress == 0.00
                        ? Text("not uploaded")
                        : Consumer<DownloadProvider>(
                            builder: (context, value, child) => double.parse(
                                            Progressfinal.progress
                                                .toStringAsFixed(2)) ==
                                        1.00 &&
                                    value.isDownloaded == true
                                ? Column(
                                    children: [
                                      Text("Download complete"),
                                      ElevatedButton(
                                          onPressed: () {
                                            BookNameController.clear();
                                            DepartmentController.clear();
                                            regulationController.clear();
                                            final download =
                                                Provider.of<DownloadProvider>(
                                                    context,
                                                    listen: false);
                                            progressProvider = Provider.of<
                                                    UploadPercentageProvider>(
                                                context,
                                                listen: false);
                                            progressProvider.setprogress(0.00);

                                            if (download.isDownloaded == true) {
                                              download.changeStatus();
                                            }
                                            setState(() {
                                              _image = null;
                                              path = null;
                                              fileName = null;
                                            });
                                          },
                                          child: Text("upload another book"))
                                    ],
                                  )
                                : LinearProgressIndicator(
                                    value: Progressfinal.progress,
                                  ),
                          ),
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_image != null &&
                      path != null &&
                      BookNameController.text.isNotEmpty &&
                      DepartmentController.text.isNotEmpty &&
                      regulationController.text.isNotEmpty) {
                    facultyServices.uploadImage(
                        context: context,
                        filePath: path!,
                        image: _image!,
                        type: 'books',
                        api: 'booksImage',
                        typename: BookNameController.text,
                        regulation: regulationController.text,
                        department: DepartmentController.text);
                  } else if (_image == null && path == null) {
                    showTypeError(context, "image and file not selected");
                  } else if (_image == null && path != null) {
                    showTypeError(context, "image  not selected");
                  } else if (_image != null && path == null) {
                    showTypeError(context, "file  not selected");
                  } else if (BookNameController.text.isEmpty ||
                      DepartmentController.text.isEmpty ||
                      regulationController.text.isEmpty) {
                    showTypeError(context, "text field is empty");
                  } else {
                    showTypeError(context, "something went wrong");
                  }
                },
                child: Text(
                  'submit',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 17, 79, 90),
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     if (_image != null &&
      //         path != null &&
      //         BookNameController.text.isNotEmpty &&
      //         DepartmentController.text.isNotEmpty &&
      //         regulationController.text.isNotEmpty) {
      //       facultyServices.uploadImage(
      //           context: context,
      //           filePath: path!,
      //           image: _image!,
      //           type: 'books',
      //           api: 'booksImage',
      //           typename: BookNameController.text,
      //           regulation: regulationController.text,
      //           department: DepartmentController.text);
      //     } else if (_image == null && path == null) {
      //       showTypeError(context, "image and file not selected");
      //     } else if (_image == null && path != null) {
      //       showTypeError(context, "image  not selected");
      //     } else if (_image != null && path == null) {
      //       showTypeError(context, "file  not selected");
      //     } else if (BookNameController.text.isEmpty ||
      //         DepartmentController.text.isEmpty ||
      //         regulationController.text.isEmpty) {
      //       showTypeError(context, "text field is empty");
      //     } else {
      //       showTypeError(context, "something went wrong");
      //     }
      //   },
      //   child: Text("Submit"),
      // ),
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

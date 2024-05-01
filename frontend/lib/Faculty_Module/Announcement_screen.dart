import 'dart:io';
import 'package:frontend/Faculty_Module/selection_pannel/file_selection_pannel.dart';
import 'package:frontend/Faculty_Module/selection_pannel/photo_selection_pannel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/providers/faculty_provider.dart';
import 'package:frontend/providers/upload_percentage_provider.dart';
import 'package:frontend/services/faculty_services.dart';
import 'package:provider/provider.dart';

class UpdatesScreen extends StatefulWidget {
  const UpdatesScreen({Key? key}) : super(key: key);

  @override
  State<UpdatesScreen> createState() => _UpdatesScreenState();
}

class _UpdatesScreenState extends State<UpdatesScreen> {
  FacultyServices facultyServices = FacultyServices();
  late UploadPercentageProvider progressProvider;
  final TextEditingController sectionController = TextEditingController();
  final TextEditingController DepartmentController = TextEditingController();
  final TextEditingController regulationController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final TextEditingController TitleController = TextEditingController();

  List<Uint8List> _images = [];
  List<File> _pdfFiles = [];
  List<String> _pdfNames = [];

  List<File> convertPathsToFiles(List<String> filePaths) {
    List<File> files = [];
    for (String path in filePaths) {
      files.add(File(path));
    }
    return files;
  }

  @override
  Widget build(BuildContext context) {
    final faculty =
        Provider.of<FacultyProvider>(context, listen: false).faculty;
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Updates"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10.0),

              TextFormField(
                keyboardType: TextInputType.text,
                controller: regulationController,
                decoration: InputDecoration(
                  labelText: "Enter the Regulation",
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 17, 79, 90),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: sectionController,
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
                controller: sectionController,
                decoration: InputDecoration(
                  labelText: "Enter section",
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 17, 79, 90),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: TitleController,
                decoration: InputDecoration(
                  labelText: "Enter Title(max 5 words)",
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 17, 79, 90),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: messageController,
                decoration: InputDecoration(
                  labelText: "Enter message",
                  fillColor: Color.fromARGB(255, 255, 255, 255),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () async {
                  Uint8List? image = await showImagePickerOption(context);
                  if (image != null) {
                    setState(() {
                      _images.add(image);
                    });
                  }
                },
                child: Text("Add Image"),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildImagePreview(),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () async {
                  List<String>? filePaths = await showPdfPickerOption(context);
                  print(filePaths);
                  if (filePaths != null) {
                    setState(() {
                      _pdfNames.add(filePaths[0]);
                      print(filePaths[0]);
                      _pdfFiles.add(File(filePaths[1]));
                    });
                  }
                },
                child: Text("Add PDF Files"),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildPdfFilesPreview(),
                  ],
                ),
              ),
              // SizedBox(height: 20.0),
              // // ElevatedButton(
              // //   onPressed: () {
              // //     _uploadFiles();
              // //   },
              // //   child: Text("Submit"),
              // // ),
              // SizedBox(height: 20.0),
              SizedBox(height: 25.0),
              ElevatedButton(
                onPressed: () {
                  _uploadFiles("${faculty.FacultyName} - ${faculty.FacultyId}");
                },
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 17, 79, 90)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePreview() {
    return _images.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Image Preview:",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 10.0),
              Wrap(
                spacing: 10.0,
                runSpacing: 10.0,
                children: _images.map((image) {
                  return Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.memory(image, fit: BoxFit.cover),
                  );
                }).toList(),
              ),
            ],
          )
        : SizedBox.shrink();
  }

  Widget _buildPdfFilesPreview() {
    return _pdfNames.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "PDF Files:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _pdfNames.map((name) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(name),
                  );
                }).toList(),
              ),
            ],
          )
        : SizedBox.shrink();
  }

  void _uploadFiles(String sentBy) {
    if (sectionController.text.isNotEmpty &&
        messageController.text.isNotEmpty &&
        DepartmentController.text.isNotEmpty &&
        regulationController.text.isNotEmpty) {
      facultyServices.uploadFiles(
        context: context,
        imageFiles: _images,
        pdfFiles: _pdfFiles,
        Section: sectionController.text.toUpperCase(),
        SentBy: sentBy,
        Message: messageController.text,
        Regulation: regulationController.text,
        Department: DepartmentController.text,
        Title: TitleController.text,
        onUploadComplete: (bool success) {
          if (success) {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text("Success"),
                content: const Text("Update posted"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("ok"),
                  ),
                ],
              ),
            );
          } else {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text("Failed"),
                content: const Text("Something went wrong ! please try again"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("ok"),
                  ),
                ],
              ),
            );
          }
        },
      );
    } else {
      showTypeError(context, "Please fill all fields and add files.");
    }
  }

  void showTypeError(BuildContext context, String errtxt) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Error"),
        content: Text(errtxt),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}

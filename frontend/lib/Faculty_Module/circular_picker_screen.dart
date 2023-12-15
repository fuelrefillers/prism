import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class CircularPickerScreen extends StatefulWidget {
  const CircularPickerScreen({super.key});

  @override
  State<CircularPickerScreen> createState() => _CircularPickerScreenState();
}

class _CircularPickerScreenState extends State<CircularPickerScreen> {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController CircularNameController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController semisterController = TextEditingController();
  String? fileName;
  String? path;
  File? selectedIMage;
  File? selectedFile;

  Future<void> uploadImage() async {
    if (fileName == null) {
      print('No file selected.');
      return;
    }

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://192.168.29.194:3000/api/booksImage/upload'),
    );

    // Add the image file
    request.files.add(await http.MultipartFile.fromPath('circularPdf', path!));

    // Add additional datd
    request.fields['CircularName'] = CircularNameController.text.trim();
    request.fields['department'] = departmentController.text.trim();
    request.fields['semester'] = semisterController.text.trim();
    // Replace with your data

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        print('Image and data uploaded successfully');
      } else {
        print(
            'Failed to upload image and data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading image and data: $e ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Books Upload"),
      ),
      //backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'circular title'),
              controller: CircularNameController,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'DepartMent'),
              controller: departmentController,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'Semester'),
              controller: semisterController,
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      if (fileName == null) {
                        showPdfPickerOption(context);
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
                            ? Center(child: Text(fileName!.toString()))
                            : Center(child: Text("no pdf selected"))),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          uploadImage();
        },
        child: Text("submit"),
      ),
    );
  }

  void showPdfPickerOption(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.blue[100],
        context: context,
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4.5,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _pickFile();
                      },
                      child: const SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.file_copy_sharp,
                              size: 70,
                            ),
                            Text("Files")
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

//pdf
  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path ?? '');

      setState(() {
        fileName = file.path.split('/').last;
        path = file.path;
      });

      Navigator.of(context).pop(); // Close the file picker
    }
  }
}

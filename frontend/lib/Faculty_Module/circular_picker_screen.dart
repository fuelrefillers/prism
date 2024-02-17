import 'package:flutter/material.dart';
import 'package:frontend/Faculty_Module/selection_pannel/file_selection_pannel.dart';
import 'package:frontend/providers.dart/download_provider.dart';
import 'package:frontend/providers.dart/upload_percentage_provider.dart';
import 'package:frontend/services/faculty_services.dart';
import 'package:provider/provider.dart';

class CircularPickerScreen extends StatefulWidget {
  const CircularPickerScreen({super.key});

  @override
  State<CircularPickerScreen> createState() => _CircularPickerScreenState();
}

class _CircularPickerScreenState extends State<CircularPickerScreen> {
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

  FacultyServices facultyServices = FacultyServices();
  final TextEditingController CircularNameController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController regulationController = TextEditingController();
  String? fileName;
  String? path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Circular Upload"),
      ),
      //backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
                controller: CircularNameController,
                decoration: InputDecoration(
                  labelText: "circular title",
                  fillColor: const Color.fromARGB(255, 215, 224, 243),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
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
              ),
              SizedBox(height: 16.0),
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
                                            CircularNameController.clear();
                                            departmentController.clear();
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
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (path != null &&
              CircularNameController.text.isNotEmpty &&
              departmentController.text.isNotEmpty &&
              regulationController.text.isNotEmpty) {
            facultyServices.uploadImage(
                context: context,
                filePath: path!,
                image: null,
                type: 'circular',
                api: 'circularpdf',
                typename: CircularNameController.text,
                regulation: regulationController.text,
                department: departmentController.text);
          } else if (path == null) {
            showTypeError(context, "image and file not selected");
          } else if (CircularNameController.text.isEmpty ||
              departmentController.text.isEmpty ||
              regulationController.text.isEmpty) {
            showTypeError(context, "text field is empty");
          } else {
            showTypeError(context, "something went wrong");
          }
        },
        child: Text("submit"),
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

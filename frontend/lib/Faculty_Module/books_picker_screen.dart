import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:frontend/services/ip.dart';

class PickImage extends StatefulWidget {
  const PickImage({super.key});

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController BookNameController = TextEditingController();
  final TextEditingController DepartmentController = TextEditingController();
  final TextEditingController regulationController = TextEditingController();
  Uint8List? _image;
  String? fileName;
  String? path;
  File? selectedIMage;
  File? selectedFile;

  Future<File> saveImage(Uint8List imageData) async {
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/temp_image.jpg');
    await file.writeAsBytes(imageData);
    return file;
  }

  Future<void> uploadImage(BuildContext context) async {
    if (fileName == null) {
      print('No file selected.');
      return;
    }
    if (_image == null) return;

    final tempFile = await saveImage(_image!);

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${ip}/api/booksImage/upload'),
    );

    // Add the image file
    request.files
        .add(await http.MultipartFile.fromPath('booksCover', tempFile.path));
    request.files.add(await http.MultipartFile.fromPath('booksPdf', path!));

    // Add additional datd
    request.fields['bookname'] = BookNameController.text.trim();
    request.fields['department'] = DepartmentController.text.trim();
    request.fields['regulation'] = regulationController.text.trim();
    // Replace with your dataxt---,

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
                  fillColor: Color.fromARGB(255, 215, 224, 243),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: DepartmentController,
                decoration: InputDecoration(
                  labelText: "Enter the Department Name",
                  fillColor: Color.fromARGB(255, 215, 224, 243),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: regulationController,
                decoration: InputDecoration(
                  labelText: "Enter the regulation",
                  fillColor: const Color.fromARGB(255, 215, 224, 243),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
              SizedBox(height: 50.0),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showImagePickerOption(context);
                      },
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: _image != null
                            ? Image(
                                image: MemoryImage(_image!),
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/fileadd.jpg',
                                scale: 1.8,
                              ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showPdfPickerOption(context);
                      },
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width / 2,
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
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          uploadImage(context);
        },
        child: Text("submit"),
      ),
    );
  }

  void showImagePickerOption(BuildContext context) {
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
                        _pickImageFromGallery();
                      },
                      child: const SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.image,
                              size: 70,
                            ),
                            Text("Gallery")
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _pickImageFromCamera();
                      },
                      child: const SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 70,
                            ),
                            Text("Camera")
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

//Gallery
  Future _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedIMage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.of(context).pop(); //close the model sheet
  }

//Camera
  Future _pickImageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedIMage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.of(context).pop();
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



 

// Column(
//         children: [
//           Center(
//             child: Stack(
//               children: [
//                 _image != null
//                     ? SizedBox(
//                         height: 200,
//                         width: 200,
//                         child: Image(image: MemoryImage(_image!)),
//                       )
//                     : const CircleAvatar(
//                         radius: 100,
//                         backgroundImage: NetworkImage(
//                             "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"),
//                       ),
//                 Positioned(
//                     bottom: -0,
//                     left: 140,
//                     child: IconButton(
//                         onPressed: () {
//                           showImagePickerOption(context);
//                         },
//                         icon: const Icon(Icons.add_a_photo)))
//               ],
//             ),
//           ),
//           fileName != null
//               ? SizedBox(
//                   height: 200,
//                   width: 200,
//                   child: Image(image: MemoryImage(_image!)),
//                 )
//               : Text("not uploaded"),
//           IconButton(
//               onPressed: () {
//                 showPdfPickerOption(context);
//               },
//               icon: const Icon(Icons.file_copy))
//         ],
//       ),
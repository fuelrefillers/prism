import 'dart:io';
import 'package:frontend/providers.dart/is_loading_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';

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
  final TextEditingController SemesterController = TextEditingController();
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

  Future<void> uploadImage() async {
    if (fileName == null) {
      print('No file selected.');
      return;
    }
    if (_image == null) return;

    final tempFile = await saveImage(_image!);

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://192.168.29.194:3000/api/booksImage/upload'),
    );

    // Add the image file
    request.files
        .add(await http.MultipartFile.fromPath('booksCover', tempFile.path));
    request.files.add(await http.MultipartFile.fromPath('booksPdf', path!));

    // Add additional datd
    request.fields['bookname'] = BookNameController.text.trim();
    request.fields['department'] = DepartmentController.text.trim();
    request.fields['semester'] = SemesterController.text.trim();
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
              decoration: InputDecoration(labelText: 'Book Name'),
              controller: BookNameController,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'DepartMent'),
              controller: DepartmentController,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'Semester'),
              controller: SemesterController,
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      if (_image == null) {
                        showImagePickerOption(context);
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
                      child: _image != null
                          ? Image(
                              image: MemoryImage(_image!),
                              fit: BoxFit.cover,
                            )
                          : const CircleAvatar(
                              radius: 100,
                              backgroundImage: NetworkImage(
                                  "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"),
                            ),
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
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
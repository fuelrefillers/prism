import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

Future<List<String>> showPdfPickerOption(BuildContext context) async {
  Completer<List<String>> completer = Completer<List<String>>();

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
                    onTap: () async {
                      List<String> res = await _pickFile(context);
                      completer.complete(res);
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
  return completer.future;
}

Future<List<String>> _pickFile(BuildContext context) async {
  final result = await FilePicker.platform.pickFiles();
  List<String> res = [];
  if (result != null) {
    File file = File(result.files.single.path ?? '');

    String fileName = file.path.split('/').last;
    String path = file.path;
    res.add(fileName);
    res.add(path);

    Navigator.of(context).pop();

    // Close the file picker
  }
  return res;
}

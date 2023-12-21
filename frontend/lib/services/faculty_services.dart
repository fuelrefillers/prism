import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/providers.dart/atten_confirm_provider.dart';
import 'package:frontend/providers.dart/download_provider.dart';
import 'package:frontend/providers.dart/is_error_provider.dart';
import 'package:frontend/providers.dart/is_loading_provider.dart';
import 'package:frontend/providers.dart/upload_percentage_provider.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/services/ip.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class FacultyServices {
// Faculty to set attendance
  void setAttendance(
      {required List<String> rollnumbers,
      required String section,
      required String department,
      required BuildContext context}) async {
    try {
      final attenProvider =
          Provider.of<AttendanceConfirm>(context, listen: false);
      final loaging = Provider.of<isLoadinProvider>(context, listen: false);
      final Err = Provider.of<isErrorProvider>(context, listen: false);
      http.Response res = await http.post(
        Uri.parse(
            '${ip}/api/attendance/setAttendance?section=${section}&department=${department}'),
        body: jsonEncode({
          'rollNumbers': rollnumbers,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (res.statusCode == 200) {
        await Future.delayed(Duration(seconds: 1));
        if (loaging.isloading == true) {
          loaging.changeStatus();
        }
        attenProvider.setAttenFromJsonString(res.body);
      } else if (res.statusCode != 200) {
        if (loaging.isloading == true) {
          loaging.changeStatus();
        }
        if (Err.isError == false) {
          Err.changeStatus();
        }
      }
    } catch (err) {
      print(err);
    }
  }
  // setAttendance function ends here

  Future<File> saveImage(Uint8List imageData) async {
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/temp_image.jpg');
    await file.writeAsBytes(imageData);
    return file;
  }

  Future<void> uploadImage(
      {required context,
      required String api,
      required String filePath,
      Uint8List? image,
      required String type,
      required String typename,
      required String regulation,
      required String department}) async {
    final uploadPercentageProvider =
        Provider.of<UploadPercentageProvider>(context, listen: false);
    final download = Provider.of<DownloadProvider>(context, listen: false);

    if (double.parse(uploadPercentageProvider.progress.toStringAsFixed(2)) ==
        1.0) {
      uploadPercentageProvider.setprogress(0.00);
    }

    Dio dio = Dio();

    try {
      FormData formData;
      if (type == 'books') {
        final tempFile = await saveImage(image!);
        formData = FormData.fromMap({
          '${type}Cover': await MultipartFile.fromFile(tempFile.path),
          '${type}Pdf': await MultipartFile.fromFile(filePath),
          '${type}name': typename,
          'department': department.toUpperCase(),
          'regulation': regulation.toUpperCase(),
        });
      } else {
        formData = FormData.fromMap({
          '${type}Pdf': await MultipartFile.fromFile(filePath),
          '${type}name': typename,
          'department': department.toUpperCase(),
          'regulation': regulation.toUpperCase(),
        });
      }

      var response;

      // Simulate a delay of 2 seconds (adjust as needed)

      response = await dio.post(
        '${ip}/api/${api}/upload',
        data: formData,
        onSendProgress: (int sent, int total) {
          double progress = sent / total;
          // setState(() {
          //   Progressfinal = progress;
          // });
          uploadPercentageProvider.setprogress(progress);
          print('Upload progress: ${(progress * 100).toStringAsFixed(2)}%');
        },
      );

      if (response.statusCode == 200) {
        print('Image and data uploaded successfully');
        if (download.isDownloaded == false) {
          download.changeStatus();
        }
      } else {
        print(
            'Failed to upload image and data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading image and data: $e');
    }
  }
}

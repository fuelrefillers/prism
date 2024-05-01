import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/faculty_time_table_model.dart';
import 'package:frontend/models/time_table_view_model.dart';
import 'package:frontend/models/time_table_view_screen.dart';
import 'package:frontend/providers/atten_confirm_provider.dart';
import 'package:frontend/providers/download_provider.dart';
import 'package:frontend/providers/is_error_provider.dart';
import 'package:frontend/providers/is_loading_provider.dart';
import 'package:frontend/providers/time_table_view_provider.dart';
import 'package:frontend/providers/upload_percentage_provider.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/services/ip.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class FacultyServices {
// Faculty to set attendance
  void setAttendance(
      {required List<String> rollnumbers,
      required String section,
      required String department,
      required String regulation,
      required String startTime,
      required String endTime,
      required BuildContext context,
      required String type}) async {
    try {
      final attenProvider =
          Provider.of<AttendanceConfirm>(context, listen: false);
      final loaging = Provider.of<isLoadinProvider>(context, listen: false);
      final Err = Provider.of<isErrorProvider>(context, listen: false);
      http.Response res = await http.post(
        Uri.parse(
            '${ip}/api/attendance/setAttendance?section=${section}&department=${department}&regulation=${regulation}'),
        body: jsonEncode({
          'type': type,
          'rollNumbers': rollnumbers,
          "startTime": startTime,
          "endTime": endTime,
          "currentTime": DateFormat.Hm().format(DateTime.now())
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

  Future<void> setFacultyTimeTable(
      {required facultyId, required context}) async {
    try {
      final FTP = Provider.of<FacultyTimeTableProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      var response = await http.get(
        Uri.parse('${ip}/api/faculty/getFacultyTimeTable'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      var res = jsonDecode(response.body);
      List<FTimeTable> fTimeTable = [];
      for (var item in res["TimeTable"]) {
        String day = item['Day'];
        List<FPeriods> periods = [];
        for (var periodData in item['Periods']) {
          FPeriods period = FPeriods(
            StartTime: periodData['StartTime'],
            EndTime: periodData['EndTime'],
            ClassType: periodData['ClassType'],
            SubjectName: periodData['SubjectName'],
            Subjectcode: periodData['Subjectcode'],
            Section: periodData['Section'],
            Department: periodData['Department'],
            Regulation: periodData['Regulation'],
            Year: periodData['Year'],
          );
          periods.add(period);
        }

        FTimeTable timeTableView = FTimeTable(
          Day: day,
          Periods: periods,
        );
        fTimeTable.add(timeTableView);
      }

      // print(fTimeTable);

      FacultyTimeTable FT = FacultyTimeTable(
          FacultyId: res["FacultyId"],
          FacultyName: res["FacultyName"],
          FacultyDepartment: res["FacultyDepartment"],
          TimeTable: fTimeTable);
      FTP.setFromModel(FT);
    } catch (e) {
      print("e");
    }
  }

  // Future<void> uploadPrevQP(){

  // }

  Future<File> saveImage(Uint8List imageData) async {
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/temp_image.jpg');
    await file.writeAsBytes(imageData);
    return file;
  }

  Future<void> uploadImage({
    required context,
    required String api,
    required String filePath,
    Uint8List? image,
    required String type,
    required String typename,
    required String regulation,
    required String department,
  }) async {
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
        // print(response.body);
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

  Future<void> uploadFiles(
      {required context,
      required List<Uint8List> imageFiles,
      required List<File> pdfFiles,
      required String Section,
      required String SentBy,
      required String Message,
      required String Regulation,
      required String Department,
      required String Title,
      required Function(bool) onUploadComplete}) async {
    final uploadPercentageProvider =
        Provider.of<UploadPercentageProvider>(context, listen: false);
    final download = Provider.of<DownloadProvider>(context, listen: false);

    if (double.parse(uploadPercentageProvider.progress.toStringAsFixed(2)) ==
        1.0) {
      uploadPercentageProvider.setprogress(0.00);
    }

    Dio dio = Dio();

    try {
      // FormData formData = FormData();
      List<MultipartFile> ii = [];

      // Add image files if they exist
      if (imageFiles.isNotEmpty) {
        for (int i = 0; i < imageFiles.length; i++) {
          final tempFile = await saveImage(imageFiles[i]);
          ii.add(await MultipartFile.fromFile(tempFile.path));
          // formData.files.add(MapEntry(
          //   'images[$i]',
          //   await MultipartFile.fromFile(tempFile.path),
          // ));
        }
      }

      // Add PDF files if they exist
      List<MultipartFile> ss = [];
      if (pdfFiles.isNotEmpty) {
        for (int i = 0; i < pdfFiles.length; i++) {
          ss.add(await MultipartFile.fromFile(pdfFiles[i].path));
          // formData.files.add(MapEntry(
          //   'pdfs[$i]',
          //   await MultipartFile.fromFile(pdfFiles[i].path),
          // ));
        }
      }

      // formData.fields.addAll([
      //   MapEntry('SentBy', SentBy),
      //   MapEntry('Message', Message),
      //   MapEntry('Section', Section.toUpperCase()),
      //   MapEntry('Department', Department.toUpperCase()),
      //   MapEntry('Regulation', Regulation.toUpperCase()),
      // ]);

      FormData formData1 = FormData.fromMap({
        'pdfs': ss,
        'images': ii,
        'SentBy': SentBy,
        'Message': Message,
        'Title': Title,
        'Section': Section.toUpperCase(),
        'Department': Department.toUpperCase(),
        'Regulation': Regulation.toUpperCase(),
      });

      print(formData1.fields);

      var response;

      // Simulate a delay of 2 seconds (adjust as needed)
      response = await dio.post(
        '${ip}/api/updates/upload',
        data: formData1,
        onSendProgress: (int sent, int total) {
          double progress = sent / total;
          uploadPercentageProvider.setprogress(progress);
          print('Upload progress: ${(progress * 100).toStringAsFixed(2)}%');
        },
      );

      if (response.statusCode == 200) {
        print('Files uploaded successfully');
        onUploadComplete(true);
        if (download.isDownloaded == false) {
          download.changeStatus();
        }
      } else {
        onUploadComplete(false);
        print('Failed to upload files. Status code: ${response.statusCode}');
      }
    } catch (e) {
      onUploadComplete(false);

      print('Error uploading files: $e');
    }
  }

  Future<void> timeTableUpload(
      {required context,
      required String api,
      required String filePath,
      Uint8List? image,
      required String type,
      required String typename,
      required String regulation,
      required String department,
      required String section}) async {
    final uploadPercentageProvider =
        Provider.of<UploadPercentageProvider>(context, listen: false);
    final download = Provider.of<DownloadProvider>(context, listen: false);
    final timeTableViewProvider =
        Provider.of<TimeTableViewProvider>(context, listen: false);

    if (double.parse(uploadPercentageProvider.progress.toStringAsFixed(2)) ==
        1.0) {
      uploadPercentageProvider.setprogress(0.00);
    }

    Dio dio = Dio();

    try {
      FormData formData;

      formData = FormData.fromMap({
        '${type}Pdf': await MultipartFile.fromFile(filePath),
        '${type}name': typename,
        'department': department.toUpperCase(),
        'regulation': regulation.toUpperCase(),
        'section': section.toUpperCase(),
      });

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
        List<TimeTableView> timeTableViews = [];
        for (var item in response.data) {
          String day = item['Day'];
          List<Period> periods = [];
          for (var periodData in item['Periods']) {
            Period period = Period(
              id: periodData['_id'],
              startTime: periodData['StartTime'],
              endTime: periodData['EndTime'],
              classType: periodData['ClassType'],
              className: periodData['ClassName'],
              subjectName: periodData['SubjectName'],
              subjectCode: periodData['Subjectcode'],
              lecturerName: periodData['LecturerName'],
              lecturerId: periodData['LecturerId'],
              lecturerNumber: periodData['LecturerNumber'],
              substitute: periodData['Substitute'],
            );
            periods.add(period);
          }

          TimeTableView timeTableView = TimeTableView(
            Day: day,
            Periods: periods,
          );
          timeTableViews.add(timeTableView);
        }
        timeTableViewProvider.setFromModel(timeTableViews);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => TimeTableViewScreen()));
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

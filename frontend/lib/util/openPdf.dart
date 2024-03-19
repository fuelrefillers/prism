// import 'package:open_file/open_file.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class OpenPdf{
//     Future<List<String>> getListOfDownloadedPdf() async {
//       final prefs = await SharedPreferences.getInstance();
//       return prefs.getStringList('downloadedPdf') ?? []; // return empty list if 'myList' is null
//     }

//     Future<void> saveListOfDownloadedPdf(List<String> list) async {
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setStringList('downloadedPdf', list);
//     }


//     void openPdf(String path) {
//     try {
//       OpenFile.open(path);
//     } catch (error) {
//       print('Error opening PDF: $error');
//     }
//   }

//   void downloadPdf() async {
//     List<String> downloadPdf = await getListOfDownloadedPdf();


//     isAlreadyDownloaded = alreadyD.any((cir) => cir.id == widget.timetable.id);
//     if (!isAlreadyDownloaded) {
//       PermissionStatus status = await Permission.storage.request();
//       if (status.isGranted) {
//         var dir = await getExternalStorageDirectory();
//         if (dir != null) {
//           String extention = widget.timetable.TimeTableUrl.split('.').last;
//           print(extention);
//           String savename = "${widget.timetable.TimeTableTitle}.pdf";
//           String savePath = dir.path + "/$savename";
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text("File Download Started"),
//           ));
//           try {
//             await Dio().download(widget.timetable.TimeTableUrl, savePath);
//             print("File is saved to download folder.");

//             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//               content: Text("File Downloaded"),
//             ));
//             openPdf(savePath);

//             List<TimeTable> existingtimetable =
//                 await TimeTable.loadListFromLocalStorage('timetable');
//             TimeTable newp = TimeTable(
//                 TimeTableTitle: widget.timetable.TimeTableTitle,
//                 Department: widget.timetable.Department,
//                 Regulation: widget.timetable.Regulation,
//                 TimeTableUrl: savePath,
//                 id: widget.timetable.id);

//             existingtimetable.add(newp);
//             TimeTable.saveListToLocalStorage(existingtimetable, 'timetable');
//           } on DioException catch (e) {
//             print(e.message);
//           }
//         }
//       }
//     } else {
//       TimeTable alreadyDownloadedCircular =
//           alreadyD.firstWhere((cir) => cir.id == widget.timetable.id);
//       openPdf(alreadyDownloadedCircular.TimeTableUrl);
//     }
//   }
// }
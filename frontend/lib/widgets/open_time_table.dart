import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/circularModel.dart';
import 'package:frontend/models/timetable_model.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class OpenTimeTable extends StatefulWidget {
  const OpenTimeTable(
      {super.key,
      required this.height1,
      required this.timetable,
      required this.context});
  final double height1;
  final TimeTable timetable;
  final BuildContext context;
  @override
  State<OpenTimeTable> createState() => _OpenTimeTableState();
}

class _OpenTimeTableState extends State<OpenTimeTable> {
  bool isAlreadyDownloaded = false;

  void openPdf(String path) {
    try {
      OpenFile.open(path);
    } catch (error) {
      print('Error opening PDF: $error');
    }
  }

  void downloadPdf() async {
    List<TimeTable> alreadyD =
        await TimeTable.loadListFromLocalStorage('timetable');
    isAlreadyDownloaded = alreadyD.any((cir) => cir.id == widget.timetable.id);
    if (!isAlreadyDownloaded) {
      PermissionStatus status = await Permission.storage.request();
      if (status.isGranted) {
        var dir = await getExternalStorageDirectory();
        if (dir != null) {
          String extention = widget.timetable.TimeTableUrl.split('.').last;
          print(extention);
          String savename = "${widget.timetable.TimeTableTitle}.pdf";
          String savePath = dir.path + "/$savename";
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("File Download Started"),
          ));
          try {
            await Dio().download(widget.timetable.TimeTableUrl, savePath);
            print("File is saved to download folder.");

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("File Downloaded"),
            ));
            openPdf(savePath);

            List<TimeTable> existingtimetable =
                await TimeTable.loadListFromLocalStorage('timetable');
            TimeTable newp = TimeTable(
                TimeTableTitle: widget.timetable.TimeTableTitle,
                Department: widget.timetable.Department,
                Regulation: widget.timetable.Regulation,
                TimeTableUrl: savePath,
                id: widget.timetable.id);

            existingtimetable.add(newp);
            TimeTable.saveListToLocalStorage(existingtimetable, 'timetable');
          } on DioException catch (e) {
            print(e.message);
          }
        }
      }
    } else {
      TimeTable alreadyDownloadedCircular =
          alreadyD.firstWhere((cir) => cir.id == widget.timetable.id);
      openPdf(alreadyDownloadedCircular.TimeTableUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        clipBehavior: Clip.hardEdge,
        height: widget.height1,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(),
        child: GestureDetector(
          onTap: () {
            downloadPdf();
          },
          child: Card(
            child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${widget.timetable.TimeTableTitle}\n${widget.timetable.Department}",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

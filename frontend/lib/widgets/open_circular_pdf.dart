import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/circularModel.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class OpenCircular extends StatefulWidget {
  const OpenCircular(
      {super.key,
      required this.height1,
      required this.circular,
      required this.context});
  final double height1;
  final CircularsModel circular;
  final BuildContext context;
  @override
  State<OpenCircular> createState() => _OpenCircularState();
}

class _OpenCircularState extends State<OpenCircular> {
  bool isAlreadyDownloaded = false;

  void openPdf(String path) {
    try {
      OpenFile.open(path);
    } catch (error) {
      print('Error opening PDF: $error');
    }
  }

  void downloadPdf() async {
    String extention = widget.circular.CircularUrl.split('.').last;
    print(extention);
    List<CircularsModel> alreadyD =
        await CircularsModel.loadListFromLocalStorage('circulars');
    isAlreadyDownloaded = alreadyD.any((cir) => cir.id == widget.circular.id);
    if (!isAlreadyDownloaded) {
      PermissionStatus status = await Permission.storage.request();
      if (status.isGranted) {
        var dir = await getExternalStorageDirectory();
        if (dir != null) {
          String savename = "${widget.circular.circularTitle}.pdf";
          String savePath = dir.path + "/$savename";
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("File Download Started"),
          ));
          try {
            await Dio().download(widget.circular.CircularUrl, savePath);
            print("File is saved to download folder.");

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("File Downloaded"),
            ));
            openPdf(savePath);

            List<CircularsModel> existingcirculars =
                await CircularsModel.loadListFromLocalStorage('circulars');
            CircularsModel newp = CircularsModel(
              circularTitle: widget.circular.circularTitle,
              Department: widget.circular.Department,
              Regulation: widget.circular.Regulation,
              CircularUrl: savePath,
              id: widget.circular.id,
            );

            existingcirculars.add(newp);
            CircularsModel.saveListToLocalStorage(
                existingcirculars, 'circulars');
          } on DioException catch (e) {
            print(e.message);
          }
        }
      }
    } else {
      CircularsModel alreadyDownloadedCircular =
          alreadyD.firstWhere((cir) => cir.id == widget.circular.id);
      openPdf(alreadyDownloadedCircular.CircularUrl);
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
                      widget.circular.circularTitle,
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

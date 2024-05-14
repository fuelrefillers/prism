import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/updates_model.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class UpdatesViewerScreen extends StatefulWidget {
  const UpdatesViewerScreen({Key? key, required this.update}) : super(key: key);

  final UpdatesModel update;

  @override
  State<UpdatesViewerScreen> createState() => _UpdatesViewerScreenState();
}

class _UpdatesViewerScreenState extends State<UpdatesViewerScreen> {
  String? pdfPath11;

  void openPdf() {
    try {
      OpenFile.open(pdfPath11);
    } catch (error) {
      print('Error opening PDF: $error');
    }
  }

  void openpdf(String url, String name) {
    downloadPdf(name, url);
  }

  void downloadPdf(String name, String url) async {
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      //private storage -------> var dir = await getApplicationDocumentsDirectory(); <-------

      var dir = await getExternalStorageDirectory();
      if (dir != null) {
        String savename = name;
        String savePath = dir.path + "/$savename";
        setState(() {
          pdfPath11 = savePath;
        });
        print(savePath);

        //output:  /storage/emulated/0/Android/data/com.example.frontend/files/next.pdf

        try {
          await Dio().download(url, savePath,
              onReceiveProgress: (received, total) {
            if (total != -1) {}
          });

          openPdf();

          print("File is saved to download folder.");
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("File Downloaded"),
          ));
        } on DioException catch (e) {
          print(e.message);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.update.Title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Sent by: ${widget.update.SentBy}"),
            Text("Sent on: ${widget.update.created_at}"),
            SizedBox(height: 20),
            Text(
                textAlign: TextAlign.justify, widget.update.Message.toString()),
            SizedBox(height: 20),
            Container(
              height: MediaQuery.of(context).size.height /
                  1.3, // Adjust the height as needed
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.update.ImagesUrl.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      widget.update.ImagesUrl[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            widget.update.PdfUrl.isNotEmpty ? Text("PDF ") : Text(""),
            Container(
              height: 200, // Adjust the height as needed
              child: ListView.builder(
                itemCount: widget.update.PdfUrl.length,
                itemBuilder: (context, index) => ListTile(
                  onTap: () {
                    openpdf(widget.update.PdfUrl[index],
                        widget.update.PdfUrl[index].split("-").last);
                  },
                  leading: Icon(Icons.picture_as_pdf),
                  title: Text(widget.update.PdfUrl[index].split("-").last),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';

// class DummyLinkPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: PDFViewerPage(
//         pdfUrl: 'https://www.africau.edu/images/default/sample.pdf',
//       ),
//     );
//   }
// }

// class PDFViewerPage extends StatelessWidget {
//   final String pdfUrl;

//   PDFViewerPage({required this.pdfUrl});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('PDF Viewer'),
//       ),
//       body: PDFView(
//         filePath: pdfUrl,
//         autoSpacing: true,
//         pageSnap: true,
//         swipeHorizontal: true,
//         pageFling: true,
//       ),
//     );
//   }
// }

import 'package:dio/dio.dart';
//import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';

import 'package:flutter/material.dart';
import 'package:frontend/widgets/pdfff.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DummyLinkPage extends StatefulWidget {
  const DummyLinkPage({super.key});
  @override
  State<DummyLinkPage> createState() => _DummyLinkPageState();
}

class _DummyLinkPageState extends State<DummyLinkPage> {
  String? pdfPath;
  String fileurl =
      "http://192.168.42.61:3000/upload/booksPdf/PDFbooksPdf_1702566749637.pdf";
  //you can save other file formats too.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Download File from URL"),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Container(
          margin: EdgeInsets.only(top: 50),
          child: Column(
            children: [
              Text("File URL: $fileurl"),
              Divider(),
              ElevatedButton(
                onPressed: () async {
                  PermissionStatus status = await Permission.storage.request();
                  if (status.isGranted) {
                    var dir = await getApplicationDocumentsDirectory();

                    String savename = "file.pdf";
                    String savePath = dir.path + "/$savename";
                    setState(() {
                      pdfPath = savePath;
                    });
                    print(savePath);
                    //output:  /storage/emulated/0/Download/banner.png

                    try {
                      await Dio().download(fileurl, savePath,
                          onReceiveProgress: (received, total) {
                        if (total != -1) {
                          print((received / total * 100).toStringAsFixed(0) +
                              "%");
                          //you can build progressbar feature too
                        }
                      });
                      print("File is saved to download folder.");
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("File Downloaded"),
                      ));
                    } on DioException catch (e) {
                      print(e.message);
                    }
                  }
                },
                child: Text("Download File."),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PdfViewerPage(
                            pdfPath: '/storage/emulated/0/Download/file.pdf'),
                      ),
                    );
                  },
                  child: Text("open pdf"))
            ],
          ),
        ));
  }
}

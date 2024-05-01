import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/certificates_model.dart';
import 'package:frontend/screens/CertificateScreens/uploadCertificatesScreen.dart';
import 'package:frontend/services/ip.dart';
import 'package:frontend/util/util.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class UploadedCertificatesScreen extends StatefulWidget {
  const UploadedCertificatesScreen({super.key, required this.rno});
  final String rno;

  @override
  State<UploadedCertificatesScreen> createState() =>
      _UploadedCertificatesScreenState();
}

class _UploadedCertificatesScreenState
    extends State<UploadedCertificatesScreen> {
  List<CertificatesModel> certificates = [];
  String? pdfPath11;

  @override
  void initState() {
    super.initState();
    getCertificates();
  }

  void openPdf() {
    try {
      OpenFile.open(pdfPath11);
    } catch (error) {
      print('Error opening PDF: $error');
    }
  }

  void downloadPdf(String name, String url) async {
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      //private storage -------> var dir = await getApplicationDocumentsDirectory(); <-------

      var dir = await getExternalStorageDirectory();
      if (dir != null) {
        String savename = name;
        String savePath = dir.path + "/$savename.pdf";
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

  void deleteCertificate(String id, int index) async {
    var response = await http
        .delete(Uri.parse("${ip}/api/certificates//deleteCertificate/${id}"));

    if (response.statusCode == 200) {
      setState(() {
        certificates.removeAt(index);
      });
    } else {
      showSnackBar(context, "something went wrong");
    }
  }

  void getCertificates() async {
    try {
      var Response = await http.get(Uri.parse(
          "${ip}/api/certificates/getCertificates?rollno=${widget.rno}"));
      // print(Response.body);
      if (Response.statusCode == 200) {
        List<CertificatesModel> temp = [];
        var result = jsonDecode(Response.body);
        print(result);
        for (int i = 0; i < result.length; i++) {
          CertificatesModel s =
              CertificatesModel.fromMap(result[i] as Map<String, dynamic>);
          temp.add(s);
        }
        setState(() {
          certificates = temp;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("certificates"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: certificates.length,
              itemBuilder: (context, index) => ListTile(
                onTap: () {
                  downloadPdf(certificates[index].Name,
                      certificates[index].CertificateUrl);
                },
                title: Text(certificates[index].Name),
                subtitle: Text(certificates[index].Course),
                leading: Icon(Icons.verified_rounded),
                trailing: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text("Warning"),
                          content: const Text(
                              "This operation will delete the update permanently"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("cancel"),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  deleteCertificate(
                                      certificates[index].id, index);
                                  Navigator.pop(context);
                                },
                                child: Text("Ok"))
                          ],
                        ),
                      );
                    },
                    icon: Icon(Icons.delete_forever)),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StudentForm(
                rno: widget.rno,
              ),
            ),
          );
          getCertificates();
        },
        child: Text("Add"),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/certificates_model.dart';
import 'package:frontend/screens/CertificateScreens/uploadCertificatesScreen.dart';
import 'package:frontend/services/ip.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/widgets/multipurpose_link_card.dart';

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

  @override
  void initState() {
    super.initState();
    getCertificates();
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
              itemBuilder: (context, index) => MultiPurposeLinkCard(
                  category: certificates[index].Course,
                  height1: 70,
                  subcategory: certificates[index].CertificationBy,
                  subcategory1: certificates[index].Name),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StudentForm(
                        rno: widget.rno,
                      )));
        },
        child: Text("Add"),
      ),
    );
  }
}

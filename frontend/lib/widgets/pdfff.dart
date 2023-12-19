import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewerPage extends StatelessWidget {
  final String pdfPath;

  PdfViewerPage({required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: PDFView(
        filePath:
            'http://192.168.29.194:3000/upload/circulars/circularPdf_1702824581530.pdf',
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageSnap: true,
        defaultPage: 0,
        fitPolicy: FitPolicy.BOTH,
      ),
    );
  }
}

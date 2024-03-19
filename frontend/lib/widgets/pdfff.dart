import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFViewerScreen extends StatelessWidget {
  final String pdfUrl;

  const PDFViewerScreen({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: PDFView(
        filePath: pdfUrl,
        autoSpacing: true,
        enableSwipe: true,
        pageFling: true,
        onRender: (pages) {
          // Do something when the PDF is rendered
        },
        onError: (error) {
          // Handle error when PDF fails to load
          print(error.toString());
        },
        onPageError: (page, error) {
          // Handle error for specific page
          print('Error on page $page: $error');
        },
        onViewCreated: (PDFViewController controller) {
          // Do something when the PDF view is created
        },
      ),
    );
  }
}

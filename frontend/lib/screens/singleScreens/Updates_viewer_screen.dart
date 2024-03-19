import 'package:flutter/material.dart';
import 'package:frontend/models/updates_model.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdatesViewerScreen extends StatefulWidget {
  const UpdatesViewerScreen({Key? key, required this.update}) : super(key: key);

  final UpdatesModel update;

  @override
  State<UpdatesViewerScreen> createState() => _UpdatesViewerScreenState();
}

class _UpdatesViewerScreenState extends State<UpdatesViewerScreen> {
  void _launchPDFURL(String pdfUrl) async {
    if (await canLaunchUrl(Uri.parse(pdfUrl))) {
      await launchUrl(Uri.parse(pdfUrl));
    } else {
      throw 'Could not launch $pdfUrl';
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
              'Wikipedia is a free online encyclopedia that anyone can edit, and millions already have. Wikipedia differs from printed references in important ways. It is continually created and updated, and encyclopedic articles on new events appear within minutes rather than months or years. Because anyone can improve Wikipedia, it has become more comprehensive than any other encyclopedia. Its contributors enhance its articles\' quality and quantity, and remove misinformation, errors and vandalism. Any reader can fix a mistake or add more information (see Researching with Wikipedia).',
              textAlign: TextAlign.justify,
            ),
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
                    _launchPDFURL(widget.update.PdfUrl[index]);
                  },
                  leading: Icon(Icons.picture_as_pdf),
                  title: Text("Tap to open PDF"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

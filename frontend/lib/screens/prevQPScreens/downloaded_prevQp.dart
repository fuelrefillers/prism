import 'package:flutter/material.dart';
import 'package:frontend/models/prevQP_model.dart';
import 'package:open_file/open_file.dart';

class PrevQPDownloadedScreen extends StatefulWidget {
  const PrevQPDownloadedScreen({super.key});

  @override
  State<PrevQPDownloadedScreen> createState() => _PrevQPDownloadedScreenState();
}

class _PrevQPDownloadedScreenState extends State<PrevQPDownloadedScreen> {
  List<PrevQp> downloadedBooks = [];
  bool isError = false;
  @override
  void initState() {
    super.initState();
    getDownloadedBooks();
  }

  void getDownloadedBooks() async {
    List<PrevQp> books1 =
        await PrevQp.loadListFromLocalStorage("downloadedPapers");
    //await Future.delayed(Duration(seconds: 1));
    print(books1);
    setState(() {
      downloadedBooks = books1;
    });
    await Future.delayed(Duration(seconds: 5));
    if (books1.isEmpty) {
      setState(() {
        isError = true;
      });
    }
  }

  void openPdf(String path) {
    try {
      OpenFile.open(path);
    } catch (error) {
      print('Error opening PDF: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Downloads"),
        ),
        body: downloadedBooks.isEmpty && isError == false
            ? Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : isError
                ? Center(
                    child: Text(
                        "Something went wrong or resultrs aren't updated yet !!!"),
                  )
                : ListView.builder(
                    itemCount: downloadedBooks.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(downloadedBooks[index].SubjectName),
                      onTap: () {
                        openPdf(downloadedBooks[index].PrevQuestionPaperUrl);
                      },
                      onLongPress: () {
                        PrevQp.deleteItemFromLocalStorage(
                            "downloadedPapers", downloadedBooks[index].Id);
                        setState(() {
                          downloadedBooks.removeAt(index);
                        });
                      },
                    ),
                  ));
  }
}

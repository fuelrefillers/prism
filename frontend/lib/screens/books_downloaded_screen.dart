import 'package:flutter/material.dart';
import 'package:frontend/models/books_model.dart';
import 'package:frontend/widgets/Download_books_open.dart';

class BooksDownloadedScreen extends StatefulWidget {
  const BooksDownloadedScreen({super.key});

  @override
  State<BooksDownloadedScreen> createState() => _BooksDownloadedScreenState();
}

class _BooksDownloadedScreenState extends State<BooksDownloadedScreen> {
  List<Books> downloadedBooks = [];
  bool isError = false;
  @override
  void initState() {
    super.initState();
    getDownloadedBooks();
  }

  void getDownloadedBooks() async {
    List<Books> books1 =
        await Books.loadListFromLocalStorage("downloadedBooks");
    //await Future.delayed(Duration(seconds: 1));
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
                    itemBuilder: (context, index) => DownloadCard(
                        category: downloadedBooks[index], height1: 100),
                  ));
  }
}

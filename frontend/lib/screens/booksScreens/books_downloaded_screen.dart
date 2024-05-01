import 'package:flutter/material.dart';
import 'package:frontend/models/books_model.dart';
import 'package:open_file/open_file.dart';

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

  void openPdf(String path) {
    try {
      OpenFile.open(path);
    } catch (error) {
      print('Error opening PDF: $error');
    }
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
                  itemBuilder: (context, index) => ListTile(
                    onTap: () {
                      openPdf(downloadedBooks[index].BookLinkUrl);
                    },
                    leading: Container(
                      width: 50,
                      height: 70,
                      child: Image.network(
                        downloadedBooks[index].BookImageUrl,
                        fit: BoxFit
                            .cover, // Adjust this property as per your requirement
                      ),
                    ),
                    title: Text(downloadedBooks[index].BookName),
                    subtitle: Text(downloadedBooks[index].Department),
                    trailing: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text("Warning"),
                              content: const Text(
                                  "This operation will delete the Book permanently"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("cancel"),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      Books.deleteBookFromLocalStorage(
                                          "downloadedBooks",
                                          downloadedBooks[index].id);
                                      setState(() {
                                        downloadedBooks.removeAt(index);
                                      });
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
    );
  }
}

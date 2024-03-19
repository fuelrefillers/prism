import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:frontend/models/books_model.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class BookItem extends StatefulWidget {
  const BookItem({super.key, required this.book});
  final Books book;

  @override
  State<BookItem> createState() => _BookItemState();
}

class _BookItemState extends State<BookItem> {
  bool DownloadStarted = false;
  bool DownloadCompleated = false;
  double progress = 0.00;
  String? pdfPath11;
  String fileurl = '';
  String imageurl = '';
  String bookId = '';
  bool isAlreadyDownloaded = false;
  String alreadyDownloadedPath = '';

  @override
  void initState() {
    super.initState();
    bookId = widget.book.id;
    fileurl = widget.book.BookLinkUrl;
    imageurl = widget.book.BookImageUrl;
    getDownloadedBooks();
  }

  void openPdf() {
    try {
      OpenFile.open(pdfPath11);
    } catch (error) {
      print('Error opening PDF: $error');
    }
  }

  void getDownloadedBooks() async {
    // List<Books> existingBookList = [];
    // await Books.saveListToLocalStorage(existingBookList, 'downloadedBooks');

    List<Books> existingBookList =
        await Books.loadListFromLocalStorage('downloadedBooks');
    setState(() {
      if (existingBookList.length > 0) {
        isAlreadyDownloaded = existingBookList.any((book) => book.id == bookId);

        if (isAlreadyDownloaded) {
          Books alreadyDownloadedBook =
              existingBookList.firstWhere((book) => book.id == bookId);
          alreadyDownloadedPath = alreadyDownloadedBook.BookLinkUrl;
          pdfPath11 = alreadyDownloadedPath;
        }
      }
    });
  }

  void downloadPdf() async {
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      //private storage -------> var dir = await getApplicationDocumentsDirectory(); <-------

      var dir = await getExternalStorageDirectory();
      if (dir != null) {
        String imageSavename = "${widget.book.BookName}.jpg";
        String imageSavepath = dir.path + "/$imageSavename";
        String savename = "${widget.book.BookName}.pdf";
        String savePath = dir.path + "/$savename";
        setState(() {
          pdfPath11 = savePath;
        });
        print(savePath);

        //output:  /storage/emulated/0/Android/data/com.example.frontend/files/next.pdf

        try {
          setState(() {
            DownloadStarted = true;
          });

          await Dio().download(fileurl, savePath,
              onReceiveProgress: (received, total) {
            if (total != -1) {
              // print((received / total * 100)
              //         .toStringAsFixed(0) +
              //     "%");
              setState(() {
                progress = received / total;
              }); // For progress indicaton
            }
          });

          await Dio().download(imageurl, imageSavepath);

          setState(() {
            DownloadStarted = false;
            DownloadCompleated = true;
          });

          // List<Books> existingBookList = [];

          // await Books.saveListToLocalStorage(
          //     existingBookList, 'downloadedBooks');

          if (pdfPath11 != null) {
            List<Books> existingBookList1 =
                await Books.loadListFromLocalStorage('downloadedBooks');

            print(
                "dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd");
            print(bookId);
            Books newBook = Books(
                id: bookId,
                Department: widget.book.Department,
                Regulation: widget.book.Regulation,
                BookName: widget.book.BookName,
                BookImageUrl: imageurl,
                BookLinkUrl: pdfPath11!,
                BookAuthor: widget.book.BookAuthor);

            existingBookList1.add(newBook);

            await Books.saveListToLocalStorage(
                existingBookList1, 'downloadedBooks');
          }

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
    return Container(
      margin: EdgeInsets.fromLTRB(4, 8, 4, 5),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 4.8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Row(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              height: MediaQuery.of(context).size.height / 4.8,
              width: MediaQuery.of(context).size.width / 3.8,
              child: Image.network(
                widget.book.BookImageUrl,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2.3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Book Name:',
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          child: Text(
                            widget.book.BookName.toUpperCase(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 17, 79, 90),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Author:',
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                        Text(
                          widget.book.BookAuthor,
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 17, 79, 90),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Department:',
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                        Text(
                          "${widget.book.Department}",
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 17, 79, 90),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        isAlreadyDownloaded || DownloadCompleated
                            ? ElevatedButton.icon(
                                onPressed: () {
                                  openPdf();
                                },
                                icon: Icon(Icons.check),
                                label: Text("Tap to open"))
                            : DownloadStarted
                                ? Center(
                                    child: CircularProgressIndicator.adaptive(
                                    value: progress,
                                  ))
                                : ElevatedButton.icon(
                                    onPressed: () {
                                      // openPdf();
                                      downloadPdf();
                                    },
                                    icon: Icon(Icons.download),
                                    label: Text("Downlad"))
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//  CircularProgressIndicator(
//                               value: progress,
//                             ),
//                             if (!DownloadStarted && !DownloadCompleated)
//                               GestureDetector(
//                                 onTap: () {
//                                   downloadPdf();
//                                 },
//                                 child: Icon(
//                                   Icons.download,
//                                   size: 50,
//                                   color: Colors.blue,
//                                 ),
//                               ),
//                             if (DownloadCompleated)
//                               Icon(
//                                 Icons.check_circle,
//                                 size: 50,
//                                 color: Colors.green,
//                               ),

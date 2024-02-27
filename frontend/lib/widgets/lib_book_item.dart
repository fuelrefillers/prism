import 'package:flutter/material.dart';
import 'package:frontend/models/library_books_model.dart';

class LibBookLii extends StatelessWidget {
  const LibBookLii(
      {super.key, required this.libbook, required this.fetchedDate});
  final LibraryBooks libbook;
  final String fetchedDate;

  @override
  Widget build(BuildContext context) {
    DateTime fetchedDate1 = DateTime.parse(fetchedDate);
    DateTime currentDate = DateTime.now();
    Duration difference = currentDate.difference(fetchedDate1);
    int daysPassed = difference.inDays;
    print(daysPassed);
    return Container(
      margin: EdgeInsets.fromLTRB(10, 8, 10, 5),
      width: MediaQuery.of(context).size.width,
      height: 170,
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
          ]),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        child: Row(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              height: 140,
              width: 100,
              child: Image.network(
                libbook.BookImage,
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
                    SizedBox(
                      child: Text(
                        libbook.BookName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Text(
                      libbook.BookEdition,
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(libbook.BookAuthor),
                    Text(
                      "Days Left : ${(14 - daysPassed).toString()}",
                      style: TextStyle(fontSize: 18),
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

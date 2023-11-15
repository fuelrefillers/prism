import 'package:flutter/material.dart';
import 'package:frontend/screens/books_screen.dart';

class BookItem extends StatelessWidget {
  const BookItem({super.key, required this.book});
  final Books book;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 8, 10, 5),
      width: MediaQuery.of(context).size.width,
      height: 150,
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
              height: 130,
              width: 100,
              child: Image.network(
                "https://www.shutterstock.com/image-vector/physics-chalkboard-background-hand-drawn-600w-1988419205.jpg",
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.bookname,
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    book.bookauthor,
                    style: TextStyle(fontSize: 18),
                  ),
                  Text("${book.bookedition} edition "),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

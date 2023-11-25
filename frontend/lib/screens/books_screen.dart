// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/services/auth.dart';
import 'package:frontend/services/ip.dart';
import 'package:frontend/widgets/book_item.dart';
import 'package:http/http.dart' as http;

class Books {
  final String id;
  final String bookid;
  final String bookname;
  final String bookimageurl;
  final String bookdrivelink;
  final int bookrating;
  final String bookauthor;
  final String bookedition;
  Books({
    required this.id,
    required this.bookid,
    required this.bookname,
    required this.bookimageurl,
    required this.bookdrivelink,
    required this.bookrating,
    required this.bookauthor,
    required this.bookedition,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'bookid': bookid,
      'bookname': bookname,
      'bookimageurl': bookimageurl,
      'bookdrivelink': bookdrivelink,
      'bookrating': bookrating,
      'bookauthor': bookauthor,
      'bookedition': bookedition,
    };
  }

  factory Books.fromMap(Map<String, dynamic> map) {
    return Books(
      id: map['_id'] as String,
      bookid: map['bookid'] as String,
      bookname: map['bookname'] as String,
      bookimageurl: map['bookimageurl'] as String,
      bookdrivelink: map['bookdrivelink'] as String,
      bookrating: map['bookrating'] as int,
      bookauthor: map['bookauthor'] as String,
      bookedition: map['bookedition'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Books.fromJson(String source) =>
      Books.fromMap(json.decode(source) as Map<String, dynamic>);
}

class BooksScreen extends StatefulWidget {
  const BooksScreen({super.key, required this.category});
  final String category;
  @override
  State<BooksScreen> createState() {
    return _BooksScreenState();
  }
}

class _BooksScreenState extends State<BooksScreen> {
  final Authservice authservice = Authservice();
  List<Books> books = [];
  List<Books> filteredList = [];
  @override
  void initState() {
    super.initState();
    getbooks();
  }

  void getbooks() async {
    List<Books> books1 = [];
    try {
      var response = await http
          .get(Uri.parse('$ip/api/books/getbook?category=${widget.category}'));
      List result = jsonDecode(response.body);

      for (int i = 0; i < result.length; i++) {
        Books post = Books.fromMap(result[i] as Map<String, dynamic>);
        books1.add(post);
      }
      print(books1);
      setState(() {
        books = books1;
        filteredList = books;
      });
    } catch (err) {
      print(err.toString());
    }
  }

  void search(String searchkey) {
    List<Books> result = [];

    if (searchkey.isEmpty) {
      result = books;
    } else {
      result = books
          .where((book) =>
              book.bookname.toLowerCase().contains(searchkey.toLowerCase()))
          .toList();
      print(result.toList());
      print(filteredList);
    }
    setState(() {
      filteredList = result;
    });
    print(filteredList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => search(value),
              decoration: InputDecoration(
                hintText: 'Search...',
                // Add a clear button to the search bar
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {},
                ),
                // Add a search icon or button to the search bar
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, index) =>
                    BookItem(book: filteredList[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

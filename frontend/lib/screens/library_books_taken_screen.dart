import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/models/books_model.dart';
import 'package:frontend/models/library_books_model.dart';
import 'package:frontend/services/ip.dart';
import 'package:frontend/widgets/book_item.dart';
import 'package:frontend/widgets/lib_book_item.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LibraryBooksTakenScreen extends StatefulWidget {
  const LibraryBooksTakenScreen({super.key, required this.datelist});
  final List<dynamic> datelist;
  @override
  State<LibraryBooksTakenScreen> createState() {
    return _LibraryBooksTakenScreenState();
  }
}

class _LibraryBooksTakenScreenState extends State<LibraryBooksTakenScreen> {
  bool isError = false;
  List<LibraryBooks> books = [];

  @override
  void initState() {
    super.initState();
    getLibbooks();
  }

  void getLibbooks() async {
    List<LibraryBooks> libBooks = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      var response = await http.get(
        Uri.parse('$ip/api/library/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      List result = jsonDecode(response.body);
      print(result);
      for (int i = 0; i < result.length; i++) {
        LibraryBooks post =
            LibraryBooks.fromMap(result[i] as Map<String, dynamic>);
        libBooks.add(post);
      }
      print(libBooks);
      setState(() {
        books = libBooks;
      });
      await Future.delayed(Duration(seconds: 5));
      if (libBooks.isEmpty) {
        setState(() {
          isError = true;
        });
      }
      print(libBooks[0].BookName);
    } catch (err) {
      print(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Books Taken"),
        ),
        body: books.isEmpty && isError == false
            ? Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : isError
                ? Center(
                    child: Text(
                        "Something went wrong or resultrs aren't updated yet !!!"),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: books.length,
                          itemBuilder: (context, index) => LibBookLii(
                            libbook: books[index],
                            fetchedDate: widget.datelist[index],
                          ),
                        ),
                      )
                    ],
                  ));
  }
}

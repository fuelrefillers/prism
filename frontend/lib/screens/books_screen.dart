import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/models/books_model.dart';
import 'package:frontend/services/auth.dart';
import 'package:frontend/services/prismBloc/prism_bloc.dart';
import 'package:frontend/widgets/book_item.dart';

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
  final PrismBloc prismBloc = PrismBloc();
  bool isError = false;
  List<Books> books = [];
  @override
  void initState() {
    super.initState();
    getBooksFrom();
    //prismBloc.add(BooksInitialFetchEvent(category: widget.category));
  }

  void getBooksFrom() async {
    List<Books> books1 = await authservice.getbooks(context, widget.category);
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      books = books1;
    });
    await Future.delayed(Duration(seconds: 5));
    if (books1.isEmpty) {
      setState(() {
        isError = true;
      });
    }
  }

  // void search(String searchkey) {
  //   List<Books> result = [];

  //   if (searchkey.isEmpty) {
  //     result = books;
  //   } else {
  //     result = books
  //         .where((book) =>
  //             book.bookname.toLowerCase().contains(searchkey.toLowerCase()))
  //         .toList();
  //     print(result.toList());
  //     print(filteredList);
  //   }
  //   setState(() {
  //     filteredList = result;
  //   });
  //   print(filteredList);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: books.isEmpty && isError == false
          ? Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : isError
              ? Center(child: Text("Error"))
              : Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      TextField(
                        //onChanged: (value) => search(value),
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
                          itemCount: books.length,
                          itemBuilder: (context, index) =>
                              BookItem(book: books[index]),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}

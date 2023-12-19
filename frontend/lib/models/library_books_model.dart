import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class LibraryBooks {
  final String BookId;
  final String BookName;
  final String BookImage;
  final String BookAuthor;
  final String BookEdition;
  LibraryBooks({
    required this.BookId,
    required this.BookName,
    required this.BookImage,
    required this.BookAuthor,
    required this.BookEdition,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'BookId': BookId,
      'BookName': BookName,
      'BookImage': BookImage,
      'BookAuthor': BookAuthor,
      'BookEdition': BookEdition,
    };
  }

  factory LibraryBooks.fromMap(Map<String, dynamic> map) {
    return LibraryBooks(
      BookId: map['BookId'] as String,
      BookName: map['BookName'] as String,
      BookImage: map['BookImage'] as String,
      BookAuthor: map['BookAuthor'] as String,
      BookEdition: map['BookEdition'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LibraryBooks.fromJson(String source) =>
      LibraryBooks.fromMap(json.decode(source) as Map<String, dynamic>);
}

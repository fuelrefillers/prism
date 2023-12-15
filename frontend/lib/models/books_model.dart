import 'dart:convert';

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

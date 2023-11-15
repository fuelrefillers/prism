// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String rollno;
  final String name;
  final String imageurl;
  final String branch;
  final String clas;
  final String studentphno;
  final String studentemail;
  final String parentname;
  final String parentphno;
  final String parentemail;
  User({
    required this.rollno,
    required this.name,
    required this.imageurl,
    required this.branch,
    required this.clas,
    required this.studentphno,
    required this.studentemail,
    required this.parentname,
    required this.parentphno,
    required this.parentemail,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rollno': rollno,
      'name': name,
      'imageurl': imageurl,
      'branch': branch,
      'clas': clas,
      'studentphno': studentphno,
      'studentemail': studentemail,
      'parentname': parentname,
      'parentphno': parentphno,
      'parentemail': parentemail,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      rollno: map['rollno'] as String,
      name: map['name'] as String,
      imageurl: map['imageurl'] as String,
      branch: map['branch'] as String,
      clas: map['clas'] as String,
      studentphno: map['studentphno'] as String,
      studentemail: map['studentemail'] as String,
      parentname: map['parentname'] as String,
      parentphno: map['parentphno'] as String,
      parentemail: map['parentemail'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}

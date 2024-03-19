import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CertificatesModel {
  final String RollNo;
  final String Department;
  final String Regulation;
  final String Section;
  final String Name;
  final String CertificationBy;
  final String Course;
  final String CertificateUrl;
  final String CertificateAddress;
  CertificatesModel({
    required this.RollNo,
    required this.Department,
    required this.Regulation,
    required this.Section,
    required this.Name,
    required this.CertificationBy,
    required this.Course,
    required this.CertificateUrl,
    required this.CertificateAddress,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'RollNo': RollNo,
      'Department': Department,
      'Regulation': Regulation,
      'Section': Section,
      'Name': Name,
      'CertificationBy': CertificationBy,
      'Course': Course,
      'CertificateUrl': CertificateUrl,
      'CertificateAddress': CertificateAddress,
    };
  }

  factory CertificatesModel.fromMap(Map<String, dynamic> map) {
    return CertificatesModel(
      RollNo: map['RollNo'] as String,
      Department: map['Department'] as String,
      Regulation: map['Regulation'] as String,
      Section: map['Section'] as String,
      Name: map['Name'] as String,
      CertificationBy: map['CertificationBy'] as String,
      Course: map['Course'] as String,
      CertificateUrl: map['CertificateUrl'] as String,
      CertificateAddress: map['CertificateAddress'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CertificatesModel.fromJson(String source) =>
      CertificatesModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

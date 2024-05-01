import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UpdatesModel {
  String Regulation;
  String Department;
  String Section;
  String Message;
  List<String> ImagesUrl;
  List<String> PdfUrl;
  String SentBy;
  String Title;
  String created_at;
  String id;
  UpdatesModel({
    required this.Regulation,
    required this.Department,
    required this.Section,
    required this.Message,
    required this.ImagesUrl,
    required this.PdfUrl,
    required this.SentBy,
    required this.Title,
    required this.created_at,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Regulation': Regulation,
      'Department': Department,
      'Section': Section,
      'Message': Message,
      'ImagesUrl': ImagesUrl,
      'PdfUrl': PdfUrl,
      'SentBy': SentBy,
      'Title': Title,
      'created_at': created_at,
      'id': id,
    };
  }

  factory UpdatesModel.fromMap(Map<String, dynamic> map) {
    return UpdatesModel(
      Regulation: map['Regulation'] as String,
      Department: map['Department'] as String,
      Section: map['Section'] as String,
      Message: map['Message'] as String,
      ImagesUrl: List<String>.from(map['ImagesUrl'] as List<dynamic>),
      PdfUrl: List<String>.from(map['PdfUrl'] as List<dynamic>),
      SentBy: map['SentBy'] as String,
      Title: map['Title'] as String,
      created_at: map['created_at'] as String,
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdatesModel.fromJson(String source) =>
      UpdatesModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

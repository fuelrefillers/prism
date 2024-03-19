import 'dart:convert';

class Details {
  final String adminId;
  final String name;

  Details({
    required this.adminId,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'adminId': adminId,
      'name': name,
    };
  }

  factory Details.fromMap(Map<String, dynamic> map) {
    return Details(
      adminId: map['adminId'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());
  factory Details.fromJson(String source) =>
      Details.fromMap(json.decode(source) as Map<String, dynamic>);
}

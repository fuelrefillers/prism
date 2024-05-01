import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserAlreadyExistsModel {
  final String adminId;
  final String name;
  final UserAlreadyExistsRoomModel roomDetails;
  UserAlreadyExistsModel({
    required this.adminId,
    required this.name,
    required this.roomDetails,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'adminId': adminId,
      'name': name,
      'roomDetails': roomDetails.toMap(),
    };
  }

  factory UserAlreadyExistsModel.fromMap(Map<String, dynamic> map) {
    return UserAlreadyExistsModel(
      adminId: map['adminId'] as String,
      name: map['name'] as String,
      roomDetails: UserAlreadyExistsRoomModel.fromMap(
          map['roomDetails'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserAlreadyExistsModel.fromJson(String source) =>
      UserAlreadyExistsModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}

class UserAlreadyExistsRoomModel {
  final String type;
  final int floorNumber;
  final int roomNumber;
  final int bedNumber;
  UserAlreadyExistsRoomModel({
    required this.type,
    required this.floorNumber,
    required this.roomNumber,
    required this.bedNumber,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'floorNumber': floorNumber,
      'roomNumber': roomNumber,
      'bedNumber': bedNumber,
    };
  }

  factory UserAlreadyExistsRoomModel.fromMap(Map<String, dynamic> map) {
    return UserAlreadyExistsRoomModel(
      type: map['type'] as String,
      floorNumber: map['floorNumber'] as int,
      roomNumber: map['roomNumber'] as int,
      bedNumber: map['bedNumber'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserAlreadyExistsRoomModel.fromJson(String source) =>
      UserAlreadyExistsRoomModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}

class HostelFloorsModel {
  final String type;
  final int floorNumber;
  final int totalBeds;
  final int availableBeds;
  HostelFloorsModel({
    required this.type,
    required this.floorNumber,
    required this.totalBeds,
    required this.availableBeds,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'floorNumber': floorNumber,
      'totalBeds': totalBeds,
      'availableBeds': availableBeds,
    };
  }

  factory HostelFloorsModel.fromMap(Map<String, dynamic> map) {
    return HostelFloorsModel(
      type: map['type'] as String,
      floorNumber: map['floorNumber'] as int,
      totalBeds: map['totalBeds'] as int,
      availableBeds: map['availableBeds'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory HostelFloorsModel.fromJson(String source) =>
      HostelFloorsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class HostelsRoomModel {
  final String type;
  final int floorNumber;
  final int roomNumber;
  final List<HostelBedsModel> beds;
  final int totalBeds;
  final int bedsNotBooked;
  HostelsRoomModel({
    required this.type,
    required this.floorNumber,
    required this.roomNumber,
    required this.beds,
    required this.totalBeds,
    required this.bedsNotBooked,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'floorNumber': floorNumber,
      'roomNumber': roomNumber,
      'beds': beds.map((x) => x.toMap()).toList(),
      'totalBeds': totalBeds,
      'bedsNotBooked': bedsNotBooked,
    };
  }

  factory HostelsRoomModel.fromMap(Map<String, dynamic> map) {
    return HostelsRoomModel(
      type: map['type'] as String,
      floorNumber: map['floorNumber'] as int,
      roomNumber: map['roomNumber'] as int,
      beds: List<HostelBedsModel>.from(
        (map['beds'] as List<dynamic>).map<HostelBedsModel>(
          (x) => HostelBedsModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      totalBeds: map['totalBeds'] as int,
      bedsNotBooked: map['bedsNotBooked'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory HostelsRoomModel.fromJson(String source) =>
      HostelsRoomModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class HostelBedsModel {
  final int bedNumber;
  final bool isBooked;
  final String bookedBy;
  final String bookedById;
  HostelBedsModel({
    required this.bedNumber,
    required this.isBooked,
    required this.bookedBy,
    required this.bookedById,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bedNumber': bedNumber,
      'isBooked': isBooked,
      'bookedBy': bookedBy,
      'bookedById': bookedById,
    };
  }

  factory HostelBedsModel.fromMap(Map<String, dynamic> map) {
    return HostelBedsModel(
      bedNumber: map['bedNumber'] as int,
      isBooked: map['isBooked'] as bool,
      bookedBy: map['bookedBy'] as String,
      bookedById: map['bookedById'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory HostelBedsModel.fromJson(String source) =>
      HostelBedsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

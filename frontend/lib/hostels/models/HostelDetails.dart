class HostelDetails {
  final int hostelId;
  final String hostelType;
  final int floors;
  final int totalRooms;
  final int specialRooms;
  final int beds;

  HostelDetails({
    required this.hostelId,
    required this.hostelType,
    required this.floors,
    required this.totalRooms,
    required this.specialRooms,
    required this.beds,
  });

  factory HostelDetails.fromJson(Map<String, dynamic> json) {
    return HostelDetails(
      hostelId: json['hostelId'] ?? 0,
      hostelType: json['hostelType'] ?? '',
      floors: json['floors'] ?? 0,
      totalRooms: json['totalRooms'] ?? 0,
      specialRooms: json['specialRooms'] ?? 0,
      beds: json['beds'] ?? 0,
    );
  }
}

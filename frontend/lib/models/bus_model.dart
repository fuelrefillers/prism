import 'dart:convert';

class Bus {
  final String Busno;
  final String Routeno;
  final String Routename;
  final String Routedesc;
  final String drivername;
  final int driverph;
  final String driverimage;
  final String startlocation;
  final String currentlocation;
  final String starttime;
  final String reachtime;
  final List<dynamic> Stoplocation;
  Bus({
    required this.Busno,
    required this.Routeno,
    required this.Routename,
    required this.Routedesc,
    required this.drivername,
    required this.driverph,
    required this.driverimage,
    required this.startlocation,
    required this.currentlocation,
    required this.starttime,
    required this.reachtime,
    required this.Stoplocation,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Busno': Busno,
      'Routeno': Routeno,
      'Routename': Routename,
      'Routedesc': Routedesc,
      'drivername': drivername,
      'driverph': driverph,
      'driverimage': driverimage,
      'startlocation': startlocation,
      'currentlocation': currentlocation,
      'starttime': starttime,
      'reachtime': reachtime,
      'Stoplocation': Stoplocation,
    };
  }

  factory Bus.fromMap(Map<String, dynamic> map) {
    return Bus(
      Busno: map['Busno'] as String,
      Routeno: map['Routeno'] as String,
      Routename: map['Routename'] as String,
      Routedesc: map['Routedesc'] as String,
      drivername: map['drivername'] as String,
      driverph: map['driverph'] as int,
      driverimage: map['driverimage'] as String,
      startlocation: map['startlocation'] as String,
      currentlocation: map['currentlocation'] as String,
      starttime: map['starttime'] as String,
      reachtime: map['reachtime'] as String,
      Stoplocation: List<dynamic>.from((map['Stoplocation'] as List<dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Bus.fromJson(String source) =>
      Bus.fromMap(json.decode(source) as Map<String, dynamic>);
}

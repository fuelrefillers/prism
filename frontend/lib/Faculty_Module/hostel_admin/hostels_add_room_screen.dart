import 'package:flutter/material.dart';
import 'package:frontend/Faculty_Module/hostel_admin/rooms_display_page.dart';

class HostelAddRoomScreen extends StatefulWidget {
  const HostelAddRoomScreen({Key? key}) : super(key: key);

  @override
  State<HostelAddRoomScreen> createState() => _HostelAddRoomScreenState();
}

class _HostelAddRoomScreenState extends State<HostelAddRoomScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _floorNoController = TextEditingController();
  final TextEditingController _noOfRoomsController = TextEditingController();
  final TextEditingController _bedsPerRoomController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    _typeController.dispose();
    _floorNoController.dispose();
    _noOfRoomsController.dispose();
    _bedsPerRoomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add rooms'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _typeController,
                decoration: InputDecoration(labelText: 'Type'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter type';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _floorNoController,
                decoration: InputDecoration(labelText: 'Floor No'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter floor number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _noOfRoomsController,
                decoration: InputDecoration(labelText: 'Number of Rooms'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter number of rooms';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _bedsPerRoomController,
                decoration: InputDecoration(labelText: 'Beds per Room'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter beds per room';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // Process the data
            String type = _typeController.text;
            String floorNo = _floorNoController.text;
            String noOfRooms = _noOfRoomsController.text;
            String bedsPerRoom = _bedsPerRoomController.text;

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RoomsDisplayPage(
                  bedsPerRoom: int.parse(bedsPerRoom),
                  floorno: int.parse(floorNo),
                  noofrooms: int.parse(noOfRooms),
                  type: type,
                ),
              ),
            );

            print('Type: $type');
            print('Floor No: $floorNo');
            print('Number of Rooms: $noOfRooms');
            print('Beds per Room: $bedsPerRoom');
          }
        },
        child: Text("Next"),
      ),
    );
  }
}

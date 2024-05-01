import 'package:flutter/material.dart';
import 'package:frontend/models/hostel_models.dart';

class HostelAlreadyBookedScreen extends StatelessWidget {
  const HostelAlreadyBookedScreen({super.key, required this.userDetails});
  final UserAlreadyExistsModel userDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hostels"),
      ),
      body: Card(
        color: Colors.white,
        shadowColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          //set border radius more than 50% of height and width to make circle
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Student Details:',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 17,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  const Text("Name :"),
                  Text(
                    userDetails.name,
                    style: TextStyle(
                        fontSize: 18, color: Color.fromARGB(255, 17, 79, 90)),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  const Text("Admin ID :"),
                  Text(
                    userDetails.adminId,
                    style: TextStyle(
                        fontSize: 18, color: Color.fromARGB(255, 17, 79, 90)),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  const Text("Hostel :"),
                  Text(
                    userDetails.roomDetails.type,
                    style: TextStyle(
                        fontSize: 18, color: Color.fromARGB(255, 17, 79, 90)),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  const Text("Floor :"),
                  Text(
                    userDetails.roomDetails.floorNumber.toString(),
                    style: TextStyle(
                        fontSize: 18, color: Color.fromARGB(255, 17, 79, 90)),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  const Text("Room No :"),
                  Text(
                    userDetails.roomDetails.roomNumber.toString(),
                    style: TextStyle(
                        fontSize: 18, color: Color.fromARGB(255, 17, 79, 90)),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  const Text("Bed No :"),
                  Text(
                    userDetails.roomDetails.bedNumber.toString(),
                    style: TextStyle(
                        fontSize: 18, color: Color.fromARGB(255, 17, 79, 90)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

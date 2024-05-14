import 'package:flutter/material.dart';
import 'package:frontend/Faculty_Module/hostel_admin/to_be_changed/floors.dart';
import 'package:frontend/screens/Hostel_Screens/widgets/hostel_main_screen_button.dart';

class Hostels extends StatelessWidget {
  const Hostels({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hostel Selection"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              HostelHomeScreenButton(
                bottomtext: "Take a look",
                image: "assets/hostel_image_1.png",
                toptext: "Boy's Hostel",
                type: "boys",
                screen: Floors(
                  type: "boys",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              HostelHomeScreenButton(
                bottomtext: "Take a look",
                image: "assets/hostel_image_2.png",
                toptext: "Girl's Hostel",
                type: "girls",
                screen: Floors(
                  type: "girls",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

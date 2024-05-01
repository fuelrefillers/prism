import 'package:flutter/material.dart';
import 'package:frontend/screens/Hostel_Screens/hostel_floors_screen.dart';
import 'package:frontend/screens/Hostel_Screens/widgets/hostel_main_screen_button.dart';

class HostelsHomeScreen extends StatefulWidget {
  const HostelsHomeScreen({super.key});

  @override
  State<HostelsHomeScreen> createState() => _HostelsHomeScreenState();
}

class _HostelsHomeScreenState extends State<HostelsHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hostel Selection"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                HostelHomeScreenButton(
                  bottomtext: "Take a look",
                  image: "assets/hostel_image_1.png",
                  toptext: "Boy's Hostel",
                  type: "boys",
                  screen: HostelsFLoorScreen(
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
                  screen: HostelsFLoorScreen(
                    type: "girls",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

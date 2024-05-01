import 'package:flutter/material.dart';
import 'package:frontend/screens/Hostel_Screens/hostel_floors_screen.dart';

class HostelHomeScreenButton extends StatelessWidget {
  final String image;
  final String toptext;
  final String bottomtext;
  final String type;
  final Widget screen;
  const HostelHomeScreenButton(
      {super.key,
      required this.bottomtext,
      required this.image,
      required this.toptext,
      required this.type,
      required this.screen});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Stack(
        children: [
          // Background image
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(image)),
              ),
            ),
          ),
          // Text on top left corner
          Positioned(
            top: 20,
            left: 20,
            child: Container(
              padding: EdgeInsets.all(8),
              color: Colors.transparent,
              child: Text(
                toptext,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
          // Glass-like container with text
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 210, 210, 210)
                          .withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  bottomtext,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

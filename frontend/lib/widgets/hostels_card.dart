import 'package:flutter/material.dart';
import 'package:frontend/screens/Hostel_Screens/hostel_floors_screen.dart';

class HostelsCard extends StatelessWidget {
  final String title;
  final String type;
  const HostelsCard({super.key, required this.title, required this.type});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HostelsFLoorScreen(
              type: type,
            ),
          ),
        );
      },
      child: Container(
          height: MediaQuery.of(context).size.height / 3.3,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromARGB(255, 180, 180, 180),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 4.3,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: AssetImage('assets/hostels-hero.jpg'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              )
            ],
          )),
    );
  }
}

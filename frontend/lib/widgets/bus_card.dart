import 'package:flutter/material.dart';
import 'package:frontend/screens/bus_details_screen.dart';

class BusCard extends StatelessWidget {
  const BusCard({super.key});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BusScreenDetails(),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Route no",
                style: TextStyle(fontSize: 20),
              ),
              Divider(),
              Text(
                "route name + bus no",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Text(
                "route desc",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(Icons.timer_outlined),
                      Text("time"),
                    ],
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.pin_drop_outlined),
                          Text("start location"),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

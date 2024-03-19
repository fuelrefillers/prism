import 'package:flutter/material.dart';
import 'package:frontend/models/bus_model.dart';
import 'package:frontend/screens/busScreens/bus_details_screen.dart';

class BusCard extends StatelessWidget {
  const BusCard({super.key, required this.bus});
  final Bus bus;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BusScreenDetails(bus: bus),
          ),
        );
      },
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Container(
          margin: EdgeInsets.fromLTRB(2, 10, 2, 10),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 5,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Route ${bus.Routeno}",
                  style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 196, 148, 80),
                      fontWeight: FontWeight.w700),
                ),
                Divider(
                  thickness: 0.5,
                ),
                Text(
                  "${bus.Routename} - ${bus.Busno}",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 17, 79, 90),
                  ),
                ),
                Text(
                  bus.Routedesc,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
                Divider(
                  thickness: 0.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                        Text(
                          "start time :",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: const Color.fromARGB(255, 0, 0, 0)),
                        ),
                        Text(
                          bus.starttime,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromARGB(255, 25, 86, 136)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.pin_drop_outlined,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            Text(
                              "start stop :",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            Text(bus.startlocation,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: const Color.fromARGB(
                                        255, 25, 86, 136))),
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
      ),
    );
  }
}

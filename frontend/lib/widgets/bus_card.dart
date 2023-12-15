import 'package:flutter/material.dart';
import 'package:frontend/models/bus_model.dart';
import 'package:frontend/screens/bus_details_screen.dart';

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
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Route ${bus.Routeno}",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.indigo,
                    fontWeight: FontWeight.w700),
              ),
              Divider(),
              Text(
                "${bus.Routename} - ${bus.Busno}",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              Text(
                bus.Routedesc,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        color: Colors.blue,
                      ),
                      Text(
                        "start time :",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue),
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
                            color: Color.fromARGB(255, 243, 33, 33),
                          ),
                          Text(
                            "start stop :",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: const Color.fromARGB(255, 243, 33, 33)),
                          ),
                          Text(bus.startlocation,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      const Color.fromARGB(255, 25, 86, 136))),
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

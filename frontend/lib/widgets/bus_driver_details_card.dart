import 'package:flutter/material.dart';
import 'package:frontend/models/bus_model.dart';

class BusDriverDetailsCard extends StatelessWidget {
  const BusDriverDetailsCard({super.key, required this.bus});
  final Bus bus;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 8, 10, 5),
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
              offset: Offset(0, 3),
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        child: Row(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              height: 130,
              width: 100,
              child: Image.network(
                "https://www.shutterstock.com/image-vector/physics-chalkboard-background-hand-drawn-600w-1988419205.jpg",
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bus.drivername,
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    bus.driverph.toString(),
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(bus.Busno),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

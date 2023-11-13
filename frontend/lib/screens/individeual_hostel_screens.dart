import 'package:flutter/material.dart';
import 'package:frontend/screens/dummy_screen.dart';
import 'package:frontend/widgets/home_nav_control.dart';

class HostelsInfo extends StatelessWidget {
  const HostelsInfo({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hostel Details")),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text("title"),
            Stack(
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 124, 124, 124)),
                  child: Image.asset(
                    'assets/hostels-hero.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        color: Color.fromARGB(120, 152, 152, 152)),
                    child: Center(
                        child: Text(
                      "Hostel name",
                      style: TextStyle(fontSize: 20),
                    )),
                  ),
                ),
              ],
            ),
            Expanded(
              child: GridView(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 2 / 1.5,
                ),
                children: [
                  Buttonhome(
                      category: "room",
                      icon: Icons.bed_outlined,
                      screen: DummyScreen()),
                  Buttonhome(
                      category: "room",
                      icon: Icons.bed_outlined,
                      screen: DummyScreen()),
                  Buttonhome(
                      category: "room",
                      icon: Icons.bed_outlined,
                      screen: DummyScreen()),
                  Buttonhome(
                      category: "room",
                      icon: Icons.bed_outlined,
                      screen: DummyScreen()),
                  Buttonhome(
                      category: "room",
                      icon: Icons.bed_outlined,
                      screen: DummyScreen()),
                  Buttonhome(
                      category: "room",
                      icon: Icons.bed_outlined,
                      screen: DummyScreen()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

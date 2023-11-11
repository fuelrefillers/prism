import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:frontend/widgets/multi_purpose_card.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final con = FlipCardController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Library"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Stack(
            children: [
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 5.5,
                    padding: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(238, 135, 135, 135),
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: Offset(
                            0,
                            10,
                          ),
                        ),
                      ],
                      color: Color.fromARGB(51, 0, 0, 0),
                      image: DecorationImage(
                        image: AssetImage('assets/chefs-3.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 5,
                    padding: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      color: Color.fromARGB(255, 189, 111, 187),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "sai tharak",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        Text(
                          "21J41A05R5",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        SizedBox(
                          height: 8,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                  left: MediaQuery.of(context).size.width / 2 - 50,
                  top: MediaQuery.of(context).size.height / 5 - 85,
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    height: 140,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image(
                      image: AssetImage('assets/chefs-3.jpg'),
                      fit: BoxFit.fitHeight,
                    ),
                  ))
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView(
                clipBehavior: Clip.hardEdge,
                children: [
                  FlipCard(
                    animationDuration: Duration(milliseconds: 500),
                    rotateSide: RotateSide.left,
                    onTapFlipping: true,
                    axis: FlipAxis.vertical,
                    controller: con,
                    frontWidget: Container(
                        clipBehavior: Clip.hardEdge,
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
                        width: 300,
                        height: 200,
                        child: const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "MALLA REDDY ENGINEERING COLLEGE",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 17.8,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              // SizedBox(
                              //   height: 20,
                              // ),
                              Text("BORROWERS'S LIBRARY CARD"),
                              Text("21J41A05R5"),
                              Text("valid till 2025"),
                              Text("sai tharak"),
                            ],
                          ),
                        )),
                    backWidget: Container(
                        width: 300,
                        height: 200,
                        clipBehavior: Clip.hardEdge,
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
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(),
                                height: 75,
                                width: 180,
                                child: Image.network(
                                  'https://barcode.tec-it.com/barcode.ashx?data=21J41A05R5&code=Code128&translate-esc=on',
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Text(
                                "books count : 3 of 6 ",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
          MultiPurposeCard(category: "Books history")
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:frontend/screens/Hostel_Screens/hostel_details_screen.dart';

class HostelTnC_Screen extends StatelessWidget {
  const HostelTnC_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 19, 79, 90),
      appBar: AppBar(
        leadingWidth: MediaQuery.of(context).size.width,
        toolbarHeight: MediaQuery.of(context).size.height / 3,
        leading: Container(
          height: 500,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            "assets/hostels-background.png",
            fit: BoxFit.cover,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 19, 79, 90),
        elevation: 0,
      ),
      body: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0), topRight: Radius.circular(0)),
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Color.fromARGB(255, 232, 232, 232),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              'Instructions:',
                              style: TextStyle(
                                  fontSize: 24.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 16.0), // Add spacing

                          // Add spacing and increase font size for each instruction
                          Text('1. Read and agree to the terms below:',
                              style: TextStyle(fontSize: 18.0)),
                          SizedBox(height: 8.0),
                          Text('2. Follow the guidelines carefully.',
                              style: TextStyle(fontSize: 18.0)),
                          SizedBox(height: 8.0),
                          Text('3. Complete each step thoroughly.',
                              style: TextStyle(fontSize: 18.0)),
                          SizedBox(height: 8.0),
                          Text('4. Ensure you understand before proceeding.',
                              style: TextStyle(fontSize: 18.0)),
                          SizedBox(height: 8.0),
                          Text('5. Contact support if you encounter issues.',
                              style: TextStyle(fontSize: 18.0)),
                          SizedBox(height: 8.0),
                          Text('6. Save your progress periodically.',
                              style: TextStyle(fontSize: 18.0)),
                          SizedBox(height: 8.0),
                          Text('7. Review your work before submission.',
                              style: TextStyle(fontSize: 18.0)),
                          SizedBox(height: 8.0),
                          Text('8. Stay focused and attentive.',
                              style: TextStyle(fontSize: 18.0)),
                          SizedBox(height: 8.0),
                          Text('9. Take breaks when needed.',
                              style: TextStyle(fontSize: 18.0)),
                          SizedBox(height: 8.0),
                          Text('10. Enjoy the process!',
                              style: TextStyle(fontSize: 18.0)),
                        ],
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 4,
                      width: MediaQuery.of(context).size.width,
                      color: Color.fromARGB(255, 255, 255, 255),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Icon(Icons.watch_later_outlined),
                                  Text("Time")
                                ],
                              ),
                              Column(
                                children: [Icon(Icons.router), Text("Wifi")],
                              ),
                              Column(
                                children: [
                                  Icon(Icons.cleaning_services_rounded),
                                  Text("Clean")
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(Icons.food_bank_rounded),
                                  Text("Food")
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(Icons.menu_book_rounded),
                                  Text("Study")
                                ],
                              )
                            ],
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color.fromARGB(255, 17, 79, 90)),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            HostelDetailsScreen()));
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: Text(
                                  "I Agree",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

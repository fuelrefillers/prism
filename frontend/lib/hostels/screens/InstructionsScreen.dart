import 'package:flutter/material.dart';
import 'package:frontend/hostels/providers/HostelDetailsProvider.dart';
import 'package:frontend/hostels/screens/ContainerScreen.dart';
import 'package:provider/provider.dart'; // Import Provider package

class InstructionScreen extends StatefulWidget {
  @override
  _InstructionScreenState createState() => _InstructionScreenState();
}

class _InstructionScreenState extends State<InstructionScreen> {
  bool agreed = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HostelDetailsProvider(), // Wrap with Provider
      child: Scaffold(
        appBar: AppBar(
          title: Text('Instructions'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Instructions
              Container(
                padding: EdgeInsets.all(16.0),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Instructions:',
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
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
              // Agreement Checkbox
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: agreed,
                        onChanged: (value) {
                          setState(() {
                            agreed = value!;
                          });
                        },
                      ),
                      const Text('I agree'),
                    ],
                  ),
                ),
              ),
              // Continue Button
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (agreed) {
                        // // Access the hostel details provider
                        // final hostelDetailsProvider =
                        //     Provider.of<HostelDetailsProvider>(context,
                        //         listen: false);

                        // // Print the number of beds
                        // print(
                        //     'Total Beds: ${hostelDetailsProvider.hostelDetails.beds}');

                        // // Print hostel name if hostel ID is 1
                        // if (hostelDetailsProvider.hostelDetails.hostelId == 1) {
                        //   print(
                        //       'Hostel Name: ${hostelDetailsProvider.hostelDetails.hostelType}');
                        // } else {
                        //   print('Hostel ID is not 1');
                        // }

                        // // Print hostel details regardless of ID for additional debugging
                        // print(
                        //     'Hostel Details: ${hostelDetailsProvider.hostelDetails}');

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContainerScreen(),
                          ),
                        );
                      } else {
                        // Show a message or handle the case where the user hasn't agreed
                        // You can use a snackbar or dialog to inform the user
                        // For simplicity, I'm just printing a message to the console
                        print('Please agree to the terms.');
                      }
                    },
                    child: const Text('Continue'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

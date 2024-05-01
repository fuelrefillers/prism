import 'package:flutter/material.dart';

class RaiseComplaintScreen extends StatelessWidget {
  const RaiseComplaintScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Raise complaint"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: TextField(
                maxLines: null, // Allow unlimited lines of text
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your complaint here',
                ),
              ),
            ),
            SizedBox(
                height:
                    16), // Add some spacing between the text area and the button
            ElevatedButton(
              onPressed: () {
                // Handle submit button pressed
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

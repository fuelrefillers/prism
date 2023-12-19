import 'package:flutter/material.dart';
import 'package:frontend/providers.dart/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class FeeStatusScreen extends StatelessWidget {
  const FeeStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fee Status"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Here are your details :"),
              ],
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                //set border radius more than 50% of height and width to make circle
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Name :"),
                    Text(user.StudentName),
                    const Divider(
                      color: Colors.black,
                    ),
                    const Text("Email :"),
                    Text(user.StudentEmail),
                    const Divider(
                      color: Colors.black,
                    ),
                    const Text("Mobile :"),
                    Text(user.StudentPhnNo.toString()),
                    const Divider(
                      color: Colors.black,
                    ),
                    const Text("Department :"),
                    Text(user.Department),
                    const Divider(
                      color: Colors.black,
                    ),
                    const Text("Parent details :"),
                    Text(user.FatherName),
                    Text(user.FatherPhnNo.toString()),
                    Text(user.FatherEmail),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Fee Status : ",
                    style: TextStyle(
                        fontSize: 25, color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          launchUrlString('https://mrecacademics.com/');
                        },
                        child: const Text("Pay Fee"),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

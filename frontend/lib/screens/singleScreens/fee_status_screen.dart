import 'package:flutter/material.dart';
import 'package:frontend/providers.dart/user_provider.dart';
import 'package:provider/provider.dart';

class FeeStatusScreen extends StatelessWidget {
  const FeeStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        shadowColor: Colors.grey,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Fee Status"),
            Image.asset(
              'assets/MREC_logo.png',
              height: MediaQuery.of(context).size.height / 8,
              width: MediaQuery.of(context).size.width / 8,
            ),
          ],
        ),
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
              color: Colors.white,
              shadowColor: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                //set border radius more than 50% of height and width to make circle
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Student Details:',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        const Text("Name :"),
                        Text(
                          user.StudentName,
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 17, 79, 90)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        const Text("Email :"),
                        Text(
                          user.StudentEmail,
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 17, 79, 90)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        const Text("Mobile :"),
                        Text(
                          user.StudentPhnNo.toString(),
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 17, 79, 90)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        const Text("Department :"),
                        Text(
                          user.Department,
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 17, 79, 90)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    const Divider(
                      color: Color.fromARGB(255, 193, 192, 192),
                    ),
                    Text(
                      'Parent Details:',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        const Text("Name :"),
                        Text(
                          user.FatherName,
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 17, 79, 90)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        const Text("Email :"),
                        Text(
                          user.FatherEmail,
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 17, 79, 90)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        const Text("Phno :"),
                        Text(
                          user.FatherPhnNo.toString(),
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 17, 79, 90)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
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
                  Row(
                    children: [
                      const Text(
                        "Fee Status : ",
                        style: TextStyle(
                            fontSize: 20, color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      user.FeeStatus == 0
                          ? const Text(
                              "Not Paid ",
                              style: TextStyle(
                                fontSize: 25,
                                color: Color.fromARGB(255, 196, 148, 80),
                              ),
                            )
                          : const Text(
                              "Paid ",
                              style: TextStyle(
                                fontSize: 25,
                                color: Color.fromARGB(255, 196, 148, 80),
                              ),
                            ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'View more details',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: Color.fromARGB(255, 0, 229, 255),
                            decorationThickness: 2,
                            decorationStyle: TextDecorationStyle.solid,
                            color: Color.fromARGB(255, 0, 229, 255),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 17, 79, 90),
                          shadowColor: Colors.grey,
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Pay Fee",
                          style: TextStyle(color: Colors.white),
                        ),
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

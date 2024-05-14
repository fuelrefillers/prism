import 'package:flutter/material.dart';

class Community extends StatelessWidget {
  const Community({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Campus Community'),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 2, color: Colors.grey)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            image: DecorationImage(
                              image: AssetImage('assets/MREC_logo.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              'Vivek',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 17, 79, 90),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'CSE',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 251, 171, 98),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Image.asset(
                    'assets/appbar.png',
                    width: double.infinity,
                    fit: BoxFit.fitHeight,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      'Welcome to the Campus Community!\nDate:02-05-2024',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 2, color: Colors.grey)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            image: DecorationImage(
                              image: AssetImage('assets/MREC_logo.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              'Vivek',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 17, 79, 90),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'CSE',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 251, 171, 98),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Image.asset(
                    'assets/appbar.png',
                    width: double.infinity,
                    fit: BoxFit.fitHeight,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      'Welcome to the Campus Community!\nDate:02-05-2024',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 2, color: Colors.grey)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            image: DecorationImage(
                              image: AssetImage('assets/MREC_logo.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              'Vivek',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 17, 79, 90),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'CSE',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 251, 171, 98),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Image.asset(
                    'assets/appbar.png',
                    width: double.infinity,
                    fit: BoxFit.fitHeight,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      'Welcome to the Campus Community!\nDate:02-05-2024',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

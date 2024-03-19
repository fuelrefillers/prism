import 'package:flutter/material.dart';
import 'package:frontend/providers.dart/user_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 19, 79, 90),
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        title: Center(
            widthFactor: MediaQuery.of(context).size.width / 95,
            child: Text('Profile', style: TextStyle(color: Colors.white))),
        backgroundColor: Color.fromARGB(255, 19, 79, 90),
        elevation: 0,
      ),
      body: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50), topRight: Radius.circular(50)),
        child: Container(
          color: Colors.white,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2.5,
                    height: MediaQuery.of(context).size.height / 4.5,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: DecorationImage(
                        image: NetworkImage(user.ImageUrl),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Text(
                          user.StudentName.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 20.0,
                            letterSpacing: 0.5,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          user.StudentEmail,
                          style: const TextStyle(
                            fontSize: 15.0,
                            letterSpacing: 0.5,
                            color: Color.fromARGB(255, 17, 79, 90),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
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
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Student Details:',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 17,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              const Text(
                                "Name :",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                user.StudentName,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 17, 79, 90),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              const Text(
                                "Email :",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
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
                              const Text(
                                "Mobile :",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
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
                              const Text(
                                "Department :",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
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
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              const Text(
                                "Name :",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
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
                              const Text(
                                "Email :",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
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
                              const Text(
                                "Phno :",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
  // Widget build(BuildContext context) {
     

  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text("Profile Screen"),
  //       backgroundColor: Color.fromARGB(255, 0, 0, 0),
  //     ),
  //     body: ClipRRect(
  //       borderRadius: BorderRadius.only(
  //           topLeft: Radius.circular(50), topRight: Radius.circular(50)),
  //       child: Container(
  //         color: const Color.fromARGB(255, 0, 0, 0),
  //         child: Center(
  //           child: Text(
  //             'App Content',
  //             // style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.black),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
//}
//       body: Stack(
//         alignment: Alignment.center,
//         children: [
//           CustomPaint(
//             painter: HeaderCurvedContainer(),
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height,
//             ),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
              // Padding(
              //   padding: const EdgeInsets.all(20.0),
              //   child: Text(
              //     user.RollNo.toUpperCase(),
              //     style: const TextStyle(
              //       fontSize: 35.0,
              //       letterSpacing: 1.5,
              //       color: Colors.white,
              //       fontWeight: FontWeight.w600,
              //     ),
              //   ),
              // ),
              // Container(
              //   width: MediaQuery.of(context).size.width / 2,
              //   height: MediaQuery.of(context).size.width / 2,
              //   padding: EdgeInsets.all(10.0),
              //   decoration: BoxDecoration(
              //     boxShadow: [
              //       BoxShadow(
              //         color: Color.fromARGB(210, 135, 135, 135),
              //         blurRadius: 10,
              //         spreadRadius: 2,
              //         offset: Offset(
              //           0,
              //           10,
              //         ),
              //       ),
              //     ],
              //     shape: BoxShape.circle,
              //     color: Colors.white,
              //     image: DecorationImage(
              //       image: NetworkImage(user.ImageUrl),
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              // ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: SizedBox(
//                   width: MediaQuery.of(context).size.width,
//                   child: Container(
//                     decoration: const BoxDecoration(
//                       boxShadow: [
//                         BoxShadow(
//                           color: Color.fromARGB(119, 135, 135, 135),
//                           blurRadius: 10,
//                           spreadRadius: 2,
//                           offset: Offset(
//                             0,
//                             10,
//                           ),
//                         ),
//                       ],
//                     ),
//                     child: Card(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         //set border radius more than 50% of height and width to make circle
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(10),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text("Name :"),
//                             Text(user.StudentName),
//                             const Divider(
//                               color: Colors.black,
//                             ),
//                             const Text("Email :"),
//                             Text(user.StudentEmail),
//                             const Divider(
//                               color: Colors.black,
//                             ),
//                             const Text("Mobile :"),
//                             Text(user.StudentPhnNo.toString()),
//                             const Divider(
//                               color: Colors.black,
//                             ),
//                             const Text("Department :"),
//                             Text(user.Department),
//                             const Divider(
//                               color: Colors.black,
//                             ),
//                             const Text("Parent details :"),
//                             Text(user.FatherName),
//                             Text(user.FatherPhnNo.toString()),
//                             Text(user.FatherEmail),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// // CustomPainter class to for the header curved-container
// class HeaderCurvedContainer extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()..color = Color.fromARGB(255, 181, 201, 154);
//     Path path = Path()
//       ..relativeLineTo(0, 150)
//       ..quadraticBezierTo(size.width / 2, 250.0, size.width, 150)
//       ..relativeLineTo(0, -150)
//       ..close();
//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }

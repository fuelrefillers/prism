// import 'package:flutter/material.dart';
// import 'package:flutter_flip_card/flutter_flip_card.dart';
// import 'package:frontend/providers/library_provider.dart';
// import 'package:frontend/providers/user_provider.dart';
// import 'package:frontend/screens/libraryScreens/library_books_taken_screen.dart';
// import 'package:frontend/services/Students_Parents_services.dart';
// import 'package:frontend/widgets/multi_purpose_card.dart';
// import 'package:provider/provider.dart';

// class LibraryScreen extends StatefulWidget {
//   const LibraryScreen({Key? key}) : super(key: key);

//   @override
//   _LibraryScreenState createState() => _LibraryScreenState();
// }

// class _LibraryScreenState extends State<LibraryScreen> {
//   final con = FlipCardController();
//   final StudentParentServices service = StudentParentServices();

//   @override
//   void initState() {
//     super.initState();
//     service.getLibrary(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final library = Provider.of<LibraryProvider>(context).library;
//     final user = Provider.of<UserProvider>(context).user;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         shadowColor: Colors.grey,
//         elevation: 1.0,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text("Library"),
//             Image.asset(
//               'assets/MREC_logo.png',
//               height: MediaQuery.of(context).size.height / 8,
//               width: MediaQuery.of(context).size.width / 8,
//             ),
//           ],
//         ),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Stack(
//             children: [
//               Column(
//                 children: [
//                   Container(
//                     width: MediaQuery.of(context).size.width,
//                     height: MediaQuery.of(context).size.height / 5.5,
//                     padding: const EdgeInsets.all(10.0),
//                     decoration: const BoxDecoration(
//                       boxShadow: [
//                         BoxShadow(
//                           color: Color.fromARGB(238, 135, 135, 135),
//                           blurRadius: 10,
//                           spreadRadius: 2,
//                           offset: Offset(
//                             0,
//                             10,
//                           ),
//                         ),
//                       ],
//                       color: Color.fromARGB(51, 0, 0, 0),
//                       image: DecorationImage(
//                         image: AssetImage('assets/library-hero.jpg'),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: MediaQuery.of(context).size.width,
//                     height: MediaQuery.of(context).size.height / 5,
//                     padding: const EdgeInsets.all(10.0),
//                     decoration: const BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(20),
//                           bottomRight: Radius.circular(20)),
//                       color: const Color.fromARGB(255, 17, 79, 90),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Text(
//                           user.StudentName,
//                           style: TextStyle(color: Colors.white, fontSize: 25),
//                         ),
//                         Text(
//                           library.RollNo.toUpperCase(),
//                           style: TextStyle(color: Colors.white, fontSize: 20),
//                         ),
//                         SizedBox(
//                           height: 8,
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               Positioned(
//                 left: MediaQuery.of(context).size.width / 2 - 50,
//                 top: MediaQuery.of(context).size.height / 5 - 85,
//                 child: Container(
//                   clipBehavior: Clip.hardEdge,
//                   height: MediaQuery.of(context).size.height / 6,
//                   width: MediaQuery.of(context).size.width / 4,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: Colors.white,
//                   ),
//                   child: Image(
//                     image: NetworkImage(user.ImageUrl),
//                     fit: BoxFit.fitHeight,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 40,
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: ListView(
//                 clipBehavior: Clip.hardEdge,
//                 children: [
//                   FlipCard(
//                     animationDuration: Duration(milliseconds: 500),
//                     rotateSide: RotateSide.left,
//                     onTapFlipping: true,
//                     axis: FlipAxis.vertical,
//                     controller: con,
//                     frontWidget: Container(
//                         clipBehavior: Clip.hardEdge,
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(15),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.withOpacity(0.5),
//                                 spreadRadius: 3,
//                                 blurRadius: 10,
//                                 offset: Offset(0, 3),
//                               ),
//                             ]),
//                         width: MediaQuery.of(context).size.width / 2,
//                         height: MediaQuery.of(context).size.height / 4.5,
//                         child: Padding(
//                           padding: EdgeInsets.all(15.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 "MALLA REDDY ENGINEERING COLLEGE",
//                                 style: TextStyle(
//                                     color:
//                                         const Color.fromARGB(255, 25, 86, 136),
//                                     fontSize: 17.8,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                               Text(
//                                 "BORROWERS'S LIBRARY CARD",
//                                 style: TextStyle(
//                                     fontSize: 13, fontWeight: FontWeight.w300),
//                               ),
//                               Text(
//                                 user.StudentName.toUpperCase(),
//                                 style: TextStyle(
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w600,
//                                     color:
//                                         const Color.fromARGB(255, 25, 86, 136)),
//                               ),
//                               Text(
//                                 user.RollNo.toUpperCase(),
//                                 style: TextStyle(
//                                   fontSize: 13,
//                                   fontWeight: FontWeight.w300,
//                                   color: const Color.fromARGB(255, 25, 86, 136),
//                                 ),
//                               ),
//                               Text(
//                                 "valid till 2025",
//                                 style: TextStyle(
//                                   color:
//                                       const Color.fromARGB(255, 243, 180, 33),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )),
//                     backWidget: Container(
//                         width: MediaQuery.of(context).size.width / 2,
//                         height: MediaQuery.of(context).size.height / 4.5,
//                         clipBehavior: Clip.hardEdge,
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(15),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.withOpacity(0.5),
//                                 spreadRadius: 3,
//                                 blurRadius: 10,
//                                 offset: Offset(0, 3),
//                               ),
//                             ]),
//                         child: Padding(
//                           padding: const EdgeInsets.all(15.0),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(
//                                 clipBehavior: Clip.hardEdge,
//                                 decoration: BoxDecoration(),
//                                 height:
//                                     MediaQuery.of(context).size.height / 12.5,
//                                 width: MediaQuery.of(context).size.width / 2,
//                                 child: Image.network(
//                                   'https://barcode.tec-it.com/barcode.ashx?data=${user.RollNo.toUpperCase()}&code=Code128&translate-esc=on',
//                                   fit: BoxFit.fill,
//                                 ),
//                               ),
//                               Text(
//                                 "books count : ${library.booksTaken.length} of 6 ",
//                                 style: TextStyle(
//                                     color: Color.fromARGB(255, 0, 0, 0),
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                             ],
//                           ),
//                         )),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: MultiPurposeCard(
//               category: "Books history",
//               height1: 60,
//               screen: LibraryBooksTakenScreen(
//                 datelist: library.dateTaken,
//               ),
//               subcategory: '',
//               subcategory1: '',
//             ),
//           ),
//           SizedBox(
//             height: 60,
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:frontend/providers/library_provider.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:frontend/screens/libraryScreens/library_books_taken_screen.dart';
import 'package:frontend/services/Students_Parents_services.dart';
import 'package:frontend/widgets/multi_purpose_card.dart';
import 'package:provider/provider.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final con = FlipCardController();
  final StudentParentServices service = StudentParentServices();

  @override
  void initState() {
    super.initState();
    service.getLibrary(context);
  }

  @override
  Widget build(BuildContext context) {
    final library = Provider.of<LibraryProvider>(context).library;
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.grey,
        elevation: 1.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Library"),
            Image.asset(
              'assets/MREC_logo.png',
              height: MediaQuery.of(context).size.height / 8,
              width: MediaQuery.of(context).size.width / 8,
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        image: AssetImage('assets/library-hero.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 4.8,
                    padding: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      color: const Color.fromARGB(255, 17, 79, 90),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          textAlign: TextAlign.center,
                          user.StudentName,
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        Text(
                          user.RollNo.toUpperCase(),
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
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
                  height: MediaQuery.of(context).size.height / 6,
                  width: MediaQuery.of(context).size.width / 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Image(
                    image: NetworkImage(user.ImageUrl),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
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
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.height / 4.5,
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "MALLA REDDY ENGINEERING COLLEGE",
                                style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 25, 86, 136),
                                    fontSize: 17.8,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "BORROWERS'S LIBRARY CARD",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w300),
                              ),
                              Text(
                                user.StudentName.toUpperCase(),
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        const Color.fromARGB(255, 25, 86, 136)),
                              ),
                              Text(
                                user.RollNo.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300,
                                  color: const Color.fromARGB(255, 25, 86, 136),
                                ),
                              ),
                              Text(
                                "valid till 2025",
                                style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 243, 180, 33),
                                ),
                              ),
                            ],
                          ),
                        )),
                    backWidget: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.height / 4.5,
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
                                height:
                                    MediaQuery.of(context).size.height / 12.5,
                                width: MediaQuery.of(context).size.width / 2,
                                child: Image.network(
                                  'https://barcode.tec-it.com/barcode.ashx?data=${library.RollNo}&code=Code128&translate-esc=on',
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Text(
                                "books count : ${library.booksTaken.length} of 6 ",
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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: MultiPurposeCard(
              category: "Books history",
              height1: 60,
              screen: LibraryBooksTakenScreen(
                datelist: library.dateTaken,
              ),
              subcategory: '',
              subcategory1: '',
            ),
          ),
          SizedBox(
            height: 60,
          ),
        ],
      ),
    );
  }
}

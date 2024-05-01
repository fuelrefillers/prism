// import 'package:flutter/material.dart';
// import 'package:frontend/Faculty_Module/main_screen.dart';
// import 'package:frontend/models/faculty_model.dart';
// import 'package:frontend/providers/faculty_provider.dart';
// import 'package:frontend/screens/home_screen.dart';
// import 'package:frontend/widgets/multi_purpose_card.dart';
// import 'package:provider/provider.dart';

// class IndividualStudentSubjectAttendaceScreen extends StatefulWidget {
//   const IndividualStudentSubjectAttendaceScreen({super.key});

//   @override
//   State<IndividualStudentSubjectAttendaceScreen> createState() =>
//       _IndividualStudentSubjectAttendaceScreenState();
// }

// class _IndividualStudentSubjectAttendaceScreenState
//     extends State<IndividualStudentSubjectAttendaceScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final faculty =
//         Provider.of<FacultyProvider>(context, listen: false).faculty;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Individual"),
//       ),
//       body: Column(
//         children: [
//           ListView.builder(
//               itemCount: faculty.Classes.length,
//               itemBuilder: (context, index) => MultiPurposeCard(
//                   category:
//                       "${faculty.Classes[index].Department}-${faculty.Classes[index].Section} ",
//                   subcategory: "${faculty.Classes[index].Subject}",
//                   subcategory1: "",
//                   height1: 100,
//                   screen: HomeScreen(whoissignedin: "facjj")))
//         ],
//       ),
//     );
//   }
// }

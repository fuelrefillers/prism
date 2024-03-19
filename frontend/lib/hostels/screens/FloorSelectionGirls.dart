import 'package:flutter/material.dart';
import 'package:frontend/hostels/models/GirlsFloors.dart';
import 'package:frontend/hostels/screens/RoomSelection_girls.dart';
import 'package:frontend/hostels/services/fetching.dart';

class FloorSeclection_girls extends StatefulWidget {
  @override
  State<FloorSeclection_girls> createState() => _FloorSeclection_girlsState();
}

class _FloorSeclection_girlsState extends State<FloorSeclection_girls> {
  final Fetching dd = Fetching();
  List<GirlsFloors> data = [];
  @override
  void initState() {
    super.initState();
    // assignData();
  }

  void assignData() async {
    List<GirlsFloors> dummy = await dd.fetchGirlsFloorsFromApi();
    setState(() {
      data = dummy;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final girls =
    //     Provider.of<GirlsFloorsProvider>(context, listen: false).girlsFloors;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Floor Selection'),
      ),
      body:

          // data.isEmpty
          //     ? Center(
          //         child: CircularProgressIndicator.adaptive(),
          //       )
          //     :
          SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildContainer(context, floorNumber: 1, bedNumber: 30),
            const SizedBox(height: 16.0),
            buildContainer(context, floorNumber: 2, bedNumber: 29),
            const SizedBox(height: 16.0),
            buildContainer(context, floorNumber: 3, bedNumber: 35),
            const SizedBox(height: 16.0),
            buildContainer(context, floorNumber: 4, bedNumber: 20),
            const SizedBox(height: 16.0),
            buildContainer(context, floorNumber: 5, bedNumber: 30),
          ],
        ),
      ),
    );
  }

  Widget buildContainer(BuildContext context,
      {required int floorNumber, required int bedNumber}) {
    double progressPercentage = bedNumber / 50.0;
    Color progressBarColor = calculateProgressBarColor(progressPercentage);

    return GestureDetector(
      onTap: () {
        _onContainerTap(context, floorNumber);
      },
      child: Container(
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.king_bed, size: 30.0),
                    const SizedBox(width: 12.0),
                    Text(
                      bedNumber.toString(),
                      style: const TextStyle(fontSize: 24.0),
                    ),
                  ],
                ),
                Text(
                  'Floor $floorNumber',
                  style: const TextStyle(fontSize: 24.0),
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            LinearProgressIndicator(
              value: progressPercentage,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(progressBarColor),
              minHeight: 20.0,
            ),
          ],
        ),
      ),
    );
  }

  Color calculateProgressBarColor(double progressPercentage) {
    if (progressPercentage < 0.5) {
      return Colors.red;
    } else if (progressPercentage < 0.8) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  void _onContainerTap(BuildContext context, int floor) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RoomSelection_girls(floor: floor),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:host/providers/GirlsFloorsProvider.dart';
// //import 'package:host/providers/GirlsFloorsProvider.dart';
// import 'package:host/screens/RoomSelection_girls.dart';
// import 'package:provider/provider.dart';
// //import 'package:provider/provider.dart';

// // ignore: camel_case_types
// class FloorSeclection_girls extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final girlsFloorsProvider = Provider.of<GirlsFloorsProvider>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Floor Selection'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             buildContainer(context,
//                 floorNumber: 0,
//                 bedNumber: girlsFloorsProvider.girlsFloors.availableBeds),
//             const SizedBox(height: 16.0),
//             buildContainer(context,
//                 floorNumber: 1,
//                 bedNumber: girlsFloorsProvider.girlsFloors.availableBeds),
//             const SizedBox(height: 16.0),
//             buildContainer(context,
//                 floorNumber: 1,
//                 bedNumber: girlsFloorsProvider.girlsFloors.availableBeds),
//             const SizedBox(height: 16.0),
//             buildContainer(context,
//                 floorNumber: 3,
//                 bedNumber: girlsFloorsProvider.girlsFloors.availableBeds),
//             const SizedBox(height: 16.0),
//             buildContainer(context,
//                 floorNumber: 4,
//                 bedNumber: girlsFloorsProvider.girlsFloors.availableBeds),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildContainer(BuildContext context,
//       {required int floorNumber, required int bedNumber}) {
//     double progressPercentage = bedNumber / 50.0;
//     Color progressBarColor = calculateProgressBarColor(progressPercentage);

//     return GestureDetector(
//       onTap: () {
//         _onContainerTap(context, floorNumber);
//       },
//       child: Container(
//         margin: const EdgeInsets.all(16.0),
//         padding: const EdgeInsets.all(16.0),
//         decoration: BoxDecoration(
//           color: Colors.grey[200],
//           borderRadius: BorderRadius.circular(10.0),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.5),
//               spreadRadius: 3,
//               blurRadius: 5,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     const Icon(Icons.king_bed, size: 30.0),
//                     const SizedBox(width: 12.0),
//                     Text(
//                       bedNumber.toString(),
//                       style: const TextStyle(fontSize: 24.0),
//                     ),
//                   ],
//                 ),
//                 Text(
//                   'Floor $floorNumber',
//                   style: const TextStyle(fontSize: 24.0),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 24.0),
//             LinearProgressIndicator(
//               value: progressPercentage,
//               backgroundColor: Colors.grey[300],
//               valueColor: AlwaysStoppedAnimation<Color>(progressBarColor),
//               minHeight: 20.0,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Color calculateProgressBarColor(double progressPercentage) {
//     if (progressPercentage < 0.5) {
//       return Colors.red;
//     } else if (progressPercentage < 0.8) {
//       return Colors.orange;
//     } else {
//       return Colors.green;
//     }
//   }

//   void _onContainerTap(BuildContext context, int floor) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => RoomSelection_girls(floor: floor),
//       ),
//     );
//   }
// }

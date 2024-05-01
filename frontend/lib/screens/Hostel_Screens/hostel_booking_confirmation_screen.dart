import 'package:flutter/material.dart';
import 'package:frontend/models/hostel_models.dart';
import 'package:frontend/screens/Hostel_Screens/widgets/HomeButton.dart';
import 'package:frontend/screens/home_screen.dart';

class HostelBookingConfirmationScreen extends StatefulWidget {
  final UserAlreadyExistsModel bookingDetails;
  final String inside;
  const HostelBookingConfirmationScreen(
      {super.key, required this.bookingDetails, required this.inside});

  @override
  State<HostelBookingConfirmationScreen> createState() =>
      _HostelBookingConfirmationScreenState();
}

Color themeColor = const Color(0xFF43D19E);

class _HostelBookingConfirmationScreenState
    extends State<HostelBookingConfirmationScreen> {
  double screenWidth = 600;
  double screenHeight = 400;
  Color textColor = const Color(0xFF32567A);
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: screenHeight * 0.05),
            Container(
              height: 170,
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: themeColor,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                "assets/online-booking.png",
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            widget.inside == "Bed booked Successfully"
                ? Text(
                    "Thank You!",
                    style: TextStyle(
                      color: themeColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 36,
                    ),
                  )
                : Text(
                    "You've Already Booked ",
                    style: TextStyle(
                      color: themeColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 36,
                    ),
                  ),
            SizedBox(height: screenHeight * 0.01),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Text(
                textAlign: TextAlign.center,
                widget.inside,
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
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
                        'Booking Details:',
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
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            widget.bookingDetails.name,
                            style: TextStyle(
                              fontSize: 21,
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
                            "Admin Id :",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            widget.bookingDetails.adminId,
                            style: TextStyle(
                                fontSize: 21,
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
                            "Hostel :",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            widget.bookingDetails.roomDetails.type,
                            style: TextStyle(
                                fontSize: 21,
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
                            "Floor :",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            widget.bookingDetails.roomDetails.floorNumber
                                .toString(),
                            style: TextStyle(
                                fontSize: 21,
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
                            "Room No :",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            widget.bookingDetails.roomDetails.roomNumber
                                .toString(),
                            style: TextStyle(
                                fontSize: 21,
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
                            "Bed No :",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            widget.bookingDetails.roomDetails.bedNumber
                                .toString(),
                            style: TextStyle(
                                fontSize: 21,
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
            ),
            Text(
              "Take a scrrenshot as a reference \n click here to return to home page",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            SizedBox(height: screenHeight * 0.06),
            Flexible(
              child: widget.inside == "Bed booked Successfully"
                  ? HomeButton(
                      title: 'Home',
                      onTap: HomeScreen(whoissignedin: 'student'),
                    )
                  : HomeButton(
                      title: 'Change',
                      onTap: HomeScreen(whoissignedin: 'student'),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

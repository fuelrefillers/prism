import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final IconData icon;
  final Widget onPressed;

  const CustomButton({
    Key? key,
    required this.buttonText,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => onPressed,
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        padding: EdgeInsets.all(
          10.0,
        ),
        elevation: 3,
        shadowColor: Colors.grey.withOpacity(0.3),
        // Increase padding for button size
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 9,
              width: MediaQuery.of(context).size.width / 9,
              padding: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Color(0xFF114F5A),
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: Color.fromARGB(255, 255, 255, 255),
                  size: 20,
                ),
              ),
            ),
            SizedBox(width: 5.0),
            SizedBox(
              width: MediaQuery.of(context).size.width / 4.45,
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

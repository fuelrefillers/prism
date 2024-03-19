import 'package:flutter/material.dart';
import 'package:frontend/screens/singleScreens/individeual_hostel_screens.dart';

class HostelsCard extends StatelessWidget {
  const HostelsCard({super.key});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HostelsInfo(),
          ),
        );
      },
      child: Container(
          height: MediaQuery.of(context).size.height / 3.3,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromARGB(255, 180, 180, 180),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 5,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: AssetImage('assets/hostels-hero.jpg'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                          "hbjfhvsbewnjqrhizvbjnhriavbgjnq3hirehavbytfcvbjhuiytrdtfcgvhuiytrdt"),
                    ),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          )),
    );
  }
}

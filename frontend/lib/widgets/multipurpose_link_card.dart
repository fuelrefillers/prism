import 'package:flutter/material.dart';

class MultiPurposeLinkCard extends StatelessWidget {
  const MultiPurposeLinkCard({
    super.key,
    required this.category,
    required this.height1,
  });
  final String category;
  final double height1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        clipBehavior: Clip.hardEdge,
        height: height1,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(),
        child: InkWell(
          splashColor: Colors.white,
          onTap: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => screen,
            //   ),
            // );
          },
          child: Card(
            child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      category.toString(),
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

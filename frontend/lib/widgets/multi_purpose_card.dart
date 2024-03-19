import 'package:flutter/material.dart';

class MultiPurposeCard extends StatelessWidget {
  const MultiPurposeCard(
      {super.key,
      required this.category,
      required this.subcategory,
      required this.subcategory1,
      required this.height1,
      required this.screen});
  final String category;
  final String subcategory;
  final String subcategory1;
  final double height1;
  final Widget screen;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          clipBehavior: Clip.hardEdge,
          height: height1,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(),
          child: InkWell(
            splashColor: Colors.white,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => screen,
                ),
              );
            },
            child: Card(
              shadowColor: Colors.grey,
              elevation: 1.0,
              color: Colors.white,
              child: Padding(
                  padding: EdgeInsets.all(8),
                  child: subcategory == "" && subcategory1 == ""
                      ? Row(
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
                        )
                      : subcategory1 == ""
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      category.toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          subcategory.toString(),
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Color.fromARGB(
                                                255, 196, 148, 80),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Icon(Icons.arrow_forward_ios),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  category.toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color:
                                        const Color.fromARGB(255, 17, 79, 90),
                                  ),
                                ),
                                Icon(Icons.arrow_forward_ios),
                              ],
                            )),
            ),
          ),
        ));
  }
}

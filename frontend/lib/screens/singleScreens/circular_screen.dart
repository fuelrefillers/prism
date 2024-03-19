import 'package:flutter/material.dart';
import 'package:frontend/models/circularModel.dart';
import 'package:frontend/services/Students_Parents_services.dart';
import 'package:frontend/widgets/open_circular_pdf.dart';

class Circulars extends StatefulWidget {
  const Circulars(
      {super.key, required this.department, required this.regulation});
  final String department;
  final String regulation;
  @override
  State<Circulars> createState() => _CircularsState();
}

class _CircularsState extends State<Circulars> {
  List<CircularsModel> circular = [];
  final StudentParentServices service = StudentParentServices();
  bool isError = false;

  @override
  void initState() {
    super.initState();
    getCirculars();
  }

  void getCirculars() async {
    print(widget.regulation);
    List<CircularsModel> cir = await service.getCirculars(
        regulation: widget.regulation, department: widget.department);
    await Future.delayed(Duration(seconds: 1));
    print(cir);
    setState(() {
      circular = cir;
    });
    await Future.delayed(Duration(seconds: 5));
    if (cir.isEmpty) {
      setState(() {
        isError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Circular"),
      ),
      body: circular.isEmpty && isError == false
          ? Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : isError
              ? Center(
                  child: Text(
                      "Something went wrong or resultrs aren't updated yet !!!"),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      itemCount: circular.length,
                      itemBuilder: (context, index) => OpenCircular(
                            height1: 100,
                            circular: circular[index],
                            context: context,
                          ))),
    );
  }
}

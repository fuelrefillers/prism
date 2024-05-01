import 'package:flutter/material.dart';
import 'package:frontend/models/hostel_models.dart';

class Details extends StatefulWidget {
  final List<HostelBedsModel> beds;
  const Details({super.key, required this.beds});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Info"),
      ),
      body: ListView.builder(
        itemCount: widget.beds.length,
        itemBuilder: (context, index) => ListTile(
          leading: Icon(
            Icons.bed,
            size: 40,
            color: widget.beds[index].isBooked
                ? Color.fromARGB(255, 240, 86, 86) // White background if booked
                : Color.fromARGB(
                    255, 141, 224, 108), // Icon color based on selection
          ),
          title: Text(
            widget.beds[index].bookedById,
            style: TextStyle(fontSize: 20),
          ),
          subtitle: Text(
            widget.beds[index].bookedBy,
            style: TextStyle(fontSize: 20),
          ),
          trailing: Text(
            "Bed no : ${widget.beds[index].bedNumber.toString()}",
            style: TextStyle(fontSize: 15),
          ), // Adjust as per your model
        ),
      ),
    );
  }
}

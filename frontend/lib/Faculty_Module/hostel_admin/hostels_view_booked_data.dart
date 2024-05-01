import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/models/hostel_models.dart';
import 'package:frontend/services/ip.dart';
import 'package:http/http.dart' as http;

class HostelsViewBookedDataScreen extends StatefulWidget {
  const HostelsViewBookedDataScreen({Key? key}) : super(key: key);

  @override
  State<HostelsViewBookedDataScreen> createState() =>
      _HostelsViewBookedDataScreenState();
}

class _HostelsViewBookedDataScreenState
    extends State<HostelsViewBookedDataScreen> {
  List<UserAlreadyExistsModel> data = [];
  bool isError = false;
  bool isFetched = false;

  @override
  void initState() {
    super.initState();
    getBookedDetails();
  }

  void getBookedDetails() async {
    List<UserAlreadyExistsModel> temp = [];
    try {
      var response =
          await http.get(Uri.parse("${ip}/api/hostels/getBookedData"));

      if (response.statusCode == 200) {
        List result = jsonDecode(response.body);
        for (int i = 0; i < result.length; i++) {
          UserAlreadyExistsModel post =
              UserAlreadyExistsModel.fromMap(result[i] as Map<String, dynamic>);
          temp.add(post);
        }
        setState(() {
          isFetched = true;
          data = temp;
        });
      } else {
        setState(() {
          isError = true;
        });
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setState(() {
        isError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booked Information"),
      ),
      body: isError
          ? Center(
              child: Text("Something went wrong!"),
            )
          : isFetched
              ? data.isEmpty
                  ? Center(
                      child: Text("There is nothing here"),
                    )
                  : ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) => ListTile(
                        leading: Text(
                          data[index].roomDetails.type,
                          style: TextStyle(fontSize: 20),
                        ),
                        title: Text(
                          data[index].adminId,
                          style: TextStyle(fontSize: 20),
                        ),
                        subtitle: Text(
                          data[index].name,
                          style: TextStyle(fontSize: 20),
                        ),
                        trailing: Text(
                          "Room no - ${data[index].roomDetails.roomNumber} \n Bed no - ${data[index].roomDetails.bedNumber}",
                          style: TextStyle(fontSize: 15),
                        ), // Adjust as per your model
                      ),
                    )
              : Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
    );
  }
}

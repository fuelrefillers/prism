import 'package:flutter/material.dart';
import 'package:frontend/models/bus_model.dart';
import 'package:frontend/services/Students_Parents_services.dart';
import 'package:frontend/widgets/bus_card.dart';

// model compleated

class Transportscreen extends StatefulWidget {
  @override
  State<Transportscreen> createState() {
    return _TransportscreenState();
  }
}

class _TransportscreenState extends State<Transportscreen> {
  String searchValue = '';
  final StudentParentServices service = StudentParentServices();
  List<Bus> busses = [];
  List<Bus> filteredList = [];

  // List<String> _suggestions = [];

  bool isError = false;
  @override
  void initState() {
    super.initState();
    set();
  }

  void set() async {
    List<Bus> b = await service.getBusses();
    // await Future.delayed(Duration(seconds: 1));
    setState(() {
      busses = b;
      filteredList = b;
      // _suggestions = busses.map((bus) => bus.Routename).toList();
    });
    await Future.delayed(Duration(seconds: 2));
    if (b.isEmpty) {
      setState(() {
        isError = true;
      });
    }

    print(b);
  }

  void search(String searchkey) {
    List<Bus> result = [];
    if (searchkey.isEmpty) {
      result = busses;
    } else {
      result = busses
          .where((bus) =>
              bus.Routename.toLowerCase().contains(searchkey.toLowerCase()) ||
              bus.Busno.toLowerCase().contains(searchkey.toLowerCase()) ||
              bus.Routeno.toLowerCase().contains(searchkey.toLowerCase()))
          .toList();
    }
    setState(() {
      filteredList = result;
    });
  }

  // Future<List<String>> _fetchSuggestions(String searchValue) async {
  //   await Future.delayed(const Duration(milliseconds: 750));

  //   return _suggestions.where((element) {
  //     return element.toLowerCase().contains(searchValue.toLowerCase());
  //   }).toList();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        shadowColor: Colors.grey,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Transport"),
            Image.asset(
              'assets/MREC_logo.png',
              height: MediaQuery.of(context).size.height / 8,
              width: MediaQuery.of(context).size.width / 8,
            ),
          ],
        ),
      ),
      body: busses.isEmpty && isError == false
          ? Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : isError
              ? Center(
                  child: Text(
                      "Something went wrong or resultrs aren't updated yet !!!"),
                )
              : Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      TextField(
                        onChanged: (value) {
                          search(value);
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 245, 245, 241),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.black45),
                          ),
                          hintText: "Search for Items",
                          prefixIcon: const Icon(Icons.search),
                          prefixIconColor: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(15.0),

                      // ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: filteredList.length,
                          itemBuilder: (context, index) => BusCard(
                            bus: filteredList[index],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}

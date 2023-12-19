import 'package:easy_search_bar/easy_search_bar.dart';
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
  List<String> _suggestions = [];
  bool isError = false;
  @override
  void initState() {
    super.initState();
    set();
  }

  void set() async {
    List<Bus> b = await service.getBusses();
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      busses = b;
      _suggestions = busses.map((bus) => bus.Routename).toList();
    });
    await Future.delayed(Duration(seconds: 5));
    if (b.isEmpty) {
      setState(() {
        isError = true;
      });
    }
  }

  // void search(String searchkey) {
  //   List<Bus> result = [];

  //   if (searchkey.isEmpty) {
  //     result = Busses;
  //   } else {
  //     result = Busses.where((bus) =>
  //             bus.Routename.toLowerCase().contains(searchkey.toLowerCase()))
  //         .toList();
  //     print(result.toList());
  //     print(filteredList);
  //   }
  //   setState(() {
  //     filteredList = result;
  //   });
  //   print(filteredList);
  // }

  Future<List<String>> _fetchSuggestions(String searchValue) async {
    await Future.delayed(const Duration(milliseconds: 750));

    return _suggestions.where((element) {
      return element.toLowerCase().contains(searchValue.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EasySearchBar(
        backgroundColor: Colors.white,
        title: Text("Transport"),
        onSearch: (value) => setState(() => searchValue = value),
        asyncSuggestions: (value) async => await _fetchSuggestions(value),
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
                      // Padding(
                      //   padding: const EdgeInsets.all(15.0),

                      // ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: busses.length,
                          itemBuilder: (context, index) => BusCard(
                            bus: busses[index],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}

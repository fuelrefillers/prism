import 'package:flutter/material.dart';
import 'package:frontend/widgets/bus_card.dart';

class Transportscreen extends StatefulWidget {
  @override
  State<Transportscreen> createState() {
    return _TransportscreenState();
  }
}

class _TransportscreenState extends State<Transportscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transport"),
      ),
      body: Column(
        children: [
          TextField(
            //onChanged: (value) => search(value),
            decoration: InputDecoration(
              hintText: 'Search...',
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {},
              ),
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: const BusCard(),
          ),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: filteredList.length,
          //     itemBuilder: (context, index) =>
          //         BookItem(book: filteredList[index]),
          //   ),
          // ),
        ],
      ),
    );
  }
}

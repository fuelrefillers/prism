import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/models/books_model.dart';
import 'package:frontend/models/bus_model.dart';
import 'package:frontend/services/auth.dart';
import 'package:frontend/services/prismBloc/prism_bloc.dart';
import 'package:frontend/widgets/bus_card.dart';

// model compleated

class Transportscreen extends StatefulWidget {
  @override
  State<Transportscreen> createState() {
    return _TransportscreenState();
  }
}

class _TransportscreenState extends State<Transportscreen> {
  final PrismBloc prismBloc = PrismBloc();

  @override
  void initState() {
    super.initState();

    prismBloc.add(BussesInitialFetchEvent());
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Transport"),
        ),
        body: BlocConsumer<PrismBloc, PrismState>(
          bloc: prismBloc,
          listener: (context, state) {},
          builder: (context, state) {
            switch (state.runtimeType) {
              case BusFetchingLoadingState:
                return Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              case BusFetchingSuccessfullState:
                final successState = state as BusFetchingSuccessfullState;
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      TextField(
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
                      // Padding(
                      //   padding: const EdgeInsets.all(15.0),

                      // ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: successState.busses.length,
                          itemBuilder: (context, index) => BusCard(
                            bus: successState.busses[index],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              default:
                return SizedBox();
            }
          },
        ));
  }
}

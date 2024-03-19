import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final Function(String) onSearch;

  const SearchBar({super.key, required this.onSearch});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final List<String> _results = [];

  get myCoolStrings => null; // Empty at start

  void _handleSearch(String input) {
    _results.clear();
    for (var str in myCoolStrings) {
      if (str.toLowerCase().contains(input.toLowerCase())) {
        setState(() {
          _results.add(str);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: 360,
      child: TextField(
        onChanged: _handleSearch,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xfff1f1f1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          hintText: "Search for Items",
          prefixIcon: const Icon(Icons.search),
          prefixIconColor: Colors.black,
        ),
      ),
    );
  }
}

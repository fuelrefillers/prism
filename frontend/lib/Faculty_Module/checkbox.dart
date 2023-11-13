import 'package:flutter/material.dart';

class RollNoCheckbox extends StatefulWidget {
  const RollNoCheckbox({super.key, required this.rollno, required this.list});
  final String rollno;
  final List<String> list;
  @override
  State<RollNoCheckbox> createState() => _RollNoCheckboxState();
}

class _RollNoCheckboxState extends State<RollNoCheckbox> {
  bool checkboxValue1 = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: checkboxValue1,
      onChanged: (bool? value) {
        setState(
          () {
            checkboxValue1 = value!;
            if (checkboxValue1) {
              widget.list.add(widget.rollno);
            } else {
              widget.list.remove(widget.rollno);
            }
          },
        );
      },
      title: Text(widget.rollno),
      subtitle: const Text('Supporting text'),
    );
  }
}

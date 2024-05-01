import 'package:flutter/material.dart';
import 'package:frontend/Faculty_Module/hostel_admin/hostels_add_room_screen.dart';
import 'package:frontend/Faculty_Module/hostel_admin/hostels_add_special_room_screen.dart';
import 'package:frontend/Faculty_Module/hostel_admin/hostels_view_booked_data.dart';
import 'package:frontend/Faculty_Module/hostel_admin/to_be_changed/hostels.dart';
import 'package:frontend/widgets/custom_button.dart';

class HostelAdminHomeScreen extends StatefulWidget {
  const HostelAdminHomeScreen({super.key});

  @override
  State<HostelAdminHomeScreen> createState() => _HostelAdminHomeScreenState();
}

class _HostelAdminHomeScreenState extends State<HostelAdminHomeScreen> {
  List<Widget> buttons = [
    CustomButton(
      buttonText: "Add room",
      icon: Icons.person,
      onPressed: HostelAddRoomScreen(),
    ),
    CustomButton(
      buttonText: "Add special room",
      icon: Icons.person,
      onPressed: HostelAddSpecialRoomScreen(),
    ),
    CustomButton(
      buttonText: "Booked Data",
      icon: Icons.person,
      onPressed: HostelsViewBookedDataScreen(),
    ),
    CustomButton(
      buttonText: "Data",
      icon: Icons.person,
      onPressed: Hostels(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hostels Admin"),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(3),
        itemCount: buttons.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 10,
          childAspectRatio: 2 / 0.8,
        ),
        itemBuilder: (context, index) => buttons[index],
      ),
    );
  }
}

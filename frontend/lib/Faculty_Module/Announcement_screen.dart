import 'package:flutter/material.dart';

class AnnouncementsPage extends StatefulWidget {
  @override
  _AnnouncementsPageState createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends State<AnnouncementsPage> {
  List<String> categories = ['General', 'Important', 'Urgent', 'Event'];
  List<String> stringList = ['CSE-A', 'CSE-B', 'CSE-C', 'CSE-D'];
  String selectedCategory = 'General';
  String selectedClass = 'CSE-A';
  TextEditingController announcementController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Announcements'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: DropdownButton<String>(
                value: selectedCategory,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCategory = newValue!;
                  });
                },
                items: categories.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                    ),
                  );
                }).toList(),
                isExpanded: true,
                underline: SizedBox(), // Hide the default underline
                icon: Icon(Icons.arrow_drop_down, color: Colors.blue),
                style: TextStyle(fontSize: 16.0, color: Colors.black),
                hint: Text(
                  'Select Category',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: DropdownButton<String>(
                value: selectedClass,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedClass = newValue!;
                  });
                },
                items: stringList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                    ),
                  );
                }).toList(),
                isExpanded: true,
                underline: SizedBox(), // Hide the default underline
                icon: Icon(Icons.arrow_drop_down, color: Colors.blue),
                style: TextStyle(fontSize: 16.0, color: Colors.black),
                hint: Text(
                  'Select Category',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: announcementController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Enter your announcement...',
                border: OutlineInputBorder(),
              ),
              style: TextStyle(fontSize: 16.0, color: Colors.black),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle the announcement submission here
                String category = selectedCategory;
                String announcement = announcementController.text;
                // Perform actions with the selected category and announcement text
                print('Selected Category: $category');
                print('Announcement Text: $announcement');
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

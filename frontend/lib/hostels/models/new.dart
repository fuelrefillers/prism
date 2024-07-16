import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:frontend/Faculty_Module/selection_pannel/photo_selection_pannel.dart';
import 'package:frontend/hostels/models/tesr.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  List<Add_Category> addcat = [];
  final TextEditingController categoryController = TextEditingController();
  Uint8List? _image;
  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  Future<void> loadCategories() async {
    List<Add_Category> temp =
        await Add_Category.loadListFromLocalStorage('categories');
    setState(() {
      addcat = temp;
    });
  }

  Future<void> saveCategory() async {
    if (categoryController.text.isNotEmpty && _image != null) {
      Add_Category newCategory = Add_Category(
        name: categoryController.text,
        img: _image!,
      );
      addcat.add(newCategory);
      await Add_Category.saveListToLocalStorage(addcat, 'categories');
      setState(() {
        categoryController.clear();
        _image = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Category'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.text,
              controller: categoryController,
              decoration: InputDecoration(
                labelText: "Enter the Category Name",
                fillColor: Color.fromARGB(255, 255, 255, 255),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () async {
                Uint8List? dummy = await showImagePickerOption(context);
                setState(() {
                  _image = dummy;
                });
              },
              child: Container(
                clipBehavior: Clip.hardEdge,
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: _image != null
                    ? Image(
                        image: MemoryImage(_image!),
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/fileadd.jpg',
                        scale: 1.8,
                      ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: saveCategory,
              child: Text('submit'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: addcat.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.memory(
                      addcat[index].img,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(addcat[index].name),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

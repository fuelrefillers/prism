import 'package:flutter/material.dart';
import 'package:frontend/models/library_model.dart';

class LibraryProvider extends ChangeNotifier {
  Library _library = Library(
    RollNo: '',
    booksTaken: [],
    dateTaken: [],
  );

  Library get library => _library;

  void setLibrary(String library) {
    _library = Library.fromJson(library);
    notifyListeners();
  }

  void setLibraryFromModel(Library library) {
    _library = library;
    notifyListeners();
  }
}

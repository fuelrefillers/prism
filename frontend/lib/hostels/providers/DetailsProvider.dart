import 'package:flutter/foundation.dart';
// import 'package:host/models/DetailsModel.dart';
import 'package:frontend/hostels/models/DetailsModel.dart';

class DetailsProvider extends ChangeNotifier {
  Details? _details;

  Details? get details => _details;

  void setDetails(Details details) {
    _details = details;
    notifyListeners();
  }

  void clearDetails() {
    _details = null;
    notifyListeners();
  }
}

import 'package:flutter/foundation.dart';

class DownloadProvider extends ChangeNotifier {
  bool isDownloaded = false;

  void changeStatus() {
    isDownloaded = !isDownloaded;
    notifyListeners();
  }
}

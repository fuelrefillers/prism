import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotifications {
  static final _firebaseMessaging = FirebaseMessaging.instance;

  static Future intt() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    final token = await _firebaseMessaging.getToken();

    print("token : ${token}");
  }
}

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Faculty_Module/faculty-home-screen.dart';
import 'package:frontend/chatting/socketio.dart';
import 'package:frontend/firebase_options.dart';
import 'package:frontend/hostels/providers/BoysRoomsPriovider.dart';
import 'package:frontend/hostels/providers/DetailsProvider.dart';
import 'package:frontend/hostels/providers/GirlsFloorsProvider.dart';
import 'package:frontend/hostels/providers/GirlsRoomsProvider.dart';
import 'package:frontend/hostels/providers/verifyProvider.dart';
import 'package:frontend/providers.dart/atten_confirm_provider.dart';
import 'package:frontend/providers.dart/attendance_provider.dart';
import 'package:frontend/providers.dart/download_provider.dart';
import 'package:frontend/providers.dart/faculty_login_provider.dart';
import 'package:frontend/providers.dart/faculty_provider.dart';
import 'package:frontend/providers.dart/is_error_provider.dart';
import 'package:frontend/providers.dart/is_loading_provider.dart';
import 'package:frontend/providers.dart/time_table_view_provider.dart';
import 'package:frontend/providers.dart/upload_percentage_provider.dart';
import 'package:frontend/providers.dart/who_is_signed_in.dart';
import 'package:frontend/providers.dart/library_provider.dart';
import 'package:frontend/providers.dart/performance_provider.dart';
import 'package:frontend/providers.dart/token_provider.dart';
import 'package:frontend/providers.dart/user_provider.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:frontend/services/auth.dart';
import 'package:frontend/services/push_notification.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

//  Hi nithin baby how are you
// work:
// change the UI for faculty which you feel that page can be improved
// also change some UI to the newly added things in student
// take your own time
// do what you like and if you feel it looks good or any idea about improving it further do it ,its your take do as you want

// import 'SocketService.dart';

// function to lisen to background changes
Future _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print("Some notification Received");
  }
}

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  SocketService().connectToServer();
  // io.Socket socket = SocketService().socket;

  // socket.onConnect((data) {+++++++++++
  //   print("Connected");
  // });

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  PushNotifications.intt();

  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

  SharedPreferences prefs = await SharedPreferences.getInstance();

  final RemoteMessage? message =
      await FirebaseMessaging.instance.getInitialMessage();

  if (message != null) {
    print("Launched from terminated state");
    Future.delayed(Duration(seconds: 1), () {
      navigatorKey.currentState!.pushNamed("/message", arguments: message);
    });
  }

  if (prefs.getString('whoIsSignedIn') == null) {
    prefs.setString("whoIsSignedIn", "");
  }

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => GirlsFloorsProvider()),
          ChangeNotifierProvider(create: (_) => GirlsFloorsProvider()),
          ChangeNotifierProvider(create: (_) => SocketService()),
          ChangeNotifierProvider(create: (_) => GirlsRoomProvider()),
          ChangeNotifierProvider(create: (_) => DetailsProvider()),
          ChangeNotifierProvider(create: (_) => BoysRoomProvider()),
          ChangeNotifierProvider(create: (_) => VerifyProvider()),
          ChangeNotifierProvider(create: (_) => FacultyTimeTableProvider()),
          ChangeNotifierProvider(create: (_) => TimeTableViewProvider()),
          ChangeNotifierProvider(create: (_) => isLoadinProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => TokenProvider()),
          ChangeNotifierProvider(create: (_) => whoIsSignedIn()),
          ChangeNotifierProvider(create: (_) => AttendanceProvider()),
          ChangeNotifierProvider(create: (_) => PerformanceProvider()),
          ChangeNotifierProvider(create: (_) => LibraryProvider()),
          ChangeNotifierProvider(create: (_) => IsfacultyLoggedIn()),
          ChangeNotifierProvider(create: (_) => FacultyProvider()),
          ChangeNotifierProvider(create: (_) => AttendanceConfirm()),
          ChangeNotifierProvider(create: (_) => isErrorProvider()),
          ChangeNotifierProvider(create: (_) => UploadPercentageProvider()),
          ChangeNotifierProvider(create: (_) => DownloadProvider()),
        ],
        child: MyApp(
          token: prefs.getString('x-auth-token'),
          whoIsSignedIn: prefs.getString('whoIsSignedIn'),
        ),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.token, required this.whoIsSignedIn});
  final token;
  final whoIsSignedIn;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Authservice authService = Authservice();

  @override
  void initState() {
    // authService.getmarks(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final whoIs = Provider.of<whoIsSignedIn>(context, listen: false);
    whoIs.changeStatus(widget.whoIsSignedIn);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Prism',
      theme: ThemeData(useMaterial3: true),
      home: (widget.token == '' || widget.token == null)
          ? const LoginPage()
          : (widget.whoIsSignedIn == 'faculty')
              ? FacultyHomeScreen()
              : HomeScreen(whoissignedin: widget.whoIsSignedIn),
    );
  }
}

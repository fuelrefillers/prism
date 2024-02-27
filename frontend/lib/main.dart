import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Faculty_Module/faculty-home-screen.dart';
import 'package:frontend/chatting/socketio.dart';
import 'package:frontend/firebase_options.dart';
import 'package:frontend/providers.dart/atten_confirm_provider.dart';
import 'package:frontend/providers.dart/attendance_provider.dart';
import 'package:frontend/providers.dart/download_provider.dart';
import 'package:frontend/providers.dart/faculty_login_provider.dart';
import 'package:frontend/providers.dart/faculty_provider.dart';
import 'package:frontend/providers.dart/is_error_provider.dart';
import 'package:frontend/providers.dart/is_loading_provider.dart';
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
import 'package:socket_io_client/socket_io_client.dart' as io;
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
  io.Socket socket = SocketService().socket;
  // socket.emit("signin", "SAITHARAK");
  socket.onConnect((data) {
    print("Connected");
  });

  // socket.emit("signin", "21J41A05R5");

  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // FirebaseMessaging.instance.getToken().then((value) {
  //   print("getToken : $value");
  // });

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // final socket = IO.io("http://192.168.29.194:3000", <String, dynamic>{
  //   "transports": ["websocket"],
  //   "autoConnect": false,
  // });
  // socket.connect();

  PushNotifications.intt();
  // Listen to background notifications
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
          ChangeNotifierProvider(create: (_) => isLoadinProvider()),
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

// (widget.token == null) ? const HomeScreen() : const LoginPage()
//Provider.of<TokenProvider>(context).token.token.isEmpty ? const LoginPage() : const HomeScreen()
// Provider.of<TokenProvider>(context).token.token.isEmpty ? const LoginPage(): const HomeScreen()
// const ProfileScreen()
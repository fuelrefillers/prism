import 'package:flutter/material.dart';
import 'package:frontend/Faculty_Module/faculty-home-screen.dart';
import 'package:frontend/providers.dart/atten_confirm_provider.dart';
import 'package:frontend/providers.dart/attendance_provider.dart';
import 'package:frontend/providers.dart/faculty_login_provider.dart';
import 'package:frontend/providers.dart/faculty_provider.dart';
import 'package:frontend/providers.dart/is_error_provider.dart';
import 'package:frontend/providers.dart/is_loading_provider.dart';
import 'package:frontend/providers.dart/who_is_signed_in.dart';
import 'package:frontend/providers.dart/library_provider.dart';
import 'package:frontend/providers.dart/performance_provider.dart';
import 'package:frontend/providers.dart/token_provider.dart';
import 'package:frontend/providers.dart/user_provider.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:frontend/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getString('whoIsSignedIn') == null) {
    prefs.setString("whoIsSignedIn", "");
  }

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(
      MultiProvider(
        providers: [
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
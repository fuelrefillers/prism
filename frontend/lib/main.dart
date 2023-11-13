import 'package:flutter/material.dart';
import 'package:frontend/providers.dart/attendance_provider.dart';
import 'package:frontend/providers.dart/favourite_provider.dart';
import 'package:frontend/providers.dart/is_parent_provider.dart';
import 'package:frontend/providers.dart/library_provider.dart';
import 'package:frontend/providers.dart/performance_provider.dart';
import 'package:frontend/providers.dart/token_provider.dart';
import 'package:frontend/providers.dart/user_provider.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/screens/login_screen.dart';
//import 'package:frontend/screens/login_screen.dart';
// import 'package:frontend/screens/profile_screen.dart';
import 'package:frontend/services/auth.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => TokenProvider()),
          ChangeNotifierProvider(create: (_) => ProductFavoriteController()),
          ChangeNotifierProvider(create: (_) => IsParentLoggedIn()),
          ChangeNotifierProvider(create: (_) => AttendanceProvider()),
          ChangeNotifierProvider(create: (_) => PerformanceProvider()),
          ChangeNotifierProvider(create: (_) => LibraryProvider()),
        ],
        child: MyApp(
          token: prefs.getString('x-auth-token'),
        ),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.token});
  final token;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Authservice authService = Authservice();

  @override
  void initState() {
    super.initState();
    authService.getAttendance(context);
    authService.getUser(context);
    authService.getPerformance(context);
    authService.getLibrary(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Node Auth',
      theme: ThemeData(useMaterial3: true),
      home: (widget.token == null) ? const HomeScreen() : const LoginPage(),
    );
  }
}


//Provider.of<TokenProvider>(context).token.token.isEmpty ? const LoginPage() : const HomeScreen()
// Provider.of<TokenProvider>(context).token.token.isEmpty ? const LoginPage(): const HomeScreen()
// const ProfileScreen()
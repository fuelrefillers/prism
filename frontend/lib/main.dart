import 'package:flutter/material.dart';
import 'package:frontend/providers.dart/token_provider.dart';
import 'package:frontend/providers.dart/user_provider.dart';
import 'package:frontend/screens/home_screen.dart';
//import 'package:frontend/screens/login_screen.dart';
// import 'package:frontend/screens/profile_screen.dart';
import 'package:frontend/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MultiProvider(providers: [
            ChangeNotifierProvider(create: (_) => UserProvider()),
            ChangeNotifierProvider(create: (_) => TokenProvider()),
          ], child: const MyApp())));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Authservice authService = Authservice();

  @override
  void initState() {
    super.initState();
    authService.getUser(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Node Auth',
      theme: ThemeData(useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}


//Provider.of<TokenProvider>(context).token.token.isEmpty ? const LoginPage() : const HomeScreen()
// Provider.of<TokenProvider>(context).token.token.isEmpty ? const LoginPage(): const HomeScreen()
//  const ProfileScreen()
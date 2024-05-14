import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:frontend/providers/is_loading_provider.dart';
import 'package:frontend/screens/Hostel_Screens/hostel_home_screen.dart';
import 'package:frontend/screens/Hostel_Screens/hostel_terms_and_conditions_screen.dart';
import 'package:frontend/services/auth.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController rollnoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final Authservice authservice = Authservice();
  void login() {
    authservice.loginUser(
      context: context,
      rollno: rollnoController.text.trim(),
      password: passwordController.text.trim(),
    );
  }

  void loginParent() {
    authservice.loginParent(
      context: context,
      parentphno: rollnoController.text.trim(),
      parentpassword: passwordController.text.trim(),
    );
  }

  void loginfaculty() {
    authservice.loginfaculty(
      context: context,
      username: rollnoController.text.trim(),
      password: passwordController.text.trim(),
    );
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final isLoadingProvider =
        Provider.of<isLoadinProvider>(context, listen: false);
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(color: Colors.white),
              height: 250,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 50,
                    left: width / 2 - 100,
                    height: 200,
                    width: 200,
                    child: FadeInUp(
                        duration: const Duration(seconds: 1),
                        child: Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/MREC_logo.png'),
                                  fit: BoxFit.fill)),
                        )),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeInUp(
                        duration: const Duration(milliseconds: 1500),
                        child: Center(
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          ),
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    FadeInUp(
                        duration: const Duration(milliseconds: 1700),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              border: Border.all(
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(255, 181, 181, 181),
                                  blurRadius: 20,
                                  offset: Offset(0, 10),
                                )
                              ]),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Color.fromRGBO(
                                                196, 135, 198, .3)))),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This field should not be empty';
                                    }
                                    return null;
                                  },
                                  controller: rollnoController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Username",
                                      hintStyle: TextStyle(
                                          color: Colors.grey.shade700)),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This field should not be empty';
                                    }
                                    return null;
                                  },
                                  controller: passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      hintStyle: TextStyle(
                                          color: Colors.grey.shade700)),
                                ),
                              )
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    FadeInUp(
                      duration: const Duration(milliseconds: 1700),
                      child: Center(
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(
                                color: Color.fromRGBO(196, 135, 198, 1)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FadeInUp(
                      duration: const Duration(milliseconds: 1900),
                      child: MaterialButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            login();
                            isLoadingProvider.toggleStudentLoading();
                          }
                        },
                        color: const Color.fromRGBO(49, 39, 79, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        height: 50,
                        child: Center(
                          child: Consumer<isLoadinProvider>(
                            builder: (context, value, child) =>
                                value.isloadingstudent
                                    ? CircularProgressIndicator.adaptive()
                                    : Text(
                                        "Student Login",
                                        style: TextStyle(color: Colors.white),
                                      ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FadeInUp(
                      duration: const Duration(milliseconds: 2000),
                      child: Center(
                        child: MaterialButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                              loginParent();
                              isLoadingProvider.toggleParentLoading();
                            }
                          },
                          color: const Color.fromRGBO(49, 39, 79, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          height: 50,
                          child: Center(
                            child: Consumer<isLoadinProvider>(
                              builder: (context, value, child) =>
                                  value.isloadingparent
                                      ? CircularProgressIndicator.adaptive()
                                      : Text(
                                          "Parent Login",
                                          style: TextStyle(color: Colors.white),
                                        ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FadeInUp(
                      duration: const Duration(milliseconds: 1900),
                      child: MaterialButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            loginfaculty();
                            isLoadingProvider.toggleFacultyLoading();
                          }
                        },
                        color: const Color.fromRGBO(49, 39, 79, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        height: 50,
                        child: Center(
                          child: Consumer<isLoadinProvider>(
                            builder: (context, value, child) =>
                                value.isloadingsfaculty
                                    ? CircularProgressIndicator.adaptive()
                                    : Text(
                                        "Faculty Login",
                                        style: TextStyle(color: Colors.white),
                                      ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FadeInUp(
                      duration: const Duration(milliseconds: 1500),
                      child: Center(
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HostelTnC_Screen()));
                          },
                          color: const Color.fromRGBO(49, 39, 79, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          height: 50,
                          child: Center(
                            child: Text(
                              "Hostels Booking",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:appd2fp/service.dart';
import 'package:appd2fp/user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final _formkey = GlobalKey<FormState>();

// @override
class logIn extends StatefulWidget {
  const logIn({super.key});

  @override
  State<logIn> createState() => _logInState();
}

bool? isChecked = false;

class _logInState extends State<logIn> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final ApiService _apiService = ApiService();

  void _login() async {
    if (_formKey.currentState!.validate()) {
      // Implement login logic here
      Navigator.pushReplacementNamed(context, '/home',
          arguments: _usernameController.text);
    }
  }
  // void _login() async {
  //   if (_formKey.currentState!.validate()) {
  //     try {
  //       print('Attempting to fetch user: ${_usernameController.text}');
  //       User user = await _apiService.fetchUser(_usernameController.text);
  //       print('User fetched: ${user.username}');
  //       // Optionally, you can also check if the password matches here
  //       if (user.password == _passwordController.text) {
  //         Navigator.pushReplacementNamed(
  //           context,
  //           '/home',
  //           arguments: _usernameController.text,
  //         );
  //       } else {
  //         print('incorrect');
  //         // Show error if password is incorrect
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text('Incorrect password. Please try again.')),
  //         );
  //       }
  //     } catch (e) {
  //       print('not found');
  //       // Show error if user is not found or another error occurs
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('User not found. Please try again.')),
  //       );
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: 871,
        width: 1440,
        child: Stack(
          children: [
            Image.asset(
              'assets/images/logIn/container.png',
              width: double.infinity,
              height: 871,
              fit: BoxFit.fill,
            ),
            Positioned(
                top: 100,
                left: 500,
                child: Stack(children: [
                  Container(
                      height: 550,
                      width: 567,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(27),
                          image: const DecorationImage(
                              image: AssetImage(
                                  'assets/images/logIn/smallContainer.png'),
                              fit: BoxFit.cover))),
                  Positioned(
                    left: 46,
                    top: 80,
                    child: Form(
                      key: _formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Login',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28,
                                  color: const Color(0xFF262626)),
                            ),
                            const SizedBox(height: 30),
                            Container(
                              padding: const EdgeInsets.all(0),
                              height: 68,
                              width: 478,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xFFF6F6F6)),
                              child: Center(
                                child: TextFormField(
                                  controller: _usernameController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Username',
                                      prefixIcon: Image.asset(
                                          'assets/icons/username.png'),
                                      hintStyle: GoogleFonts.heebo(
                                        color: const Color(0xFF252525),
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18,
                                      )),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your username';
                                    }
                                    return null;
                                  },
                                  // autovalidateMode:
                                  //     AutovalidateMode.onUserInteraction,
                                ),
                              ),
                            ),
                            const SizedBox(height: 21),
                            Container(
                              padding: const EdgeInsets.all(0),
                              height: 68,
                              width: 478,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xFFF6F6F6)),
                              child: Center(
                                child: TextFormField(
                                  controller: _passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Password',
                                      prefixIcon: Image.asset(
                                          'assets/icons/password.png'),
                                      hintStyle: GoogleFonts.heebo(
                                        color: const Color(0xFF252525),
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18,
                                      )),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    return null;
                                  },
                                  // autovalidateMode:
                                  //     AutovalidateMode.onUserInteraction,
                                ),
                              ),
                            ),
                            const SizedBox(height: 21),
                            SizedBox(
                              width: 478,
                              height: 64,
                              child: Material(
                                elevation: 10,
                                shadowColor: Colors.grey.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: const Color(0xFF176BCE),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: _login,
                                  // if (_formkey.currentState!.validate()) {}

                                  child: Text("Login",
                                      style: GoogleFonts.inter(
                                        color: const Color(0xFFFFFFFF),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      )),
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                  Positioned(
                    bottom: 90,
                    left: 187,
                    child: Row(
                      children: [
                        Text(
                          'Not Yet Registered?',
                          style: GoogleFonts.heebo(
                              color: const Color(0xFF202020),
                              fontWeight: FontWeight.normal,
                              fontSize: 16),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/registration');
                            },
                            child: Text(
                              "Sign Up",
                              style: GoogleFonts.heebo(
                                  color: const Color(0xFF176BCE),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                            ))
                      ],
                    ),
                  )
                ])),
          ],
        ),
      ),
    );
  }
}

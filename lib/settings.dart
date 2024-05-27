import 'package:appd2fp/service.dart';
import 'package:appd2fp/user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class setting extends StatefulWidget {
  final String username;
  // const setting({super.key});
  setting({required this.username});
  @override
  State<setting> createState() => _settingState();
}

class _settingState extends State<setting> {
  // Map<String, dynamic> userDetails = {};
  bool isediting = false;

  late Future<User> _userFuture;
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController(text: '********');
  @override
  void initState() {
    super.initState();
    _userFuture = ApiService().fetchUser(widget.username);
  }

  void _updateUser(User user) async {
    user.fullName = _fullNameController.text;
    user.email = _emailController.text;
    user.username = _usernameController.text;
    user.password = _passwordController.text;
    try {
      await ApiService().updateUser(user);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('User updated successfully')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to update user')));
    }
  }

  void _deleteUser(String username) async {
    try {
      await ApiService().deleteUser(username);
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to delete user')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            User user = snapshot.data!;
            _usernameController.text = user.username;
            _fullNameController.text = user.fullName;
            _emailController.text = user.email;
            _passwordController.text = user.password;

            return Stack(children: [
              Positioned(
                top: 200,
                child: Row(
                  children: [
                    SizedBox(
                      width: 100,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 0),
                        Text(
                          'Profile',
                          style: GoogleFonts.inter(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 22),
                        Text(
                          'Personal Details',
                          style: GoogleFonts.inter(
                            fontSize: 22,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Text(
                              'Name',
                              style: GoogleFonts.heebo(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: Color(0xFF6A6A6A),
                              ),
                            ),
                            const SizedBox(width: 101),
                            isediting
                                ? SizedBox(
                                    width: 250,
                                    child: TextField(
                                      controller: _fullNameController,
                                      style: GoogleFonts.heebo(
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                        color: Color(0xFF6A6A6A),
                                      ),
                                    ),
                                  )
                                : Text(
                                    _fullNameController.text,
                                    style: GoogleFonts.heebo(
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xFF6A6A6A),
                                    ),
                                  ),
                          ],
                        ),
                        const SizedBox(height: 9),
                        Row(
                          children: [
                            Text(
                              'Email',
                              style: GoogleFonts.heebo(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: Color(0xFF6A6A6A),
                              ),
                            ),
                            const SizedBox(width: 101),
                            isediting
                                ? SizedBox(
                                    width: 250,
                                    child: TextField(
                                      controller: _emailController,
                                      style: GoogleFonts.heebo(
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                        color: Color(0xFF6A6A6A),
                                      ),
                                    ),
                                  )
                                : Text(
                                    _emailController.text,
                                    style: GoogleFonts.heebo(
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xFF6A6A6A),
                                    ),
                                  ),
                          ],
                        ),
                        const SizedBox(height: 9),
                        Row(
                          children: [
                            Text(
                              'Username',
                              style: GoogleFonts.heebo(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: Color(0xFF6A6A6A),
                              ),
                            ),
                            const SizedBox(width: 60),
                            isediting
                                ? SizedBox(
                                    width: 200,
                                    child: TextField(
                                      controller: _usernameController,
                                      style: GoogleFonts.heebo(
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                        color: Color(0xFF6A6A6A),
                                      ),
                                    ),
                                  )
                                : Text(
                                    _usernameController.text,
                                    style: GoogleFonts.heebo(
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xFF6A6A6A),
                                    ),
                                  ),
                          ],
                        ),
                        const SizedBox(height: 9),
                        Row(
                          children: [
                            Text(
                              'Password',
                              style: GoogleFonts.heebo(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: Color(0xFF6A6A6A),
                              ),
                            ),
                            const SizedBox(width: 60),
                            isediting
                                ? SizedBox(
                                    width: 200,
                                    child: TextField(
                                      controller: _passwordController,
                                      style: GoogleFonts.heebo(
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                        color: Color(0xFF6A6A6A),
                                      ),
                                    ),
                                  )
                                : Text(
                                    '*********',
                                    style: GoogleFonts.heebo(
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xFF6A6A6A),
                                    ),
                                  ),
                          ],
                        ),
                        const SizedBox(height: 70),
                        SizedBox(
                          width: 189,
                          height: 40,
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
                              onPressed: () {
                                if (isediting) {
                                  _updateUser(user);
                                }
                                setState(() {
                                  isediting = !isediting;
                                });
                              },
                              child: Text(
                                isediting ? "Save" : "Edit Profile",
                                style: GoogleFonts.inter(
                                  color: const Color(0xFFFFFFFF),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 670,
                left: 0,
                right: 0,
                child: Image.asset(
                  'assets/images/dashboard/Line.png',
                  width: 2000,
                ),
              ),
              Positioned(
                top: 700,
                right: 500,
                child: SizedBox(
                  width: 189,
                  height: 40,
                  child: Material(
                    elevation: 10,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: const Color(0xFFE55E48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () => _deleteUser(user.username),
                      child: Text("Delete Account",
                          style: GoogleFonts.inter(
                            color: const Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          )),
                    ),
                  ),
                ),
              ),
            ]);
          } else {
            return const Center(child: Text('No user found'));
          }
        });
  }
}

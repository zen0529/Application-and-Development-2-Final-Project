import 'package:appd2fp/service.dart';
import 'package:appd2fp/user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  // final _formKey = GlobalKey<FormState>();
  bool _isButtonEnabled = false;

  // final TextEditingController emailController = TextEditingController();
  // final TextEditingController fullnameController = TextEditingController();
  // final TextEditingController usernameController = TextEditingController();
  // final TextEditingController passwordController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   emailController.addListener(_validateForm);
  //   fullnameController.addListener(_validateForm);
  //   usernameController.addListener(_validateForm);
  //   passwordController.addListener(_validateForm);
  // }

  String? validateEmail(String? email) {
    RegExp emailRegex = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
    final emailIsValid = emailRegex.hasMatch(email ?? '');
    if (!emailIsValid) {
      return 'Please Enter a valid email';
    }
    return null;
  }

  void _validateForm() {
    setState(() {
      _isButtonEnabled = _formKey.currentState?.validate() ?? false;
    });
  }

  // // Future<void> _register() async {
  // //   final response = await http.post(
  // //     Uri.parse('http://127.0.0.1:8000/api/users/register/'),
  // //     body: {
  // //       'username': usernameController.text,
  // //       'email': emailController.text,
  // //       'first_name': fullnameController.text,
  // //       'password': passwordController.text,
  // //     },
  // //   );
  // //   print(usernameController.text);
  // //   print(emailController.text);
  // //   print(fullnameController.text);
  // //   print(passwordController.text);
  // //   if (response.statusCode == 201) {
  // //     print('Registration successful');
  // //   } else {
  // //     print('Registration failed');
  // //   }
  // // }

  // @override
  // void dispose() {
  //   emailController.dispose();
  //   fullnameController.dispose();
  //   usernameController.dispose();
  //   passwordController.dispose();
  //   super.dispose();
  // }

  // Future<void> _register() async {
  //   final response = await http.post(
  //     Uri.parse('http://127.0.0.1:8000/api/users/register/'),
  //     body: {
  //       'username': usernameController.text,
  //       'email': emailController.text,
  //       'first_name': fullnameController.text,
  //       'password': passwordController.text,
  //     },
  //   );
  // }

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _register() async {
    if (_formKey.currentState!.validate()) {
      User user = User(
        username: _usernameController.text,
        fullName: _fullNameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );
      print(_usernameController.text);
      print(_fullNameController.text);
      print(_emailController.text);
      print(_passwordController.text);
      try {
        await ApiService().registerUser(user);
        Navigator.pushReplacementNamed(context, '/login');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to register user')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Material(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/registration/registerbg.png',
              width: double.infinity,
              height: 1095,
              fit: BoxFit.fill,
            ),
            const Positioned(top: 48, left: 101, child: Text(' ')),
            Positioned(
              left: 515,
              top: 60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Register',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: const Color(0xFF262626),
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildTextField(
                    controller: _usernameController,
                    label: 'Username',
                    hint: 'delacruz101',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  _buildTextField(
                    controller: _emailController,
                    label: 'Email',
                    hint: 'juandelacruz@email.com',
                    validator: validateEmail,
                  ),
                  const SizedBox(height: 15),
                  _buildTextField(
                    controller: _fullNameController,
                    label: 'Full Name',
                    hint: 'Juan Dela Cruz',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  _buildTextField(
                    controller: _passwordController,
                    label: 'Password',
                    hint: '*********',
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 25),
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
                          // : Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: _register

                        // showDialog(
                        //   context: context,
                        //   builder: (BuildContext context) {
                        //     return AlertDialog(
                        //       // title: Text("Registration Successful"),
                        //       title: Text(
                        //         'Registration Successful',
                        //         style: GoogleFonts.inter(
                        //           fontWeight: FontWeight.w600,
                        //           fontSize: 20,
                        //           color: const Color(0xFF262626),
                        //         ),
                        //       ),
                        //       content: Text(
                        //         'You have registered successfully.',
                        //         style: GoogleFonts.inter(
                        //           fontWeight: FontWeight.normal,
                        //           fontSize: 15,
                        //           color: const Color(0xFF262626),
                        //         ),
                        //       ),

                        //       actions: [
                        //         SizedBox(
                        //           width: 120,
                        //           height: 30,
                        //           child: Material(
                        //             elevation: 10,
                        //             shadowColor: Colors.grey.withOpacity(0.5),
                        //             borderRadius: BorderRadius.circular(10),
                        //             child: ElevatedButton(
                        //               style: ElevatedButton.styleFrom(
                        //                 elevation: 0,
                        //                 backgroundColor:
                        //                     const Color(0xFF176BCE),
                        //                 shape: RoundedRectangleBorder(
                        //                   borderRadius:
                        //                       BorderRadius.circular(10),
                        //                 ),
                        //               ),
                        //               onPressed: () {
                        //                 Navigator.of(context).pop();
                        //                 Navigator.pushNamed(
                        //                     context, '/login');
                        //               },
                        //               child: Text(
                        //                 'Proceed',
                        //                 style: GoogleFonts.inter(
                        //                   color: const Color(0xFFFFFFFF),
                        //                   fontWeight: FontWeight.w400,
                        //                   fontSize: 14,
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //         )
                        //       ],
                        //     );
                        //   },
                        // );
                        ,
                        child: Text(
                          "Register",
                          style: GoogleFonts.inter(
                            color: const Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    bool obscureText = false,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.normal,
            fontSize: 20,
            color: const Color(0xFF262626),
          ),
        ),
        const SizedBox(height: 7),
        Container(
          padding: const EdgeInsets.only(left: 20),
          height: 68,
          width: 478,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFFFDFDFD),
          ),
          child: Center(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle: GoogleFonts.heebo(
                  color: const Color(0xFF6A6A6A),
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                ),
              ),
              validator: validator,
              obscureText: obscureText,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
          ),
        ),
      ],
    );
  }
}

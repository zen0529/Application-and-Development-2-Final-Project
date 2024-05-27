// import 'package:flutter/material.dart';
// import 'service.dart';

// class AuthScreen extends StatefulWidget {
//   @override
//   _AuthScreenState createState() => _AuthScreenState();
// }

// class _AuthScreenState extends State<AuthScreen> {
//   final AuthService authService = AuthService();
//   late String token;
//   Map<String, dynamic> userDetails = {};

//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _fullNameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();

//   void _register() async {
//     final response = await authService.register(
//       _fullNameController.text,
//       _usernameController.text,
//       _passwordController.text,
//       _emailController.text,
//     );
//     print(response);
//   }

//   void _login() async {
//     final response = await authService.login(
//       _usernameController.text,
//       _passwordController.text,
//     );
//     if (response.containsKey('token')) {
//       setState(() {
//         token = response['token'];
//       });
//       _fetchUserDetails();
//     } else {
//       print('Login failed');
//     }
//   }

//   void _fetchUserDetails() async {
//     final response = await authService.getUserDetails(token);
//     setState(() {
//       userDetails = response;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Auth Demo')),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _fullNameController,
//               decoration: InputDecoration(labelText: 'Full Name'),
//             ),
//             TextField(
//               controller: _usernameController,
//               decoration: InputDecoration(labelText: 'Username'),
//             ),
//             TextField(
//               controller: _passwordController,
//               decoration: InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             TextField(
//               controller: _emailController,
//               decoration: InputDecoration(labelText: 'Email'),
//             ),
//             ElevatedButton(
//               onPressed: _register,
//               child: Text('Register'),
//             ),
//             ElevatedButton(
//               onPressed: _login,
//               child: Text('Login'),
//             ),
//             if (userDetails != null) ...[
//               Text('Full Name: ${userDetails['full_name']}'),
//               Text('Username: ${userDetails['username']}'),
//               Text('Email: ${userDetails['email']}'),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }

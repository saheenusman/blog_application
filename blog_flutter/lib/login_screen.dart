import 'package:flutter/material.dart';
import 'api_service.dart';
import 'post_list_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  String? token;

  void handleLogin() async {
    final result = await ApiService.login(
      usernameController.text,
      passwordController.text,
    );

    if (result != null && result['token'] != null) {
      setState(() {
        token = result['token'];
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PostListScreen(token: token!)),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Login failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 8),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(onPressed: handleLogin, child: Text('Login')),
          ],
        ),
      ),
    );
  }
}

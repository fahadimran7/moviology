import 'package:flutter/material.dart';
import 'package:movie_search_app/commons/header.dart';
import 'package:movie_search_app/screens/login/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Movie Finder",
              style: TextStyle(fontWeight: FontWeight.bold))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(
                height: 50,
              ),
              Header(
                title: "Login",
                text: "Provide your email to continue",
              ),
              SizedBox(height: 40),
              LoginForm()
            ]),
      ),
    );
  }
}

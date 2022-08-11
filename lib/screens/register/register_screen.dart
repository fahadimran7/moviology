import 'package:flutter/material.dart';
import 'package:movie_search_app/commons/header.dart';
import 'package:movie_search_app/screens/register/register_form.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                title: "Sign Up",
                text: "Create an account to get started",
              ),
              SizedBox(height: 40),
              RegisterForm(),
              SizedBox(
                height: 50,
              )
            ]),
      ),
    );
  }
}

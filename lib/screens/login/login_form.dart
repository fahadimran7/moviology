import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movie_search_app/shared/divider.dart';
import 'package:movie_search_app/shared/elevated_button.dart';
import 'package:movie_search_app/shared/text_button.dart';
import 'package:movie_search_app/shared/text_field.dart';
import 'package:movie_search_app/firebase/firebase_authentication.dart';
import 'package:movie_search_app/screens/home_screen/home_screen.dart';
import 'package:movie_search_app/utils/input_validators.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  late FirebaseAuthentication auth;
  late String userId;

  void buttonHandler() {
    Navigator.pushNamed(context, "/register");
  }

  @override
  void initState() {
    Firebase.initializeApp().whenComplete(() {
      auth = FirebaseAuthentication();
    });
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        autovalidateMode: _autoValidate,
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomTextField(
                controller: emailController,
                labelText: "Enter Email Address",
                icon: Icons.email,
                obscureText: false,
                autocorrect: true,
                suggestions: true,
                validator: InputValidators.validateEmailAddress,
                disableFloating: true,
                filled: true,
              ),
              const SizedBox(
                height: 24,
              ),
              CustomTextField(
                controller: passwordController,
                labelText: "Enter Password",
                icon: Icons.password,
                obscureText: true,
                autocorrect: false,
                suggestions: false,
                validator: InputValidators.validatePassword,
                disableFloating: true,
                filled: true,
              ),
              const SizedBox(
                height: 32,
              ),
              CustomElevatedButton(
                  text: "Continue",
                  validateCallback: () {
                    if (_formKey.currentState!.validate()) {
                      auth
                          .login(emailController.text, passwordController.text)
                          .then((value) {
                        if (value == null) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Login error!"),
                          ));
                        } else {
                          setState(() {
                            userId = value;
                          });
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Login successful!"),
                          ));

                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen(
                                        username: "Guest User",
                                      )));
                          _formKey.currentState?.reset();
                        }
                      });
                    } else {
                      setState(() {
                        _autoValidate = AutovalidateMode.onUserInteraction;
                      });
                    }
                  }),
              const SizedBox(
                height: 20,
              ),
              const CustomDivider(),
              const SizedBox(
                height: 20,
              ),
              CustomTextButton(buttonHandler: buttonHandler)
            ]));
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movie_search_app/shared/divider.dart';
import 'package:movie_search_app/shared/elevated_button.dart';
import 'package:movie_search_app/shared/text_field.dart';
import 'package:movie_search_app/constants/styles.dart';
import 'package:movie_search_app/firebase/firebase_authentication.dart';
import 'package:movie_search_app/screens/home_screen/home_screen.dart';
import 'package:movie_search_app/screens/login/login_screen.dart';
import 'package:movie_search_app/utils/input_validators.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  String? fullName;
  String? email;
  String? password;
  String? confirmPassword;
  late FirebaseAuthentication auth;
  late FirebaseFirestore firestore;
  late String userId;

  void buttonHandler() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  void initState() {
    Firebase.initializeApp().whenComplete(() {
      auth = FirebaseAuthentication();
      firestore = FirebaseFirestore.instance;
    });
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: _autoValidate,
      key: _formKey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
          Widget>[
        CustomTextField(
          controller: nameController,
          labelText: "Enter Full Name",
          icon: Icons.person,
          obscureText: false,
          disableFloating: true,
          filled: true,
          autocorrect: true,
          suggestions: true,
          validator: InputValidators.validateFullName,
          onSaved: (String? value) => fullName = value,
        ),
        const SizedBox(
          height: 24,
        ),
        CustomTextField(
            controller: emailController,
            labelText: "Enter Email Address",
            icon: Icons.email,
            disableFloating: true,
            filled: true,
            obscureText: false,
            autocorrect: true,
            suggestions: true,
            validator: InputValidators.validateEmailAddress,
            onSaved: (String? value) => email = value),
        const SizedBox(
          height: 24,
        ),
        CustomTextField(
            controller: passwordController,
            labelText: "Enter New Password",
            icon: Icons.password,
            obscureText: true,
            disableFloating: true,
            filled: true,
            autocorrect: false,
            suggestions: false,
            validator: InputValidators.validatePassword,
            onSaved: (String? value) => password = value),
        const SizedBox(
          height: 24,
        ),
        CustomTextField(
            controller: confirmPasswordController,
            labelText: "Confirm New Password",
            icon: Icons.verified_user,
            obscureText: true,
            disableFloating: true,
            filled: true,
            autocorrect: false,
            suggestions: false,
            passwordCompare: passwordController,
            validator: InputValidators.validateConfirmPassword,
            onSaved: (String? value) => confirmPassword = value),
        const SizedBox(
          height: 32,
        ),
        CustomElevatedButton(
            text: "Continue",
            validateCallback: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                auth
                    .createUser(emailController.text, passwordController.text)
                    .then((value) async {
                  if (value == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Register error!"),
                    ));
                  } else {
                    userId = value;
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(userId)
                        .set({'fullName': fullName, 'email': email});
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Register successful!"),
                    ));

                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: ((context) =>
                                HomeScreen(username: fullName))),
                        (Route<dynamic> route) => false);

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
        Center(
            child: Column(
          children: [
            Text(
              "Have an account?",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: const EdgeInsets.only(left: 4),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: buttonHandler,
              child: Text(
                "Login Now",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: kcPrimarySwatch[900],
                ),
              ),
            )
          ],
        ))
      ]),
    );
  }
}

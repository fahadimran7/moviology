import 'package:flutter/material.dart';
import 'package:movie_search_app/config/palette.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      required this.controller,
      required this.labelText,
      required this.icon,
      required this.obscureText,
      required this.autocorrect,
      required this.suggestions,
      required this.validator,
      this.onSaved,
      this.passwordCompare,
      this.disableFloating,
      this.enableBorder,
      this.filled})
      : super(key: key);

  final TextEditingController controller;
  final bool obscureText;
  final bool autocorrect;
  final bool suggestions;
  final IconData icon;
  final String labelText;
  final Function validator;
  final FormFieldSetter<String>? onSaved;
  final TextEditingController? passwordCompare;
  final bool? disableFloating;
  final bool? enableBorder;
  final bool? filled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onSaved: onSaved,
        controller: controller,
        obscureText: obscureText,
        enableSuggestions: suggestions,
        autocorrect: autocorrect,
        decoration: InputDecoration(
            floatingLabelBehavior: disableFloating == true
                ? FloatingLabelBehavior.never
                : FloatingLabelBehavior.auto,
            prefixIcon: Icon(icon),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(
                    color: Palette.kToDark,
                    style: enableBorder == false
                        ? BorderStyle.none
                        : BorderStyle.solid)),
            errorStyle: TextStyle(color: Colors.red.shade400),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red.shade400, width: 1)),
            fillColor: const Color.fromARGB(255, 243, 243, 243),
            filled: filled,
            labelText: labelText),
        validator: (value) {
          return passwordCompare == null
              ? validator(value)
              : validator(value, passwordCompare);
        });
  }
}
